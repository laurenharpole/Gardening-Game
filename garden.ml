open Tile
type tile = Tile.t

type t = tile list

type tile_cord = (int * int)

let width = 10
let height = 7
let size = width*height


let convert_to_1D (row, col) = row * width + col

let convert_to_2D idx = (idx / width, idx mod width)

(** [build_garden g size tile] is [g] with [tile] prepended to it[size] times *)
let rec build_garden (g : t) (size : int) (tile : Tile.t) =
  if size = 0 then g else
    build_garden (tile::g) (size - 1) tile

let new_garden () : t =
  build_garden [] size Grass

(** [apply_helper acc i g idx f] will iterate through [g] and apply [f]
    to the tile at index [idx]. [acc] and [i] are accumulators, and should be 
    initially set to [[]] and [0], respectively. *)
let rec apply_helper acc i g idx f =
  match g with
  | [] -> acc
  | h::t -> if i = idx then
      apply_helper ((f h)::acc) (i + 1) t idx f
    else
      apply_helper (h::acc) (i + 1) t idx f

let apply_to_tile_at_idx g idx f =
  apply_helper [] 0 g idx f |> List.rev

let step g = 
  List.map (fun t -> Tile.step t) g

let plant_tile (g : t) row col p =
  let idx = convert_to_1D (row,col) in
  apply_to_tile_at_idx g idx (fun x -> (Tile.plant (List.nth g idx) p))

let harvest_tile g row col  =
  let idx = convert_to_1D (row,col) in
  apply_to_tile_at_idx g idx (fun x -> (Tile.harvest (List.nth g idx)))

let water_tile g row col =
  let idx = convert_to_1D (row,col) in
  apply_to_tile_at_idx g idx (fun x -> Tile.water (List.nth g idx))

let till_tile g row col =
  let idx = convert_to_1D (row,col) in
  apply_to_tile_at_idx g idx  Tile.till

let get_tile g row col = 
  let idx = convert_to_1D (row,col) in
  List.nth g idx
