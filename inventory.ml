open Item

type t = {
  items : (Item.t option) list;
  capacity : int;
}

(** [make_empty_lst size acc] is [acc] with [None] prepended [size] times. *)
let rec make_empty_lst size acc =
  if size = 0 then acc else make_empty_lst (size - 1) (None::acc)

let empty width height : t = {
  items = make_empty_lst (width*height) [];
  capacity = width*height;
}

(** [find_idx_h itms itm acc] is the index of [itm] in [itms], added to [acc] *)
let rec find_idx_h itms itm acc =
  match itms with
  | [] -> failwith "Item not found"
  | (Some i)::t -> if (i = itm) then acc else find_idx_h t itm (acc + 1)
  | None::t -> find_idx_h t itm (acc + 1)

let find_idx inv itm  =
  (* helper to find idx of an item *)
  find_idx_h (inv.items) itm 0

let size inv =
  List.filter_map (fun x -> x) inv.items |> List.length 

let is_full inv =
  let filt = List.filter_map (fun x -> x) inv.items in
  List.length filt = inv.capacity

let get_items inv =
  inv.items

let get_capacity inv =
  inv.capacity

(** [add_item_h init build item] is [init] with [Some item] inserted into
    the first occurance of [None], reversed. *)
let rec add_item_h init build item : Item.t option list=
  match init with 
  | [] -> build |> List.rev
  | (Some h)::t -> add_item_h t ((Some h)::build) item
  | (None) :: t -> add_item_h t ((item)::build) None

let add_item inv item = {
  items = add_item_h (get_items inv) [] (Some item); 
  capacity = get_capacity inv;
}

(** [remove_item inv builder idx i] is [inv] with the item at index [idx] set
    to [None]. Starts searching at [i]. *)
let rec remove_item inv builder idx i =
  match inv with
  | [] -> List.rev builder
  | h::t -> if idx = i then (List.rev builder) @ (None :: t)
    else remove_item t (h::builder) idx (i+1)

let use_item inv (idx : int) = 
  {
    items = remove_item (get_items inv) [] idx 0;
    capacity = get_capacity inv;
  }

let lst_to_inv lst : t =
  {
    items = lst;
    capacity = List.length lst;
  }

(** [make_inv_h itms cap build] will build an inventory of size cap. *)
let rec make_inv_h itms cap build =
  match itms with
  | [] -> if cap = 0 then build else make_inv_h [] (cap - 1) (None::build)
  | h::t -> make_inv_h t (cap - 1) (h::build)

let make_inv itms cap = {
  items = (make_inv_h itms cap []) |> List.rev;
  capacity = cap
}

let get_item t idx =
  List.nth (t.items) idx
