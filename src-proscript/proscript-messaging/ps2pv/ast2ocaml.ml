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

exception InvariantViolationError of string

exception MultiReturnError of string

exception UnknownExpressionError of string

exception TooComplexMutationError of string

type numbered_expression =
  { expr_num : int
  ; expr : Ast.identifier_t
  }

type parameter_replacement =
  { replacement_module_name : string option
  ; replacement_type : string
  }

type parameter_type = string * parameter_replacement

type translation_options =
  { treat_equality_as_assertion : bool
  ; parameter_types : parameter_type list
  }

type stack_context =
  { module_name : string
  ; constructing_buffer : bool
  ; parameter_types : parameter_type list
  ; style_letin : bool
  ; treat_equality_as_assertion : bool
  }

let recode_utf8 = Globals.recode_utf8

let init_translation_options () =
  { treat_equality_as_assertion = false; parameter_types = [] }


let error_too_complex_mutation loc =
  TooComplexMutationError
    (Lexerror.get_error
       loc
       "Currently only OCaml 'let in' translations are supported. Complicated \
        mutations cannot be translated into 'let in'. Switch your ProScript \
        code to more of a functional form" )


let join_with_prespace l =
  List.fold_left (fun a_i prev -> a_i ^ " " ^ prev) "" l


let camel_case_to_snake_case s =
  let r = Str.regexp "\\([a-z]\\)\\([A-Z]\\)" in
  let g = Str.global_replace r "\\1_\\2" s in
  StringLabels.lowercase_ascii g


(** Make OCaml identifiers that are not OCaml keywords *)
let sanitize_ocaml_id s = if s = "assert" then "xassert" else s

