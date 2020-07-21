open Plant

type t =
  | Plant of Plant.t
  | WateringCan
  | Hoe

(* [get_store_price i] gets price for seed from store *)
let get_store_price i = 
  match i with
  | Plant p -> get_seed_price p
  | _ -> 0

(* [get_store_price_opt i] gets price for item from store *)
let get_store_price_opt i =
  match i with
  | Some itm -> get_store_price itm
  | None -> 0

(* [get_sell_price i] gets sell price for plant from store *)
let get_sell_price i =
  match i with
  | Plant p -> get_sell_price p
  | _ -> 0

(* [item_opt_to_string i] gets sell price for item from store *)
let item_opt_to_string i =
  match i with
  | Some itm -> (match itm with
      | Plant p -> Plant.to_string p
      | WateringCan -> "water can"
      | Hoe -> "hoe")
  | None -> ""