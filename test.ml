open OUnit2
open Plant
open Garden
open Player_info
open Tile
open Shop_info
open Game
open GameState
(* TESTING STRATEGY
   Our project is a farming game with a graphical user interface. This means,
   because of the nature of our project, a lot of testing was done manually by
   running the game. However, before we started testing manually, we ran 
   extensive OUnit glassbox test cases for the lower levels of our game. Though
   glassbox is not necessarily more effective, it was the most applicable test
   strategy for our project because there is only a small sample of inputs
   that can be used on each method. We're not expecting many surprises since the
   game is very contained.

   Our system is in the shape of a tree: modules extend down from gameState into
   lower level modules such as Plant. The higher level modules strongly rely on
   the lower level ones, so our testing strategy was to extensively test the 
   methods written in lower level modules to make sure our foundation is
    strong, and then afterwards, we tested the rest of our functions using
   our graphical interface. This combination of OUnit testing and manual
   graphical testing makes us pretty certain of the accuracy of our code.
*)

(* PLAYER INFO TESTS *)

let test_select_item
    (name : string)
    (p : Player_info.t)
    (pos : int)
    (expected_output : Player_info.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Player_info.select_item p pos))

let test_selected_item
    (name : string)
    (p : Player_info.t)
    (expected_output : Item.t option) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Player_info.selected_item p))

let test_balence
    (name : string)
    (p : Player_info.t)
    (expected_output : int) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Player_info.balance p))

let test_player_inv
    (name : string)
    (p : Player_info.t)
    (expected_output : Inventory.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Player_info.player_inv p))

let test_add_item
    (name : string)
    (p : Player_info.t)
    (item : Item.t)
    (expected_output : Player_info.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Player_info.add_item p item))

let test_buy_item
    (name : string)
    (p : Player_info.t)
    (item : Item.t)
    (expected_output : Player_info.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Player_info.buy_item p item))

(* let test_remove_item
    (name : string)
    (p : Player_info.t)
    (expected_output : Player_info.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Player_info.remove_item p))

   let test_sell_item
    (name : string)
    (p : Player_info.t)
    (expected_output : Player_info.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Player_info.sell_item p)) *)


(* TILE TESTS *)

(* let test_click
    (name : string)
    (t : Tile.t)
    (expected_output : Tile.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Tile.click t)) *)

(* let test_step
    (name : string)
    (t : Tile.t)
    (expected_output : Tile.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Tile.step t))

   let test_water
    (name : string)
    (t : Tile.t)
    (expected_output : Tile.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Tile.water t))

   let test_harvest
    (name : string)
    (t : Tile.t)
    (player: Player_info.t)
    (expected_output : Tile.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Tile.harvest t)) *)

(* let test_till
    (name : string)
    (t : Tile.t)
    (expected_output : Tile.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Tile.till t ))

   let test_plant
    (name : string)
    (t : Tile.t)
    (p:Plant.t)
    (expected_output : Tile.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Tile.plant t p )) *)

(* PLANT TESTS *)

let test_step
    (name : string)
    (t : Plant.t)
    (expected_output : Plant.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Plant.step t ))

let test_past_harvest
    (name : string)
    (p : Plant.t)
    (expected_output : bool) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Plant.past_harvest p ))

let test_make_seed
    (name : string)
    (spec : Plant.species)
    (sell : int)
    (buy : int)
    (expected_output : Plant.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Plant.make_seed spec sell buy ))
(* 
let test_make_rand_seed
    (name : string)
    (u : unit)
    (expected_output : Plant.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Plant.make_rand_seed u )) *)

let test_get_seed_price
    (name : string)
    (t : Plant.t)
    (expected_output : int) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Plant.get_seed_price t ))

let test_water
    (name : string)
    (t : Plant.t)
    (expected_output : Plant.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Plant.water t ))

let test_is_harvest
    (name : string)
    (t : Plant.t)
    (expected_output : bool) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Plant.is_harvest t ))

let test_is_alive
    (name : string)
    (t : Plant.t)
    (expected_output : bool) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Plant.is_alive t ))

(* SHOP INFO TESTS *)
(* let test_init_shop
    (name : string)
    (expected_output : Shop_info.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Shop_info.init_shop))

   let test_sell_item
    (name : string)
    (idx : int)
    (shop : Shop_info.t)
    (expected_output : Shop_info.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Shop_info.sell_item idx shop)) *)

(* let test_width
    (name : string)
    (shop : Shop_info.t)
    (expected_output : Inventory.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Shop_info.inventory shop))

   let test_width
    (name : string)
    (expected_output : int) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Shop_info.width))

   let test_height
    (name : string)
    (expected_output : int) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Shop_info.height)) *)

