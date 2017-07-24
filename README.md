# invertn_tactic
Automatic invertn tactic from Adam's dsss17 lectures

Adam introduced a convenient ```invertN``` in his first lecture,
defined as follows.

    Ltac invert  H := inversion H; clear H; subst. 
    Ltac invert0 H := invert H; fail. 
    Ltac invert1 H := invert0 H || (invert H; [ ]). 
    Ltac invert2 H := invert1 H || (invert H; [ | ]). 
    Ltac invert3 H := invert2 H || (invert H; [ | | ]).
    Ltac invert4 H := invert2 H || (invert H; [ | | | ]).

This plugin automates this pattern for general n: ```invertn <n> <H>```.