(*
** Polymorphism
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

typedef boxstr = boxed(string)

(* ****** ****** *)
//
fun swap_boxed{a,b:type} (xy: (a, b)): (b, a) = (xy.1, xy.0)
//
val AB = (box("A"), box("B"))
val BA1 = swap_boxed{boxstr,boxstr} (AB)
val BA2 = swap_boxed (AB) // omitting type arguments may be fine
//
(* ****** ****** *)

val () = println! ("BA1=(", unbox(BA1.0), ", ", unbox(BA1.1), ")")
val () = println! ("BA2=(", unbox(BA2.0), ", ", unbox(BA2.1), ")")

(* ****** ****** *)
//
fun swap2_boxed{a:type}{b:type} (xy: (a, b)): (b, a) = (xy.1, xy.0)
//
val AB = (box("A"), box("B"))
val BA1 = swap2_boxed (AB) // both static arguments to be synthesized
val BA2 = swap2_boxed{...} (AB) // both static arguments to be synthesized
val BA3 = swap2_boxed{..}{boxstr} (AB) // 1st static argument to be synthesized
val BA4 = swap2_boxed{boxstr}{..} (AB) // 2nd static argument to be synthesized
val BA5 = swap2_boxed{..}{..} (AB) // both static arguments to be synthesized
val BA6 = swap2_boxed{boxstr}{boxstr} (AB) // both static arguments are provided
//
(* ****** ****** *)

val () = println! ("BA1=(", unbox(BA1.0), ", ", unbox(BA1.1), ")")
val () = println! ("BA2=(", unbox(BA2.0), ", ", unbox(BA2.1), ")")
val () = println! ("BA3=(", unbox(BA3.0), ", ", unbox(BA3.1), ")")
val () = println! ("BA4=(", unbox(BA4.0), ", ", unbox(BA4.1), ")")
val () = println! ("BA5=(", unbox(BA5.0), ", ", unbox(BA5.1), ")")
val () = println! ("BA6=(", unbox(BA6.0), ", ", unbox(BA6.1), ")")

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test02.dats] *)
