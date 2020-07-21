(** This module encompasses functionality for inventories of the player
    and of the shop. *)

(** The type representing an inventory. *)
type t

(** [empty width height] is an empty inventory 
    with the capacity [width]*[height]*)
val empty : int -> int ->  t

(** [is_full inv] is whether or not [inv] is full. *)
val is_full : t -> bool

(** [get_items inv] is [inv] represented as a list. *)
val get_items : t -> (Item.t option) list

(** [get_capacity inv] is the capacity of [inv] *)
val get_capacity : t -> int

(**[find_idx inv itm] returns index at of itm in inv*)
val find_idx : t -> Item.t -> int

(**[size inv] returns size of [inv].items*)
val size : t -> int

(** [add_item inv item] is [inv] with [item] added to the first available space. 
    Requires: [inv] is not full. *)
val add_item : t -> Item.t -> t

(** [use_item inv item] is [inv] without [item]. If [item] is not in
    [inv] then return [inv] *)
val use_item : t -> int -> t

(**[lst_to_inv lst] takes a list and makes an inventory of that size*)
val lst_to_inv : Item.t option list -> t

(**[make_inv items cap] takes in a list of item.t options and turns
   it into an inventory of size [cap]*)
val make_inv : Item.t option list -> int -> t

(**[get_item t idx] returns an item at specific index*)
val get_item : t -> int -> Item.t option