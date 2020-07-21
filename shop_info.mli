(** Encompasses functionality for managing shop data. *)

(** The type representing a shop. Has an inventory and a balance. *)
type t

(** Generates the daily deals for a shop randomly *)
val init_shop : t

(** Regenerates shop after an item has been purchased *)
val sell_item : int -> t -> t

(** [buy_item idx t] returns shop with a new item *)
val buy_item : Item.t -> t -> t

(** The number of items in a row of the shop *)
val width : int

(** the number of rows in the shop *)
val height : int

(** [inventory s] is the inventory associate with [s] *)
val inventory : t -> Inventory.t

(** [get_item t idx] returns item at [idx] in inventory*)
val get_item : t -> int -> Item.t option

(**[get_balance  t] returns balance*)
val get_balance : t -> int