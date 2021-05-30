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

open Lexing
open Printf

let format_position = function
  | { pos_fname = fn; pos_lnum = line; pos_bol = 0; pos_cnum = pos } ->
      sprintf "File \"%s\", line %d, character %d" fn line pos
  | _ -> "<unknown position>"


let format_loc (l1, l2) =
  sprintf
    "file %s, line %d:%d to %d:%d"
    l1.pos_fname
    l1.pos_lnum
    l1.pos_cnum
    l2.pos_lnum
    l2.pos_cnum


let get_error loc msg = sprintf "%s at %s\n%!" msg (format_loc loc)
