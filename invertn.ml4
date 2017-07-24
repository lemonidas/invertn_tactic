DECLARE PLUGIN "invertn"

open Pp
open Constrarg
open Names

let base_invert (hyp : Id.t) = 
  Proofview.Goal.enter { enter = begin fun gl ->
      Tacticals.New.tclTHEN 
        (Inv.inv FullInversion None (NamedHyp hyp))
      (Tacticals.New.tclTHEN
        (Tactics.clear [hyp])
        (Equality.subst_all ()))
  end }

let rec repeat n x = 
  if n = 0 then []
  else x :: repeat (n-1) x

let rec do_invert (n : int) (hyp : Id.t) =
  Proofview.Goal.enter { enter = begin fun gl ->
    if n = 0 then
      Tacticals.New.tclTHEN 
        (base_invert hyp)
        (Tacticals.New.tclFAIL 0 (str ".."))
    else 
      Tacticals.New.tclOR
        (do_invert (n-1) hyp)
        (Tacticals.New.tclTHENS
           (base_invert hyp)
           (repeat n Tacticals.New.tclIDTAC))
  end }


TACTIC EXTEND invertn
  | ["invertn" int_or_var(n) ident(hyp)] -> [ do_invert n hyp]
END;;

