(** This module encompasses functionality of an item, which is the element
    of an inventory. *)

(** The type representing an item *)
type t =
  | Plant of Plant.t
  | WateringCan
  | Hoe

(**[get_store_price i] returns price of item in store*)
val get_store_price : t -> int

(**[get_sell_price i] returns price of sell*)
val get_sell_price : t -> int

(**[get_store_price_opt i] returns price of item in store*)
val get_store_price_opt : t option -> int

(**[item_opt_to_string i] returns string representation of item*)
val item_opt_to_string : t option -> string