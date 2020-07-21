open Inventory
open Item

type t = {
  inventory : Inventory.t;
  balance : int;
  selected_item : Item.t option
}

let select_item (p : t) (pos : int) : t = {
  inventory = p.inventory;
  balance = p.balance;
  selected_item = List.nth (get_items p.inventory) pos;
}

let init_player_inv =
  (* Creates an empty inventory but with a can and hoe *)
  Inventory.add_item 
    (Inventory.add_item (empty 6 1) WateringCan) Hoe

let init_player = {
  inventory = init_player_inv;
  balance = 200;
  selected_item = None;
}

(* selected_item : t -> Item.t option *)
let selected_item p = p.selected_item

let balance p = p.balance

let player_inv p = p.inventory

let step p = {
  inventory = p.inventory;
  balance = p.balance;
  selected_item = None;
}

let make_player inv b s = {
  inventory = inv;
  balance = b;
  selected_item = s
}


let add_item p item = {
  inventory = Inventory.add_item (player_inv p) item;
  balance = p.balance;
  selected_item = Some item;
}

let buy_item p item = {
  inventory = Inventory.add_item (player_inv p) item;
  balance = p.balance - (Item.get_sell_price item);
  selected_item = p.selected_item
}

(** [item_to_idx p item] is the index of [item] in the inventory contained in
    [p] *)
let item_to_idx p item =
  match item with
  | Some i -> Inventory.find_idx (player_inv p) i
  | None -> 0

(** [remove_item p item] removes selected_item from inventory *)
let remove_item p item = {
  inventory = Inventory.use_item (player_inv p) (item_to_idx p item);
  balance = p.balance;
  selected_item = None
}

(** [get_item_price p idx] is the price of the item in the inventory of [p] at
    index [idx] *)
let get_item_price p idx =
  match (List.nth (Inventory.get_items p.inventory) idx ) with
  | Some i ->p.balance 
             + (Item.get_store_price i);
  | None -> p.balance

(** [sell_item p idx] sells selected_item *)
let sell_item p idx = {
  inventory = Inventory.use_item (player_inv p) idx;
  balance = get_item_price p idx;
  selected_item = None;
}

(** [get_item p idx] gets item from inventory *)
let get_item p idx =
  Inventory.get_item p.inventory idx