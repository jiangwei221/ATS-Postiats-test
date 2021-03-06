(* ****** ****** *)
//
// ATS:
// solving N-queen puzzle
//
(* ****** ****** *)
//
// How to test:
// ./queens
// How to compile
// patscc -DATS_MEMALLOC_LIBC-o queens queens.dats
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

fun
solutions(N:int) = let
//
fun
show
(
  board: list0(int)
) : void =
(
  list0_foreach<int>
  ( list0_reverse(board)
  , lam(n) => ((N).foreach()(lam(i) => print_string(if i = n then " Q" else " _")); print '\n')
  ) ; print_newline()
)
//
fun
safe
(
  i: int, j: int, k: int, xs: list0(int)
) : bool =
(
  case+ xs of
  | nil0() => true
  | cons0(x, xs) =>
      x != i && x != j && x != k && safe(i, j+1, k-1, xs)
    // end of [cons0]
) (* safe *)
//
fun
loop
(
  col: int, xs: list0(int)
) : void =
(N).foreach()
(
//
lam(i) =>
if
safe(i, i+1, i-1, xs)
then let
  val xs = cons0(i, xs)
in
  if col = N then show(xs) else loop(col+1, xs)
end // end of [then]
//
) (* foreach() *)
//
in
  loop(1, nil0())
end // end of [solutions]

(* ****** ****** *)

val () = solutions(8)

(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

(* end of [queens.dats] *)
