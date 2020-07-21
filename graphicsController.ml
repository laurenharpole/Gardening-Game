open Graphics

(** The size in pixels of a garden tile *)
let tile_scale = 75
(** The number of tiles in a row of the garden *)
let garden_width = Garden.width
(** The number of rows in the garden *)
let garden_height = Garden.height
(** The height of the player's inventory *)
let inv_scale = 90
(** The padding for each item in the player's inventory *)
let inv_padding = 10
(** The height of one line in the terminal *)
let cmd_height = 30

(** The height of the entire window *)
let window_height = cmd_height*3 + inv_scale + inv_padding*2 + garden_height*tile_scale
(** The width of the enter window *)
let window_width = garden_width*tile_scale

(** The height and width of an item in the shop *)
let item_scale = 100

(** The x-coord of the lower-left corner of the garden *)
let garden_x = 0
(** The y-coord of the lower-left corner of the garden *)
let garden_y = cmd_height*3 + inv_padding*2 + inv_scale
(** The coord of the lower-left corner of the player's inventory *)
let inv_offset = (0, cmd_height*3)

(** The width of the shop *)
let shop_width = window_width - tile_scale
(** The height of the shop *)
let shop_height = tile_scale*6
(** The thickness of the shop's border *)
let shop_border = 3

(** The x-coord of the lower-left corner of the shop *)
let shop_x = (window_width - shop_width) / 2 + garden_x 
(** The y-coord of the lower-left corner of the shop *)
let shop_y = garden_y + tile_scale/2 

(** The string to be passed to [open_window]. *)
let window_size = " "^(string_of_int window_width)^"x"^(string_of_int window_height)

(** [darken color] is a darker version of [color] *)
let darken color =
  let b = color mod 256 in
  let g = (color / 256) mod 256 in
  let r = (color / (256*256)) in
  rgb (r/2) (g/2) (b/2) 

(** [lighten_helper i] is the pixel intensity after brightening [i] *)
let lighten_helper i =
  let i' = ((Float.of_int (i + 30)) *. 1.7) |> Int.of_float in
  if i' > 255 then 255 else i'

(** [lighten color] is a lighter version of color *)
let lighten color =
  let b = color mod 256 |> lighten_helper in
  let g = (color / 256) mod 256 |> lighten_helper in
  let r = (color / (256*256)) |> lighten_helper in
  rgb r g b

(** The color corresponding to a grass tile *)
let grass_color = darken green
(** The color corresponding to a dirt tile *)
let dirt_color = 0x964b00
(** The color corresponding to a tilled tile *)
let tilled_color = darken dirt_color |> darken

(** [plant_scale p] is the size of [p], dependent on its age in proportion to
    its harvest age *)
let plant_scale p =
  let proportion = (Float.of_int (Plant.get_age p)) /. (Float.of_int (Plant.get_harvest_age p)) in
  match proportion with
  | x when x < 0.0 -> tile_scale / 6
  | x when x >= 0.0 && x <= 1.0 -> 
    (Int.of_float(x *. Float.of_int(tile_scale * 2 / 3)) + (tile_scale / 3)) / 2
  | _ -> tile_scale / 2

(** [plant_color p] is the color corresponding to [p] *)
let plant_color p = 
  if not (Plant.is_alive p) then
    darken white
  else
    match Plant.get_species p with
    | Poppy -> white
    | Coca -> dirt_color
    | Sassafras -> blue |> lighten
    | Marigold -> red
    | Petunia -> blue

let open_window title = 
  open_graph window_size; 
  auto_synchronize false;
  set_window_title title;
  ()

(** [in_window (x, y)] is whether [(x, y)] is in the bounds of the window *)
let in_window (x, y) =
  x >= 0 && x < size_x () &&
  y >= 0 && y < size_y ()

let in_garden (x, y) =
  x >= (0 + garden_x) && x < (garden_width*tile_scale + garden_x) &&
  y >= (0 + garden_y) && y < (garden_height*tile_scale + garden_y)

let in_player_inv (x, y) =
  x >= (window_width - inv_scale*6)/2 && x < window_width - (window_width - inv_scale*6)/2 &&
  y >= (0 + cmd_height*3) && y < (cmd_height*3 + inv_scale)

let in_shop_inv (x, y) =
  x >= shop_x  + (shop_width - item_scale*Shop_info.width)/2  
  && x < shop_x + shop_width - (shop_width - item_scale*Shop_info.width)/2 
  && y >= shop_y + shop_height - item_scale*2 - (
      shop_width - item_scale*Shop_info.width)/2 && y < shop_y + shop_height - (
      shop_width - item_scale*Shop_info.width)/2


let x_y_to_col_row (x, y) = 
  if in_garden (x, y) then
    let x' = ((x - garden_x)/tile_scale) in
    let y' = ((y - garden_y)/tile_scale) in
    Some (x', y')
  else
    None

let x_y_to_player_idx (x, y) =
  if in_player_inv (x, y) then
    let idx = (x - (window_width - inv_scale*6)/2)/inv_scale in
    Some idx
  else
    None

let x_y_to_shop_idx (x, y) =
  if in_shop_inv (x, y) then
    let x' = (x - shop_x - (shop_width - item_scale*Shop_info.width)/2) / item_scale in
    let y' = ((y - shop_y -shop_height + item_scale*2) + (
        shop_width - item_scale*Shop_info.width)/2) / item_scale in
    Some (x' + Shop_info.width*y')
  else
    None

(** [find_tile_cords (x, y)] is [Some (x', y')] if [(x, y)] is in the garden,
    where [(x', y')] is the coordinate of the lower-left corner pertaining to 
    the tile containing [(x, y)]. If [(x, y)] is not in the window, then this 
    function is [None] *)
let find_tile_cords (x, y) =
  match x_y_to_col_row (x, y) with
  | None -> None
  | Some (c, r) -> Some (garden_x + c*tile_scale, garden_y + r*tile_scale)

(** [draw_flat color x y] draws a tile with [color] with the lower-left corner
    located at [(x,y)]. Returns unit. *)
let draw_flat color x y =
  set_color (color);
  fill_rect x y tile_scale tile_scale;
  set_color black;
  draw_rect x y tile_scale tile_scale

(** [draw_flower p x y] draws the graphical representation of plant [p] at the
    tile located at pixel [(x, y)]. Returns unit. *)
let draw_flower p x y =
  set_color tilled_color;
  fill_rect x y tile_scale tile_scale;
  set_color (plant_color p);
  let scale = (plant_scale p) in
  let x', y' = x + (tile_scale/2) - (scale/2), y + (tile_scale/2) - (scale/2) in
  fill_rect x' y' scale scale;

  (if Plant.is_watered p then
     let img =  get_image (x + 3) (y+3) (tile_scale -6) (tile_scale - 6) in
     set_color (lighten blue);
     fill_rect x y tile_scale tile_scale;
     draw_image img (x+3) (y+3));

  (if Plant.is_harvest p 
   then
     (set_color yellow;
      draw_rect x' y' scale scale;
      draw_rect (x'+1) (y'+1) (scale-2) (scale-2))
   else
     (set_color black;
      draw_rect x' y' scale scale));

  set_color black;
  draw_rect x y tile_scale tile_scale

let highlight (x, y) =
  match find_tile_cords (x, y) with
  | None -> ()
  | Some (x', y') ->
    let tile = get_image x' y' tile_scale tile_scale |> dump_image |>
               Array.map(fun row -> row 
                                    |> Array.map (fun color -> lighten color)) 
               |> make_image in
    draw_image tile x' y'

(** [render_tile idx t] draws the graphical representation of [t] at 
    the location corresponding to the [idx] tile of the garden. 
    Evaluates to [idx + 1]. To be used by a fold_left on the garden. *)
let render_tile (idx : int) (t : Tile.t) =
  let (r, c) = Garden.convert_to_2D idx in
  let x' = garden_x + c*tile_scale in
  let y' = garden_y + r*tile_scale in
  (match t with
   | Grass -> draw_flat grass_color x' y'
   | Dirt -> draw_flat dirt_color x' y'
   | Tilled -> draw_flat tilled_color x' y'
   | Plant p -> draw_flower p x' y');
  idx + 1

(** [render_garden g] draws the graphical representation of 
    [g] and returns unit. *)
let render_garden (g: Garden.t) = 
  List.fold_left render_tile 0 g |>
  (fun x -> ())

(** [render_string color str x y] draws [str] with color [color] with the lower-
    left corner at [(x, y)]. Returns unit. *)
let render_string color str x y =
  set_color color;
  moveto x y;
  draw_string str

(** [render_terminal st] draws the graphical representation of the terminal
    encoded in [st]. Returns unit. *)
let render_terminal st = 
  set_color 0xDDDDDD;
  fill_rect 0 0 window_width (cmd_height);
  set_color 0xEEEEEE;
  fill_rect 0 cmd_height window_width (cmd_height*2);
  set_font "-*-fixed-medium-r-semicondensed--20-*-*-*-*-*-iso8859-1";
  render_string black ("> "^(GameState.get_cmd st)^"_") 5 5;

  let feedback = GameState.get_feedback st |>
                 (fun str -> if str = "" then "" else "**"^str) in
  render_string 0x444444 feedback 5 (5 + cmd_height);
  render_string 0x444444 (GameState.get_prev_cmd st) 5 (5 + cmd_height*2);
  set_color black;
  fill_rect 0 (cmd_height*3) window_width 1

(** [render_shop_item idx item_op] draws the graphical representation of 
    [item_op]at the location corresponding to the [idx] element of the shop's
    inventory.
    Returns unit. *)
let render_shop_item idx item_op =
  let x' = shop_x + (idx mod Shop_info.width)*item_scale + 
           (shop_width - item_scale*Shop_info.width)/2 in
  let y' = shop_y + shop_height - item_scale*2 - (
      shop_width - item_scale*Shop_info.width)/2 + 
           item_scale*(idx / Shop_info.width) in
  let s = Item.item_opt_to_string item_op in
  set_color black;
  draw_rect x' y' item_scale item_scale;
  set_color white;
  fill_rect (x' + 5) (y' + 5) (item_scale - 10) (item_scale - 10);
  render_string black s (x' + 10) (y' + item_scale/2 - 10);
  idx + 1

(** [render_player_item idx item_op] draws 
    the graphical representation of [item_op]
    at the location corresponding to the [idx] element 
    of the player's inventory.
    Returns unit. *)
let render_player_item idx item_op =
  let x' = idx*inv_scale + 
           (window_width - inv_scale*6)/2 in
  let y' = cmd_height*3 in
  let s = Item.item_opt_to_string item_op in 
  set_color black;
  draw_rect x' y' inv_scale inv_scale;
  set_color white;
  fill_rect (x' + 5) (y' + 5) (inv_scale - inv_padding) (inv_scale - inv_padding);
  render_string black s (x' + 10) (y' + inv_scale/2 - 10);
  idx + 1

(** [render_shop shop] draws the graphical representation of the shop encoded
    in [shop]. Returns unit.*)
let render_shop shop =
  let backdrop = get_image garden_x garden_y (garden_width*tile_scale) (garden_height*tile_scale) 
                 |> dump_image |>
                 Array.map (fun row -> row |> Array.map (fun color -> 
                     darken color)) |> make_image in
  draw_image backdrop garden_x garden_y;

  set_color black;
  fill_rect (shop_x - shop_border) (shop_y - shop_border) 
    (shop_width + 2*shop_border) (shop_height + 2*shop_border);
  set_color 0xDDDDDD;
  fill_rect shop_x shop_y shop_width shop_height;
  set_font "-*-fixed-medium-r-semicondensed--40-*-*-*-*-*-iso8859-1";
  render_string black "Shoppe" (shop_x + 20) (shop_y + shop_height - 50);

  set_font "-*-fixed-medium-r-semicondensed--15-*-*-*-*-*-iso8859-1";
  Shop_info.inventory shop |> Inventory.get_items 
  |> List.fold_left render_shop_item 0 |> (fun x -> ())

(** [render_player player] draws the graphical representaion of the player's
    inventory encoded in [player]. Returns unit. *)
let render_player st =
  let player = (GameState.get_player st) in
  let b = Player_info.balance player |> string_of_int in
  set_color (darken white |> darken);
  fill_rect 0 (cmd_height*3) window_width inv_scale;
  set_font "-*-fixed-medium-r-semicondensed--15-*-*-*-*-*-iso8859-1";
  Player_info.player_inv player |> Inventory.get_items
  |> List.fold_left render_player_item 0 |> (fun x -> ());
  set_font "-*-fixed-medium-r-semicondensed--40-*-*-*-*-*-iso8859-1";
  render_string yellow ("$"^b) 20 (cmd_height*3 + inv_scale/2 - 20)

let render_state (st : GameState.t) (mouse : int*int) = 
  set_color white;
  fill_rect 0 0 window_width window_height;
  render_garden (GameState.get_garden st); 
  render_terminal st;
  render_player st;
  (  if GameState.get_shop_open st then
       render_shop (GameState.get_shop st)
     else highlight mouse);
  ()

let close_window () = close_graph ()