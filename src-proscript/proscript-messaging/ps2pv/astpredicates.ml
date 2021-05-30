(* Copyright 2021 Diskuv, Inc.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License. *)

(** Tests on the ProScript AST that can be used for compiling or translating ProScript *)

type letin_check_context =
  { last_statement_in_letin_sequence : bool
  ; within_conditional : bool
  }

(** @param skip_nested_functions If true, then do process any nested functions as having no impact on the
      passed-in function's safety. Use this flag to partially translate huge ProScript/JavaScript code that
      has many nested functions, or to avoid the exponential big-O if you are visiting nested functions in
      the AST later *)
type letin_check_options = { skip_nested_functions : bool }

let enable_debugging = false

let is_object_list_composed_only_of_properties (ol : Ast.object_prop_t list) =
  List.for_all
    (function
      | e ->
        ( match e with
        | `Property _pv, _loc -> true
        | _ -> false ) )
    ol


let is_array_composed_only_of_element_accesses (a : Ast.expression_t list) =
  List.for_all
    (function
      | `Property _ef, _loc -> true
      | _ -> false )
    a


(** Can we rewrite the AST by replacing all imperative statements with the functional OCaml "let in" form?

    {1 Preconditions}

    The AST must be Javascript in strict mode (that is, all variables are declared before they are used).

    {1 Why use 'let in' form?}

    OCaml can model mutable fields in record types, which maps well to ProScript code (at least the code used in KBB2017).
    The "let in" form works great with mutable fields and keeps the translated code easy to review and looking like
    idiomatic OCaml.

    One alternative to "let in" is to translate all of the ProScript functions to use mutable "ref".
    "ref" rewriting is fairly complicated and may never be implemented. Another alternative is to translate
    ProScript into monadic style; again, that may never be implemented. It is preferable to
    simply constrain the ProScript to have more functional functions (aka. be less imperative).

    The following functions can be rewritten with "let in":

    [
      function() { a(); b(); c(); d() }
    ]

    [
      function() { a(); if (b()) { c(); } else { d(); }; e(); }
    ]

    [
      function() { var v = a(); v = v + b(); v = v - c(); return v * d() }
    ]

    Those become:

    [
      let _ () = begin let _ = a () in let _ = b () in let _ = c () in d () end
    ]

    [
      let _ () begin let _ = a () in ( if b () then c () else d () ) in e () end
    ]

    [
      let _ () begin let v = a () in let v = v + b () in let v = v - c () in v * d () end
    ]

    The following ProScript cannot be rewritten:

    [
      function() { var v = a(); for (i in b()) { v += c(); }; return v + d() }
    ]

    As long as **you cannot skip over any variable assignments**, then we can use "let in".
    And mutations through mutable records are fine to use with "let in".

    {1 Logic}

    R1. We descend into all Ast.statement_t and all Ast.expression_t because statements can interrupt sequential
        top-down execution flow; statements can possibly result in variable assignments skipped, and expressions
        can contain statements.
    R2. We evaluate all Ast.expression_t within conditionals (ex. `If) to see whether they contain
        variable assignments. A variable assignment within a conditional statement is not safe to rewrite in
        "let in" form. However variable assignments in the main flow of a function are safe!
    R3. Any use of `Return occurs that is not the last _statement_ of a sequential statement list is not
        safe to rewrite. For clarity, there is no impact on safety if a conditional like `If is the last
        statement.
        The Ast.stm_t that have a "statement_t list" are:
        a) `Block which has one; b) `Switch which has two.
        Note: This rule is too strict and reflects a bit of laziness (see R0). Many or perhaps
        all functions can be rewritten so that an "if (a) {return b} ...other code..."
        becomes "if (a) {return b} else {...other code..}". In other words, the `Return can be rewritten
        to be within the last statement.
    R4. Throwing exceptions should be safe for "let in", as OCaml already supports exceptions within an OCaml
        expression. But OCaml does support Lwt and Async libraries where we need to consider
        coroutines + exceptions. To err on the side of caution (R0), we just say that throwing exceptions
        is unsafe until we can foolproof detect the absence of coroutines.
    R0. We err on conservatism ... we say "not safe for rewriting" if we don't know how or simply don't
        have the bandwidth to deal with a ProScript statement or expression.    

    The logic is a recursive evaluation of those rules. We short-circuit return
    if we run into any rules says is not rewritable.
*)
let rec is_ast_writable_with_letin_style
    (ast : Ast.t) (opts : letin_check_options) =
  (* Helper for R3 *)
  let rec test_statements_while_distinguishing_last_statement
      (ctx : letin_check_context)
      (test : letin_check_context -> Ast.stm_t -> bool) = function
    | [] -> true
    | [ (hd, _loc) ] ->
        test { ctx with last_statement_in_letin_sequence = true } hd
    | (hd, _loc) :: tl ->
        test { ctx with last_statement_in_letin_sequence = true } hd
        && test_statements_while_distinguishing_last_statement ctx test tl
  in
  (* Core Logic: is_*_safe *)
  let rec is_source_safe ctx = function
    | [] -> true
    | (`FunctionDeclaration childf, _loc) :: _tl ->
        (* R1. A function declared within another function is a brand-new scope. *)
        let _id_opt, _args, childast = childf in
        opts.skip_nested_functions
        || is_ast_writable_with_letin_style childast opts
    | [ (`Statement (stm, _loc2), _loc) ] ->
        (* R1. Descend into all statements *)
        (* R3. Distinguish last statement in sequence from others *)
        is_statement_safe
          { ctx with last_statement_in_letin_sequence = true }
          stm
    | (`Statement (stm, _loc2), _loc) :: tl ->
        (* R1. Descend into all statements *)
        (* R3. Distinguish last statement in sequence from others *)
        is_statement_safe
          { ctx with last_statement_in_letin_sequence = false }
          stm
        && is_source_safe ctx tl
  and is_statement_safe ctx = function
    | `Empty | `Debugger -> true
    | `Return expression_opt ->
        (* R3. Return as last statement is OK! *)
        (* R1. Descend into all expressions *)
        let _ =
          if enable_debugging
          then
            Printf.printf
              "is_statement_safe last_statement_in_letin_sequence=%b\n"
              ctx.last_statement_in_letin_sequence
        in
        ctx.last_statement_in_letin_sequence
        &&
        ( match expression_opt with
        | None -> true
        | Some expression ->
            let expr, _loc = expression in
            let result = is_expression_safe ctx expr in
            let _ =
              if enable_debugging
              then Printf.printf "is_statement_safe Return result=%b\n" result
            in
            result )
    | `Throw _ ->
        (* R4. Throwing an exception is unsafe (for now) *)
        false
    | `Continue _ | `Break _ | `Try _ | `Label _ ->
        (* R1. Anything that can cause a jump in sequential execution flow is not safe. *)
        false
    | `Do _ | `While _ | `For _ | `Forin _ ->
        (* R0. Conservative laziness.
           We in fact could accept loops as long as they didn't have variable assignments
           inside the loop.
        *)
        false
    | `Block statement_l ->
        (* R1. Sequential execution is OK, if child statements are OK *)
        (* R3. Distinguish last statement in sequence from others *)
        test_statements_while_distinguishing_last_statement
          ctx
          is_statement_safe
          statement_l
    | `Expression expression ->
        (* R1. Descend into all expressions *)
        let expr, _loc = expression in
        is_expression_safe ctx expr
    | `If (expression, if_statement, else_statement_opt) ->
        (* R1. Consider statement branches and consider the expression *)
        (* R2. An assignment within a conditional is unsafe *)
        let ctx = { ctx with within_conditional = true } in
        let expr, _loc = expression in
        is_expression_safe ctx expr
        &&
        let if_stmt, _loc = if_statement in
        is_statement_safe ctx if_stmt
        && Option.fold
             ~none:true
             ~some:(function
               | else_stmt, _loc -> is_statement_safe ctx else_stmt )
             else_statement_opt
    | `Switch (expression, default_statement_l_opt, case_expr_statement_l_l) ->
        (* R1. Consider statement branches and consider the expression *)
        (* R2. An assignment within a conditional is unsafe *)
        let ctx = { ctx with within_conditional = true } in
        let expr, _loc = expression in
        is_expression_safe ctx expr
        && Option.fold
             ~none:true
             ~some:
               ((* R3. Distinguish last statement in sequence from others *)
                test_statements_while_distinguishing_last_statement
                  ctx
                  is_statement_safe )
             default_statement_l_opt
        && List.for_all
             (function
               | _expr, statement_l ->
                   (* R3. Distinguish last statement in sequence from others *)
                   test_statements_while_distinguishing_last_statement
                     ctx
                     is_statement_safe
                     statement_l )
             case_expr_statement_l_l
    | `Const id_expression_opt_l | `Declaration id_expression_opt_l ->
        (* R1. Descend into all expressions *)
        List.for_all
          (function
            | _id, None -> true
            | _id, Some (expr, _loc) -> is_expression_safe ctx expr )
          id_expression_opt_l
    | `With _ ->
        (* R0. Conservative laziness. This will rarely be used. Too difficult to reason about what objects
            are being accessed, so punt *)
        false
  and is_expression_safe ctx = function
    | `This | `Null | `Undefined | `Elision | `Bool _ | `Byte _ | `Number _
     |`String _ | `Regexp _ | `Identifier _ ->
        (* Primitive values are safe *)
        true
    | `Array expression_l | `Sequence expression_l ->
        (* R1. Descend into all expressions *)
        List.for_all
          (function
            | expr, _loc -> is_expression_safe ctx expr )
          expression_l
    | `Object (object_prop_l : Ast.object_prop_t list) ->
        List.for_all
          (function
            | (_oprop : Ast.oprop_t), _loc ->
              ( match _oprop with
              | `Property (_id, ((expr : Ast.expr_t), _loc)) ->
                  (* R1. Descend into all expressions *)
                  is_expression_safe ctx expr
              | `Getter (_id, childf) | `Setter (_id, childf) ->
                  (* R1. A function declared within another function is a brand-new scope. *)
                  let _id_opt, _args, childast = childf in
                  opts.skip_nested_functions
                  || is_ast_writable_with_letin_style childast opts ) )
          object_prop_l
    | `New (left_expression, right_expression_l_opt) ->
        (* R1. Descend into all expressions *)
        let left_expr, _loc = left_expression in
        is_expression_safe ctx left_expr
        &&
        ( match right_expression_l_opt with
        | None -> true
        | Some right_expression_l ->
            List.for_all
              (function
                | expr, _loc -> is_expression_safe ctx expr )
              right_expression_l )
    | `Typeof expression
     |`Delete expression
     |`Void expression
     |`Plus expression
     |`Preincr expression
     |`Postincr expression
     |`Predecr expression
     |`Postdecr expression
     |`Minus expression
     |`Lnot expression
     |`Bnot expression ->
        (* R1. Descend into all expressions *)
        let expr, _loc = expression in
        is_expression_safe ctx expr
    | `Function childf ->
        (* R1. A function declared within another function is a brand-new scope. *)
        let _id_opt, _args, childast = childf in
        opts.skip_nested_functions
        || is_ast_writable_with_letin_style childast opts
    | `Conditional ((expr1, _loc1), (expr2, _loc2), (expr3, _loc3)) ->
        (* R1. Descend into all expressions *)
        (* R2. An assignment within a conditional is unsafe. x ? y : z is a conditional *)
        let ctx = { ctx with within_conditional = true } in
        is_expression_safe ctx expr1
        && is_expression_safe ctx expr2
        && is_expression_safe ctx expr3
    | `Assign (lhs_expression, rhs_expression)
     |`Ashassign (lhs_expression, rhs_expression) ->
        (* R1. Descend into all expressions *)
        (* R2. An assignment within a conditional is unsafe. We abort immediately if we are in a conditional *)
        (not ctx.within_conditional)
        &&
        let lhs_expr, _lloc = lhs_expression in
        is_expression_safe ctx lhs_expr
        &&
        let rhs_expr, _rloc = rhs_expression in
        is_expression_safe ctx rhs_expr
    | `Lor (lhs_expression, rhs_expression)
     |`Land (lhs_expression, rhs_expression) ->
        (* R1. Descend into all expressions *)
        (* R2. An assignment within a conditional is unsafe. || and && are short-circuit conditionals *)
        let ctx = { ctx with within_conditional = true } in
        let lhs_expr, _lloc = lhs_expression in
        is_expression_safe ctx lhs_expr
        &&
        let rhs_expr, _rloc = rhs_expression in
        is_expression_safe ctx rhs_expr
    | `Property (lhs_expression, rhs_expression)
     |`In (lhs_expression, rhs_expression)
     |`Instanceof (lhs_expression, rhs_expression)
     |`Add (lhs_expression, rhs_expression)
     |`Sub (lhs_expression, rhs_expression)
     |`Multiply (lhs_expression, rhs_expression)
     |`Mod (lhs_expression, rhs_expression)
     |`Divide (lhs_expression, rhs_expression)
     |`Lsh (lhs_expression, rhs_expression)
     |`Rsh (lhs_expression, rhs_expression)
     |`Ash (lhs_expression, rhs_expression)
     |`Bor (lhs_expression, rhs_expression)
     |`Band (lhs_expression, rhs_expression)
     |`Bxor (lhs_expression, rhs_expression)
     |`Equal (lhs_expression, rhs_expression)
     |`Lt (lhs_expression, rhs_expression)
     |`Gt (lhs_expression, rhs_expression)
     |`Le (lhs_expression, rhs_expression)
     |`Ge (lhs_expression, rhs_expression)
     |`Sequal (lhs_expression, rhs_expression) ->
        (* R1. Descend into all expressions *)
        let lhs_expr, _lloc = lhs_expression in
        is_expression_safe ctx lhs_expr
        &&
        let rhs_expr, _rloc = rhs_expression in
        is_expression_safe ctx rhs_expr
    | `Dot (expression, _id) ->
        (* R1. Descend into all expressions *)
        let expr, _loc = expression in
        let _ =
          if enable_debugging
          then
            Printf.printf
              "is_expression_safe Dot(expr=%b, id=%s)\n"
              (is_expression_safe ctx expr)
              _id
        in
        is_expression_safe ctx expr
    | `Call (target_expression, args_expression_l) ->
        (* R1. Descend into all expressions *)
        let target_expr, _loc = target_expression in
        let _ =
          if enable_debugging
          then
            Printf.printf
              "is_expression_safe Call target_result=%b\n"
              (is_expression_safe ctx target_expr)
        in
        is_expression_safe ctx target_expr
        && List.for_all
             (function
               | expr, _loc -> is_expression_safe ctx expr )
             args_expression_l
  in
  is_source_safe
    { last_statement_in_letin_sequence = false; within_conditional = false }
    ast
