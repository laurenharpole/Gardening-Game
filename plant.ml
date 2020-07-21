
type species =
  | Poppy
  | Coca
  | Sassafras
  | Marigold
  | Petunia

(**[t] creates a plant.t object *)
type t = {
  age : int;
  days_since_water : int;
  harvest_age : int;
  species : species;
  sell_price : int;
  seed_price : int; (**Do we need seed price info?*)
}

(** A list of all the variants of type species. *)
let list_of_species = [Poppy; Coca; Sassafras; Marigold; Petunia]
(** The number of species. *)
let num_species = List.length list_of_species

(**[step old_plant] steps thorugh a plant.t object *)
let step (old_plant : t) : t = {
  age = old_plant.age +1;
  days_since_water = old_plant.days_since_water + 1; 
  harvest_age  = old_plant.harvest_age;
  species =  old_plant.species;
  sell_price   = old_plant.sell_price;
  seed_price   = old_plant.seed_price;
}

(**[past_harvest p] check if the  plant is older than  harvest age*)
let past_harvest (p : t) = p.age  - p.harvest_age >  2 

(**[make_seed spec sell buy] creates a new plant.t object*)
let make_seed (spec : species) (sell : int) (buy : int) : t = {
  age = -1;
  days_since_water = 1;
  harvest_age = 3; (**We can change this later*)
  species = spec;
  sell_price = sell;
  seed_price = buy;
}

(**[make_rand_seed ()] creates a random seed type t*)
let make_rand_seed () : t = 
  let spec = List.nth list_of_species (Random.int num_species) in
  let sell = Random.int 200 in
  let buy = Random.int 275 in
  make_seed spec sell buy

(**[make_spec_seed spec] matches [spec] with plant species*)
let make_spec_seed spec =
  match spec with
  | Poppy -> make_seed Poppy 10 10
  | Coca -> make_seed Coca 10 10
  | Sassafras -> make_seed Sassafras 10 10
  | Marigold -> make_seed Marigold 10 10
  | Petunia -> make_seed Petunia 10 10

(**[get_rand_spec] gets random spec of plant species*)
let get_rand_spec =
  List.nth list_of_species (Random.int 4)

(**[get_seed_price t] gets seed price of plant *)
let get_seed_price t : int =
  t.seed_price

(**[get_sell_price t] gets seed sell price of plant *)
let get_sell_price t =
  t.sell_price

(**[water p] makes a new water.t object *)
let water p = {
  age = p.age;
  days_since_water = 0;
  harvest_age = p.harvest_age;
  species = p.species;
  sell_price = p.sell_price;
  seed_price = p.seed_price
}

(** How many days can elapse without watering before a plant dies. *) 
let water_thresh = 1 (*We can change this later*)

(**[is_harvest p] checks if plant harvest age *)
let is_harvest p : bool= 
  p.age = p.harvest_age && p.days_since_water <= water_thresh

(**[is_alive p] checks if plant is past harvest age *)
let is_alive p : bool =
  p.age <= p.harvest_age && p.days_since_water <= water_thresh

(**[get_species p] get plant species *)
let get_species p =
  p.species

(**[get_harvest_age p] gets harvest age *)
let get_harvest_age p =
  p.harvest_age

(**[get_age p] gets plant age *)
let get_age p =
  p.age

(**[is_watered p]returns bool if plant watered *)
let is_watered p =
  p.days_since_water = 0

(* [to_string p] item string takes in plant matches species  returns  string of
   the species  *)
let to_string p = 
  match get_species p with 
  | Poppy -> "poppy"
  | Coca -> "coca"
  | Sassafras -> "sassafras"
  | Marigold -> "marigold"
  | Petunia -> "petunia"