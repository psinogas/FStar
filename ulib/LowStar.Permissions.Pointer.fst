module LowStar.Permissions.Pointer

module B = LowStar.Buffer
module HS = FStar.HyperStack
module HST = FStar.HyperStack.ST
module Seq = FStar.Seq

open LowStar.Resource
open LowStar.RST

open LowStar.BufferOps
open LowStar.Permissions
open FStar.Real

type value_with_perms (a: Type0) = vp : (a & Ghost.erased (perms_rec a)){
  let (v, p) = vp in
  forall (pid:live_pid (Ghost.reveal p)). get_snapshot_from_pid (Ghost.reveal p) pid == v
}

abstract noeq type pointer (a: Type0) (perm: Ghost.erased permission) = {
  v: B.pointer (value_with_perms a);
  pid: Ghost.erased perm_id
}

abstract let ptr_view (#a:Type) (#perm: Ghost.erased permission) (ptr:pointer a perm) : view a =
  reveal_view ();
  let fp = Ghost.hide (B.loc_addr_of_buffer ptr.v) in
  let inv h =
    let (v, perm_map) = Seq.index (B.as_seq h ptr.v) 0 in
    B.live h ptr.v /\ Ghost.reveal perm >. 0.0R /\ B.freeable ptr.v /\
    get_permission_from_pid (Ghost.reveal perm_map) (Ghost.reveal ptr.pid) = Ghost.reveal perm /\
    v == get_snapshot_from_pid (Ghost.reveal perm_map) (Ghost.reveal ptr.pid)
  in
  let sel h =
    let (_, perm_map) = Seq.index (B.as_seq h ptr.v) 0 in
    let perm = get_permission_from_pid (Ghost.reveal perm_map) (Ghost.reveal ptr.pid) in
    let snapshot = get_snapshot_from_pid (Ghost.reveal perm_map) (Ghost.reveal ptr.pid) in
    snapshot
  in
  {
    fp = fp;
    inv = inv;
    sel = sel
  }

let ptr_resource (#a:Type) (#perm: Ghost.erased permission) (ptr:pointer a perm) =
  as_resource (ptr_view ptr)

inline_for_extraction noextract let ptr_read
  (#a: Type)
  (#perm: Ghost.erased permission)
  (ptr: pointer a perm)
  : RST a
    (ptr_resource ptr)
    (fun _ -> ptr_resource ptr)
    (fun _ -> allows_read perm)
    (fun h0 x h1 ->
      x == sel (ptr_view ptr) h0 /\
      sel (ptr_view ptr) h0 == sel (ptr_view ptr) h1
    )
  =
  let (x, _) = !* ptr.v in
  x

inline_for_extraction noextract let ptr_write
  (#a: Type)
  (#perm: Ghost.erased permission)
  (ptr: pointer a perm)
  (x: a)
  : RST unit
    (ptr_resource ptr)
    (fun _ -> ptr_resource ptr)
    (fun _ -> allows_write perm)
    (fun h0 _ h1 -> sel (ptr_view ptr) h1 == x)
  =
  reveal_rst_inv ();
  reveal_modifies ();
  let (v', perm_map) = !* ptr.v in
  ptr.v *= (x, Ghost.hide (change_snapshot #a #v' (Ghost.reveal perm_map) (Ghost.reveal ptr.pid) x))

inline_for_extraction noextract let ptr_alloc
  (#a:Type)
  (init:a)
  : RST (pointer a (Ghost.hide 1.0R))
    (empty_resource)
    (fun ptr -> ptr_resource ptr)
    (fun _ -> True)
    (fun _ ptr h1 -> sel (ptr_view ptr) h1 == init)
  =
  reveal_rst_inv ();
  reveal_modifies ();
  let perm_map_pid = Ghost.hide (new_value_perms init true <: perms_rec a & perm_id) in
  let ptr_v = B.malloc HS.root (init, Ghost.hide (fst (Ghost.reveal perm_map_pid))) 1ul in
  { v = ptr_v; pid = Ghost.hide (snd (Ghost.reveal perm_map_pid)) }

inline_for_extraction noextract let ptr_free
  (#a:Type)
  (ptr:pointer a (Ghost.hide 1.0R))
  : RST unit
    (ptr_resource ptr)
    (fun ptr -> empty_resource)
    (fun _ -> True )
    (fun _ _ _ -> True)
  =
  reveal_rst_inv ();
  reveal_modifies ();
  reveal_empty_resource ();
  B.free ptr.v

inline_for_extraction noextract let ptr_share
  (#a: Type)
  (#p:Ghost.erased permission)
  (ptr: pointer a p)
  : RST (pointer a (half_permission p) &
    pointer a (half_permission p))
    (ptr_resource ptr)
    (fun (ptr1, ptr2) -> ptr_resource ptr1)
    (fun _ -> allows_read p)
    (fun h0 (ptr1,ptr2) h1 ->
      same_pid ptr1.pid ptr.pid /\
      ptr1.v == ptr2.v /\
      disjoint_pid ptr1.pid ptr2.pid /\
      inv (ptr_resource ptr2) h1
    )
  =
  reveal_rst_inv ();
  reveal_modifies ();
  let (v, perm_map) = !* ptr.v in
  let (new_perm_map_new_pid) = Ghost.hide (share_perms (Ghost.reveal perm_map) (Ghost.reveal ptr.pid)) in
  ptr.v *= (v, Ghost.hide (fst (Ghost.reveal new_perm_map_new_pid)));
  let ptr1 = {
    v = ptr.v;
    pid = ptr.pid
  } in
  let ptr2 = {
    v = ptr.v;
    pid = Ghost.hide (snd (Ghost.reveal new_perm_map_new_pid))
  } in
  (ptr1, ptr2)

inline_for_extraction noextract let ptr_merge
  (#a: Type)
  (#p1 #p2: Ghost.erased permission)
  (ptr1: pointer a p1)
  (ptr2: pointer a p2{summable_permissions p1 p2})
  : RST (pointer a (sum_permissions p1 p2))
    (ptr_resource ptr1)
    (fun ptr -> ptr_resource ptr)
    (fun h ->
      allows_read p1 /\ allows_read p2 /\
      ptr1.v == ptr2.v /\
      disjoint_pid ptr1.pid ptr2.pid /\
      inv (ptr_resource ptr2) h
    )
    (fun h0 ptr h1 ->
      ptr.pid == ptr1.pid
    )
  =
  reveal_rst_inv ();
  reveal_modifies ();
  let (v, perm_map) = !* ptr1.v in
  let new_perm_map = Ghost.hide (merge_perms (Ghost.reveal perm_map) (Ghost.reveal ptr1.pid) (Ghost.reveal ptr2.pid)) in
  ptr1.v *= (v, new_perm_map);
  {
    v = ptr1.v;
    pid = ptr1.pid
  }