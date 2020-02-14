(*
*
* DIMACS parser adapted from code written by Stephane Graham-Lengrand for
* INF551 - Computational Logic: Artificial Intelligence in Mathematical Reasoning,
* École polytechnique, Fall 2018.
* Original version available at: 
* http://www.enseignement.polytechnique.fr/informatique/INF551/TD/TD1/aux/DIMACS.ml
*
*)

open String

let read_from_file filename =
  let lines = ref "" in
  let chan = open_in filename in
    try
      while true; do
	let line = input_line chan in
	  if (length line>0)&&(not ((line.[0]) = 'c')) then 
	    lines := (!lines)^"\n"^line
      done; ""
    with End_of_file ->
      close_in chan;
      !lines

let latexescaped = function
  | '%' | '{' | '}' as c -> "\\"^Char.escaped c
  | c -> Char.escaped c

let rec list_from_string s list_so_far n = 
  if (n>=length s) then List.rev list_so_far 
  else
    match s.[n] with 
      | ' ' | '\n' | '\t' -> list_from_string s list_so_far (n+1)
      | '-'  -> list_from_string s ("-"::list_so_far) (n+1)
      |  _   ->
          let rec word_from_string s word_so_far n =
	    if (n>=length s) then List.rev (word_so_far::list_so_far) 
	    else
	      begin
	        match s.[n] with
		| ' '| '\n' | '\t' -> list_from_string s (word_so_far::list_so_far) n
		| c    -> word_from_string s (word_so_far^(latexescaped c)) (n+1)
	      end
	  in
	  word_from_string s "" n

module PairLit = struct
  type t = bool*string
  let negation (b,s) = (not b,s)
end

let rec parse_cnf cnf_so_far: string list -> Sat.lit list list  = function
  | []     -> List.rev cnf_so_far
  | "0"::l -> parse_cnf cnf_so_far l
  | l -> let rec parse_clause clause_so_far ispos = function
           | []     -> parse_cnf ((List.rev clause_so_far)::cnf_so_far) []
           | "0"::l -> parse_cnf ((List.rev clause_so_far)::cnf_so_far) l
           | "-"::l -> parse_clause clause_so_far false l
           | s::l   -> parse_clause ({Sat.var1=(Z.of_int ((int_of_string s)-1)); Sat.value=ispos}::clause_so_far) true l
         in parse_clause [] true l

let rec parse_cnf_file = function
  | []     -> ([], "0")
  | "p"::"cnf"::nvars::_::l -> (parse_cnf [] l, nvars)
  | a::l -> parse_cnf_file l

let parse x =
	let clause_list, nvars = (list_from_string (read_from_file x) [] 0 |> parse_cnf_file) in
	let clauses = Array.of_list clause_list in
  	{ Sat.clauses = clauses ; Sat.nvars = Z.of_int ((int_of_string nvars)) }

let _ = 
	let fmla = parse Sys.argv.(1) in
  let t = Sys.time() in
	let ans = Sat.sat fmla in
	let result = if ans = None then "unsat" else "sat" in
  Printf.printf "%s\nexecution time:%fs\n" result (Sys.time() -. t)
