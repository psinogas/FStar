
open Prims

type local_binding =
(FStar_Ident.ident * FStar_Syntax_Syntax.bv * Prims.bool)


type rec_binding =
(FStar_Ident.ident * FStar_Ident.lid * FStar_Syntax_Syntax.delta_depth)


type module_abbrev =
(FStar_Ident.ident * FStar_Ident.lident)

type open_kind =
| Open_module
| Open_namespace


let uu___is_Open_module : open_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Open_module -> begin
true
end
| uu____12 -> begin
false
end))


let uu___is_Open_namespace : open_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Open_namespace -> begin
true
end
| uu____16 -> begin
false
end))


type open_module_or_namespace =
(FStar_Ident.lident * open_kind)

type record_or_dc =
{typename : FStar_Ident.lident; constrname : FStar_Ident.ident; parms : FStar_Syntax_Syntax.binders; fields : (FStar_Ident.ident * FStar_Syntax_Syntax.typ) Prims.list; is_private_or_abstract : Prims.bool; is_record : Prims.bool}

type scope_mod =
| Local_binding of local_binding
| Rec_binding of rec_binding
| Module_abbrev of module_abbrev
| Open_module_or_namespace of open_module_or_namespace
| Top_level_def of FStar_Ident.ident
| Record_or_dc of record_or_dc


let uu___is_Local_binding : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Local_binding (_0) -> begin
true
end
| uu____92 -> begin
false
end))


let __proj__Local_binding__item___0 : scope_mod  ->  local_binding = (fun projectee -> (match (projectee) with
| Local_binding (_0) -> begin
_0
end))


let uu___is_Rec_binding : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Rec_binding (_0) -> begin
true
end
| uu____104 -> begin
false
end))


let __proj__Rec_binding__item___0 : scope_mod  ->  rec_binding = (fun projectee -> (match (projectee) with
| Rec_binding (_0) -> begin
_0
end))


let uu___is_Module_abbrev : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Module_abbrev (_0) -> begin
true
end
| uu____116 -> begin
false
end))


let __proj__Module_abbrev__item___0 : scope_mod  ->  module_abbrev = (fun projectee -> (match (projectee) with
| Module_abbrev (_0) -> begin
_0
end))


let uu___is_Open_module_or_namespace : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Open_module_or_namespace (_0) -> begin
true
end
| uu____128 -> begin
false
end))


let __proj__Open_module_or_namespace__item___0 : scope_mod  ->  open_module_or_namespace = (fun projectee -> (match (projectee) with
| Open_module_or_namespace (_0) -> begin
_0
end))


let uu___is_Top_level_def : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Top_level_def (_0) -> begin
true
end
| uu____140 -> begin
false
end))


let __proj__Top_level_def__item___0 : scope_mod  ->  FStar_Ident.ident = (fun projectee -> (match (projectee) with
| Top_level_def (_0) -> begin
_0
end))


let uu___is_Record_or_dc : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Record_or_dc (_0) -> begin
true
end
| uu____152 -> begin
false
end))


let __proj__Record_or_dc__item___0 : scope_mod  ->  record_or_dc = (fun projectee -> (match (projectee) with
| Record_or_dc (_0) -> begin
_0
end))


type string_set =
Prims.string FStar_Util.set

type exported_id_kind =
| Exported_id_term_type
| Exported_id_field


let uu___is_Exported_id_term_type : exported_id_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Exported_id_term_type -> begin
true
end
| uu____164 -> begin
false
end))


let uu___is_Exported_id_field : exported_id_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Exported_id_field -> begin
true
end
| uu____168 -> begin
false
end))


type exported_id_set =
exported_id_kind  ->  string_set FStar_ST.ref

type env =
{curmodule : FStar_Ident.lident Prims.option; curmonad : FStar_Ident.ident Prims.option; modules : (FStar_Ident.lident * FStar_Syntax_Syntax.modul) Prims.list; scope_mods : scope_mod Prims.list; exported_ids : exported_id_set FStar_Util.smap; trans_exported_ids : exported_id_set FStar_Util.smap; includes : FStar_Ident.lident Prims.list FStar_ST.ref FStar_Util.smap; sigaccum : FStar_Syntax_Syntax.sigelts; sigmap : (FStar_Syntax_Syntax.sigelt * Prims.bool) FStar_Util.smap; iface : Prims.bool; admitted_iface : Prims.bool; expect_typ : Prims.bool}

type foundname =
| Term_name of (FStar_Syntax_Syntax.typ * Prims.bool)
| Eff_name of (FStar_Syntax_Syntax.sigelt * FStar_Ident.lident)


let uu___is_Term_name : foundname  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Term_name (_0) -> begin
true
end
| uu____314 -> begin
false
end))


let __proj__Term_name__item___0 : foundname  ->  (FStar_Syntax_Syntax.typ * Prims.bool) = (fun projectee -> (match (projectee) with
| Term_name (_0) -> begin
_0
end))


let uu___is_Eff_name : foundname  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Eff_name (_0) -> begin
true
end
| uu____334 -> begin
false
end))


let __proj__Eff_name__item___0 : foundname  ->  (FStar_Syntax_Syntax.sigelt * FStar_Ident.lident) = (fun projectee -> (match (projectee) with
| Eff_name (_0) -> begin
_0
end))


let all_exported_id_kinds : exported_id_kind Prims.list = (Exported_id_field)::(Exported_id_term_type)::[]


let open_modules : env  ->  (FStar_Ident.lident * FStar_Syntax_Syntax.modul) Prims.list = (fun e -> e.modules)


let current_module : env  ->  FStar_Ident.lident = (fun env -> (match (env.curmodule) with
| None -> begin
(failwith "Unset current module")
end
| Some (m) -> begin
m
end))


let qual : FStar_Ident.lident  ->  FStar_Ident.ident  ->  FStar_Ident.lident = FStar_Syntax_Util.qual_id


let qualify : env  ->  FStar_Ident.ident  ->  FStar_Ident.lident = (fun env id -> (match (env.curmonad) with
| None -> begin
(

let uu____369 = (current_module env)
in (qual uu____369 id))
end
| Some (monad) -> begin
(

let uu____371 = (

let uu____372 = (current_module env)
in (qual uu____372 monad))
in (FStar_Syntax_Util.mk_field_projector_name_from_ident uu____371 id))
end))


let new_sigmap = (fun uu____380 -> (FStar_Util.smap_create (Prims.parse_int "100")))


let empty_env : Prims.unit  ->  env = (fun uu____383 -> (

let uu____384 = (new_sigmap ())
in (

let uu____386 = (new_sigmap ())
in (

let uu____388 = (new_sigmap ())
in (

let uu____394 = (new_sigmap ())
in {curmodule = None; curmonad = None; modules = []; scope_mods = []; exported_ids = uu____384; trans_exported_ids = uu____386; includes = uu____388; sigaccum = []; sigmap = uu____394; iface = false; admitted_iface = false; expect_typ = false})))))


let sigmap : env  ->  (FStar_Syntax_Syntax.sigelt * Prims.bool) FStar_Util.smap = (fun env -> env.sigmap)


let has_all_in_scope : env  ->  Prims.bool = (fun env -> (FStar_List.existsb (fun uu____413 -> (match (uu____413) with
| (m, uu____417) -> begin
(FStar_Ident.lid_equals m FStar_Syntax_Const.all_lid)
end)) env.modules))


let set_bv_range : FStar_Syntax_Syntax.bv  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.bv = (fun bv r -> (

let id = (

let uu___171_425 = bv.FStar_Syntax_Syntax.ppname
in {FStar_Ident.idText = uu___171_425.FStar_Ident.idText; FStar_Ident.idRange = r})
in (

let uu___172_426 = bv
in {FStar_Syntax_Syntax.ppname = id; FStar_Syntax_Syntax.index = uu___172_426.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = uu___172_426.FStar_Syntax_Syntax.sort})))


let bv_to_name : FStar_Syntax_Syntax.bv  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.term = (fun bv r -> (FStar_Syntax_Syntax.bv_to_name (set_bv_range bv r)))


let unmangleMap : (Prims.string * Prims.string * FStar_Syntax_Syntax.delta_depth * FStar_Syntax_Syntax.fv_qual Prims.option) Prims.list = ((("op_ColonColon"), ("Cons"), (FStar_Syntax_Syntax.Delta_constant), (Some (FStar_Syntax_Syntax.Data_ctor))))::((("not"), ("op_Negation"), (FStar_Syntax_Syntax.Delta_equational), (None)))::[]


let unmangleOpName : FStar_Ident.ident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun id -> (

let t = (FStar_Util.find_map unmangleMap (fun uu____472 -> (match (uu____472) with
| (x, y, dd, dq) -> begin
(match ((id.FStar_Ident.idText = x)) with
| true -> begin
(

let uu____486 = (

let uu____487 = (FStar_Ident.lid_of_path (("Prims")::(y)::[]) id.FStar_Ident.idRange)
in (FStar_Syntax_Syntax.fvar uu____487 dd dq))
in Some (uu____486))
end
| uu____488 -> begin
None
end)
end)))
in (match (t) with
| Some (v) -> begin
Some (((v), (false)))
end
| None -> begin
None
end)))

type 'a cont_t =
| Cont_ok of 'a
| Cont_fail
| Cont_ignore


let uu___is_Cont_ok = (fun projectee -> (match (projectee) with
| Cont_ok (_0) -> begin
true
end
| uu____517 -> begin
false
end))


let __proj__Cont_ok__item___0 = (fun projectee -> (match (projectee) with
| Cont_ok (_0) -> begin
_0
end))


let uu___is_Cont_fail = (fun projectee -> (match (projectee) with
| Cont_fail -> begin
true
end
| uu____541 -> begin
false
end))


let uu___is_Cont_ignore = (fun projectee -> (match (projectee) with
| Cont_ignore -> begin
true
end
| uu____552 -> begin
false
end))


let option_of_cont = (fun k_ignore uu___141_571 -> (match (uu___141_571) with
| Cont_ok (a) -> begin
Some (a)
end
| Cont_fail -> begin
None
end
| Cont_ignore -> begin
(k_ignore ())
end))


