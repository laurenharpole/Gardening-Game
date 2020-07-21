(** This module is the top level of the game. It contains the input/output loop,
    and coordinates the underlying data with its graphical representation. *)

(** Will initialize a GUI window, and then create a new game state and render
    it. Will then enter an infinite recursive loop that will await user
    input and then handle it. *)
val start : unit -> unit