(** Make OCaml variables start with lowercase letter and try more generally to
    conform to the {{:https://opensource.janestreet.com/standards/} Jane Street Style Guide}
    snake case convention.

    {b NOTE}: The current implementation should be doing snake casing, but really only does
    the lowercasing of the first letter. The AST translation logic needs a more extensive
    overhaul than we can invest right now!
  *)
let sanitize_ocaml_variable s =
  let s = sanitize_ocaml_id s in
  if s = StringLabels.uncapitalize_ascii s then s else "x" ^ s


(** Make OCaml modules start with capital letter and more generally try to
    distinguish modules from module types which may be using the
    {{:https://www.cs.cornell.edu/courses/cs3110/2021sp/textbook/modules/signatures.html} older
    convention from the SML language that signature names are in ALLCAPS}
    .

    {b NOTE}: The current implementation should be lowercasing every letter except the first, but
    really only does the uppercasing of the first letter. The AST translation logic needs a more extensive
    overhaul than we can invest right now!

    The {{:https://ocaml.org/manual/moduleexamples.html#s%3Asignature} OCaml manual} still uses ALLCAPS
    for module types, so ALLCAPS is still in use.
 *)
let sanitize_ocaml_module s =
  StringLabels.capitalize_ascii (sanitize_ocaml_id s)


let preamble =
  "(* Auto-generated using code from \
   <dirsp-exchange>/proscript-messaging/ps2pv/ast2ocaml.ml *)\n\n"


let create_empty_context () =
  { module_name = ""
  ; constructing_buffer = false
  ; parameter_types = []
  ; style_letin = false
  ; treat_equality_as_assertion = false
  }


(* let | `Add ((`Add (f, g), loc), e) when chain_of_string_additions e -> *)
let rec chain_of_numberless_additions e f =
  match f with
  | `Number _n, _loc -> false
  | _ ->
    ( match e with
    | `Add (f, g), _loc when chain_of_numberless_additions f g -> true
    | `Number _n, _loc -> false
    | _ -> true )


let pad n = String.make (!Globals.pad_len * n) ' '

let pl d ((s, _loc) : Ast.statement_t) =
  match s with
  | `Block _ -> d
  | _ -> d + 1


let pt s b = if b then "(" ^ s ^ ")" else s

let standard_letin_check_options : Astpredicates.letin_check_options =
  { (* We will visit each nested function in the AST to emit OCaml source code, so
       pointless to check for 'let in' readiness of nested functions *)
    skip_nested_functions = true
  }


let rec eval_function_body d (ctx : stack_context) (program : Ast.t) =
  let rec eval d (ast : Ast.t) =
    match ast with
    | [] -> ""
    | ( `Statement (`Const [ (i, Some (`Object l, _loc_object)) ], _loc_const)
      , _loc )
      :: tl
    (*
        input:
          const Type_key = { construct: ..., another_function: ... }
        output:
          module Type_key = struct
            type t
            (* let construct = ... *)
          end
      *)
      when Astpredicates.is_object_list_composed_only_of_properties l ->
        let ctx = { ctx with module_name = recode_utf8 i } in
        "module "
        ^ ctx.module_name
        ^ " = struct\n"
        ^ eval_object_of_lets (d + 1) ctx l
        ^ pad d
        ^ "end\n"
        ^ eval d tl
    | (`Statement s, _loc) :: tl -> eval_statement d ctx s ^ eval d tl
    | (`FunctionDeclaration childf, loc) :: tl ->
        let _id_opt, _args, childast = childf in
        let letin_available =
          Astpredicates.is_ast_writable_with_letin_style
            childast
            standard_letin_check_options
        in
        let ctx = { ctx with style_letin = letin_available } in
        eval_function d ctx loc childf ^ "\n\n" ^ eval d tl
  in
  eval d program ^ "\n"


and eval_statement ?nopad:(np = false) d ctx ((p, loc) : Ast.statement_t) =
  let f = function
    | `Empty | `Debugger -> ""
    | `Return e ->
        if ctx.style_letin
        then
          match e with
          | None -> "()"
          | Some v -> eval_exp d ctx v
        else
          raise
            (MultiReturnError
               (Lexerror.get_error
                  loc
                  "Currently only OCaml 'let in' translations are supported. \
                   With 'let in', the return value must be the last \
                   expression. Switch your ProScript code to have the return \
                   statement as the last statement" ) )
    | `Throw e -> "raise " ^ eval_exp d ctx e
    | `Break i ->
        "break"
        ^ ( match i with
          | None -> ""
          | Some v -> " " ^ v )
        ^ ";"
    | `Continue i ->
        "continue"
        ^ ( match i with
          | None -> ""
          | Some v -> " " ^ recode_utf8 v )
        ^ ";"
    | `Block l ->
      ( match l with
      | [] -> ""
      | [ hd ] -> eval_statement (d + 1) ctx hd
      | ls -> "begin\n" ^ eval_statements (d + 1) ctx ls ^ pad d ^ "end" )
    | `Label (l, s) -> recode_utf8 l ^ ":\n" ^ eval_statement (d + 1) ctx s
    | `Expression (`Sequal (e, f), _loc) ->
        (* match: a.valid === true;
           It looks nonsensical, but ProScript seems to use it as a JavaScript-y way of checking that the value can be converted to truth-y.
           We can be explicit with full OCaml types to constrain the type to be boolean or look for the field to be true.
        *)
        let condition =
          "(" ^ eval_exp (d + 1) ctx e ^ " = " ^ eval_exp (d + 1) ctx f ^ ")"
        in
        (if ctx.style_letin then "let _ = " else "")
        ^ ( if ctx.treat_equality_as_assertion
          then
            (* constrain the type; validate the value *)
            Format.sprintf
              "if %s then () else raise (Invalid_argument \"not %s\")"
              condition
              (String.escaped condition)
          else
            (* constrain the type; ignore the value *)
            Format.sprintf "%s |> ignore" condition )
        ^ if ctx.style_letin then " in " else ";"
    | `Expression (`Add (e, f), _loc) ->
        (* match: a.preKeyId + 1;
           It looks nonsensical, but ProScript seems to use it as a JavaScript-y way of checking for overflow. We can be explicit with full OCaml types.
        *)
        let s = eval_exp (d + 1) ctx e in
        let t = eval_exp (d + 1) ctx f in
        (if ctx.style_letin then "let _ = " else "")
        ^ Format.sprintf
            "(*check s+t for overflow and underflow*) let s = %s in let t = %s \
             in (if (s > 0) then (if (t <= Int.max_int - s) then () else raise \
             (Invalid_argument (Format.sprintf \"(%s+%s)=(%%d+%%d) will \
             overflow\" s t))) else if (s < 0) then (if (t >= Int.min_int - s) \
             then () else raise (Invalid_argument (Format.sprintf \
             \"(%s+%s)=(%%d+%%d) will underflow\" s t))))"
            s
            t
            (String.escaped s)
            (String.escaped t)
            (String.escaped s)
            (String.escaped t)
        ^ if ctx.style_letin then " in " else ";"
    | `Expression (`Sub (e, f), _loc) ->
        (* match: a.preKeyId - 1; *)
        let s = eval_exp (d + 1) ctx e in
        let t = eval_exp (d + 1) ctx f in
        (if ctx.style_letin then "let _ = " else "")
        ^ Format.sprintf
            "(*check s-t for overflow and underflow*) let s = %s in let t = %s \
             in (if (s > 0) then (if (t > 0 || -t <= Int.max_int - s) then () \
             else raise (Invalid_argument (Format.sprintf \"(%s-%s)=(%%d - \
             %%d) will overflow\" s t))) else if (s < 0) then (if (t < 0 || (t \
             <> Int.max_int && -t >= Int.min_int - s)) then () else raise \
             (Invalid_argument (Format.sprintf \"(%s-%s)=(%%d - %%d) will \
             underflow\" s t))))"
            s
            t
            (String.escaped s)
            (String.escaped t)
            (String.escaped s)
            (String.escaped t)
        ^ if ctx.style_letin then " in " else ";"
    | `Expression e -> eval_exp d ctx e ^ if ctx.style_letin then "" else ";"
    | `If (c, t, f) ->
        "if ("
        ^ eval_exp d ctx c
        ^ ") then\n"
        ^ eval_statement (pl d t) ctx t
        ^
        ( match f with
        | None -> ""
        | Some s ->
            pad d
            ^ "else"
            ^
            ( match s with
            | `If _, _loc -> " " ^ eval_statement ~nopad:true d ctx s
            | _ -> "\n" ^ eval_statement (pl d s) ctx s ) )
    | `Do (s, e) ->
        "do\n"
        ^ eval_statement (pl d s) ctx s
        ^ pad d
        ^ "while("
        ^ eval_exp d ctx e
        ^ ");\n"
    | `While (e, s) ->
        "while(" ^ eval_exp d ctx e ^ ")\n" ^ eval_statement (pl d s) ctx s
    | `For (i, c, l, s) ->
        "for("
        ^ ( match i with
          | None -> " "
          | Some (e, _) ->
            ( match e with
            | `Expression f -> eval_exp d ctx ~inless:true f
            | `Declaration l ->
                "let "
                ^ List.fold_right
                    (fun (i, v) b ->
                      sanitize_ocaml_variable i
                      ^ ( match v with
                        | None -> ""
                        | Some v -> " = " ^ eval_exp d ctx ~commaless:true v )
                      ^ if b = "" then b else ", " ^ b )
                    l
                    "" ) )
        ^ "; "
        ^ ( match c with
          | None -> ""
          | Some e -> eval_exp d ctx e )
        ^ "; "
        ^ ( match l with
          | None -> ""
          | Some e -> eval_exp d ctx e )
        ^ ")\n"
        ^ eval_statement (pl d s) ctx s
    | `Forin ((i, _), e, s) ->
        "for("
        ^ ( match i with
          | `Expression f -> eval_exp d ctx ~inless:true f
          | `Declaration l ->
              let i, v = List.hd l in
              "let "
              ^ sanitize_ocaml_variable i
              ^
              ( match v with
              | None -> ""
              | Some v -> "=" ^ eval_exp d ctx ~inless:true v ) )
        ^ " in "
        ^ eval_exp d ctx e
        ^ ")\n"
        ^ eval_statement (pl d s) ctx s
    | `With (e, s) ->
        "with(" ^ eval_exp d ctx e ^ ")\n" ^ eval_statement (pl d s) ctx s
    | `Switch (e, def, cases) ->
        "switch("
        ^ eval_exp d ctx e
        ^ ")\n"
        ^ pad d
        ^ "{\n"
        ^ List.fold_left
            (fun a (e, l) ->
              a
              ^ pad (d + 1)
              ^ "case "
              ^ eval_exp d ctx e
              ^ ":\n"
              ^ eval_statements (d + 2) ctx l )
            ""
            cases
        ^ ( match def with
          | None -> ""
          | Some l -> pad (d + 1) ^ "default:\n" ^ eval_statements (d + 2) ctx l
          )
        ^ pad d
        ^ "}\n"
    | `Try (b, c, f) ->
        "try\n"
        ^ eval_statement (pl d b) ctx b
        ^ ( match c with
          | Some (i, c) ->
              pad d ^ "catch(" ^ i ^ ")\n" ^ eval_statement (pl d c) ctx c
          | None -> "" )
        ^
        ( match f with
        | Some f -> pad d ^ "finally\n" ^ eval_statement (pl d f) ctx f
        | None -> "" )
    | `Declaration l | `Const l ->
        if ctx.style_letin
        then
          "let "
          ^ List.fold_right
              (fun (i, v) b ->
                sanitize_ocaml_variable i
                ^ ( match v with
                  | None -> ""
                  | Some v -> " = " ^ eval_exp (d + 1) ctx ~commaless:true v )
                ^ if b = "" then b else ",\n" ^ pad (d + 1) ^ b )
              l
              ""
          ^ " in"
        else raise (error_too_complex_mutation loc)
  in

  (if np then "" else pad d) ^ f p ^ "\n"


and eval_statements d ctx l =
  let text =
    List.fold_left
      (fun a b ->
        { expr_num = a.expr_num + 1; expr = a.expr ^ eval_statement d ctx b } )
      { expr_num = 1; expr = "" }
      l
  in
  text.expr


and eval_exp ?commaless:(cl = false) ?inless:(il = false) d (ctx : stack_context)
    =
  let rec ppe d (ctx : stack_context) (input, loc) =
    match input with
    | `This -> ("this", 0)
    | `Null -> ("null", 0)
    | `Undefined -> ("undefined", 0)
    | `Elision -> ("undefined", 0)
    | `Bool b -> ((if b then "true" else "false"), 0)
    | `Number n -> (Globals.cutdot (Format.sprintf "%F" n), 0)
    | `String s -> ("(ProScript.of_string \"" ^ recode_utf8 s ^ "\")", 0)
    | `Regexp (r, f) -> ("/" ^ recode_utf8 ~regexp:true r ^ "/" ^ f, 0)
    | `Identifier id -> (recode_utf8 id, 0)
    | `Array l ->
        let buffer_making_array =
          Astpredicates.is_array_composed_only_of_element_accesses l
        in
        let child_ctx =
          if buffer_making_array
          then { ctx with constructing_buffer = true }
          else ctx
        in
        if buffer_making_array
        then
          ( "(ProScript.of_elem_list ["
            ^ eval_semicolonlist (d + 1) child_ctx l
            ^ "])"
          , 0 )
        else
          ( ( match l with
            | [] -> "[| |]"
            | _ -> "[| " ^ eval_semicolonlist (d + 1) child_ctx l ^ " |]" )
          , 0 )
    | `Object l ->
        ( ( match l with
          | [] -> "{}"
          | _ -> "{\n" ^ eval_object (d + 1) ctx l ^ pad d ^ "}" )
        , 0 )
    | `Function (f : Ast.function_t) ->
        let _id_opt, _args, ast = f in
        let letin_available =
          Astpredicates.is_ast_writable_with_letin_style
            ast
            standard_letin_check_options
        in
        let ctx = { ctx with style_letin = letin_available } in
        ("(" ^ eval_function (d + 1) ctx loc f ^ ")", 1)
    | `Dot ((`Dot ((`Dot ((`Identifier f, _loc3), k), _loc2), j), _loc), i)
      when f = "ProScript" ->
        (* We can't use ProScript.crypt.ED25519.xxx. Instead we need ProScript.Crypt.ED25519 since 'Crypt' must be a capitalized module name *)
        ( pt f false
          ^ "."
          ^ sanitize_ocaml_module k
          ^ "."
          ^ sanitize_ocaml_module j
          ^ "."
          ^ sanitize_ocaml_variable i
        , 1 )
    | `Dot ((`Dot ((`Identifier f, _loc2), j), _loc), i) when f = "ProScript" ->
        (* We can't use ProScript.evaluate.xxx. Instead we need ProScript.Evaluate.xxx since 'Evaluate' must be a capitalized module name *)
        ( pt f false
          ^ "."
          ^ sanitize_ocaml_module j
          ^ "."
          ^ sanitize_ocaml_variable i
        , 1 )
    | `Dot ((`Identifier f, _loc), i) when f = ctx.module_name ->
        (* In OCaml you can't refer to the module name in the middle of defining the module *)
        (sanitize_ocaml_id i, 1)
    | `Dot (e, i) ->
      ( match e with
      | `Call (_f, _l), _loc ->
          let s, p = ppe d ctx e in
          (pt s (p > 1) ^ "." ^ sanitize_ocaml_id i, 1)
      | _ ->
          let s, p = ppe d ctx e in
          (pt s (p > 1) ^ "." ^ sanitize_ocaml_id i, 1) )
    | `Property (e, f) ->
        let s, p = ppe d ctx e in
        if ctx.constructing_buffer
        then
          ( "(ProScript.elem_at " ^ pt s (p > 1) ^ " " ^ eval_exp d ctx f ^ ")"
          , 1 )
        else (pt s (p > 1) ^ ".(" ^ eval_exp d ctx f ^ ")", 1)
    | `Call (f, l) ->
        let f' =
          (* Change (UTIL.HKDF xxx) into (UTIL.hkdf xxx) since we know the last Dot within a function call must be a variable name *)
          match f with
          | `Dot (e, i), loc -> (`Dot (e, sanitize_ocaml_variable i), loc)
          | _ -> f
        in
        let s, p = ppe d ctx f' in
        ("(" ^ pt s (p > 1) ^ " " ^ eval_callargs d ctx l ^ ")", 1)
    | `New (e, f) ->
        let s, p = ppe d ctx e in
        ( ( "new "
          ^ pt s (p > 2)
          ^
          match f with
          | Some l -> "(" ^ eval_elist d ctx l ^ ")"
          | None -> "" )
        , 2 )
    | `Preincr e ->
        let s, p = ppe d ctx e in
        ("++" ^ pt s (p > 3), 3)
    | `Predecr e ->
        let s, p = ppe d ctx e in
        ("--" ^ pt s (p > 3), 3)
    | `Postincr e ->
        let s, p = ppe d ctx e in
        (pt s (p > 3) ^ "++", 3)
    | `Postdecr e ->
        let s, p = ppe d ctx e in
        (pt s (p > 3) ^ "--", 3)
    | `Plus e ->
        let s, p = ppe d ctx e in
        ("+" ^ pt s (p > 3), 3)
    | `Minus e ->
        let s, p = ppe d ctx e in
        ("-" ^ pt s (p > 3), 3)
    | `Bnot e ->
        let s, p = ppe d ctx e in
        ("~" ^ pt s (p > 3), 3)
    | `Lnot e ->
        let s, p = ppe d ctx e in
        ("!" ^ pt s (p > 3), 3)
    | `Typeof e ->
        let s, p = ppe d ctx e in
        ("typeof " ^ pt s (p > 3), 3)
    | `Delete e ->
        let s, p = ppe d ctx e in
        ("delete " ^ pt s (p > 3), 3)
    | `Void e ->
        let s, p = ppe d ctx e in
        ("void " ^ pt s (p > 3), 3)
    | `Mod (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 6) ^ " % " ^ pt s2 (p2 > 3), 4)
    | `Divide (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 6) ^ " / " ^ pt s2 (p2 > 4), 5)
    | `Multiply (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 6) ^ " * " ^ pt s2 (p2 > 6), 6)
    | `Add (e, f) when chain_of_numberless_additions e f ->
        let rec unroll ctx h =
          match h with
          | `Add (i, j), _loc ->
              let si, pi = ppe d ctx j in
              let x = pt si (pi > 7) in
              unroll ctx i ^ ";\n" ^ pad (d + 1) ^ x
          | _ ->
              let s1, p1 = ppe d ctx h in
              let x = pt s1 (p1 > 7) in
              "\n" ^ pad (d + 1) ^ x
        in
        let child_ctx = { ctx with constructing_buffer = true } in
        let s2, p2 = ppe d child_ctx f in
        let x = pt s2 (p2 > 7) in
        ( "(ProScript.concat ["
          ^ unroll child_ctx e
          ^ ";\n"
          ^ pad (d + 1)
          ^ x
          ^ "\n"
          ^ pad d
          ^ "])"
        , 7 )
    | `Add (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 7) ^ " + " ^ pt s2 (p2 > 7), 7)
    | `Sub (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 7) ^ " - " ^ pt s2 (p2 > 7), 7)
    | `Lsh (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 8) ^ " << " ^ pt s2 (p2 > 7), 8)
    | `Rsh (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 8) ^ " >> " ^ pt s2 (p2 > 7), 8)
    | `Ash (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 8) ^ " >>> " ^ pt s2 (p2 > 7), 8)
    | `Lt (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 9) ^ " < " ^ pt s2 (p2 > 8), 9)
    | `Gt (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 9) ^ " > " ^ pt s2 (p2 > 8), 9)
    | `Le (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 9) ^ " <= " ^ pt s2 (p2 > 8), 9)
    | `Ge (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 9) ^ " >= " ^ pt s2 (p2 > 8), 9)
    | `In (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt (pt s1 (p1 > 9) ^ " in " ^ pt s2 (p2 > 8)) il, 9)
    | `Instanceof (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 9) ^ " instanceof " ^ pt s2 (p2 > 8), 9)
    | `Equal (e, f) | `Sequal (e, f) ->
        (* Always use OCaml deep structural equality. Never do '==' (`Equal which is equivalency after type conversions) or '===' (`Sequal which is type equality and shallow equality) *)
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 10) ^ " = " ^ pt s2 (p2 > 9), 10)
    | `Band (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 11) ^ " & " ^ pt s2 (p2 > 10), 11)
    | `Bxor (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 12) ^ " ^ " ^ pt s2 (p2 > 11), 12)
    | `Bor (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 13) ^ " | " ^ pt s2 (p2 > 12), 13)
    | `Land (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 14) ^ " && " ^ pt s2 (p2 > 13), 14)
    | `Lor (e, f) ->
        let s1, p1 = ppe d ctx e
        and s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 15) ^ " || " ^ pt s2 (p2 > 14), 15)
    | `Conditional (c, e, f) ->
        let s1, p1 = ppe d ctx c
        and s2, p2 = ppe d ctx e
        and s3, p3 = ppe d ctx f in
        (pt s1 (p1 > 16) ^ " ? " ^ pt s2 (p2 > 16) ^ " : " ^ pt s3 (p3 > 16), 16)
    | `Assign ((`Dot ((`Identifier id_id, id_loc), dot_id), dot_loc), f) ->
        (*
          property assignment.
          input:
            a.ephemeralKey = Type_key.assert(a.ephemeralKey);
          output if style=letin will use immediate record mutation:
           let _ = a.ephemeralKey <- (Type_key.assert a.ephemeralKey) in
        *)
        let e = (`Dot ((`Identifier id_id, id_loc), dot_id), dot_loc) in
        let s1, p1 = ppe d ctx e in
        let s2, p2 = ppe d ctx f in
        if ctx.style_letin
        then
          ("let _ = " ^ pt s1 (p1 > 16) ^ " <- " ^ pt s2 (p2 > 17) ^ " in ", 17)
        else raise (error_too_complex_mutation loc)
    | `Assign
        ( ( `Property (array_expression, (`Number array_idx, _num_loc))
          , _prop_loc )
        , f ) ->
        (*
          array assignment.
          input:
            a.recvKeys[0] = Type_key.assert(a.recvKeys[0]);
          output if style=letin will use immediate record mutation:
            let _ = Array.set a.recvKeys 0 (Type_key.xassert a.recvKeys.(0)) in
        *)
        let s1, p1 = ppe d ctx array_expression in
        let s2, p2 = ppe d ctx f in
        if ctx.style_letin
        then
          ( "let _ = Array.set "
            ^ pt s1 (p1 > 16)
            ^ " "
            ^ string_of_int (int_of_float array_idx)
            ^ " "
            ^ pt s2 (p2 > 17)
            ^ " in "
          , 17 )
        else raise (error_too_complex_mutation loc)
    | `Assign (e, f) ->
        (*
          bare assignment.
          input:
            dec = RATCHET.tryDecrypt();
          output if style=letin will use local variable shadowing:
            let dec = RATCHET.tryDecrypt () in
          *)
        let s1, p1 = ppe d ctx e in
        let s2, p2 = ppe d ctx f in
        if ctx.style_letin
        then ("let " ^ pt s1 (p1 > 16) ^ " = " ^ pt s2 (p2 > 17) ^ " in ", 17)
        else raise (error_too_complex_mutation loc)
    | `Ashassign (e, f) ->
        let s1, p1 = ppe d ctx e in
        let s2, p2 = ppe d ctx f in
        (pt s1 (p1 > 16) ^ " >>>= " ^ pt s2 (p2 > 17), 17)
    | `Sequence e -> (pt (eval_elist d ctx e) cl, 18)
    | _ ->
        raise
          (UnknownExpressionError
             (Lexerror.get_error loc "<unknown expression>") )
  in
  fun e -> fst (ppe d ctx e)


and eval_elist d ctx = function
  | [ h ] -> eval_exp d ctx ~commaless:true h
  | h :: t -> eval_exp d ctx ~commaless:true h ^ ", " ^ eval_elist d ctx t
  | [] -> ""


and eval_callargs d ctx = function
  | [ h ] -> eval_exp d ctx ~commaless:true h
  | [] -> "()"
  | l ->
      String.concat
        " "
        (List.map
           (function
             | h -> "(" ^ eval_exp d ctx ~commaless:true h ^ ")" )
           l )


and eval_semicolonlist d (ctx : stack_context) = function
  | [ h ] -> eval_exp d ctx ~commaless:true h
  | h :: t ->
      eval_exp d ctx ~commaless:true h ^ "; " ^ eval_semicolonlist d ctx t
  | [] -> ""


and eval_function
    d ?decl:(h = true) (ctx : stack_context) loc ((n, args, b) : Ast.function_t)
    =
  let name =
    match n with
    | Some i -> sanitize_ocaml_variable i
    | None -> ""
  in
  try
    (if h then "function " ^ name else "")
    ^ "("
    ^ eval_elist d ctx (List.map (fun s -> (`Identifier s, loc)) args)
    ^ ")"
    ^ ( match List.length b with
      | 0 -> "{"
      | _ -> "\n" ^ pad d ^ "{\n" ^ eval_function_body (d + 1) ctx b ^ pad d )
    ^ "}"
  with
  | MultiReturnError msg
   |UnknownExpressionError msg
   |TooComplexMutationError msg ->
      (* Yes, the shim name for anonymous functions is pretty unstable; whenever the
         ProScript changes, the shim name changes. However, there is no good way to
         name anonymous functions! *)
      let l1, _l2 = loc in
      "(* "
      ^ String.trim msg
      ^ " *) "
      ^ "shim_"
      ^ (if ctx.module_name = "" then "" else ctx.module_name ^ "_")
      ^ if name = "" then name else "line" ^ string_of_int l1.pos_lnum


