(** This module serves as the interface between game data and calls to the
    Graphics API. This module generally contains functions that take some piece
     of data as input (i.e. a garden or a tile), and then makes 
    appropriate calls to
    Graphics before returning unit. *)

(** [open_window title] will create a window with title [title] and with a size
    dependent on the scale defined by the module 
    as well as Garden width and height*)
val open_window : string ->  unit

(** [render_state st mouse] draws the graphical representation of the game
    encoded in [st]. Returns unit. *)
val render_state : GameState.t -> int * int -> unit

(** [highlight (x, y)] draws the highlighted tile containing [(x, y)] and returns
    unit. *)
val highlight : (int * int) -> unit

(** [close_window ()] closes the oCaml Graphics window and returns unit. *)
val close_window : unit -> unit

(** [x_y_to_col_row (x, y)] is [Some (c, r)], where [(c, y)] is the column and 
    row of the tile containing [(x, y)]. Evaluates to [None] if [(x, y)] is
     not in 
    the garden. *)
val x_y_to_col_row : (int * int) -> (int * int) option

(** [x_y_to_player_idx (x, y)] is the index option of the player
    inventory corresponding
    to the slot containing the pixel [(x, y)]. 
    Evaluates to [None] if there is no such slot *)
val x_y_to_player_idx : (int * int) -> int option

(** [x_y_to_shop_idx (x, y)] is the index option of the shop 
    inventory corresponding
    to the slot containing the pixel [(x,y)].
     Evaluates to [None] if there is no such
    slot. *)
val x_y_to_shop_idx : (int*int) -> int option

(** [in_garden (x, y)] is whether [(x, y)] is in the bounds of the garden *)
val in_garden : (int * int) -> bool

(** [in_player_inv (x, y)] is whether or not [(x, y)] is located in the player's
    inventory. *)
val in_player_inv : (int * int) -> bool

(** [in_shop_inv (x, y)] is whether or not [(x, y)] is located in the shop's
    inventory. *)
val in_shop_inv : (int*int) -> bool