open Garden
open Shop_info
open Player_info
open Item

type t = {
  g : Garden.t;
  shop_open: bool;
  shop: Shop_info.t;
  player: Player_info.t;
  selected_item : Item.t option;
  prev_cmd: string;
  feedback: string;
  cmd: string;
}

let new_game =
  {
    g = Garden.new_garden ();
    shop_open = false;
    shop = init_shop;
    player = init_player;
    selected_item = None;
    prev_cmd = "";
    feedback = "";
    cmd = "";
  }

let get_garden (st:t) = st.g

let get_cmd (st:t) = st.cmd

let get_prev_cmd st = st.prev_cmd

let get_feedback st = st.feedback

let get_shop_open st = st.shop_open

(* MUST CHANGE WHEN SHOP INFO IS IMPLEMENTED *)
let get_shop st = st.shop

let get_player st = st.player

let show_help st =
  {
    g =st.g;
    shop_open = st.shop_open;
    shop = st.shop;
    player = st.player;
    selected_item = st.selected_item;
    cmd = "";
    prev_cmd = st.cmd;
    feedback = "commands: \"sleep\"
     \"open shop\" \"close shop\" \"help\" \"quit\"";
  }

let bad_command st =
  {
    g =st.g;
    shop_open = st.shop_open;
    shop = st.shop;
    player = st.player;
    selected_item = st.selected_item;
    cmd = "";
    prev_cmd = st.cmd;
    feedback = "Unknown command!";
  }

let bad_action st output =
  {
    g =st.g;
    shop_open = st.shop_open;
    shop = st.shop;
    player = st.player;
    selected_item = st.selected_item;
    cmd = st.cmd;
    prev_cmd = st.cmd;
    feedback = output;
  }

let set_shop_open st =
  {
    g =st.g;
    shop_open = true;
    shop = st.shop;
    player = st.player;
    selected_item = st.selected_item;
    cmd = "";
    prev_cmd = st.cmd;
    feedback = "opened shop";
  }

let set_shop_closed st =
  {
    g =st.g;
    shop_open = false;
    shop = st.shop;
    player = st.player;
    selected_item = st.selected_item;
    cmd = "";
    prev_cmd = st.cmd;
    feedback = "closed shop";
  }

let add_char st char =
  {
    g = st.g;
    shop_open = st.shop_open;
    shop = st.shop;
    player = st.player;
    selected_item = st.selected_item;
    cmd = if (Char.code char) = 8 then
        (let length = String.length st.cmd in
         if length > 0 then String.sub st.cmd 0 (length - 1)
         else st.cmd)
      else st.cmd^(Char.escaped char);
    prev_cmd = st.prev_cmd;
    feedback = st.feedback;
  }

let step (old_state : t) : t = 
  {
    g = Garden.step old_state.g;
    shop_open = old_state.shop_open;
    shop = Shop_info.init_shop;
    player = Player_info.step old_state.player;
    selected_item = None;
    cmd = "";
    prev_cmd = old_state.cmd;
    feedback = "zzzzz......";
  }

let till st row col = {
  g = Garden.till_tile (st.g) row col;
  shop_open = st.shop_open;
  shop = st.shop;
  player = st.player;
  selected_item = st.selected_item;
  cmd = st.cmd;
  prev_cmd = st.prev_cmd;
  feedback = Item.item_opt_to_string st.selected_item
}

let water st row col = {
  g = Garden.water_tile (st.g) row col;
  shop_open = st.shop_open;
  shop = st.shop;
  player = st.player;
  selected_item = st.selected_item;
  cmd = st.cmd;
  prev_cmd = st.prev_cmd;
  feedback = "Thanks for watering!"
}

let harvest st row col p = {
  g = Garden.harvest_tile st.g row col;
  shop_open = st.shop_open;
  shop = st.shop;
  player = Player_info.add_item st.player p;
  selected_item = st.selected_item;
  cmd = st.cmd;
  prev_cmd = st.prev_cmd;
  feedback = st.feedback
}


let plant st row col p = {
  g = Garden.plant_tile st.g row col p;
  shop_open = st.shop_open;
  shop = st.shop;
  player =  Player_info.remove_item st.player (Some (Plant p)) ;
  selected_item = st.selected_item;
  cmd = st.cmd;
  prev_cmd = st.prev_cmd;
  feedback = "You planted a seed <3"
}

let new_selected st itm = {
  g =st.g;
  shop_open = st.shop_open;
  shop = st.shop;
  player = st.player;
  selected_item = itm;
  cmd = st.cmd;
  prev_cmd = st.prev_cmd;
  feedback = item_opt_to_string itm
}

let buy st itm idx = {
  g = st.g;
  shop_open = true;
  shop = Shop_info.sell_item idx st.shop;
  player = Player_info.buy_item st.player itm;
  selected_item = st.selected_item;
  cmd = st.cmd;
  prev_cmd = st.prev_cmd;
  feedback = "Item purchased!"
}

let sell st itm idx = {
  g = st.g;
  shop_open = st.shop_open;
  shop = st.shop;
  player = Player_info.sell_item st.player idx;
  selected_item = st.selected_item;
  cmd = st.cmd;
  prev_cmd = st.prev_cmd;
  feedback = "Item soooooold... to the only bidder"
}

let tile_click st row col = 
  let tile = Garden.get_tile st.g row col in
  let item = st.selected_item in
  match tile, item with
  | Grass, Some Hoe -> till st row col
  | Dirt, Some Hoe -> till st row col
  | Plant p, _ when not (Plant.is_alive p) -> till st row col
  | Plant p, Some WateringCan -> water st row col
  (* we have a  boolthat checks if plant can be harvested in plant so I put 
     that in *)
  | Plant p, _ -> if Plant.is_harvest p then 
      harvest st row col (Plant p)  
    else bad_action st "! Can't harvest this guy !"
  | Tilled, Some (Plant p) when (Plant.get_age p) < 0 -> plant st row col p 
  | _, _ -> st

let shop_click st idx = 
  let item = Shop_info.get_item st.shop idx in 
  let cost = Item.get_store_price_opt item in
  let bal = Player_info.balance st.player in
  if Inventory.is_full (Player_info.player_inv st.player) 
  then bad_action st "Inventory is full" else
  if (bal >= cost) then match item with 
    | Some itm -> buy st itm idx
    | None -> bad_action st "No item to buy" else
    bad_action st "Not enough money :("

let inv_click st idx = 
  let item = Player_info.get_item st.player idx in
  (* let cost = Item.get_store_price_opt item in
     let shop_bal = Shop_info.get_balance st.shop in *)
  if (st.shop_open) then 
    match item with
    (* we have a  boolthat checks if plant can be harvested in plant so I put that in *)
    | Some (Plant p) -> if (Plant.is_harvest p) 
      then sell st (Plant p) idx 
      else bad_action st "Can't sell this... Hint: if a plant, try growing it"
    | Some itm -> bad_action st "You can't sell that!"
    | None -> bad_action st "The item you selected doesn't exist!"
  else new_selected st item       



