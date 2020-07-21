(** Encompasses functionality of a tile in the garden *)

(** The type representing a tile *)
type t = Grass | Dirt | Tilled | Plant of Plant.t


(** The value representing a grass tile *)
val grass : t

(** [step t] If a plant is planted, it grows the plant *)
val step : t -> t

(** [water t] waters a plant*)
val water : t -> t

(** [harvest t] if Tile contains harvestable plant, return dirt *)
val harvest : t -> t

(**[till t] steps the status of the tile, unless it's a plant*)
val till : t -> t

(**[plant t p] turn tilled soil into Plant of [p]*)
val plant : t -> Plant.t -> t

(**[bounty t] returns the plant found at t*)
val bounty : t -> t
