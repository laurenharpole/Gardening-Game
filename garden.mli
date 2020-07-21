(** This module encompasses functionality for representing and 
    augmenting a garden, contained in a game state. *)

open Tile
(** The type of a tile *)
type tile = Tile.t

(** The type of a garden *)
type t = tile list

(** The type of a cordinate of a tile. *)
type tile_cord = int * int

(** The number of tiles in a row of the garden *)
val width : int

(** The number of rows in the garden *)
val height : int

(** The number of tiles in the garden *)
val size : int

(** [convert_to_1D (row, col)] is the index in the garden corresponding to the
    tile at [(row, col)] *)
val convert_to_1D : tile_cord -> int

(** [convert_to_2D idx] is the tile cordinate corresponding to the tile at index
    [idx] in the garden *)
val convert_to_2D : int -> tile_cord

(** The initial garden, at the start of a game. *)
val new_garden : unit -> t

(** [apply_to_tile_at_idx g idx f] is [g] with [f] applied to 
    the tile at [idx] *)
val apply_to_tile_at_idx : t -> int -> (Tile.t -> Tile.t) -> t


(**[step g] reinitializes the garden after a day has passed*)
val step : t -> t

(** [plant_tile g row col p] creates a new garden with plant [p] at [idx]*)
val plant_tile : t -> int -> int -> Plant.t -> t

(**[harvest_tile g row col] creates a new garden with tile [idx] harvested*)
val harvest_tile : t -> int -> int -> t

(**[water_tile g row col] waters tile at idx*)
val water_tile : t -> int -> int -> t

(**[till_tile g row col] tills the tile at [idx]*)
val till_tile : t -> int -> int -> t

(**[get_tile g row col] tills the tile at [idx]*)
val get_tile : t -> int -> int -> Tile.t