let find_in_record = (fun ns id record cont -> (

let typename' = (FStar_Ident.lid_of_ids (FStar_List.append ns ((record.typename.FStar_Ident.ident)::[])))
in (match ((FStar_Ident.lid_equals typename' record.typename)) with
| true -> begin
(

let fname = (FStar_Ident.lid_of_ids (FStar_List.append record.typename.FStar_Ident.ns ((id)::[])))
in (

let find = (FStar_Util.find_map record.fields (fun uu____616 -> (match (uu____616) with
| (f, uu____621) -> begin
(match ((id.FStar_Ident.idText = f.FStar_Ident.idText)) with
| true -> begin
Some (record)
end
| uu____623 -> begin
None
end)
end)))
in (match (find) with
| Some (r) -> begin
(cont r)
end
| None -> begin
Cont_ignore
end)))
end
| uu____626 -> begin
Cont_ignore
end)))


let get_exported_id_set : env  ->  Prims.string  ->  exported_id_set Prims.option = (fun e mname -> (FStar_Util.smap_try_find e.exported_ids mname))


let get_trans_exported_id_set : env  ->  Prims.string  ->  exported_id_set Prims.option = (fun e mname -> (FStar_Util.smap_try_find e.trans_exported_ids mname))


let string_of_exported_id_kind : exported_id_kind  ->  Prims.string = (fun uu___142_651 -> (match (uu___142_651) with
| Exported_id_field -> begin
"field"
end
| Exported_id_term_type -> begin
"term/type"
end))


let find_in_module_with_includes = (fun eikind find_in_module find_in_module_default env ns id -> (

let idstr = id.FStar_Ident.idText
in (

let rec aux = (fun uu___143_700 -> (match (uu___143_700) with
| [] -> begin
find_in_module_default
end
| (modul)::q -> begin
(

let mname = modul.FStar_Ident.str
in (

let not_shadowed = (

let uu____708 = (get_exported_id_set env mname)
in (match (uu____708) with
| None -> begin
true
end
| Some (mex) -> begin
(

let mexports = (

let uu____712 = (mex eikind)
in (FStar_ST.read uu____712))
in (FStar_Util.set_mem idstr mexports))
end))
in (

let mincludes = (

let uu____719 = (FStar_Util.smap_try_find env.includes mname)
in (match (uu____719) with
| None -> begin
[]
end
| Some (minc) -> begin
(FStar_ST.read minc)
end))
in (

let look_into = (match (not_shadowed) with
| true -> begin
(

let uu____739 = (qual modul id)
in (find_in_module uu____739))
end
| uu____740 -> begin
Cont_ignore
end)
in (match (look_into) with
| Cont_ignore -> begin
(aux (FStar_List.append mincludes q))
end
| uu____742 -> begin
look_into
end)))))
end))
in (aux ((ns)::[])))))


let is_exported_id_field : exported_id_kind  ->  Prims.bool = (fun uu___144_746 -> (match (uu___144_746) with
| Exported_id_field -> begin
true
end
| uu____747 -> begin
false
end))


let try_lookup_id'' = (fun env id eikind k_local_binding k_rec_binding k_record find_in_module lookup_default_id -> (

let check_local_binding_id = (fun uu___145_836 -> (match (uu___145_836) with
| (id', uu____838, uu____839) -> begin
(id'.FStar_Ident.idText = id.FStar_Ident.idText)
end))
in (

let check_rec_binding_id = (fun uu___146_843 -> (match (uu___146_843) with
| (id', uu____845, uu____846) -> begin
(id'.FStar_Ident.idText = id.FStar_Ident.idText)
end))
in (

let curmod_ns = (

let uu____849 = (current_module env)
in (FStar_Ident.ids_of_lid uu____849))
in (

let proc = (fun uu___147_854 -> (match (uu___147_854) with
| Local_binding (l) when (check_local_binding_id l) -> begin
(k_local_binding l)
end
| Rec_binding (r) when (check_rec_binding_id r) -> begin
(k_rec_binding r)
end
| Open_module_or_namespace (ns, uu____859) -> begin
(find_in_module_with_includes eikind find_in_module Cont_ignore env ns id)
end
| Top_level_def (id') when (id'.FStar_Ident.idText = id.FStar_Ident.idText) -> begin
(lookup_default_id Cont_ignore id)
end
| Record_or_dc (r) when (is_exported_id_field eikind) -> begin
(

let uu____862 = (FStar_Ident.lid_of_ids curmod_ns)
in (find_in_module_with_includes Exported_id_field (fun lid -> (

let id = lid.FStar_Ident.ident
in (find_in_record lid.FStar_Ident.ns id r k_record))) Cont_ignore env uu____862 id))
end
| uu____865 -> begin
Cont_ignore
end))
in (

let rec aux = (fun uu___148_871 -> (match (uu___148_871) with
| (a)::q -> begin
(

let uu____877 = (proc a)
in (option_of_cont (fun uu____879 -> (aux q)) uu____877))
end
| [] -> begin
(

let uu____880 = (lookup_default_id Cont_fail id)
in (option_of_cont (fun uu____882 -> None) uu____880))
end))
in (aux env.scope_mods)))))))


let found_local_binding = (fun r uu____901 -> (match (uu____901) with
| (id', x, mut) -> begin
(

let uu____908 = (bv_to_name x r)
in ((uu____908), (mut)))
end))


let find_in_module = (fun env lid k_global_def k_not_found -> (

let uu____945 = (FStar_Util.smap_try_find (sigmap env) lid.FStar_Ident.str)
in (match (uu____945) with
| Some (sb) -> begin
(k_global_def lid sb)
end
| None -> begin
k_not_found
end)))


let try_lookup_id : env  ->  FStar_Ident.ident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun env id -> (

let uu____967 = (unmangleOpName id)
in (match (uu____967) with
| Some (f) -> begin
Some (f)
end
| uu____981 -> begin
(try_lookup_id'' env id Exported_id_term_type (fun r -> (

let uu____988 = (found_local_binding id.FStar_Ident.idRange r)
in Cont_ok (uu____988))) (fun uu____993 -> Cont_fail) (fun uu____996 -> Cont_ignore) (fun i -> (find_in_module env i (fun uu____1003 uu____1004 -> Cont_fail) Cont_ignore)) (fun uu____1011 uu____1012 -> Cont_fail))
end)))


let lookup_default_id = (fun env id k_global_def k_not_found -> (

let find_in_monad = (match (env.curmonad) with
| Some (uu____1064) -> begin
(

let lid = (qualify env id)
in (

let uu____1066 = (FStar_Util.smap_try_find (sigmap env) lid.FStar_Ident.str)
in (match (uu____1066) with
| Some (r) -> begin
(

let uu____1079 = (k_global_def lid r)
in Some (uu____1079))
end
| None -> begin
None
end)))
end
| None -> begin
None
end)
in (match (find_in_monad) with
| Some (v) -> begin
v
end
| None -> begin
(

let lid = (

let uu____1092 = (current_module env)
in (qual uu____1092 id))
in (find_in_module env lid k_global_def k_not_found))
end)))


let module_is_defined : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> ((

let uu____1100 = (current_module env)
in (FStar_Ident.lid_equals lid uu____1100)) || (FStar_List.existsb (fun x -> (FStar_Ident.lid_equals lid (Prims.fst x))) env.modules)))


let resolve_module_name : env  ->  FStar_Ident.lident  ->  Prims.bool  ->  FStar_Ident.lident Prims.option = (fun env lid honor_ns -> (

let nslen = (FStar_List.length lid.FStar_Ident.ns)
in (

let rec aux = (fun uu___149_1124 -> (match (uu___149_1124) with
| [] -> begin
(

let uu____1127 = (module_is_defined env lid)
in (match (uu____1127) with
| true -> begin
Some (lid)
end
| uu____1129 -> begin
None
end))
end
| (Open_module_or_namespace (ns, Open_namespace))::q when honor_ns -> begin
(

let new_lid = (

let uu____1134 = (

let uu____1136 = (FStar_Ident.path_of_lid ns)
in (

let uu____1138 = (FStar_Ident.path_of_lid lid)
in (FStar_List.append uu____1136 uu____1138)))
in (FStar_Ident.lid_of_path uu____1134 (FStar_Ident.range_of_lid lid)))
in (

let uu____1140 = (module_is_defined env new_lid)
in (match (uu____1140) with
| true -> begin
Some (new_lid)
end
| uu____1142 -> begin
(aux q)
end)))
end
| (Module_abbrev (name, modul))::uu____1145 when ((nslen = (Prims.parse_int "0")) && (name.FStar_Ident.idText = lid.FStar_Ident.ident.FStar_Ident.idText)) -> begin
Some (modul)
end
| (uu____1149)::q -> begin
(aux q)
end))
in (aux env.scope_mods))))


let resolve_in_open_namespaces'' = (fun env lid eikind k_local_binding k_rec_binding k_record f_module l_default -> (match (lid.FStar_Ident.ns) with
| (uu____1237)::uu____1238 -> begin
(

let uu____1240 = (

let uu____1242 = (

let uu____1243 = (FStar_Ident.lid_of_ids lid.FStar_Ident.ns)
in (FStar_Ident.set_lid_range uu____1243 (FStar_Ident.range_of_lid lid)))
in (resolve_module_name env uu____1242 true))
in (match (uu____1240) with
| None -> begin
None
end
| Some (modul) -> begin
(

let uu____1246 = (find_in_module_with_includes eikind f_module Cont_fail env modul lid.FStar_Ident.ident)
in (option_of_cont (fun uu____1248 -> None) uu____1246))
end))
end
| [] -> begin
(try_lookup_id'' env lid.FStar_Ident.ident eikind k_local_binding k_rec_binding k_record f_module l_default)
end))


let cont_of_option = (fun k_none uu___150_1263 -> (match (uu___150_1263) with
| Some (v) -> begin
Cont_ok (v)
end
| None -> begin
k_none
end))


let resolve_in_open_namespaces' = (fun env lid k_local_binding k_rec_binding k_global_def -> (

let k_global_def' = (fun k lid def -> (

let uu____1342 = (k_global_def lid def)
in (cont_of_option k uu____1342)))
in (

let f_module = (fun lid' -> (

let k = Cont_ignore
in (find_in_module env lid' (k_global_def' k) k)))
in (

let l_default = (fun k i -> (lookup_default_id env i (k_global_def' k) k))
in (resolve_in_open_namespaces'' env lid Exported_id_term_type (fun l -> (

let uu____1363 = (k_local_binding l)
in (cont_of_option Cont_fail uu____1363))) (fun r -> (

let uu____1366 = (k_rec_binding r)
in (cont_of_option Cont_fail uu____1366))) (fun uu____1368 -> Cont_ignore) f_module l_default)))))


let fv_qual_of_se : FStar_Syntax_Syntax.sigelt  ->  FStar_Syntax_Syntax.fv_qual Prims.option = (fun uu___152_1372 -> (match (uu___152_1372) with
| FStar_Syntax_Syntax.Sig_datacon (uu____1374, uu____1375, uu____1376, l, uu____1378, quals, uu____1380, uu____1381) -> begin
(

let qopt = (FStar_Util.find_map quals (fun uu___151_1388 -> (match (uu___151_1388) with
| FStar_Syntax_Syntax.RecordConstructor (uu____1390, fs) -> begin
Some (FStar_Syntax_Syntax.Record_ctor (((l), (fs))))
end
| uu____1397 -> begin
None
end)))
in (match (qopt) with
| None -> begin
Some (FStar_Syntax_Syntax.Data_ctor)
end
| x -> begin
x
end))
end
| FStar_Syntax_Syntax.Sig_declare_typ (uu____1401, uu____1402, uu____1403, quals, uu____1405) -> begin
None
end
| uu____1408 -> begin
None
end))


let lb_fv : FStar_Syntax_Syntax.letbinding Prims.list  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.fv = (fun lbs lid -> (

let uu____1417 = (FStar_Util.find_map lbs (fun lb -> (

let fv = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (

let uu____1421 = (FStar_Syntax_Syntax.fv_eq_lid fv lid)
in (match (uu____1421) with
| true -> begin
Some (fv)
end
| uu____1423 -> begin
None
end)))))
in (FStar_All.pipe_right uu____1417 FStar_Util.must)))


let ns_of_lid_equals : FStar_Ident.lident  ->  FStar_Ident.lident  ->  Prims.bool = (fun lid ns -> (((FStar_List.length lid.FStar_Ident.ns) = (FStar_List.length (FStar_Ident.ids_of_lid ns))) && (

let uu____1435 = (FStar_Ident.lid_of_ids lid.FStar_Ident.ns)
in (FStar_Ident.lid_equals uu____1435 ns))))


let try_lookup_name : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  foundname Prims.option = (fun any_val exclude_interf env lid -> (

let occurrence_range = (FStar_Ident.range_of_lid lid)
in (

let k_global_def = (fun source_lid uu___156_1460 -> (match (uu___156_1460) with
| (uu____1464, true) when exclude_interf -> begin
None
end
| (se, uu____1466) -> begin
(match (se) with
| FStar_Syntax_Syntax.Sig_inductive_typ (uu____1468) -> begin
(

let uu____1480 = (

let uu____1481 = (

let uu____1484 = (FStar_Syntax_Syntax.fvar source_lid FStar_Syntax_Syntax.Delta_constant None)
in ((uu____1484), (false)))
in Term_name (uu____1481))
in Some (uu____1480))
end
| FStar_Syntax_Syntax.Sig_datacon (uu____1485) -> begin
(

let uu____1496 = (

let uu____1497 = (

let uu____1500 = (

let uu____1501 = (fv_qual_of_se se)
in (FStar_Syntax_Syntax.fvar source_lid FStar_Syntax_Syntax.Delta_constant uu____1501))
in ((uu____1500), (false)))
in Term_name (uu____1497))
in Some (uu____1496))
end
| FStar_Syntax_Syntax.Sig_let ((uu____1503, lbs), uu____1505, uu____1506, uu____1507, uu____1508) -> begin
(

let fv = (lb_fv lbs source_lid)
in (

let uu____1521 = (

let uu____1522 = (

let uu____1525 = (FStar_Syntax_Syntax.fvar source_lid fv.FStar_Syntax_Syntax.fv_delta fv.FStar_Syntax_Syntax.fv_qual)
in ((uu____1525), (false)))
in Term_name (uu____1522))
in Some (uu____1521)))
end
| FStar_Syntax_Syntax.Sig_declare_typ (lid, uu____1527, uu____1528, quals, uu____1530) -> begin
(

let uu____1533 = (any_val || (FStar_All.pipe_right quals (FStar_Util.for_some (fun uu___153_1535 -> (match (uu___153_1535) with
| FStar_Syntax_Syntax.Assumption -> begin
true
end
| uu____1536 -> begin
false
end)))))
in (match (uu____1533) with
| true -> begin
(

let lid = (FStar_Ident.set_lid_range lid (FStar_Ident.range_of_lid source_lid))
in (

let dd = (

let uu____1540 = ((FStar_Syntax_Util.is_primop_lid lid) || ((ns_of_lid_equals lid FStar_Syntax_Const.prims_lid) && (FStar_All.pipe_right quals (FStar_Util.for_some (fun uu___154_1542 -> (match (uu___154_1542) with
| (FStar_Syntax_Syntax.Projector (_)) | (FStar_Syntax_Syntax.Discriminator (_)) -> begin
true
end
| uu____1545 -> begin
false
end))))))
in (match (uu____1540) with
| true -> begin
FStar_Syntax_Syntax.Delta_equational
end
| uu____1546 -> begin
FStar_Syntax_Syntax.Delta_constant
end))
in (

let uu____1547 = (FStar_Util.find_map quals (fun uu___155_1549 -> (match (uu___155_1549) with
| FStar_Syntax_Syntax.Reflectable (refl_monad) -> begin
Some (refl_monad)
end
| uu____1552 -> begin
None
end)))
in (match (uu____1547) with
| Some (refl_monad) -> begin
(

let refl_const = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_reflect (refl_monad)))) None occurrence_range)
in Some (Term_name (((refl_const), (false)))))
end
| uu____1568 -> begin
(

let uu____1570 = (

let uu____1571 = (

let uu____1574 = (

let uu____1575 = (fv_qual_of_se se)
in (FStar_Syntax_Syntax.fvar lid dd uu____1575))
in ((uu____1574), (false)))
in Term_name (uu____1571))
in Some (uu____1570))
end))))
end
| uu____1577 -> begin
None
end))
end
| (FStar_Syntax_Syntax.Sig_new_effect_for_free (ne, _)) | (FStar_Syntax_Syntax.Sig_new_effect (ne, _)) -> begin
Some (Eff_name (((se), ((FStar_Ident.set_lid_range ne.FStar_Syntax_Syntax.mname (FStar_Ident.range_of_lid source_lid))))))
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (uu____1581) -> begin
Some (Eff_name (((se), (source_lid))))
end
| uu____1591 -> begin
None
end)
end))
in (

let k_local_binding = (fun r -> (

let uu____1603 = (

let uu____1604 = (found_local_binding (FStar_Ident.range_of_lid lid) r)
in Term_name (uu____1604))
in Some (uu____1603)))
in (

let k_rec_binding = (fun uu____1614 -> (match (uu____1614) with
| (id, l, dd) -> begin
(

let uu____1622 = (

let uu____1623 = (

let uu____1626 = (FStar_Syntax_Syntax.fvar (FStar_Ident.set_lid_range l (FStar_Ident.range_of_lid lid)) dd None)
in ((uu____1626), (false)))
in Term_name (uu____1623))
in Some (uu____1622))
end))
in (

let found_unmangled = (match (lid.FStar_Ident.ns) with
| [] -> begin
(

let uu____1630 = (unmangleOpName lid.FStar_Ident.ident)
in (match (uu____1630) with
| Some (f) -> begin
Some (Term_name (f))
end
| uu____1640 -> begin
None
end))
end
| uu____1644 -> begin
None
end)
in (match (found_unmangled) with
| None -> begin
(resolve_in_open_namespaces' env lid k_local_binding k_rec_binding k_global_def)
end
| x -> begin
x
end)))))))