(* INVENTORY TESTS *)

let test_empty
    (name : string)
    (width : int)
    (height : int)
    (expected_output : Inventory.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Inventory.empty width height))

let test_is_full
    (name : string)
    (t: Inventory.t)
    (expected_output : bool) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Inventory.is_full t))

let test_get_items
    (name : string)
    (inv: Inventory.t)
    (expected_output : Item.t option list) : test =
  name >:: (fun _ -> 
      assert_equal expected_output  (Inventory.get_items inv))

let test_get_capacity
    (name : string)
    (t: Inventory.t)
    (expected_output : int) : test =
  name >:: (fun _ -> 
      assert_equal expected_output  (Inventory.get_capacity t))

let test_size
    (name : string)
    (t: Inventory.t)
    (expected_output : int) : test =
  name >:: (fun _ -> 
      assert_equal expected_output  (Inventory.size t))

let test_add_item
    (name : string)
    (inv: Inventory.t)
    (item: Item.t)
    (expected_output : Inventory.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output  (Inventory.add_item inv item))

(* let test_use_item
    (name : string)
    (inv: Inventory.t)
    (idx: int)
    (expected_output : Inventory.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (Inventory.use_item inv idx)) *)
(* let test_buy_item
    (name : string)
    (p : Player_info.t)
    (item : Item.t)
    (expected_output : Player_info.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Player_info.buy_item p item)) *)

(* let test_sell_item
    (name : string)
    (p : Player_info.t)
    (expected_output : Player_info.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output (Player_info.sell_item p)) *)

let test_lst_to_inv
    (name : string)
    (lst: Item.t option list)
    (expected_output :Inventory.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output  (Inventory.lst_to_inv lst))

(* GAME *)
(* 
let test_start
    (name : string)
    (u: unit)
    (expected_output :unit) : test =
  name >:: (fun _ -> 
      assert_equal expected_output  (Game.start u)) *)

(* GAME STATE *)

(* let test_new_game
    (name : string)
    (expected_output :GameState.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.new_game)) *)

(* let test_get_garden
    (name : string)
    (st :GameState.t)
    (expected_output :Garden.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.get_garden st))

   let test_get_shop
    (name : string)
    (st :GameState.t)
    (expected_output :Shop_info.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.get_shop st))

   let test_get_shop_open
    (name : string)
    (st :GameState.t)
    (expected_output :bool) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.get_shop_open st)) *)

(* let test_get_cmd
    (name : string)
    (st :GameState.t)
    (expected_output :string) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.get_cmd st))

   let test_get_prev_cmd
    (name : string)
    (st :GameState.t)
    (expected_output :string) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.get_prev_cmd st)) *)

(* let test_get_feedback
    (name : string)
    (st :GameState.t)
    (expected_output :string) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.get_feedback st))

   let test_add_char
    (name : string)
    (st :GameState.t)
    (char :char)
    (expected_output :GameState.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.add_char st char)) *)

(* let test_set_shop_open
    (name : string)
    (st :GameState.t)
    (expected_output :GameState.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.set_shop_open st))

   let test_set_shop_closed
    (name : string)
    (st :GameState.t)
    (expected_output :GameState.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.set_shop_closed st))

   let test_show_help
    (name : string)
    (st :GameState.t)
    (expected_output :GameState.t) : test =
   name >:: (fun _ -> 
      assert_equal expected_output  (GameState.show_help st)) *)
(* 
let test_bad_command
    (name : string)
    (st:GameState.t)
    (expected_output :GameState.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output  (GameState.bad_command st))

let test_tile_click
    (name : string)
    (st:GameState.t)
    (row:int)
    (col:int)
    (expected_output :GameState.t) : test =
  name >:: (fun _ -> 
      assert_equal expected_output  (GameState.tile_click st  row col)) *)

(*a young petunia *)
let aPlant  = (Plant.make_seed Petunia 3 2) 
(*a young petunia *)
let bPlant  = Plant.make_seed Petunia 4 3

let cPlant  = Plant.make_seed Sassafras 4 3

let dPlant  = Plant.make_seed Coca 1 1 

let ePlant  = Plant.make_seed Poppy 5 4 

let fPlant  = Plant.make_seed Poppy 2 2 

let gPlant  = Plant.make_seed Coca 5 4 

let hPlant  = Plant.make_seed Coca 7 7 

let iPlant  = Plant.make_seed Coca 7 7 


let iiPlant  = Plant.make_seed Coca 7 7 

let anInventory = Inventory.make_inv [] 3 

