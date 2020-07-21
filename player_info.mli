(** This module encompasses functionality for managing player data. *)

(** The type representing player information. *)
type t

(** [select_item pos info] is [info] with its selected item set as the
    [pos] entry of the player inventory. *)
val select_item : t -> int -> t

(** [selected_item info] is the item that is selected by 
    the player corresponding
    to [info] *)
val selected_item : t -> Item.t option

(** Player data at the start of a game. *)
val init_player : t

(** [balance p] is the balance associated with [p] *)
val balance : t -> int

(** [player_inv p] is the inventory associate with [p] *)
val player_inv : t -> Inventory.t

(**[step p] steps p, everything same but selected item is unselected*)
val step : t -> t

(** [make_player inv b s] makes a player object*)
val make_player : Inventory.t -> int -> Item.t option -> t

(** [update_inventory player item] adds an item to a players inventory*)
val add_item : t -> Item.t -> t

(** [buy_item p item] adds item to player and decreases balance*)
val buy_item : t -> Item.t -> t

(** [use_item p idx] removes selected_item from inventory, balance stays same
    ie for planting*)
val remove_item : t -> Item.t option -> t

(** [sell_item p idx] removes selected_item at [idx] 
    and increases balance by the cost*)
val sell_item : t -> int -> t

(** [get_item p idx] returns the item at [idx] from inventory*)
val get_item : t -> int -> Item.t option