let try_lookup_effect_name' : Prims.bool  ->  env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.sigelt * FStar_Ident.lident) Prims.option = (fun exclude_interf env lid -> (

let uu____1664 = (try_lookup_name true exclude_interf env lid)
in (match (uu____1664) with
| Some (Eff_name (o, l)) -> begin
Some (((o), (l)))
end
| uu____1673 -> begin
None
end)))


let try_lookup_effect_name : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.option = (fun env l -> (

let uu____1684 = (try_lookup_effect_name' (not (env.iface)) env l)
in (match (uu____1684) with
| Some (o, l) -> begin
Some (l)
end
| uu____1693 -> begin
None
end)))


let try_lookup_effect_name_and_attributes : env  ->  FStar_Ident.lident  ->  (FStar_Ident.lident * FStar_Syntax_Syntax.cflags Prims.list) Prims.option = (fun env l -> (

let uu____1707 = (try_lookup_effect_name' (not (env.iface)) env l)
in (match (uu____1707) with
| Some (FStar_Syntax_Syntax.Sig_new_effect (ne, uu____1716), l) -> begin
Some (((l), (ne.FStar_Syntax_Syntax.cattributes)))
end
| Some (FStar_Syntax_Syntax.Sig_new_effect_for_free (ne, uu____1725), l) -> begin
Some (((l), (ne.FStar_Syntax_Syntax.cattributes)))
end
| Some (FStar_Syntax_Syntax.Sig_effect_abbrev (uu____1733, uu____1734, uu____1735, uu____1736, uu____1737, cattributes, uu____1739), l) -> begin
Some (((l), (cattributes)))
end
| uu____1751 -> begin
None
end)))


let try_lookup_effect_defn : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.eff_decl Prims.option = (fun env l -> (

let uu____1765 = (try_lookup_effect_name' (not (env.iface)) env l)
in (match (uu____1765) with
| Some (FStar_Syntax_Syntax.Sig_new_effect (ne, uu____1771), uu____1772) -> begin
Some (ne)
end
| Some (FStar_Syntax_Syntax.Sig_new_effect_for_free (ne, uu____1776), uu____1777) -> begin
Some (ne)
end
| uu____1780 -> begin
None
end)))


let is_effect_name : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (

let uu____1790 = (try_lookup_effect_name env lid)
in (match (uu____1790) with
| None -> begin
false
end
| Some (uu____1792) -> begin
true
end)))


let try_lookup_root_effect_name : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.option = (fun env l -> (

let uu____1800 = (try_lookup_effect_name' (not (env.iface)) env l)
in (match (uu____1800) with
| Some (FStar_Syntax_Syntax.Sig_effect_abbrev (l', uu____1806, uu____1807, uu____1808, uu____1809, uu____1810, uu____1811), uu____1812) -> begin
(

let rec aux = (fun new_name -> (

let uu____1824 = (FStar_Util.smap_try_find (sigmap env) new_name.FStar_Ident.str)
in (match (uu____1824) with
| None -> begin
None
end
| Some (s, uu____1834) -> begin
(match (s) with
| (FStar_Syntax_Syntax.Sig_new_effect_for_free (ne, _)) | (FStar_Syntax_Syntax.Sig_new_effect (ne, _)) -> begin
Some ((FStar_Ident.set_lid_range ne.FStar_Syntax_Syntax.mname (FStar_Ident.range_of_lid l)))
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (uu____1841, uu____1842, uu____1843, cmp, uu____1845, uu____1846, uu____1847) -> begin
(

let l'' = (FStar_Syntax_Util.comp_effect_name cmp)
in (aux l''))
end
| uu____1853 -> begin
None
end)
end)))
in (aux l'))
end
| Some (uu____1854, l') -> begin
Some (l')
end
| uu____1858 -> begin
None
end)))


let lookup_letbinding_quals : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.qualifier Prims.list = (fun env lid -> (

let k_global_def = (fun lid uu___157_1879 -> (match (uu___157_1879) with
| (FStar_Syntax_Syntax.Sig_declare_typ (lid, uu____1885, uu____1886, quals, uu____1888), uu____1889) -> begin
Some (quals)
end
| uu____1893 -> begin
None
end))
in (

let uu____1897 = (resolve_in_open_namespaces' env lid (fun uu____1901 -> None) (fun uu____1903 -> None) k_global_def)
in (match (uu____1897) with
| Some (quals) -> begin
quals
end
| uu____1909 -> begin
[]
end))))


let try_lookup_module : env  ->  Prims.string Prims.list  ->  FStar_Syntax_Syntax.modul Prims.option = (fun env path -> (

let uu____1921 = (FStar_List.tryFind (fun uu____1927 -> (match (uu____1927) with
| (mlid, modul) -> begin
(

let uu____1932 = (FStar_Ident.path_of_lid mlid)
in (uu____1932 = path))
end)) env.modules)
in (match (uu____1921) with
| Some (uu____1936, modul) -> begin
Some (modul)
end
| None -> begin
None
end)))


let try_lookup_let : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term Prims.option = (fun env lid -> (

let k_global_def = (fun lid uu___158_1958 -> (match (uu___158_1958) with
| (FStar_Syntax_Syntax.Sig_let ((uu____1962, lbs), uu____1964, uu____1965, uu____1966, uu____1967), uu____1968) -> begin
(

let fv = (lb_fv lbs lid)
in (

let uu____1981 = (FStar_Syntax_Syntax.fvar lid fv.FStar_Syntax_Syntax.fv_delta fv.FStar_Syntax_Syntax.fv_qual)
in Some (uu____1981)))
end
| uu____1982 -> begin
None
end))
in (resolve_in_open_namespaces' env lid (fun uu____1985 -> None) (fun uu____1986 -> None) k_global_def)))


let try_lookup_definition : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term Prims.option = (fun env lid -> (

let k_global_def = (fun lid uu___159_2005 -> (match (uu___159_2005) with
| (FStar_Syntax_Syntax.Sig_let (lbs, uu____2012, uu____2013, uu____2014, uu____2015), uu____2016) -> begin
(FStar_Util.find_map (Prims.snd lbs) (fun lb -> (match (lb.FStar_Syntax_Syntax.lbname) with
| FStar_Util.Inr (fv) when (FStar_Syntax_Syntax.fv_eq_lid fv lid) -> begin
Some (lb.FStar_Syntax_Syntax.lbdef)
end
| uu____2033 -> begin
None
end)))
end
| uu____2038 -> begin
None
end))
in (resolve_in_open_namespaces' env lid (fun uu____2045 -> None) (fun uu____2048 -> None) k_global_def)))


let empty_include_smap : FStar_Ident.lident Prims.list FStar_ST.ref FStar_Util.smap = (new_sigmap ())


let empty_exported_id_smap : exported_id_set FStar_Util.smap = (new_sigmap ())


let try_lookup_lid' : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun any_val exclude_interf env lid -> (

let uu____2075 = (try_lookup_name any_val exclude_interf env lid)
in (match (uu____2075) with
| Some (Term_name (e, mut)) -> begin
Some (((e), (mut)))
end
| uu____2084 -> begin
None
end)))


let try_lookup_lid : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun env l -> (try_lookup_lid' env.iface false env l))


let try_lookup_lid_no_resolve : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun env l -> (

let env' = (

let uu___173_2107 = env
in {curmodule = uu___173_2107.curmodule; curmonad = uu___173_2107.curmonad; modules = uu___173_2107.modules; scope_mods = []; exported_ids = empty_exported_id_smap; trans_exported_ids = uu___173_2107.trans_exported_ids; includes = empty_include_smap; sigaccum = uu___173_2107.sigaccum; sigmap = uu___173_2107.sigmap; iface = uu___173_2107.iface; admitted_iface = uu___173_2107.admitted_iface; expect_typ = uu___173_2107.expect_typ})
in (try_lookup_lid env' l)))


let try_lookup_datacon : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.fv Prims.option = (fun env lid -> (

let k_global_def = (fun lid uu___161_2124 -> (match (uu___161_2124) with
| (FStar_Syntax_Syntax.Sig_declare_typ (uu____2128, uu____2129, uu____2130, quals, uu____2132), uu____2133) -> begin
(

let uu____2136 = (FStar_All.pipe_right quals (FStar_Util.for_some (fun uu___160_2138 -> (match (uu___160_2138) with
| FStar_Syntax_Syntax.Assumption -> begin
true
end
| uu____2139 -> begin
false
end))))
in (match (uu____2136) with
| true -> begin
(

let uu____2141 = (FStar_Syntax_Syntax.lid_as_fv lid FStar_Syntax_Syntax.Delta_constant None)
in Some (uu____2141))
end
| uu____2142 -> begin
None
end))
end
| (FStar_Syntax_Syntax.Sig_datacon (uu____2143), uu____2144) -> begin
(

let uu____2155 = (FStar_Syntax_Syntax.lid_as_fv lid FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor)))
in Some (uu____2155))
end
| uu____2156 -> begin
None
end))
in (resolve_in_open_namespaces' env lid (fun uu____2159 -> None) (fun uu____2160 -> None) k_global_def)))


let find_all_datacons : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.list Prims.option = (fun env lid -> (

let k_global_def = (fun lid uu___162_2179 -> (match (uu___162_2179) with
| (FStar_Syntax_Syntax.Sig_inductive_typ (uu____2184, uu____2185, uu____2186, uu____2187, uu____2188, datas, uu____2190, uu____2191), uu____2192) -> begin
Some (datas)
end
| uu____2200 -> begin
None
end))
in (resolve_in_open_namespaces' env lid (fun uu____2205 -> None) (fun uu____2207 -> None) k_global_def)))


let record_cache_aux_with_filter : (((Prims.unit  ->  Prims.unit) * (Prims.unit  ->  Prims.unit) * (Prims.unit  ->  record_or_dc Prims.list) * (record_or_dc  ->  Prims.unit) * (Prims.unit  ->  Prims.unit)) * (Prims.unit  ->  Prims.unit)) = (

let record_cache = (FStar_Util.mk_ref (([])::[]))
in (

let push = (fun uu____2241 -> (

let uu____2242 = (

let uu____2245 = (

let uu____2247 = (FStar_ST.read record_cache)
in (FStar_List.hd uu____2247))
in (

let uu____2255 = (FStar_ST.read record_cache)
in (uu____2245)::uu____2255))
in (FStar_ST.write record_cache uu____2242)))
in (

let pop = (fun uu____2270 -> (

let uu____2271 = (

let uu____2274 = (FStar_ST.read record_cache)
in (FStar_List.tl uu____2274))
in (FStar_ST.write record_cache uu____2271)))
in (

let peek = (fun uu____2290 -> (

let uu____2291 = (FStar_ST.read record_cache)
in (FStar_List.hd uu____2291)))
in (

let insert = (fun r -> (

let uu____2303 = (

let uu____2306 = (

let uu____2308 = (peek ())
in (r)::uu____2308)
in (

let uu____2310 = (

let uu____2313 = (FStar_ST.read record_cache)
in (FStar_List.tl uu____2313))
in (uu____2306)::uu____2310))
in (FStar_ST.write record_cache uu____2303)))
in (

let commit = (fun uu____2329 -> (

let uu____2330 = (FStar_ST.read record_cache)
in (match (uu____2330) with
| (hd)::(uu____2338)::tl -> begin
(FStar_ST.write record_cache ((hd)::tl))
end
| uu____2351 -> begin
(failwith "Impossible")
end)))
in (

let filter = (fun uu____2357 -> (

let rc = (peek ())
in ((pop ());
(match (()) with
| () -> begin
(

let filtered = (FStar_List.filter (fun r -> (not (r.is_private_or_abstract))) rc)
in (

let uu____2364 = (

let uu____2367 = (FStar_ST.read record_cache)
in (filtered)::uu____2367)
in (FStar_ST.write record_cache uu____2364)))
end);
)))
in (

let aux = ((push), (pop), (peek), (insert), (commit))
in ((aux), (filter))))))))))


let record_cache_aux : ((Prims.unit  ->  Prims.unit) * (Prims.unit  ->  Prims.unit) * (Prims.unit  ->  record_or_dc Prims.list) * (record_or_dc  ->  Prims.unit) * (Prims.unit  ->  Prims.unit)) = (

let uu____2441 = record_cache_aux_with_filter
in (match (uu____2441) with
| (aux, uu____2479) -> begin
aux
end))


let filter_record_cache : Prims.unit  ->  Prims.unit = (

let uu____2518 = record_cache_aux_with_filter
in (match (uu____2518) with
| (uu____2541, filter) -> begin
filter
end))


let push_record_cache : Prims.unit  ->  Prims.unit = (

let uu____2581 = record_cache_aux
in (match (uu____2581) with
| (push, uu____2601, uu____2602, uu____2603, uu____2604) -> begin
push
end))


let pop_record_cache : Prims.unit  ->  Prims.unit = (

let uu____2629 = record_cache_aux
in (match (uu____2629) with
| (uu____2648, pop, uu____2650, uu____2651, uu____2652) -> begin
pop
end))


let peek_record_cache : Prims.unit  ->  record_or_dc Prims.list = (

let uu____2678 = record_cache_aux
in (match (uu____2678) with
| (uu____2698, uu____2699, peek, uu____2701, uu____2702) -> begin
peek
end))


let insert_record_cache : record_or_dc  ->  Prims.unit = (

let uu____2727 = record_cache_aux
in (match (uu____2727) with
| (uu____2746, uu____2747, uu____2748, insert, uu____2750) -> begin
insert
end))


let commit_record_cache : Prims.unit  ->  Prims.unit = (

let uu____2775 = record_cache_aux
in (match (uu____2775) with
| (uu____2794, uu____2795, uu____2796, uu____2797, commit) -> begin
commit
end))


let extract_record : env  ->  scope_mod Prims.list FStar_ST.ref  ->  FStar_Syntax_Syntax.sigelt  ->  Prims.unit = (fun e new_globs uu___166_2832 -> (match (uu___166_2832) with
| FStar_Syntax_Syntax.Sig_bundle (sigs, uu____2837, uu____2838, uu____2839) -> begin
(

let is_rec = (FStar_Util.for_some (fun uu___163_2850 -> (match (uu___163_2850) with
| (FStar_Syntax_Syntax.RecordType (_)) | (FStar_Syntax_Syntax.RecordConstructor (_)) -> begin
true
end
| uu____2853 -> begin
false
end)))
in (

let find_dc = (fun dc -> (FStar_All.pipe_right sigs (FStar_Util.find_opt (fun uu___164_2861 -> (match (uu___164_2861) with
| FStar_Syntax_Syntax.Sig_datacon (lid, uu____2863, uu____2864, uu____2865, uu____2866, uu____2867, uu____2868, uu____2869) -> begin
(FStar_Ident.lid_equals dc lid)
end
| uu____2874 -> begin
false
end)))))
in (FStar_All.pipe_right sigs (FStar_List.iter (fun uu___165_2876 -> (match (uu___165_2876) with
| FStar_Syntax_Syntax.Sig_inductive_typ (typename, univs, parms, uu____2880, uu____2881, (dc)::[], tags, uu____2884) -> begin
(

let uu____2890 = (

let uu____2891 = (find_dc dc)
in (FStar_All.pipe_left FStar_Util.must uu____2891))
in (match (uu____2890) with
| FStar_Syntax_Syntax.Sig_datacon (constrname, uu____2895, t, uu____2897, uu____2898, uu____2899, uu____2900, uu____2901) -> begin
(

let uu____2906 = (FStar_Syntax_Util.arrow_formals t)
in (match (uu____2906) with
| (formals, uu____2915) -> begin
(

let is_rec = (is_rec tags)
in (

let formals' = (FStar_All.pipe_right formals (FStar_List.collect (fun uu____2941 -> (match (uu____2941) with
| (x, q) -> begin
(

let uu____2949 = ((FStar_Syntax_Syntax.is_null_bv x) || (is_rec && (FStar_Syntax_Syntax.is_implicit q)))
in (match (uu____2949) with
| true -> begin
[]
end
| uu____2955 -> begin
(((x), (q)))::[]
end))
end))))
in (

let fields' = (FStar_All.pipe_right formals' (FStar_List.map (fun uu____2980 -> (match (uu____2980) with
| (x, q) -> begin
(

let uu____2989 = (match (is_rec) with
| true -> begin
(FStar_Syntax_Util.unmangle_field_name x.FStar_Syntax_Syntax.ppname)
end
| uu____2990 -> begin
x.FStar_Syntax_Syntax.ppname
end)
in ((uu____2989), (x.FStar_Syntax_Syntax.sort)))
end))))
in (

let fields = fields'
in (

let record = {typename = typename; constrname = constrname.FStar_Ident.ident; parms = parms; fields = fields; is_private_or_abstract = ((FStar_List.contains FStar_Syntax_Syntax.Private tags) || (FStar_List.contains FStar_Syntax_Syntax.Abstract tags)); is_record = is_rec}
in ((

let uu____3001 = (

let uu____3003 = (FStar_ST.read new_globs)
in (Record_or_dc (record))::uu____3003)
in (FStar_ST.write new_globs uu____3001));
(match (()) with
| () -> begin
((

let add_field = (fun uu____3019 -> (match (uu____3019) with
| (id, uu____3025) -> begin
(

let modul = (

let uu____3031 = (FStar_Ident.lid_of_ids constrname.FStar_Ident.ns)
in uu____3031.FStar_Ident.str)
in (

let uu____3032 = (get_exported_id_set e modul)
in (match (uu____3032) with
| Some (my_ex) -> begin
(

let my_exported_ids = (my_ex Exported_id_field)
in ((

let uu____3039 = (

let uu____3040 = (FStar_ST.read my_exported_ids)
in (FStar_Util.set_add id.FStar_Ident.idText uu____3040))
in (FStar_ST.write my_exported_ids uu____3039));
(match (()) with
| () -> begin
(

let projname = (

let uu____3047 = (

let uu____3048 = (FStar_Syntax_Util.mk_field_projector_name_from_ident constrname id)
in uu____3048.FStar_Ident.ident)
in uu____3047.FStar_Ident.idText)
in (

let uu____3050 = (

let uu____3051 = (FStar_ST.read my_exported_ids)
in (FStar_Util.set_add projname uu____3051))
in (FStar_ST.write my_exported_ids uu____3050)))
end);
))
end
| None -> begin
()
end)))
end))
in (FStar_List.iter add_field fields'));
(match (()) with
| () -> begin
(insert_record_cache record)
end);
)
end);
))))))
end))
end
| uu____3061 -> begin
()
end))
end
| uu____3062 -> begin
()
end))))))
end
| uu____3063 -> begin
()
end))


let try_lookup_record_or_dc_by_field_name : env  ->  FStar_Ident.lident  ->  record_or_dc Prims.option = (fun env fieldname -> (

let find_in_cache = (fun fieldname -> (

let uu____3076 = ((fieldname.FStar_Ident.ns), (fieldname.FStar_Ident.ident))
in (match (uu____3076) with
| (ns, id) -> begin
(

let uu____3086 = (peek_record_cache ())
in (FStar_Util.find_map uu____3086 (fun record -> (

let uu____3089 = (find_in_record ns id record (fun r -> Cont_ok (r)))
in (option_of_cont (fun uu____3092 -> None) uu____3089)))))
end)))
in (resolve_in_open_namespaces'' env fieldname Exported_id_field (fun uu____3093 -> Cont_ignore) (fun uu____3094 -> Cont_ignore) (fun r -> Cont_ok (r)) (fun fn -> (

let uu____3097 = (find_in_cache fn)
in (cont_of_option Cont_ignore uu____3097))) (fun k uu____3100 -> k))))


let try_lookup_record_by_field_name : env  ->  FStar_Ident.lident  ->  record_or_dc Prims.option = (fun env fieldname -> (

let uu____3109 = (try_lookup_record_or_dc_by_field_name env fieldname)
in (match (uu____3109) with
| Some (r) when r.is_record -> begin
Some (r)
end
| uu____3113 -> begin
None
end)))


let belongs_to_record : env  ->  FStar_Ident.lident  ->  record_or_dc  ->  Prims.bool = (fun env lid record -> (

let uu____3124 = (try_lookup_record_by_field_name env lid)
in (match (uu____3124) with
| Some (record') when (

let uu____3127 = (

let uu____3128 = (FStar_Ident.path_of_ns record.typename.FStar_Ident.ns)
in (FStar_Ident.text_of_path uu____3128))
in (

let uu____3130 = (

let uu____3131 = (FStar_Ident.path_of_ns record'.typename.FStar_Ident.ns)
in (FStar_Ident.text_of_path uu____3131))
in (uu____3127 = uu____3130))) -> begin
(

let uu____3133 = (find_in_record record.typename.FStar_Ident.ns lid.FStar_Ident.ident record (fun uu____3135 -> Cont_ok (())))
in (match (uu____3133) with
| Cont_ok (uu____3136) -> begin
true
end
| uu____3137 -> begin
false
end))
end
| uu____3139 -> begin
false
end)))


let try_lookup_dc_by_field_name : env  ->  FStar_Ident.lident  ->  (FStar_Ident.lident * Prims.bool) Prims.option = (fun env fieldname -> (

let uu____3150 = (try_lookup_record_or_dc_by_field_name env fieldname)
in (match (uu____3150) with
| Some (r) -> begin
(

let uu____3156 = (

let uu____3159 = (

let uu____3160 = (FStar_Ident.lid_of_ids (FStar_List.append r.typename.FStar_Ident.ns ((r.constrname)::[])))
in (FStar_Ident.set_lid_range uu____3160 (FStar_Ident.range_of_lid fieldname)))
in ((uu____3159), (r.is_record)))
in Some (uu____3156))
end
| uu____3163 -> begin
None
end)))


let string_set_ref_new : Prims.unit  ->  Prims.string FStar_Util.set FStar_ST.ref = (fun uu____3172 -> (

let uu____3173 = (FStar_Util.new_set FStar_Util.compare FStar_Util.hashcode)
in (FStar_Util.mk_ref uu____3173)))


let exported_id_set_new : Prims.unit  ->  exported_id_kind  ->  Prims.string FStar_Util.set FStar_ST.ref = (fun uu____3184 -> (

let term_type_set = (string_set_ref_new ())
in (

let field_set = (string_set_ref_new ())
in (fun uu___167_3193 -> (match (uu___167_3193) with
| Exported_id_term_type -> begin
term_type_set
end
| Exported_id_field -> begin
field_set
end)))))


let unique : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  Prims.bool = (fun any_val exclude_if env lid -> (

let filter_scope_mods = (fun uu___168_3213 -> (match (uu___168_3213) with
| Rec_binding (uu____3214) -> begin
true
end
| uu____3215 -> begin
false
end))
in (

let this_env = (

let uu___174_3217 = env
in (

let uu____3218 = (FStar_List.filter filter_scope_mods env.scope_mods)
in {curmodule = uu___174_3217.curmodule; curmonad = uu___174_3217.curmonad; modules = uu___174_3217.modules; scope_mods = uu____3218; exported_ids = empty_exported_id_smap; trans_exported_ids = uu___174_3217.trans_exported_ids; includes = empty_include_smap; sigaccum = uu___174_3217.sigaccum; sigmap = uu___174_3217.sigmap; iface = uu___174_3217.iface; admitted_iface = uu___174_3217.admitted_iface; expect_typ = uu___174_3217.expect_typ}))
in (

let uu____3220 = (try_lookup_lid' any_val exclude_if this_env lid)
in (match (uu____3220) with
| None -> begin
true
end
| Some (uu____3226) -> begin
false
end)))))


let push_scope_mod : env  ->  scope_mod  ->  env = (fun env scope_mod -> (

let uu___175_3237 = env
in {curmodule = uu___175_3237.curmodule; curmonad = uu___175_3237.curmonad; modules = uu___175_3237.modules; scope_mods = (scope_mod)::env.scope_mods; exported_ids = uu___175_3237.exported_ids; trans_exported_ids = uu___175_3237.trans_exported_ids; includes = uu___175_3237.includes; sigaccum = uu___175_3237.sigaccum; sigmap = uu___175_3237.sigmap; iface = uu___175_3237.iface; admitted_iface = uu___175_3237.admitted_iface; expect_typ = uu___175_3237.expect_typ}))


let push_bv' : env  ->  FStar_Ident.ident  ->  Prims.bool  ->  (env * FStar_Syntax_Syntax.bv) = (fun env x is_mutable -> (

let bv = (FStar_Syntax_Syntax.gen_bv x.FStar_Ident.idText (Some (x.FStar_Ident.idRange)) FStar_Syntax_Syntax.tun)
in (((push_scope_mod env (Local_binding (((x), (bv), (is_mutable)))))), (bv))))


let push_bv_mutable : env  ->  FStar_Ident.ident  ->  (env * FStar_Syntax_Syntax.bv) = (fun env x -> (push_bv' env x true))


let push_bv : env  ->  FStar_Ident.ident  ->  (env * FStar_Syntax_Syntax.bv) = (fun env x -> (push_bv' env x false))


let push_top_level_rec_binding : env  ->  FStar_Ident.ident  ->  FStar_Syntax_Syntax.delta_depth  ->  env = (fun env x dd -> (

let l = (qualify env x)
in (

let uu____3276 = (unique false true env l)
in (match (uu____3276) with
| true -> begin
(push_scope_mod env (Rec_binding (((x), (l), (dd)))))
end
| uu____3277 -> begin
(Prims.raise (FStar_Errors.Error ((((Prims.strcat "Duplicate top-level names " l.FStar_Ident.str)), ((FStar_Ident.range_of_lid l))))))
end))))


let push_sigelt : env  ->  FStar_Syntax_Syntax.sigelt  ->  env = (fun env s -> (

let err = (fun l -> (

let sopt = (FStar_Util.smap_try_find (sigmap env) l.FStar_Ident.str)
in (

let r = (match (sopt) with
| Some (se, uu____3296) -> begin
(

let uu____3299 = (FStar_Util.find_opt (FStar_Ident.lid_equals l) (FStar_Syntax_Util.lids_of_sigelt se))
in (match (uu____3299) with
| Some (l) -> begin
(FStar_All.pipe_left FStar_Range.string_of_range (FStar_Ident.range_of_lid l))
end
| None -> begin
"<unknown>"
end))
end
| None -> begin
"<unknown>"
end)
in (

let uu____3304 = (

let uu____3305 = (

let uu____3308 = (FStar_Util.format2 "Duplicate top-level names [%s]; previously declared at %s" (FStar_Ident.text_of_lid l) r)
in ((uu____3308), ((FStar_Ident.range_of_lid l))))
in FStar_Errors.Error (uu____3305))
in (Prims.raise uu____3304)))))
in (

let globals = (FStar_Util.mk_ref env.scope_mods)
in (

let env = (

let uu____3315 = (match (s) with
| FStar_Syntax_Syntax.Sig_let (uu____3320) -> begin
((false), (true))
end
| FStar_Syntax_Syntax.Sig_bundle (uu____3329) -> begin
((true), (true))
end
| uu____3337 -> begin
((false), (false))
end)
in (match (uu____3315) with
| (any_val, exclude_if) -> begin
(

let lids = (FStar_Syntax_Util.lids_of_sigelt s)
in (

let uu____3342 = (FStar_Util.find_map lids (fun l -> (

let uu____3345 = (

let uu____3346 = (unique any_val exclude_if env l)
in (not (uu____3346)))
in (match (uu____3345) with
| true -> begin
Some (l)
end
| uu____3348 -> begin
None
end))))
in (match (uu____3342) with
| None -> begin
((extract_record env globals s);
(

let uu___176_3352 = env
in {curmodule = uu___176_3352.curmodule; curmonad = uu___176_3352.curmonad; modules = uu___176_3352.modules; scope_mods = uu___176_3352.scope_mods; exported_ids = uu___176_3352.exported_ids; trans_exported_ids = uu___176_3352.trans_exported_ids; includes = uu___176_3352.includes; sigaccum = (s)::env.sigaccum; sigmap = uu___176_3352.sigmap; iface = uu___176_3352.iface; admitted_iface = uu___176_3352.admitted_iface; expect_typ = uu___176_3352.expect_typ});
)
end
| Some (l) -> begin
(err l)
end)))
end))
in (

let env = (

let uu___177_3355 = env
in (

let uu____3356 = (FStar_ST.read globals)
in {curmodule = uu___177_3355.curmodule; curmonad = uu___177_3355.curmonad; modules = uu___177_3355.modules; scope_mods = uu____3356; exported_ids = uu___177_3355.exported_ids; trans_exported_ids = uu___177_3355.trans_exported_ids; includes = uu___177_3355.includes; sigaccum = uu___177_3355.sigaccum; sigmap = uu___177_3355.sigmap; iface = uu___177_3355.iface; admitted_iface = uu___177_3355.admitted_iface; expect_typ = uu___177_3355.expect_typ}))
in (

let uu____3361 = (match (s) with
| FStar_Syntax_Syntax.Sig_bundle (ses, uu____3375, uu____3376, uu____3377) -> begin
(

let uu____3384 = (FStar_List.map (fun se -> (((FStar_Syntax_Util.lids_of_sigelt se)), (se))) ses)
in ((env), (uu____3384)))
end
| uu____3398 -> begin
((env), (((((FStar_Syntax_Util.lids_of_sigelt s)), (s)))::[]))
end)
in (match (uu____3361) with
| (env, lss) -> begin
((FStar_All.pipe_right lss (FStar_List.iter (fun uu____3428 -> (match (uu____3428) with
| (lids, se) -> begin
(FStar_All.pipe_right lids (FStar_List.iter (fun lid -> ((

let uu____3439 = (

let uu____3441 = (FStar_ST.read globals)
in (Top_level_def (lid.FStar_Ident.ident))::uu____3441)
in (FStar_ST.write globals uu____3439));
(match (()) with
| () -> begin
(

let modul = (

let uu____3450 = (FStar_Ident.lid_of_ids lid.FStar_Ident.ns)
in uu____3450.FStar_Ident.str)
in ((

let uu____3452 = (get_exported_id_set env modul)
in (match (uu____3452) with
| Some (f) -> begin
(

let my_exported_ids = (f Exported_id_term_type)
in (

let uu____3458 = (

let uu____3459 = (FStar_ST.read my_exported_ids)
in (FStar_Util.set_add lid.FStar_Ident.ident.FStar_Ident.idText uu____3459))
in (FStar_ST.write my_exported_ids uu____3458)))
end
| None -> begin
()
end));
(match (()) with
| () -> begin
(FStar_Util.smap_add (sigmap env) lid.FStar_Ident.str ((se), ((env.iface && (not (env.admitted_iface))))))
end);
))
end);
))))
end))));
(

let env = (

let uu___178_3468 = env
in (

let uu____3469 = (FStar_ST.read globals)
in {curmodule = uu___178_3468.curmodule; curmonad = uu___178_3468.curmonad; modules = uu___178_3468.modules; scope_mods = uu____3469; exported_ids = uu___178_3468.exported_ids; trans_exported_ids = uu___178_3468.trans_exported_ids; includes = uu___178_3468.includes; sigaccum = uu___178_3468.sigaccum; sigmap = uu___178_3468.sigmap; iface = uu___178_3468.iface; admitted_iface = uu___178_3468.admitted_iface; expect_typ = uu___178_3468.expect_typ}))
in env);
)
end)))))))


let push_namespace : env  ->  FStar_Ident.lident  ->  env = (fun env ns -> (

let uu____3480 = (

let uu____3483 = (resolve_module_name env ns false)
in (match (uu____3483) with
| None -> begin
(

let modules = env.modules
in (

let uu____3491 = (FStar_All.pipe_right modules (FStar_Util.for_some (fun uu____3497 -> (match (uu____3497) with
| (m, uu____3501) -> begin
(FStar_Util.starts_with (Prims.strcat (FStar_Ident.text_of_lid m) ".") (Prims.strcat (FStar_Ident.text_of_lid ns) "."))
end))))
in (match (uu____3491) with
| true -> begin
((ns), (Open_namespace))
end
| uu____3504 -> begin
(

let uu____3505 = (

let uu____3506 = (

let uu____3509 = (FStar_Util.format1 "Namespace %s cannot be found" (FStar_Ident.text_of_lid ns))
in ((uu____3509), ((FStar_Ident.range_of_lid ns))))
in FStar_Errors.Error (uu____3506))
in (Prims.raise uu____3505))
end)))
end
| Some (ns') -> begin
((ns'), (Open_module))
end))
in (match (uu____3480) with
| (ns', kd) -> begin
(push_scope_mod env (Open_module_or_namespace (((ns'), (kd)))))
end)))


let push_include : env  ->  FStar_Ident.lident  ->  env = (fun env ns -> (

let uu____3521 = (resolve_module_name env ns false)
in (match (uu____3521) with
| Some (ns) -> begin
(

let env = (push_scope_mod env (Open_module_or_namespace (((ns), (Open_module)))))
in (

let curmod = (

let uu____3526 = (current_module env)
in uu____3526.FStar_Ident.str)
in ((

let uu____3528 = (FStar_Util.smap_try_find env.includes curmod)
in (match (uu____3528) with
| None -> begin
()
end
| Some (incl) -> begin
(

let uu____3541 = (

let uu____3543 = (FStar_ST.read incl)
in (ns)::uu____3543)
in (FStar_ST.write incl uu____3541))
end));
(match (()) with
| () -> begin
(

let uu____3551 = (get_trans_exported_id_set env ns.FStar_Ident.str)
in (match (uu____3551) with
| Some (ns_trans_exports) -> begin
((

let uu____3555 = (

let uu____3560 = (get_exported_id_set env curmod)
in (

let uu____3562 = (get_trans_exported_id_set env curmod)
in ((uu____3560), (uu____3562))))
in (match (uu____3555) with
| (Some (cur_exports), Some (cur_trans_exports)) -> begin
(

let update_exports = (fun k -> (

let ns_ex = (

let uu____3575 = (ns_trans_exports k)
in (FStar_ST.read uu____3575))
in (

let ex = (cur_exports k)
in ((

let uu____3584 = (

let uu____3585 = (FStar_ST.read ex)
in (FStar_Util.set_difference uu____3585 ns_ex))
in (FStar_ST.write ex uu____3584));
(match (()) with
| () -> begin
(

let trans_ex = (cur_trans_exports k)
in (

let uu____3595 = (

let uu____3596 = (FStar_ST.read ex)
in (FStar_Util.set_union uu____3596 ns_ex))
in (FStar_ST.write trans_ex uu____3595)))
end);
))))
in (FStar_List.iter update_exports all_exported_id_kinds))
end
| uu____3602 -> begin
()
end));
(match (()) with
| () -> begin
env
end);
)
end
| None -> begin
(

let uu____3607 = (

let uu____3608 = (

let uu____3611 = (FStar_Util.format1 "include: Module %s was not prepared" ns.FStar_Ident.str)
in ((uu____3611), ((FStar_Ident.range_of_lid ns))))
in FStar_Errors.Error (uu____3608))
in (Prims.raise uu____3607))
end))
end);
)))
end
| uu____3612 -> begin
(

let uu____3614 = (

let uu____3615 = (

let uu____3618 = (FStar_Util.format1 "include: Module %s cannot be found" ns.FStar_Ident.str)
in ((uu____3618), ((FStar_Ident.range_of_lid ns))))
in FStar_Errors.Error (uu____3615))
in (Prims.raise uu____3614))
end)))


let push_module_abbrev : env  ->  FStar_Ident.ident  ->  FStar_Ident.lident  ->  env = (fun env x l -> (

let uu____3628 = (module_is_defined env l)
in (match (uu____3628) with
| true -> begin
(push_scope_mod env (Module_abbrev (((x), (l)))))
end
| uu____3629 -> begin
(

let uu____3630 = (

let uu____3631 = (

let uu____3634 = (FStar_Util.format1 "Module %s cannot be found" (FStar_Ident.text_of_lid l))
in ((uu____3634), ((FStar_Ident.range_of_lid l))))
in FStar_Errors.Error (uu____3631))
in (Prims.raise uu____3630))
end)))


let check_admits : env  ->  Prims.unit = (fun env -> (FStar_All.pipe_right env.sigaccum (FStar_List.iter (fun se -> (match (se) with
| FStar_Syntax_Syntax.Sig_declare_typ (l, u, t, quals, r) -> begin
(

let uu____3646 = (try_lookup_lid env l)
in (match (uu____3646) with
| None -> begin
((

let uu____3653 = (

let uu____3654 = (FStar_Range.string_of_range (FStar_Ident.range_of_lid l))
in (

let uu____3655 = (FStar_Syntax_Print.lid_to_string l)
in (FStar_Util.format2 "%s: Warning: Admitting %s without a definition\n" uu____3654 uu____3655)))
in (FStar_Util.print_string uu____3653));
(FStar_Util.smap_add (sigmap env) l.FStar_Ident.str ((FStar_Syntax_Syntax.Sig_declare_typ (((l), (u), (t), ((FStar_Syntax_Syntax.Assumption)::quals), (r)))), (false)));
)
end
| Some (uu____3659) -> begin
()
end))
end
| uu____3664 -> begin
()
end)))))


let finish : env  ->  FStar_Syntax_Syntax.modul  ->  env = (fun env modul -> ((FStar_All.pipe_right modul.FStar_Syntax_Syntax.declarations (FStar_List.iter (fun uu___170_3672 -> (match (uu___170_3672) with
| FStar_Syntax_Syntax.Sig_bundle (ses, quals, uu____3675, uu____3676) -> begin
(match (((FStar_List.contains FStar_Syntax_Syntax.Private quals) || (FStar_List.contains FStar_Syntax_Syntax.Abstract quals))) with
| true -> begin
(FStar_All.pipe_right ses (FStar_List.iter (fun uu___169_3684 -> (match (uu___169_3684) with
| FStar_Syntax_Syntax.Sig_datacon (lid, uu____3686, uu____3687, uu____3688, uu____3689, uu____3690, uu____3691, uu____3692) -> begin
(FStar_Util.smap_remove (sigmap env) lid.FStar_Ident.str)
end
| uu____3699 -> begin
()
end))))
end
| uu____3700 -> begin
()
end)
end
| FStar_Syntax_Syntax.Sig_declare_typ (lid, uu____3702, uu____3703, quals, uu____3705) -> begin
(match ((FStar_List.contains FStar_Syntax_Syntax.Private quals)) with
| true -> begin
(FStar_Util.smap_remove (sigmap env) lid.FStar_Ident.str)
end
| uu____3710 -> begin
()
end)
end
| FStar_Syntax_Syntax.Sig_let ((uu____3711, lbs), r, uu____3714, quals, uu____3716) -> begin
((match (((FStar_List.contains FStar_Syntax_Syntax.Private quals) || (FStar_List.contains FStar_Syntax_Syntax.Abstract quals))) with
| true -> begin
(FStar_All.pipe_right lbs (FStar_List.iter (fun lb -> (

let uu____3731 = (

let uu____3732 = (

let uu____3733 = (

let uu____3738 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in uu____3738.FStar_Syntax_Syntax.fv_name)
in uu____3733.FStar_Syntax_Syntax.v)
in uu____3732.FStar_Ident.str)
in (FStar_Util.smap_remove (sigmap env) uu____3731)))))
end
| uu____3744 -> begin
()
end);
(match (((FStar_List.contains FStar_Syntax_Syntax.Abstract quals) && (not ((FStar_List.contains FStar_Syntax_Syntax.Private quals))))) with
| true -> begin
(FStar_All.pipe_right lbs (FStar_List.iter (fun lb -> (

let lid = (

let uu____3748 = (

let uu____3753 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in uu____3753.FStar_Syntax_Syntax.fv_name)
in uu____3748.FStar_Syntax_Syntax.v)
in (

let decl = FStar_Syntax_Syntax.Sig_declare_typ (((lid), (lb.FStar_Syntax_Syntax.lbunivs), (lb.FStar_Syntax_Syntax.lbtyp), ((FStar_Syntax_Syntax.Assumption)::quals), (r)))
in (FStar_Util.smap_add (sigmap env) lid.FStar_Ident.str ((decl), (false))))))))
end
| uu____3764 -> begin
()
end);
)
end
| uu____3765 -> begin
()
end))));
(

let curmod = (

let uu____3767 = (current_module env)
in uu____3767.FStar_Ident.str)
in ((

let uu____3769 = (

let uu____3774 = (get_exported_id_set env curmod)
in (

let uu____3776 = (get_trans_exported_id_set env curmod)
in ((uu____3774), (uu____3776))))
in (match (uu____3769) with
| (Some (cur_ex), Some (cur_trans_ex)) -> begin
(

let update_exports = (fun eikind -> (

let cur_ex_set = (

let uu____3789 = (cur_ex eikind)
in (FStar_ST.read uu____3789))
in (

let cur_trans_ex_set_ref = (cur_trans_ex eikind)
in (

let uu____3797 = (

let uu____3798 = (FStar_ST.read cur_trans_ex_set_ref)
in (FStar_Util.set_union cur_ex_set uu____3798))
in (FStar_ST.write cur_trans_ex_set_ref uu____3797)))))
in (FStar_List.iter update_exports all_exported_id_kinds))
end
| uu____3804 -> begin
()
end));
(match (()) with
| () -> begin
((filter_record_cache ());
(match (()) with
| () -> begin
(

let uu___179_3810 = env
in {curmodule = None; curmonad = uu___179_3810.curmonad; modules = (((modul.FStar_Syntax_Syntax.name), (modul)))::env.modules; scope_mods = []; exported_ids = uu___179_3810.exported_ids; trans_exported_ids = uu___179_3810.trans_exported_ids; includes = uu___179_3810.includes; sigaccum = []; sigmap = uu___179_3810.sigmap; iface = uu___179_3810.iface; admitted_iface = uu___179_3810.admitted_iface; expect_typ = uu___179_3810.expect_typ})
end);
)
end);
));
))

type env_stack_ops =
{push : env  ->  env; mark : env  ->  env; reset_mark : env  ->  env; commit_mark : env  ->  env; pop : env  ->  env}


let stack_ops : env_stack_ops = (

let stack = (FStar_Util.mk_ref [])
in (

let push = (fun env -> ((push_record_cache ());
(

let uu____3894 = (

let uu____3896 = (FStar_ST.read stack)
in (env)::uu____3896)
in (FStar_ST.write stack uu____3894));
(

let uu___180_3904 = env
in (

let uu____3905 = (FStar_Util.smap_copy (sigmap env))
in {curmodule = uu___180_3904.curmodule; curmonad = uu___180_3904.curmonad; modules = uu___180_3904.modules; scope_mods = uu___180_3904.scope_mods; exported_ids = uu___180_3904.exported_ids; trans_exported_ids = uu___180_3904.trans_exported_ids; includes = uu___180_3904.includes; sigaccum = uu___180_3904.sigaccum; sigmap = uu____3905; iface = uu___180_3904.iface; admitted_iface = uu___180_3904.admitted_iface; expect_typ = uu___180_3904.expect_typ}));
))
in (

let pop = (fun env -> (

let uu____3915 = (FStar_ST.read stack)
in (match (uu____3915) with
| (env)::tl -> begin
((pop_record_cache ());
(FStar_ST.write stack tl);
env;
)
end
| uu____3928 -> begin
(failwith "Impossible: Too many pops")
end)))
in (

let commit_mark = (fun env -> ((commit_record_cache ());
(

let uu____3935 = (FStar_ST.read stack)
in (match (uu____3935) with
| (uu____3940)::tl -> begin
((FStar_ST.write stack tl);
env;
)
end
| uu____3947 -> begin
(failwith "Impossible: Too many pops")
end));
))
in {push = push; mark = push; reset_mark = pop; commit_mark = commit_mark; pop = pop}))))


let push : env  ->  env = (fun env -> (stack_ops.push env))


let mark : env  ->  env = (fun env -> (stack_ops.mark env))


let reset_mark : env  ->  env = (fun env -> (stack_ops.reset_mark env))


let commit_mark : env  ->  env = (fun env -> (stack_ops.commit_mark env))


let pop : env  ->  env = (fun env -> (stack_ops.pop env))


let export_interface : FStar_Ident.lident  ->  env  ->  env = (fun m env -> (

let sigelt_in_m = (fun se -> (match ((FStar_Syntax_Util.lids_of_sigelt se)) with
| (l)::uu____3975 -> begin
(l.FStar_Ident.nsstr = m.FStar_Ident.str)
end
| uu____3977 -> begin
false
end))
in (

let sm = (sigmap env)
in (

let env = (pop env)
in (

let keys = (FStar_Util.smap_keys sm)
in (

let sm' = (sigmap env)
in ((FStar_All.pipe_right keys (FStar_List.iter (fun k -> (

let uu____3995 = (FStar_Util.smap_try_find sm' k)
in (match (uu____3995) with
| Some (se, true) when (sigelt_in_m se) -> begin
((FStar_Util.smap_remove sm' k);
(

let se = (match (se) with
| FStar_Syntax_Syntax.Sig_declare_typ (l, u, t, q, r) -> begin
FStar_Syntax_Syntax.Sig_declare_typ (((l), (u), (t), ((FStar_Syntax_Syntax.Assumption)::q), (r)))
end
| uu____4016 -> begin
se
end)
in (FStar_Util.smap_add sm' k ((se), (false))));
)
end
| uu____4019 -> begin
()
end)))));
env;
)))))))


let finish_module_or_interface : env  ->  FStar_Syntax_Syntax.modul  ->  env = (fun env modul -> ((match ((not (modul.FStar_Syntax_Syntax.is_interface))) with
| true -> begin
(check_admits env)
end
| uu____4030 -> begin
()
end);
(finish env modul);
))


let prepare_module_or_interface : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  (env * Prims.bool) = (fun intf admitted env mname -> (

let prep = (fun env -> (

let open_ns = (match ((FStar_Ident.lid_equals mname FStar_Syntax_Const.prims_lid)) with
| true -> begin
[]
end
| uu____4052 -> begin
(match ((FStar_Util.starts_with "FStar." (FStar_Ident.text_of_lid mname))) with
| true -> begin
(FStar_Syntax_Const.prims_lid)::(FStar_Syntax_Const.fstar_ns_lid)::[]
end
| uu____4054 -> begin
(FStar_Syntax_Const.prims_lid)::(FStar_Syntax_Const.st_lid)::(FStar_Syntax_Const.all_lid)::(FStar_Syntax_Const.fstar_ns_lid)::[]
end)
end)
in (

let open_ns = (match (((FStar_List.length mname.FStar_Ident.ns) <> (Prims.parse_int "0"))) with
| true -> begin
(

let ns = (FStar_Ident.lid_of_ids mname.FStar_Ident.ns)
in (ns)::open_ns)
end
| uu____4061 -> begin
open_ns
end)
in ((

let uu____4063 = (exported_id_set_new ())
in (FStar_Util.smap_add env.exported_ids mname.FStar_Ident.str uu____4063));
(match (()) with
| () -> begin
((

let uu____4068 = (exported_id_set_new ())
in (FStar_Util.smap_add env.trans_exported_ids mname.FStar_Ident.str uu____4068));
(match (()) with
| () -> begin
((

let uu____4073 = (FStar_Util.mk_ref [])
in (FStar_Util.smap_add env.includes mname.FStar_Ident.str uu____4073));
(match (()) with
| () -> begin
(

let uu___181_4082 = env
in (

let uu____4083 = (FStar_List.map (fun lid -> Open_module_or_namespace (((lid), (Open_namespace)))) open_ns)
in {curmodule = Some (mname); curmonad = uu___181_4082.curmonad; modules = uu___181_4082.modules; scope_mods = uu____4083; exported_ids = uu___181_4082.exported_ids; trans_exported_ids = uu___181_4082.trans_exported_ids; includes = uu___181_4082.includes; sigaccum = uu___181_4082.sigaccum; sigmap = env.sigmap; iface = intf; admitted_iface = admitted; expect_typ = uu___181_4082.expect_typ}))
end);
)
end);
)
end);
))))
in (

let uu____4086 = (FStar_All.pipe_right env.modules (FStar_Util.find_opt (fun uu____4098 -> (match (uu____4098) with
| (l, uu____4102) -> begin
(FStar_Ident.lid_equals l mname)
end))))
in (match (uu____4086) with
| None -> begin
(

let uu____4107 = (prep env)
in ((uu____4107), (false)))
end
| Some (uu____4108, m) -> begin
((match (((not (m.FStar_Syntax_Syntax.is_interface)) || intf)) with
| true -> begin
(

let uu____4113 = (

let uu____4114 = (

let uu____4117 = (FStar_Util.format1 "Duplicate module or interface name: %s" mname.FStar_Ident.str)
in ((uu____4117), ((FStar_Ident.range_of_lid mname))))
in FStar_Errors.Error (uu____4114))
in (Prims.raise uu____4113))
end
| uu____4118 -> begin
()
end);
(

let uu____4119 = (

let uu____4120 = (push env)
in (prep uu____4120))
in ((uu____4119), (true)));
)
end))))


let enter_monad_scope : env  ->  FStar_Ident.ident  ->  env = (fun env mname -> (match (env.curmonad) with
| Some (mname') -> begin
(Prims.raise (FStar_Errors.Error ((((Prims.strcat "Trying to define monad " (Prims.strcat mname.FStar_Ident.idText (Prims.strcat ", but already in monad scope " mname'.FStar_Ident.idText)))), (mname.FStar_Ident.idRange)))))
end
| None -> begin
(

let uu___182_4128 = env
in {curmodule = uu___182_4128.curmodule; curmonad = Some (mname); modules = uu___182_4128.modules; scope_mods = uu___182_4128.scope_mods; exported_ids = uu___182_4128.exported_ids; trans_exported_ids = uu___182_4128.trans_exported_ids; includes = uu___182_4128.includes; sigaccum = uu___182_4128.sigaccum; sigmap = uu___182_4128.sigmap; iface = uu___182_4128.iface; admitted_iface = uu___182_4128.admitted_iface; expect_typ = uu___182_4128.expect_typ})
end))


let fail_or = (fun env lookup lid -> (

let uu____4153 = (lookup lid)
in (match (uu____4153) with
| None -> begin
(

let opened_modules = (FStar_List.map (fun uu____4159 -> (match (uu____4159) with
| (lid, uu____4163) -> begin
(FStar_Ident.text_of_lid lid)
end)) env.modules)
in (

let msg = (FStar_Util.format1 "Identifier not found: [%s]" (FStar_Ident.text_of_lid lid))
in (

let msg = (match (((FStar_List.length lid.FStar_Ident.ns) = (Prims.parse_int "0"))) with
| true -> begin
msg
end
| uu____4168 -> begin
(

let modul = (

let uu____4170 = (FStar_Ident.lid_of_ids lid.FStar_Ident.ns)
in (FStar_Ident.set_lid_range uu____4170 (FStar_Ident.range_of_lid lid)))
in (

let uu____4171 = (resolve_module_name env modul true)
in (match (uu____4171) with
| None -> begin
(

let opened_modules = (FStar_String.concat ", " opened_modules)
in (FStar_Util.format3 "%s\nModule %s does not belong to the list of modules in scope, namely %s" msg modul.FStar_Ident.str opened_modules))
end
| Some (modul') when (not ((FStar_List.existsb (fun m -> (m = modul'.FStar_Ident.str)) opened_modules))) -> begin
(

let opened_modules = (FStar_String.concat ", " opened_modules)
in (FStar_Util.format4 "%s\nModule %s resolved into %s, which does not belong to the list of modules in scope, namely %s" msg modul.FStar_Ident.str modul'.FStar_Ident.str opened_modules))
end
| Some (modul') -> begin
(FStar_Util.format4 "%s\nModule %s resolved into %s, definition %s not found" msg modul.FStar_Ident.str modul'.FStar_Ident.str lid.FStar_Ident.ident.FStar_Ident.idText)
end)))
end)
in (Prims.raise (FStar_Errors.Error (((msg), ((FStar_Ident.range_of_lid lid)))))))))
end
| Some (r) -> begin
r
end)))


let fail_or2 = (fun lookup id -> (

let uu____4198 = (lookup id)
in (match (uu____4198) with
| None -> begin
(Prims.raise (FStar_Errors.Error ((((Prims.strcat "Identifier not found [" (Prims.strcat id.FStar_Ident.idText "]"))), (id.FStar_Ident.idRange)))))
end
| Some (r) -> begin
r
end)))




