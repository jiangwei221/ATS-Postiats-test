(*
** FPL-LambdaCal
*)

(* ****** ****** *)

typedef tvar = string

(* ****** ****** *)

datatype term =
//
  | TMvar of tvar
//
  | TMlam of (tvar, term)
  | TMapp of (term, term)
//
  | TMint of (int)
//
  | TMfix of (tvar(*f*), tvar(*x*), term)
//
  | TMifnz of (term, term, term) // if non-zero then ... else ...
//
(* ****** ****** *)
//
fun
print_term(t0: term): void
fun
fprint_term(out: FILEref, t0: term): void
//
overload print with print_term
overload fprint with fprint_term
//
(* ****** ****** *)
//
fun
eval_cbn(t0: term): term // call-by-name
//
fun
eval_cbv(t0: term): term // call-by-value
//
(* ****** ****** *)
//
fun
subst0(t0: term, x0: tvar, sub: term): term
//
(* ****** ****** *)

(* end of [lambda.sats] *)
 