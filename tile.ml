open Plant

type t = Grass | Dirt | Tilled | Plant of Plant.t

let grass = Grass

let step t =
  match t with
  | Plant p -> Plant (Plant.step p)
  | Tilled -> Dirt
  | Dirt -> Grass
  | Grass -> t

let water t =
  match t with
  | Tilled -> Dirt
  | Plant p -> Plant (Plant.water p)
  | _ -> t

let harvest t =
  match t with
  | Plant p -> Dirt
  | _ -> t

let till t =
  match t with
  | Grass -> Dirt
  | Dirt -> Tilled
  | Tilled -> t
  | Plant p when not (Plant.is_alive p) -> Tilled
  | _ -> t

let plant t p =
  match t with
  | Tilled -> Plant p
  | _ -> t

let bounty t =
  match t with
  | Plant p -> t
  | _ -> failwith "Not harvestable"