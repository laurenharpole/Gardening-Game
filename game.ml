open GraphicsController
open Graphics
open GameState
exception End

(** [eval_cmd st] is the state resulting from evaluating the command stored in
    [st]. *)
let eval_cmd st =
  match (GameState.get_cmd st |> String.lowercase_ascii) with
  | "quit" -> raise End
  | "sleep" -> GameState.step st
  | "help" -> GameState.show_help st
  | "open shop" -> GameState.set_shop_open st
  | "close shop" -> GameState.set_shop_closed st
  | _ -> GameState.bad_command st

(** [h_key status st] is [st] after processing a key press. *)
let h_key status st =
  let key = status.key in
  if Char.code key = 13 then
    eval_cmd st
  else
    GameState.add_char st key

(** [shop_click status st] is [st] after processing the user clicking while
    the shop is open. *)
let shop_click status st =
  let x, y = status.mouse_x, status.mouse_y in
  if in_shop_inv (x, y) then
    match x_y_to_shop_idx (x, y) with
    | None -> st
    | Some idx -> GameState.shop_click st idx
  else if in_player_inv (x, y) then
    match x_y_to_player_idx (x, y) with
    | None -> st
    | Some idx -> GameState.inv_click st idx
  else st

(** [h_click status st] is [st] after processing the user clicking when the 
    shop is closed. *)
let h_click status st =
  let x, y = status.mouse_x, status.mouse_y in
  if in_garden (x, y) then
    match x_y_to_col_row (x, y) with
    | None -> st
    | Some (col, row) -> GameState.tile_click st row col
  else if in_player_inv (x, y) then
    match x_y_to_player_idx (x, y) with
    | None -> st
    | Some idx -> GameState.inv_click st idx
  else st

(** [diff_tiles c1 c2] is whether or not [c1] and [c2] belong to different
    garden tiles. *)
let diff_tiles c1 c2 =
  match x_y_to_col_row c1, x_y_to_col_row c2 with
  | None, None -> false
  | Some a, Some b -> a <> b
  | _ -> true

(** [diff_shop_tile c1 c2] is whether or not [c1] and [c2] belong to different
    items in the shop. *)
let diff_shop_tile c1 c2 =
  match x_y_to_shop_idx c1, x_y_to_shop_idx c2 with
  | None, None -> false
  | Some a, Some b -> a <> b
  | _ -> true

(** [game_loop st sync mouse] is the input-loop for the game. The current state
    is [st], [sync] is whether or not the display should update, and [mouse] is
     theposition of the mouse in the previous state. This method 
     is tail-recursive. *)
let rec game_loop st sync mouse =
  (* If the window should update, then do it. *)
  (if sync then 
     (synchronize ();
      render_state st mouse;
      synchronize ()));

  (* The status at the time an event is triggered *)
  let status = wait_next_event [Mouse_motion; Button_down; Key_pressed] in
  let (x, y) = (status.mouse_x, status.mouse_y) in

  if status.keypressed then
    game_loop (h_key status st) true (x, y)

  else if GameState.get_shop_open st then
    (if status.button then
       game_loop (shop_click status st) true (x,y)
     else game_loop st false (x, y))

  else if status.button then 
    game_loop (h_click status st) true (status.mouse_x, status.mouse_y)

  else
    game_loop st (diff_tiles mouse (x, y)) (x, y)

(* make a new game state and pass it into the render function *)
let start () =
  try
    open_window "Garden Game";
    try
      game_loop GameState.new_game true (0, 0)
    with
    | End -> close_window ()
    | _ -> failwith "some exception!"
  with
    _ -> close_window ()