and eval_object d ctx (obj_prop_l : Ast.object_prop_t list) =
  let visit = function
    | h, loc ->
        let p =
          match h with
          | `Property (p, v) ->
              sanitize_ocaml_id p ^ " = " ^ eval_exp d ctx ~commaless:true v
          | `Getter (p, f) ->
              let _id_opt, _args, ast = f in
              let letin_available =
                Astpredicates.is_ast_writable_with_letin_style
                  ast
                  standard_letin_check_options
              in
              let ctx = { ctx with style_letin = letin_available } in
              "let get_"
              ^ sanitize_ocaml_variable p
              ^ " = begin\n"
              ^ eval_function (d + 1) ctx ~decl:false loc f
              ^ pad d
              ^ "end\n"
          | `Setter (p, f) ->
              let _id_opt, _args, ast = f in
              let letin_available =
                Astpredicates.is_ast_writable_with_letin_style
                  ast
                  standard_letin_check_options
              in
              let ctx = { ctx with style_letin = letin_available } in
              "let set_"
              ^ sanitize_ocaml_variable p
              ^ " = begin\n"
              ^ eval_function (d + 1) ctx ~decl:false loc f
              ^ pad d
              ^ "end\n"
        in
        pad d ^ p
  in
  List.fold_left
    (fun acc obj_prop -> (if acc = "" then "" else acc ^ ";\n") ^ visit obj_prop)
    ""
    obj_prop_l
  ^ "\n"


and eval_object_of_lets d ctx = function
  | (`Property (p, (`Function f, _loc_f)), _loc) :: t ->
      let _n, args, b = f in
      let name = sanitize_ocaml_variable p in
      let qualify_args ctx args =
        List.map
          (fun argname ->
            match List.assoc_opt argname ctx.parameter_types with
            | Some
                { replacement_module_name = Some filter_module_name
                ; replacement_type
                } ->
                if ctx.module_name = filter_module_name
                then "(" ^ argname ^ " : " ^ replacement_type ^ ")"
                else argname
            | Some { replacement_module_name = None; replacement_type } ->
                "(" ^ argname ^ " : " ^ replacement_type ^ ")"
            | None -> argname )
          args
      in
      ( try
          let p =
            "let "
            ^ name
            ^ ( match args with
              | [] -> " ()"
              | _ -> join_with_prespace (qualify_args ctx args) )
            ^ " = begin\n"
            ^ eval_function_body (d + 1) ctx b
            ^ pad d
            ^ "end\n"
          in
          pad d ^ p ^ "\n" ^ eval_object_of_lets d ctx t
        with
      | MultiReturnError msg
       |UnknownExpressionError msg
       |TooComplexMutationError msg ->
          pad d
          ^ "let "
          ^ name
          ^ " =\n"
          ^ pad (d + 1)
          ^ "(* "
          ^ String.trim msg
          ^ " *)\n"
          ^ pad (d + 1)
          ^ "shim_"
          ^ (if ctx.module_name = "" then "" else ctx.module_name ^ "_")
          ^ name
          ^ "\n"
          ^ eval_object_of_lets d ctx t )
  | _ :: _ ->
      failwith
        "Precondition violation: Only properties of functions are allowed in \
         eval_object_of_lets"
  | [] -> ""


let eval_toplevel_source d (program : Ast.t) (t_ops : translation_options) =
  let letin_available =
    Astpredicates.is_ast_writable_with_letin_style
      program
      standard_letin_check_options
  in
  let ctx = create_empty_context () in
  let ctx =
    { ctx with
      parameter_types = t_ops.parameter_types
    ; treat_equality_as_assertion = t_ops.treat_equality_as_assertion
    ; style_letin = letin_available
    }
  in
  eval_function_body d ctx program


let translate
    (program : Ast.t)
    (types_module : string)
    (interface_module : string)
    (t_ops : translation_options) =
  preamble
  ^ "include "
  ^ types_module
  ^ "\n\n\
     module Make(ProScript : Dirsp_proscript.S) : (PROTOCOL with type t = \
     ProScript.t) = struct\n"
  ^ pad 1
  ^ "type t = ProScript.t\n"
  ^ pad 1
  ^ "type t_aes_decrypted = ProScript.Crypto.aes_decrypted\n"
  ^ pad 1
  ^ "include "
  ^ interface_module
  ^ ".Make(ProScript)\n"
  ^ eval_toplevel_source 1 program t_ops
  ^ "\nend\n"
