(** This module encompasses functionality relevant to any particular 
    state of the game. Contains functions for augmenting GameStates, 
    as well as acessors. *)

(** Represents the state of the game. Right now, we are only tracking the
    state of the garden. Later, we need to implement shop_info, 
    and player_info *)
type t 

(** The state of a new game *)
val new_game : t

(** Accessor function to get the garden of a state *)
(* Useful for dealing with game states in another module. *)
val get_garden : t -> Garden.t

(** [get_shop st] is this shop pertaining to [st] *)
val get_shop : t -> Shop_info.t

(** [get_player st] is the player corresponding to [st] *)
val get_player : t -> Player_info.t

(** [get_shop_open st] is whether or not the shop in [st] is open *)
val get_shop_open : t -> bool

(** Accessor function to get the commands of a state *)
val get_cmd : t -> string

(** [get_prev_cmd st] is the previous command in [st] *)
val get_prev_cmd : t -> string

(** [get_feedback st] is the feedback in [st] *)
val get_feedback : t -> string

(** [add_char st char] is [st] with [char] appended to the command string *)
val add_char : t -> char -> t

(** [set_shop_open st] is [st] with an open shop *)
val set_shop_open : t -> t

(** [set_shop_closed st] is [st] with a closed shop *)
val set_shop_closed : t -> t

(** [show_help st] is [st] with the feedback listing all commands *)
val show_help : t -> t

(** [bad_command st] is [st] with the command cleared an with feedback informing
    the user that the previous command could not be parsed. *)
val bad_command : t -> t

(**[bad_action st output] is [st] but with [output] as feedback*)
val bad_action : t -> string -> t

(** [step st] is the game state resulting from stepping into a new day with
    state [st] *)
val step : t -> t

(**[till g row col] tills the tile at appropriate spot *)
val till : t -> int -> int -> t

(**[water g row col] tills the tile at appropriate spot *)
val water : t -> int -> int -> t

(**[harvest g row col] harvests tile *)
val harvest : t -> int -> int -> Item.t -> t

(**[plant st row col p] plants [p] in correct tile*)
val plant : t -> int -> int -> Plant.t -> t

(** [tile_click st row col] changes layout of garden*)
val tile_click : t -> int -> int -> t

(**[shop_click st row col] changes characteristics of shop *)
val shop_click : t -> int -> t

(**[inv_click st row col] changes characteristics of player's inventory *)
val inv_click : t -> int -> t

(**[new_selected_item st idx] updates the player's current selected item *)
val new_selected : t -> Item.t option -> t

(**[buy st itm idx] buys [itm] from store*)
val buy : t -> Item.t -> int ->  t

(**[sell st itm idx] buys [itm] from store*)
val sell : t -> Item.t -> int ->  t