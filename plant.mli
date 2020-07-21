(** This module encompasses functionality of a plant, which can either be
    in a tile or in an item. *)

(** The type representing a plant's species *)
type species =
  | Poppy
  | Coca
  | Sassafras
  | Marigold
  | Petunia

(** The type representing a plant. *)
type t = {
  age : int;
  days_since_water : int;
  harvest_age : int;
  species : species;
  sell_price : int;
  seed_price : int; (**Do we need seed price info?*)
}

(** [step p] is [p] with its age incrememnted by 1 *)
val step : t ->  t

(** [past_harvest p] is whether or not [p] is past its harvest age *)
val past_harvest : t -> bool

(** [make_seed spec i j] is a plant with species [spec] and age and harvest
    age [i] and [j], respectively. *)
val make_seed: species -> int -> int -> t

(**[make_rand_seed] creates n plant t with random species and buy/sell price *)
val make_rand_seed : unit -> t

(**Return plant's seed price*)
val get_seed_price : t -> int

(**[get_sell_price t] gets the sell_price of [t]*)
val get_sell_price : t -> int

(** [water p]  *)
val water : t -> t

(** [harvest p] returns true if plant is harvest age and has been watered*)
val is_harvest : t -> bool

(** [is_alive p] returns true if plant is <= harvest age and has been watered *)
val is_alive : t -> bool

(** [get_species p] returns species of plant *)
val get_species : t -> species

(** [get_harvest_age p] getter *)
val get_harvest_age : t -> int

(** [get_age p] getter *)
val get_age : t -> int

(**[is_watered p] returns true if plant has been watered today*)
val is_watered : t -> bool

(**[make_spec_seed spec] creates a seed that is the same for each species*)
val make_spec_seed : species -> t

(**[get_rand_spec] chooses random species*)
val get_rand_spec : species

(**[to_string p] returns a string representation of the species of p*)
val to_string : t -> string