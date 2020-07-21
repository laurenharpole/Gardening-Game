open Inventory
open Item
open Plant

type t = {
  inventory : Inventory.t;
  balance : int
}

let width = 5
let height = 2

let inventory shop = shop.inventory

(** [fill_inv_flower inv] is [inv] populated with plants. *)
let fill_inv_flower inv =
  [make_spec_seed Poppy; make_spec_seed Marigold; make_spec_seed Coca;
   make_spec_seed Sassafras; make_spec_seed Petunia; make_spec_seed Poppy;
   make_spec_seed Sassafras; make_spec_seed Petunia; make_spec_seed Marigold;
   make_spec_seed Coca]
  |> List.map (fun x -> Some (Plant x)) |> Inventory.lst_to_inv

let init_shop : t = {
  inventory = fill_inv_flower (empty 5 2);
  balance = 300;
}

(** [find_price items idx] is the price of the item located 
    at index [idx] in [items] *)
let find_price items idx =
  match (List.nth items idx) with
  | None -> 0
  | Some (Plant pl) -> Plant.get_seed_price pl
  | _ -> 0

let sell_item (idx : int) (shop : t) : t = 
  let itms = get_items shop.inventory in
  {
    inventory = Inventory.use_item shop.inventory idx;
    balance = shop.balance - (find_price itms idx);
  }

let buy_item itm t =
  {
    inventory = Inventory.add_item t.inventory itm;
    balance = t.balance + (Item.get_store_price itm);
  }

let get_item t idx =
  Inventory.get_item t.inventory idx

let get_balance t =
  t.balance
