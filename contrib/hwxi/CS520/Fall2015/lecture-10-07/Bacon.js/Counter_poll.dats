(*
** FRP via Bacon.js
*)

(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME\
/contrib/libatscc2js/ATS2-0.3.2"
//
(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"

(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Bacon.js/baconjs.sats"
staload
"{$LIBATSCC2JS}/SATS/Bacon.js/baconjs_ext.sats"
//
(* ****** ****** *)

%{^
//
var
theUps = $("#up").asEventStream("click")
var
theDowns = $("#down").asEventStream("click")
var
theRandoms = $("#random").asEventStream("click")
var
theResets = $("#reset").asEventStream("click")
//
var theCounts = 0
//
%} // end of [%{^]

(* ****** ****** *)
//
macdef ESmap = EStream_map
//
val theUps =
  $extval(EStream(void), "theUps")
val theDowns =
  $extval(EStream(void), "theDowns")
val theRandoms =
  $extval(EStream(void), "theRandoms")
val theResets =
  $extval(EStream(void), "theResets")
//
(* ****** ****** *)

datatype act = Up | Down | Random | Reset

(* ****** ****** *)
//
val theUps = ESmap (theUps, lam(x) =<cloref1> Up())
val theDowns = ESmap (theDowns, lam(x) =<cloref1> Down())
val theRandoms = ESmap (theRandoms, lam(x) =<cloref1> Random())
val theResets = ESmap (theResets, lam(x) =<cloref1> Reset())
//
val theClicks = theUps
val theClicks = merge(theClicks, theDowns)
val theClicks = merge(theClicks, theRandoms)
val theClicks = merge(theClicks, theResets)
//
(* ****** ****** *)

val
theCounts =
EStream_scan{int}{act}
(
  theClicks, 0
, lam(y, x) =<cloref1>
  case+ x of
  | Up() => min(99, y+1)
  | Down() => max(0, y-1)
  | Random() => double2int(100*JSmath_random())
  | Reset() => 0
)
//
val
theCounts = let
//
fun
stringize
(
  x0: int
) : string = let
//
  val d0 = x0 % 10
  val x1 = x0 / 10
  val d1 = x1 % 10
//
in
  String(d1) + String(d0)
end // end of [stringize]
//
in
  Property_map (theCounts, lam(x) =<cloref1> stringize(x))
end // end of [val]
//
(* ****** ****** *)
//
val
theCounts = let
//
(*
val xs = theClicks
*)
val xs =
  Bacon_interval{int}(1000, 0)
//
val poll = EValue_make_property(theCounts)
//
in
  ESmap(xs, lam(_) =<cloref1> poll[])
end // end of [val]
//
extvar "theCounts" = theCounts
//
(* ****** ****** *)
    
%{$
//
function
Counter_initize()
{
  var _ = my_dynload()
  var _ = theCounts.assign($("#counter"), "text")
}
//
jQuery(document).ready(function(){Counter_initize();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [Counter.dats] *)