let bInventory = (Inventory.add_item anInventory (Plant (aPlant))) 

let cInventory = (Inventory.add_item anInventory (Plant(aPlant))) 

let aPlayer = (Player_info.make_player (Inventory.make_inv 
                                          [Some (Plant (Plant.make_seed 
                                                          Marigold 5 5))] 3) 
                 1000 None) 

let invent1 = Player_info.player_inv aPlayer 

let water  = (Plant.water aPlant) 

let anInventory = (Inventory.make_inv [] 3) 

let cPlayer = Player_info.add_item aPlayer ((Plant (Plant.make_seed Sassafras 
                                                      3 3))) 

let tests = [

  test_selected_item "Selected item"
    (Player_info.make_player (Inventory.make_inv
                                [Some (Plant (Plant.make_seed Marigold 5 5))] 3)
       1000 (Some (Plant (Plant.make_seed Marigold 5 5))))
    (Some (Plant (Plant.make_seed Marigold 5 5)));

  test_player_inv "the balance of the select item" aPlayer invent1;
  test_get_seed_price "seed price for aPlant" aPlant 2;
  test_is_harvest "aplant harvest" aPlant false;
  test_is_alive "aplant is alive" aPlant true;
  test_make_seed "make the aPlant" Petunia 3 2 aPlant;
  test_past_harvest "dat bitch be ded?" aPlant false;

  test_get_seed_price "seed price for bPlant" bPlant 3;
  test_is_harvest "bplant harvest" bPlant false;
  test_is_alive "bplant is blive" bPlant true;
  test_make_seed "make the bPlant" Petunia 4 3 bPlant;
  test_past_harvest "dat bitch be ded?" bPlant false;

  test_get_seed_price "seed price for cPlant" cPlant 3;
  test_is_harvest "cplant harvest" cPlant false;
  test_is_alive "cplant is alive" cPlant true;
  test_make_seed "make the cPlant"  Sassafras 4 3 cPlant;
  test_past_harvest "dat bitch be ded?" cPlant false;

  test_get_seed_price "seed price for dPlant" dPlant 1;
  test_is_harvest "dplant harvest" dPlant false;
  test_is_alive "dplant is alive" dPlant true;
  test_make_seed "make the dPlant" Coca 1 1 dPlant;
  test_past_harvest "dat bitch be ded?" dPlant false;

  test_get_seed_price "seed price for ePlant" ePlant 4;
  test_is_harvest "eplant harvest" ePlant false;
  test_is_alive "eplant is alive" ePlant true;
  test_make_seed "make the dPlant" Poppy 5 4 ePlant;
  test_past_harvest "dat bitch be ded?" ePlant false;

  test_get_seed_price "seed price for fPlant" fPlant 2;
  test_is_harvest "fplant harvest" fPlant false;
  test_is_alive "fplant is alive" fPlant true;
  test_make_seed "make the fPlant" Poppy 2 2 fPlant;
  test_past_harvest "dat bitch be ded?" fPlant false;

  test_get_seed_price "seed price for gPlant" gPlant 4;
  test_is_harvest "gplant harvest" gPlant false;
  test_is_alive "gplant is alive" gPlant true;
  test_make_seed "make the gPlant" Coca 5 4 gPlant;
  test_past_harvest "dat bitch be ded?" gPlant false;

  test_get_seed_price "seed price for hPlant" hPlant 7;
  test_is_harvest "hplant harvest" hPlant false;
  test_is_alive "hplant is alive" hPlant true;
  test_make_seed "make the hPlant" Coca 7 7 hPlant;
  test_past_harvest "dat bitch be ded?" hPlant false;

  test_get_seed_price "seed price for iPlant" iPlant 7;
  test_is_harvest "iplant harvest" iPlant false;
  test_is_alive "iplant is alive" iPlant true;
  test_make_seed "make the iPlant" Coca 7 7 iPlant;
  test_past_harvest "dat bitch be ded?" iPlant false;

  test_get_seed_price "seed price for iiPlant" iiPlant 7;
  test_is_harvest "iplant harvest" iiPlant false;
  test_is_alive "iplant is alive" iiPlant true;
  test_make_seed "make the iPlant" Coca 7 7 iiPlant;
  test_past_harvest "dat bitch be ded?" iiPlant false;

  test_is_full "full?" anInventory false;

  test_get_capacity "invent capacity" bInventory 3;

  test_is_full "full?" bInventory false;

  test_get_capacity "invent capacity" cInventory 3;

  test_is_full "full?" cInventory false;
  (*57 tests so far*)

]

let suite = "search test suite" >::: tests

let _ = run_test_tt_main suite