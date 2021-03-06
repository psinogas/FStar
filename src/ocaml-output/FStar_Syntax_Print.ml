open Prims
let rec (delta_depth_to_string :
  FStar_Syntax_Syntax.delta_depth -> Prims.string) =
  fun uu___0_5 ->
    match uu___0_5 with
    | FStar_Syntax_Syntax.Delta_constant_at_level i ->
        let uu____9 = FStar_Util.string_of_int i in
        Prims.op_Hat "Delta_constant_at_level " uu____9
    | FStar_Syntax_Syntax.Delta_equational_at_level i ->
        let uu____14 = FStar_Util.string_of_int i in
        Prims.op_Hat "Delta_equational_at_level " uu____14
    | FStar_Syntax_Syntax.Delta_abstract d ->
        let uu____18 =
          let uu____20 = delta_depth_to_string d in Prims.op_Hat uu____20 ")" in
        Prims.op_Hat "Delta_abstract (" uu____18
let (sli : FStar_Ident.lident -> Prims.string) =
  fun l ->
    let uu____32 = FStar_Options.print_real_names () in
    if uu____32
    then FStar_Ident.string_of_lid l
    else
      (let uu____38 = FStar_Ident.ident_of_lid l in
       FStar_Ident.string_of_id uu____38)
let (lid_to_string : FStar_Ident.lid -> Prims.string) = fun l -> sli l
let (fv_to_string : FStar_Syntax_Syntax.fv -> Prims.string) =
  fun fv ->
    lid_to_string (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
let (bv_to_string : FStar_Syntax_Syntax.bv -> Prims.string) =
  fun bv ->
    let uu____60 = FStar_Ident.string_of_id bv.FStar_Syntax_Syntax.ppname in
    let uu____62 =
      let uu____64 = FStar_Util.string_of_int bv.FStar_Syntax_Syntax.index in
      Prims.op_Hat "#" uu____64 in
    Prims.op_Hat uu____60 uu____62
let (nm_to_string : FStar_Syntax_Syntax.bv -> Prims.string) =
  fun bv ->
    let uu____74 = FStar_Options.print_real_names () in
    if uu____74
    then bv_to_string bv
    else FStar_Ident.string_of_id bv.FStar_Syntax_Syntax.ppname
let (db_to_string : FStar_Syntax_Syntax.bv -> Prims.string) =
  fun bv ->
    let uu____87 = FStar_Ident.string_of_id bv.FStar_Syntax_Syntax.ppname in
    let uu____89 =
      let uu____91 = FStar_Util.string_of_int bv.FStar_Syntax_Syntax.index in
      Prims.op_Hat "@" uu____91 in
    Prims.op_Hat uu____87 uu____89
let (infix_prim_ops : (FStar_Ident.lident * Prims.string) Prims.list) =
  [(FStar_Parser_Const.op_Addition, "+");
  (FStar_Parser_Const.op_Subtraction, "-");
  (FStar_Parser_Const.op_Multiply, "*");
  (FStar_Parser_Const.op_Division, "/");
  (FStar_Parser_Const.op_Eq, "=");
  (FStar_Parser_Const.op_ColonEq, ":=");
  (FStar_Parser_Const.op_notEq, "<>");
  (FStar_Parser_Const.op_And, "&&");
  (FStar_Parser_Const.op_Or, "||");
  (FStar_Parser_Const.op_LTE, "<=");
  (FStar_Parser_Const.op_GTE, ">=");
  (FStar_Parser_Const.op_LT, "<");
  (FStar_Parser_Const.op_GT, ">");
  (FStar_Parser_Const.op_Modulus, "mod");
  (FStar_Parser_Const.and_lid, "/\\");
  (FStar_Parser_Const.or_lid, "\\/");
  (FStar_Parser_Const.imp_lid, "==>");
  (FStar_Parser_Const.iff_lid, "<==>");
  (FStar_Parser_Const.precedes_lid, "<<");
  (FStar_Parser_Const.eq2_lid, "==");
  (FStar_Parser_Const.eq3_lid, "===")]
let (unary_prim_ops : (FStar_Ident.lident * Prims.string) Prims.list) =
  [(FStar_Parser_Const.op_Negation, "not");
  (FStar_Parser_Const.op_Minus, "-");
  (FStar_Parser_Const.not_lid, "~")]
let (is_prim_op :
  FStar_Ident.lident Prims.list ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> Prims.bool)
  =
  fun ps ->
    fun f ->
      match f.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_fvar fv ->
          FStar_All.pipe_right ps
            (FStar_Util.for_some (FStar_Syntax_Syntax.fv_eq_lid fv))
      | uu____313 -> false
let (get_lid :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> FStar_Ident.lident)
  =
  fun f ->
    match f.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____326 -> failwith "get_lid"
let (is_infix_prim_op : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun e ->
    is_prim_op
      (FStar_Pervasives_Native.fst (FStar_List.split infix_prim_ops)) e
let (is_unary_prim_op : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun e ->
    is_prim_op
      (FStar_Pervasives_Native.fst (FStar_List.split unary_prim_ops)) e
let (quants : (FStar_Ident.lident * Prims.string) Prims.list) =
  [(FStar_Parser_Const.forall_lid, "forall");
  (FStar_Parser_Const.exists_lid, "exists")]
type exp = FStar_Syntax_Syntax.term
let (is_b2t : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t -> is_prim_op [FStar_Parser_Const.b2t_lid] t
let (is_quant : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t ->
    is_prim_op (FStar_Pervasives_Native.fst (FStar_List.split quants)) t
let (is_ite : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t -> is_prim_op [FStar_Parser_Const.ite_lid] t
let (is_lex_cons : exp -> Prims.bool) =
  fun f -> is_prim_op [FStar_Parser_Const.lexcons_lid] f
let (is_lex_top : exp -> Prims.bool) =
  fun f -> is_prim_op [FStar_Parser_Const.lextop_lid] f
let is_inr :
  'uuuuuu429 'uuuuuu430 .
    ('uuuuuu429, 'uuuuuu430) FStar_Util.either -> Prims.bool
  =
  fun uu___1_440 ->
    match uu___1_440 with
    | FStar_Util.Inl uu____445 -> false
    | FStar_Util.Inr uu____447 -> true
let filter_imp :
  'uuuuuu454 .
    ('uuuuuu454 * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) Prims.list ->
      ('uuuuuu454 * FStar_Syntax_Syntax.arg_qualifier
        FStar_Pervasives_Native.option) Prims.list
  =
  fun a ->
    FStar_All.pipe_right a
      (FStar_List.filter
         (fun uu___2_509 ->
            match uu___2_509 with
            | (uu____517, FStar_Pervasives_Native.Some
               (FStar_Syntax_Syntax.Meta
               (FStar_Syntax_Syntax.Arg_qualifier_meta_tac t))) when
                FStar_Syntax_Util.is_fvar FStar_Parser_Const.tcresolve_lid t
                -> true
            | (uu____524, FStar_Pervasives_Native.Some
               (FStar_Syntax_Syntax.Implicit uu____525)) -> false
            | (uu____530, FStar_Pervasives_Native.Some
               (FStar_Syntax_Syntax.Meta uu____531)) -> false
            | uu____535 -> true))
let rec (reconstruct_lex :
  exp -> exp Prims.list FStar_Pervasives_Native.option) =
  fun e ->
    let uu____553 =
      let uu____554 = FStar_Syntax_Subst.compress e in
      uu____554.FStar_Syntax_Syntax.n in
    match uu____553 with
    | FStar_Syntax_Syntax.Tm_app (f, args) ->
        let args1 = filter_imp args in
        let exps = FStar_List.map FStar_Pervasives_Native.fst args1 in
        let uu____615 =
          (is_lex_cons f) && ((FStar_List.length exps) = (Prims.of_int (2))) in
        if uu____615
        then
          let uu____624 =
            let uu____629 = FStar_List.nth exps Prims.int_one in
            reconstruct_lex uu____629 in
          (match uu____624 with
           | FStar_Pervasives_Native.Some xs ->
               let uu____640 =
                 let uu____643 = FStar_List.nth exps Prims.int_zero in
                 uu____643 :: xs in
               FStar_Pervasives_Native.Some uu____640
           | FStar_Pervasives_Native.None -> FStar_Pervasives_Native.None)
        else FStar_Pervasives_Native.None
    | uu____655 ->
        let uu____656 = is_lex_top e in
        if uu____656
        then FStar_Pervasives_Native.Some []
        else FStar_Pervasives_Native.None
let rec find : 'a . ('a -> Prims.bool) -> 'a Prims.list -> 'a =
  fun f ->
    fun l ->
      match l with
      | [] -> failwith "blah"
      | hd::tl -> let uu____704 = f hd in if uu____704 then hd else find f tl
let (find_lid :
  FStar_Ident.lident ->
    (FStar_Ident.lident * Prims.string) Prims.list -> Prims.string)
  =
  fun x ->
    fun xs ->
      let uu____736 =
        find
          (fun p -> FStar_Ident.lid_equals x (FStar_Pervasives_Native.fst p))
          xs in
      FStar_Pervasives_Native.snd uu____736
let (infix_prim_op_to_string :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> Prims.string) =
  fun e -> let uu____767 = get_lid e in find_lid uu____767 infix_prim_ops
let (unary_prim_op_to_string :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> Prims.string) =
  fun e -> let uu____779 = get_lid e in find_lid uu____779 unary_prim_ops
let (quant_to_string :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> Prims.string) =
  fun t -> let uu____791 = get_lid t in find_lid uu____791 quants
let (const_to_string : FStar_Const.sconst -> Prims.string) =
  fun x -> FStar_Parser_Const.const_to_string x
let (lbname_to_string : FStar_Syntax_Syntax.lbname -> Prims.string) =
  fun uu___3_805 ->
    match uu___3_805 with
    | FStar_Util.Inl l -> bv_to_string l
    | FStar_Util.Inr l ->
        lid_to_string (l.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
let (uvar_to_string : FStar_Syntax_Syntax.uvar -> Prims.string) =
  fun u ->
    let uu____816 = FStar_Options.hide_uvar_nums () in
    if uu____816
    then "?"
    else
      (let uu____823 =
         let uu____825 = FStar_Syntax_Unionfind.uvar_id u in
         FStar_All.pipe_right uu____825 FStar_Util.string_of_int in
       Prims.op_Hat "?" uu____823)
let (version_to_string : FStar_Syntax_Syntax.version -> Prims.string) =
  fun v ->
    let uu____837 = FStar_Util.string_of_int v.FStar_Syntax_Syntax.major in
    let uu____839 = FStar_Util.string_of_int v.FStar_Syntax_Syntax.minor in
    FStar_Util.format2 "%s.%s" uu____837 uu____839
let (univ_uvar_to_string :
  (FStar_Syntax_Syntax.universe FStar_Pervasives_Native.option
    FStar_Unionfind.p_uvar * FStar_Syntax_Syntax.version * FStar_Range.range)
    -> Prims.string)
  =
  fun u ->
    let uu____869 = FStar_Options.hide_uvar_nums () in
    if uu____869
    then "?"
    else
      (let uu____876 =
         let uu____878 =
           let uu____880 = FStar_Syntax_Unionfind.univ_uvar_id u in
           FStar_All.pipe_right uu____880 FStar_Util.string_of_int in
         let uu____884 =
           let uu____886 =
             FStar_All.pipe_right u
               (fun uu____903 ->
                  match uu____903 with
                  | (uu____915, u1, uu____917) -> version_to_string u1) in
           Prims.op_Hat ":" uu____886 in
         Prims.op_Hat uu____878 uu____884 in
       Prims.op_Hat "?" uu____876)
let rec (int_of_univ :
  Prims.int ->
    FStar_Syntax_Syntax.universe ->
      (Prims.int * FStar_Syntax_Syntax.universe
        FStar_Pervasives_Native.option))
  =
  fun n ->
    fun u ->
      let uu____948 = FStar_Syntax_Subst.compress_univ u in
      match uu____948 with
      | FStar_Syntax_Syntax.U_zero -> (n, FStar_Pervasives_Native.None)
      | FStar_Syntax_Syntax.U_succ u1 -> int_of_univ (n + Prims.int_one) u1
      | uu____961 -> (n, (FStar_Pervasives_Native.Some u))
let rec (univ_to_string : FStar_Syntax_Syntax.universe -> Prims.string) =
  fun u ->
    let uu____972 = FStar_Syntax_Subst.compress_univ u in
    match uu____972 with
    | FStar_Syntax_Syntax.U_unif u1 ->
        let uu____985 = univ_uvar_to_string u1 in
        Prims.op_Hat "U_unif " uu____985
    | FStar_Syntax_Syntax.U_name x ->
        let uu____989 = FStar_Ident.string_of_id x in
        Prims.op_Hat "U_name " uu____989
    | FStar_Syntax_Syntax.U_bvar x ->
        let uu____994 = FStar_Util.string_of_int x in
        Prims.op_Hat "@" uu____994
    | FStar_Syntax_Syntax.U_zero -> "0"
    | FStar_Syntax_Syntax.U_succ u1 ->
        let uu____999 = int_of_univ Prims.int_one u1 in
        (match uu____999 with
         | (n, FStar_Pervasives_Native.None) -> FStar_Util.string_of_int n
         | (n, FStar_Pervasives_Native.Some u2) ->
             let uu____1020 = univ_to_string u2 in
             let uu____1022 = FStar_Util.string_of_int n in
             FStar_Util.format2 "(%s + %s)" uu____1020 uu____1022)
    | FStar_Syntax_Syntax.U_max us ->
        let uu____1028 =
          let uu____1030 = FStar_List.map univ_to_string us in
          FStar_All.pipe_right uu____1030 (FStar_String.concat ", ") in
        FStar_Util.format1 "(max %s)" uu____1028
    | FStar_Syntax_Syntax.U_unknown -> "unknown"
let (univs_to_string : FStar_Syntax_Syntax.universes -> Prims.string) =
  fun us ->
    let uu____1049 = FStar_List.map univ_to_string us in
    FStar_All.pipe_right uu____1049 (FStar_String.concat ", ")
let (univ_names_to_string : FStar_Syntax_Syntax.univ_names -> Prims.string) =
  fun us ->
    let uu____1066 = FStar_List.map (fun x -> FStar_Ident.string_of_id x) us in
    FStar_All.pipe_right uu____1066 (FStar_String.concat ", ")
let (qual_to_string : FStar_Syntax_Syntax.qualifier -> Prims.string) =
  fun uu___4_1084 ->
    match uu___4_1084 with
    | FStar_Syntax_Syntax.Assumption -> "assume"
    | FStar_Syntax_Syntax.New -> "new"
    | FStar_Syntax_Syntax.Private -> "private"
    | FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen -> "unfold"
    | FStar_Syntax_Syntax.Inline_for_extraction -> "inline"
    | FStar_Syntax_Syntax.NoExtract -> "noextract"
    | FStar_Syntax_Syntax.Visible_default -> "visible"
    | FStar_Syntax_Syntax.Irreducible -> "irreducible"
    | FStar_Syntax_Syntax.Abstract -> "abstract"
    | FStar_Syntax_Syntax.Noeq -> "noeq"
    | FStar_Syntax_Syntax.Unopteq -> "unopteq"
    | FStar_Syntax_Syntax.Logic -> "logic"
    | FStar_Syntax_Syntax.TotalEffect -> "total"
    | FStar_Syntax_Syntax.Discriminator l ->
        let uu____1100 = lid_to_string l in
        FStar_Util.format1 "(Discriminator %s)" uu____1100
    | FStar_Syntax_Syntax.Projector (l, x) ->
        let uu____1105 = lid_to_string l in
        let uu____1107 = FStar_Ident.string_of_id x in
        FStar_Util.format2 "(Projector %s %s)" uu____1105 uu____1107
    | FStar_Syntax_Syntax.RecordType (ns, fns) ->
        let uu____1120 =
          let uu____1122 = FStar_Ident.path_of_ns ns in
          FStar_Ident.text_of_path uu____1122 in
        let uu____1123 =
          let uu____1125 =
            FStar_All.pipe_right fns
              (FStar_List.map FStar_Ident.string_of_id) in
          FStar_All.pipe_right uu____1125 (FStar_String.concat ", ") in
        FStar_Util.format2 "(RecordType %s %s)" uu____1120 uu____1123
    | FStar_Syntax_Syntax.RecordConstructor (ns, fns) ->
        let uu____1151 =
          let uu____1153 = FStar_Ident.path_of_ns ns in
          FStar_Ident.text_of_path uu____1153 in
        let uu____1154 =
          let uu____1156 =
            FStar_All.pipe_right fns
              (FStar_List.map FStar_Ident.string_of_id) in
          FStar_All.pipe_right uu____1156 (FStar_String.concat ", ") in
        FStar_Util.format2 "(RecordConstructor %s %s)" uu____1151 uu____1154
    | FStar_Syntax_Syntax.Action eff_lid ->
        let uu____1173 = lid_to_string eff_lid in
        FStar_Util.format1 "(Action %s)" uu____1173
    | FStar_Syntax_Syntax.ExceptionConstructor -> "ExceptionConstructor"
    | FStar_Syntax_Syntax.HasMaskedEffect -> "HasMaskedEffect"
    | FStar_Syntax_Syntax.Effect -> "Effect"
    | FStar_Syntax_Syntax.Reifiable -> "reify"
    | FStar_Syntax_Syntax.Reflectable l ->
        let uu____1181 = FStar_Ident.string_of_lid l in
        FStar_Util.format1 "(reflect %s)" uu____1181
    | FStar_Syntax_Syntax.OnlyName -> "OnlyName"
let (quals_to_string :
  FStar_Syntax_Syntax.qualifier Prims.list -> Prims.string) =
  fun quals ->
    match quals with
    | [] -> ""
    | uu____1198 ->
        let uu____1201 =
          FStar_All.pipe_right quals (FStar_List.map qual_to_string) in
        FStar_All.pipe_right uu____1201 (FStar_String.concat " ")
let (quals_to_string' :
  FStar_Syntax_Syntax.qualifier Prims.list -> Prims.string) =
  fun quals ->
    match quals with
    | [] -> ""
    | uu____1229 ->
        let uu____1232 = quals_to_string quals in Prims.op_Hat uu____1232 " "
let (paren : Prims.string -> Prims.string) =
  fun s -> Prims.op_Hat "(" (Prims.op_Hat s ")")
let rec (tag_of_term : FStar_Syntax_Syntax.term -> Prims.string) =
  fun t ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_bvar x ->
        let uu____1419 = db_to_string x in
        Prims.op_Hat "Tm_bvar: " uu____1419
    | FStar_Syntax_Syntax.Tm_name x ->
        let uu____1423 = nm_to_string x in
        Prims.op_Hat "Tm_name: " uu____1423
    | FStar_Syntax_Syntax.Tm_fvar x ->
        let uu____1427 =
          lid_to_string (x.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v in
        Prims.op_Hat "Tm_fvar: " uu____1427
    | FStar_Syntax_Syntax.Tm_uinst uu____1430 -> "Tm_uinst"
    | FStar_Syntax_Syntax.Tm_constant uu____1438 -> "Tm_constant"
    | FStar_Syntax_Syntax.Tm_type uu____1440 -> "Tm_type"
    | FStar_Syntax_Syntax.Tm_quoted
        (uu____1442,
         { FStar_Syntax_Syntax.qkind = FStar_Syntax_Syntax.Quote_static;
           FStar_Syntax_Syntax.antiquotes = uu____1443;_})
        -> "Tm_quoted (static)"
    | FStar_Syntax_Syntax.Tm_quoted
        (uu____1457,
         { FStar_Syntax_Syntax.qkind = FStar_Syntax_Syntax.Quote_dynamic;
           FStar_Syntax_Syntax.antiquotes = uu____1458;_})
        -> "Tm_quoted (dynamic)"
    | FStar_Syntax_Syntax.Tm_abs uu____1472 -> "Tm_abs"
    | FStar_Syntax_Syntax.Tm_arrow uu____1492 -> "Tm_arrow"
    | FStar_Syntax_Syntax.Tm_refine uu____1508 -> "Tm_refine"
    | FStar_Syntax_Syntax.Tm_app uu____1516 -> "Tm_app"
    | FStar_Syntax_Syntax.Tm_match uu____1534 -> "Tm_match"
    | FStar_Syntax_Syntax.Tm_ascribed uu____1558 -> "Tm_ascribed"
    | FStar_Syntax_Syntax.Tm_let uu____1586 -> "Tm_let"
    | FStar_Syntax_Syntax.Tm_uvar uu____1601 -> "Tm_uvar"
    | FStar_Syntax_Syntax.Tm_delayed uu____1615 -> "Tm_delayed"
    | FStar_Syntax_Syntax.Tm_meta (uu____1631, m) ->
        let uu____1637 = metadata_to_string m in
        Prims.op_Hat "Tm_meta:" uu____1637
    | FStar_Syntax_Syntax.Tm_unknown -> "Tm_unknown"
    | FStar_Syntax_Syntax.Tm_lazy uu____1641 -> "Tm_lazy"
and (term_to_string : FStar_Syntax_Syntax.term -> Prims.string) =
  fun x ->
    let uu____1644 =
      let uu____1646 = FStar_Options.ugly () in Prims.op_Negation uu____1646 in
    if uu____1644
    then
      let e = FStar_Syntax_Resugar.resugar_term x in
      let d = FStar_Parser_ToDocument.term_to_document e in
      FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0")
        (Prims.of_int (100)) d
    else
      (let x1 = FStar_Syntax_Subst.compress x in
       let x2 =
         let uu____1660 = FStar_Options.print_implicits () in
         if uu____1660 then x1 else FStar_Syntax_Util.unmeta x1 in
       match x2.FStar_Syntax_Syntax.n with
       | FStar_Syntax_Syntax.Tm_delayed uu____1668 -> failwith "impossible"
       | FStar_Syntax_Syntax.Tm_app (uu____1685, []) ->
           failwith "Empty args!"
       | FStar_Syntax_Syntax.Tm_lazy
           { FStar_Syntax_Syntax.blob = b;
             FStar_Syntax_Syntax.lkind = FStar_Syntax_Syntax.Lazy_embedding
               (uu____1711, thunk);
             FStar_Syntax_Syntax.ltyp = uu____1713;
             FStar_Syntax_Syntax.rng = uu____1714;_}
           ->
           let uu____1725 =
             let uu____1727 =
               let uu____1729 = FStar_Thunk.force thunk in
               term_to_string uu____1729 in
             Prims.op_Hat uu____1727 "]" in
           Prims.op_Hat "[LAZYEMB:" uu____1725
       | FStar_Syntax_Syntax.Tm_lazy i ->
           let uu____1735 =
             let uu____1737 =
               let uu____1739 =
                 let uu____1740 =
                   let uu____1749 =
                     FStar_ST.op_Bang FStar_Syntax_Syntax.lazy_chooser in
                   FStar_Util.must uu____1749 in
                 uu____1740 i.FStar_Syntax_Syntax.lkind i in
               term_to_string uu____1739 in
             Prims.op_Hat uu____1737 "]" in
           Prims.op_Hat "[lazy:" uu____1735
       | FStar_Syntax_Syntax.Tm_quoted (tm, qi) ->
           (match qi.FStar_Syntax_Syntax.qkind with
            | FStar_Syntax_Syntax.Quote_static ->
                let print_aq uu____1818 =
                  match uu____1818 with
                  | (bv, t) ->
                      let uu____1826 = bv_to_string bv in
                      let uu____1828 = term_to_string t in
                      FStar_Util.format2 "%s -> %s" uu____1826 uu____1828 in
                let uu____1831 = term_to_string tm in
                let uu____1833 =
                  FStar_Common.string_of_list print_aq
                    qi.FStar_Syntax_Syntax.antiquotes in
                FStar_Util.format2 "`(%s)%s" uu____1831 uu____1833
            | FStar_Syntax_Syntax.Quote_dynamic ->
                let uu____1842 = term_to_string tm in
                FStar_Util.format1 "quote (%s)" uu____1842)
       | FStar_Syntax_Syntax.Tm_meta
           (t, FStar_Syntax_Syntax.Meta_pattern (uu____1846, ps)) ->
           let pats =
             let uu____1886 =
               FStar_All.pipe_right ps
                 (FStar_List.map
                    (fun args ->
                       let uu____1923 =
                         FStar_All.pipe_right args
                           (FStar_List.map
                              (fun uu____1948 ->
                                 match uu____1948 with
                                 | (t1, uu____1957) -> term_to_string t1)) in
                       FStar_All.pipe_right uu____1923
                         (FStar_String.concat "; "))) in
             FStar_All.pipe_right uu____1886 (FStar_String.concat "\\/") in
           let uu____1972 = term_to_string t in
           FStar_Util.format2 "{:pattern %s} %s" pats uu____1972
       | FStar_Syntax_Syntax.Tm_meta
           (t, FStar_Syntax_Syntax.Meta_monadic (m, t')) ->
           let uu____1986 = tag_of_term t in
           let uu____1988 = sli m in
           let uu____1990 = term_to_string t' in
           let uu____1992 = term_to_string t in
           FStar_Util.format4 "(Monadic-%s{%s %s} %s)" uu____1986 uu____1988
             uu____1990 uu____1992
       | FStar_Syntax_Syntax.Tm_meta
           (t, FStar_Syntax_Syntax.Meta_monadic_lift (m0, m1, t')) ->
           let uu____2007 = tag_of_term t in
           let uu____2009 = term_to_string t' in
           let uu____2011 = sli m0 in
           let uu____2013 = sli m1 in
           let uu____2015 = term_to_string t in
           FStar_Util.format5 "(MonadicLift-%s{%s : %s -> %s} %s)" uu____2007
             uu____2009 uu____2011 uu____2013 uu____2015
       | FStar_Syntax_Syntax.Tm_meta
           (t, FStar_Syntax_Syntax.Meta_labeled (l, r, b)) ->
           let uu____2030 = FStar_Range.string_of_range r in
           let uu____2032 = term_to_string t in
           FStar_Util.format3 "Meta_labeled(%s, %s){%s}" l uu____2030
             uu____2032
       | FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_named l) ->
           let uu____2041 = lid_to_string l in
           let uu____2043 =
             FStar_Range.string_of_range t.FStar_Syntax_Syntax.pos in
           let uu____2045 = term_to_string t in
           FStar_Util.format3 "Meta_named(%s, %s){%s}" uu____2041 uu____2043
             uu____2045
       | FStar_Syntax_Syntax.Tm_meta
           (t, FStar_Syntax_Syntax.Meta_desugared uu____2049) ->
           let uu____2054 = term_to_string t in
           FStar_Util.format1 "Meta_desugared{%s}" uu____2054
       | FStar_Syntax_Syntax.Tm_bvar x3 ->
           let uu____2058 = db_to_string x3 in
           let uu____2060 =
             let uu____2062 =
               let uu____2064 = tag_of_term x3.FStar_Syntax_Syntax.sort in
               Prims.op_Hat uu____2064 ")" in
             Prims.op_Hat ":(" uu____2062 in
           Prims.op_Hat uu____2058 uu____2060
       | FStar_Syntax_Syntax.Tm_name x3 -> nm_to_string x3
       | FStar_Syntax_Syntax.Tm_fvar f -> fv_to_string f
       | FStar_Syntax_Syntax.Tm_uvar (u, ([], uu____2071)) ->
           let uu____2086 =
             (FStar_Options.print_bound_var_types ()) &&
               (FStar_Options.print_effect_args ()) in
           if uu____2086
           then ctx_uvar_to_string_aux true u
           else
             (let uu____2093 =
                let uu____2095 =
                  FStar_Syntax_Unionfind.uvar_id
                    u.FStar_Syntax_Syntax.ctx_uvar_head in
                FStar_All.pipe_left FStar_Util.string_of_int uu____2095 in
              Prims.op_Hat "?" uu____2093)
       | FStar_Syntax_Syntax.Tm_uvar (u, s) ->
           let uu____2118 =
             (FStar_Options.print_bound_var_types ()) &&
               (FStar_Options.print_effect_args ()) in
           if uu____2118
           then
             let uu____2122 = ctx_uvar_to_string_aux true u in
             let uu____2125 =
               let uu____2127 =
                 FStar_List.map subst_to_string
                   (FStar_Pervasives_Native.fst s) in
               FStar_All.pipe_right uu____2127 (FStar_String.concat "; ") in
             FStar_Util.format2 "(%s @ %s)" uu____2122 uu____2125
           else
             (let uu____2146 =
                let uu____2148 =
                  FStar_Syntax_Unionfind.uvar_id
                    u.FStar_Syntax_Syntax.ctx_uvar_head in
                FStar_All.pipe_left FStar_Util.string_of_int uu____2148 in
              Prims.op_Hat "?" uu____2146)
       | FStar_Syntax_Syntax.Tm_constant c -> const_to_string c
       | FStar_Syntax_Syntax.Tm_type u ->
           let uu____2155 = FStar_Options.print_universes () in
           if uu____2155
           then
             let uu____2159 = univ_to_string u in
             FStar_Util.format1 "Type u#(%s)" uu____2159
           else "Type"
       | FStar_Syntax_Syntax.Tm_arrow (bs, c) ->
           let uu____2187 = binders_to_string " -> " bs in
           let uu____2190 = comp_to_string c in
           FStar_Util.format2 "(%s -> %s)" uu____2187 uu____2190
       | FStar_Syntax_Syntax.Tm_abs (bs, t2, lc) ->
           (match lc with
            | FStar_Pervasives_Native.Some rc when
                FStar_Options.print_implicits () ->
                let uu____2222 = binders_to_string " " bs in
                let uu____2225 = term_to_string t2 in
                let uu____2227 =
                  FStar_Ident.string_of_lid
                    rc.FStar_Syntax_Syntax.residual_effect in
                let uu____2229 =
                  if FStar_Option.isNone rc.FStar_Syntax_Syntax.residual_typ
                  then "None"
                  else
                    (let uu____2238 =
                       FStar_Option.get rc.FStar_Syntax_Syntax.residual_typ in
                     term_to_string uu____2238) in
                FStar_Util.format4 "(fun %s -> (%s $$ (residual) %s %s))"
                  uu____2222 uu____2225 uu____2227 uu____2229
            | uu____2242 ->
                let uu____2245 = binders_to_string " " bs in
                let uu____2248 = term_to_string t2 in
                FStar_Util.format2 "(fun %s -> %s)" uu____2245 uu____2248)
       | FStar_Syntax_Syntax.Tm_refine (xt, f) ->
           let uu____2257 = bv_to_string xt in
           let uu____2259 =
             FStar_All.pipe_right xt.FStar_Syntax_Syntax.sort term_to_string in
           let uu____2262 = FStar_All.pipe_right f formula_to_string in
           FStar_Util.format3 "(%s:%s{%s})" uu____2257 uu____2259 uu____2262
       | FStar_Syntax_Syntax.Tm_app (t, args) ->
           let uu____2294 = term_to_string t in
           let uu____2296 = args_to_string args in
           FStar_Util.format2 "(%s %s)" uu____2294 uu____2296
       | FStar_Syntax_Syntax.Tm_let (lbs, e) ->
           let uu____2319 = lbs_to_string [] lbs in
           let uu____2321 = term_to_string e in
           FStar_Util.format2 "%s\nin\n%s" uu____2319 uu____2321
       | FStar_Syntax_Syntax.Tm_ascribed (e, (annot, topt), eff_name) ->
           let annot1 =
             match annot with
             | FStar_Util.Inl t ->
                 let uu____2386 =
                   let uu____2388 =
                     FStar_Util.map_opt eff_name FStar_Ident.string_of_lid in
                   FStar_All.pipe_right uu____2388
                     (FStar_Util.dflt "default") in
                 let uu____2399 = term_to_string t in
                 FStar_Util.format2 "[%s] %s" uu____2386 uu____2399
             | FStar_Util.Inr c -> comp_to_string c in
           let topt1 =
             match topt with
             | FStar_Pervasives_Native.None -> ""
             | FStar_Pervasives_Native.Some t ->
                 let uu____2420 = term_to_string t in
                 FStar_Util.format1 "by %s" uu____2420 in
           let uu____2423 = term_to_string e in
           FStar_Util.format3 "(%s <ascribed: %s %s)" uu____2423 annot1 topt1
       | FStar_Syntax_Syntax.Tm_match (head, branches) ->
           let uu____2464 = term_to_string head in
           let uu____2466 =
             let uu____2468 =
               FStar_All.pipe_right branches
                 (FStar_List.map branch_to_string) in
             FStar_Util.concat_l "\n\t|" uu____2468 in
           FStar_Util.format2 "(match %s with\n\t| %s)" uu____2464 uu____2466
       | FStar_Syntax_Syntax.Tm_uinst (t, us) ->
           let uu____2486 = FStar_Options.print_universes () in
           if uu____2486
           then
             let uu____2490 = term_to_string t in
             let uu____2492 = univs_to_string us in
             FStar_Util.format2 "%s<%s>" uu____2490 uu____2492
           else term_to_string t
       | FStar_Syntax_Syntax.Tm_unknown -> "_")
and (branch_to_string : FStar_Syntax_Syntax.branch -> Prims.string) =
  fun uu____2498 ->
    match uu____2498 with
    | (p, wopt, e) ->
        let uu____2520 = FStar_All.pipe_right p pat_to_string in
        let uu____2523 =
          match wopt with
          | FStar_Pervasives_Native.None -> ""
          | FStar_Pervasives_Native.Some w ->
              let uu____2534 = FStar_All.pipe_right w term_to_string in
              FStar_Util.format1 "when %s" uu____2534 in
        let uu____2538 = FStar_All.pipe_right e term_to_string in
        FStar_Util.format3 "%s %s -> %s" uu____2520 uu____2523 uu____2538
and (ctx_uvar_to_string_aux :
  Prims.bool -> FStar_Syntax_Syntax.ctx_uvar -> Prims.string) =
  fun print_reason ->
    fun ctx_uvar ->
      let reason_string =
        if print_reason
        then
          FStar_Util.format1 "(* %s *)\n"
            ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_reason
        else
          (let uu____2552 =
             let uu____2554 =
               FStar_Range.start_of_range
                 ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_range in
             FStar_Range.string_of_pos uu____2554 in
           let uu____2555 =
             let uu____2557 =
               FStar_Range.end_of_range
                 ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_range in
             FStar_Range.string_of_pos uu____2557 in
           FStar_Util.format2 "(%s-%s) " uu____2552 uu____2555) in
      let uu____2559 =
        binders_to_string ", " ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_binders in
      let uu____2562 =
        uvar_to_string ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_head in
      let uu____2564 =
        term_to_string ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_typ in
      FStar_Util.format4 "%s(%s |- %s : %s)" reason_string uu____2559
        uu____2562 uu____2564
and (subst_elt_to_string : FStar_Syntax_Syntax.subst_elt -> Prims.string) =
  fun uu___5_2567 ->
    match uu___5_2567 with
    | FStar_Syntax_Syntax.DB (i, x) ->
        let uu____2573 = FStar_Util.string_of_int i in
        let uu____2575 = bv_to_string x in
        FStar_Util.format2 "DB (%s, %s)" uu____2573 uu____2575
    | FStar_Syntax_Syntax.NM (x, i) ->
        let uu____2582 = bv_to_string x in
        let uu____2584 = FStar_Util.string_of_int i in
        FStar_Util.format2 "NM (%s, %s)" uu____2582 uu____2584
    | FStar_Syntax_Syntax.NT (x, t) ->
        let uu____2593 = bv_to_string x in
        let uu____2595 = term_to_string t in
        FStar_Util.format2 "NT (%s, %s)" uu____2593 uu____2595
    | FStar_Syntax_Syntax.UN (i, u) ->
        let uu____2602 = FStar_Util.string_of_int i in
        let uu____2604 = univ_to_string u in
        FStar_Util.format2 "UN (%s, %s)" uu____2602 uu____2604
    | FStar_Syntax_Syntax.UD (u, i) ->
        let uu____2611 = FStar_Ident.string_of_id u in
        let uu____2613 = FStar_Util.string_of_int i in
        FStar_Util.format2 "UD (%s, %s)" uu____2611 uu____2613
and (subst_to_string : FStar_Syntax_Syntax.subst_t -> Prims.string) =
  fun s ->
    let uu____2617 =
      FStar_All.pipe_right s (FStar_List.map subst_elt_to_string) in
    FStar_All.pipe_right uu____2617 (FStar_String.concat "; ")
and (pat_to_string : FStar_Syntax_Syntax.pat -> Prims.string) =
  fun x ->
    let uu____2633 =
      let uu____2635 = FStar_Options.ugly () in Prims.op_Negation uu____2635 in
    if uu____2633
    then
      let e =
        let uu____2640 = FStar_Syntax_Syntax.new_bv_set () in
        FStar_Syntax_Resugar.resugar_pat x uu____2640 in
      let d = FStar_Parser_ToDocument.pat_to_document e in
      FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0")
        (Prims.of_int (100)) d
    else
      (match x.FStar_Syntax_Syntax.v with
       | FStar_Syntax_Syntax.Pat_cons (l, pats) ->
           let uu____2669 = fv_to_string l in
           let uu____2671 =
             let uu____2673 =
               FStar_List.map
                 (fun uu____2687 ->
                    match uu____2687 with
                    | (x1, b) ->
                        let p = pat_to_string x1 in
                        if b then Prims.op_Hat "#" p else p) pats in
             FStar_All.pipe_right uu____2673 (FStar_String.concat " ") in
           FStar_Util.format2 "(%s %s)" uu____2669 uu____2671
       | FStar_Syntax_Syntax.Pat_dot_term (x1, uu____2712) ->
           let uu____2717 = FStar_Options.print_bound_var_types () in
           if uu____2717
           then
             let uu____2721 = bv_to_string x1 in
             let uu____2723 = term_to_string x1.FStar_Syntax_Syntax.sort in
             FStar_Util.format2 ".%s:%s" uu____2721 uu____2723
           else
             (let uu____2728 = bv_to_string x1 in
              FStar_Util.format1 ".%s" uu____2728)
       | FStar_Syntax_Syntax.Pat_var x1 ->
           let uu____2732 = FStar_Options.print_bound_var_types () in
           if uu____2732
           then
             let uu____2736 = bv_to_string x1 in
             let uu____2738 = term_to_string x1.FStar_Syntax_Syntax.sort in
             FStar_Util.format2 "%s:%s" uu____2736 uu____2738
           else bv_to_string x1
       | FStar_Syntax_Syntax.Pat_constant c -> const_to_string c
       | FStar_Syntax_Syntax.Pat_wild x1 ->
           let uu____2745 = FStar_Options.print_bound_var_types () in
           if uu____2745
           then
             let uu____2749 = bv_to_string x1 in
             let uu____2751 = term_to_string x1.FStar_Syntax_Syntax.sort in
             FStar_Util.format2 "_wild_%s:%s" uu____2749 uu____2751
           else bv_to_string x1)
and (lbs_to_string :
  FStar_Syntax_Syntax.qualifier Prims.list ->
    FStar_Syntax_Syntax.letbindings -> Prims.string)
  =
  fun quals ->
    fun lbs ->
      let uu____2760 = quals_to_string' quals in
      let uu____2762 =
        let uu____2764 =
          FStar_All.pipe_right (FStar_Pervasives_Native.snd lbs)
            (FStar_List.map
               (fun lb ->
                  let uu____2784 =
                    attrs_to_string lb.FStar_Syntax_Syntax.lbattrs in
                  let uu____2786 =
                    lbname_to_string lb.FStar_Syntax_Syntax.lbname in
                  let uu____2788 =
                    let uu____2790 = FStar_Options.print_universes () in
                    if uu____2790
                    then
                      let uu____2794 =
                        let uu____2796 =
                          univ_names_to_string lb.FStar_Syntax_Syntax.lbunivs in
                        Prims.op_Hat uu____2796 ">" in
                      Prims.op_Hat "<" uu____2794
                    else "" in
                  let uu____2803 =
                    term_to_string lb.FStar_Syntax_Syntax.lbtyp in
                  let uu____2805 =
                    FStar_All.pipe_right lb.FStar_Syntax_Syntax.lbdef
                      term_to_string in
                  FStar_Util.format5 "%s%s %s : %s = %s" uu____2784
                    uu____2786 uu____2788 uu____2803 uu____2805)) in
        FStar_Util.concat_l "\n and " uu____2764 in
      FStar_Util.format3 "%slet %s %s" uu____2760
        (if FStar_Pervasives_Native.fst lbs then "rec" else "") uu____2762
and (attrs_to_string :
  FStar_Syntax_Syntax.attribute Prims.list -> Prims.string) =
  fun uu___6_2820 ->
    match uu___6_2820 with
    | [] -> ""
    | tms ->
        let uu____2828 =
          let uu____2830 =
            FStar_List.map
              (fun t -> let uu____2838 = term_to_string t in paren uu____2838)
              tms in
          FStar_All.pipe_right uu____2830 (FStar_String.concat "; ") in
        FStar_Util.format1 "[@ %s]" uu____2828
and (aqual_to_string' :
  Prims.string ->
    FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option ->
      Prims.string)
  =
  fun s ->
    fun uu___7_2847 ->
      match uu___7_2847 with
      | FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Implicit (false))
          -> Prims.op_Hat "#" s
      | FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Implicit (true)) ->
          Prims.op_Hat "#." s
      | FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Equality) ->
          Prims.op_Hat "$" s
      | FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Meta
          (FStar_Syntax_Syntax.Arg_qualifier_meta_tac t)) when
          FStar_Syntax_Util.is_fvar FStar_Parser_Const.tcresolve_lid t ->
          Prims.op_Hat "[|" (Prims.op_Hat s "|]")
      | FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Meta
          (FStar_Syntax_Syntax.Arg_qualifier_meta_tac t)) ->
          let uu____2865 =
            let uu____2867 = term_to_string t in
            Prims.op_Hat uu____2867 (Prims.op_Hat "]" s) in
          Prims.op_Hat "#[" uu____2865
      | FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Meta
          (FStar_Syntax_Syntax.Arg_qualifier_meta_attr t)) ->
          let uu____2874 =
            let uu____2876 = term_to_string t in
            Prims.op_Hat uu____2876 (Prims.op_Hat "]" s) in
          Prims.op_Hat "#[@@" uu____2874
      | FStar_Pervasives_Native.None -> s
and (imp_to_string :
  Prims.string ->
    FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option ->
      Prims.string)
  = fun s -> fun aq -> aqual_to_string' s aq
and (binder_to_string' :
  Prims.bool ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) -> Prims.string)
  =
  fun is_arrow ->
    fun b ->
      let uu____2894 =
        let uu____2896 = FStar_Options.ugly () in
        Prims.op_Negation uu____2896 in
      if uu____2894
      then
        let uu____2900 =
          FStar_Syntax_Resugar.resugar_binder b FStar_Range.dummyRange in
        match uu____2900 with
        | FStar_Pervasives_Native.None -> ""
        | FStar_Pervasives_Native.Some e ->
            let d = FStar_Parser_ToDocument.binder_to_document e in
            FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0")
              (Prims.of_int (100)) d
      else
        (let uu____2911 = b in
         match uu____2911 with
         | (a, imp) ->
             let uu____2925 = FStar_Syntax_Syntax.is_null_binder b in
             if uu____2925
             then
               let uu____2929 = term_to_string a.FStar_Syntax_Syntax.sort in
               Prims.op_Hat "_:" uu____2929
             else
               (let uu____2934 =
                  (Prims.op_Negation is_arrow) &&
                    (let uu____2937 = FStar_Options.print_bound_var_types () in
                     Prims.op_Negation uu____2937) in
                if uu____2934
                then
                  let uu____2941 = nm_to_string a in
                  imp_to_string uu____2941 imp
                else
                  (let uu____2945 =
                     let uu____2947 = nm_to_string a in
                     let uu____2949 =
                       let uu____2951 =
                         term_to_string a.FStar_Syntax_Syntax.sort in
                       Prims.op_Hat ":" uu____2951 in
                     Prims.op_Hat uu____2947 uu____2949 in
                   imp_to_string uu____2945 imp)))
and (binder_to_string : FStar_Syntax_Syntax.binder -> Prims.string) =
  fun b -> binder_to_string' false b
and (arrow_binder_to_string :
  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
    FStar_Pervasives_Native.option) -> Prims.string)
  = fun b -> binder_to_string' true b
and (binders_to_string :
  Prims.string -> FStar_Syntax_Syntax.binders -> Prims.string) =
  fun sep ->
    fun bs ->
      let bs1 =
        let uu____2970 = FStar_Options.print_implicits () in
        if uu____2970 then bs else filter_imp bs in
      if sep = " -> "
      then
        let uu____2981 =
          FStar_All.pipe_right bs1 (FStar_List.map arrow_binder_to_string) in
        FStar_All.pipe_right uu____2981 (FStar_String.concat sep)
      else
        (let uu____3009 =
           FStar_All.pipe_right bs1 (FStar_List.map binder_to_string) in
         FStar_All.pipe_right uu____3009 (FStar_String.concat sep))
and (arg_to_string :
  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.arg_qualifier
    FStar_Pervasives_Native.option) -> Prims.string)
  =
  fun uu___8_3023 ->
    match uu___8_3023 with
    | (a, imp) ->
        let uu____3037 = term_to_string a in imp_to_string uu____3037 imp
and (args_to_string : FStar_Syntax_Syntax.args -> Prims.string) =
  fun args ->
    let args1 =
      let uu____3049 = FStar_Options.print_implicits () in
      if uu____3049 then args else filter_imp args in
    let uu____3064 =
      FStar_All.pipe_right args1 (FStar_List.map arg_to_string) in
    FStar_All.pipe_right uu____3064 (FStar_String.concat " ")
and (comp_to_string : FStar_Syntax_Syntax.comp -> Prims.string) =
  fun c ->
    let uu____3092 =
      let uu____3094 = FStar_Options.ugly () in Prims.op_Negation uu____3094 in
    if uu____3092
    then
      let e = FStar_Syntax_Resugar.resugar_comp c in
      let d = FStar_Parser_ToDocument.term_to_document e in
      FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0")
        (Prims.of_int (100)) d
    else
      (match c.FStar_Syntax_Syntax.n with
       | FStar_Syntax_Syntax.Total (t, uopt) ->
           let uu____3115 =
             let uu____3116 = FStar_Syntax_Subst.compress t in
             uu____3116.FStar_Syntax_Syntax.n in
           (match uu____3115 with
            | FStar_Syntax_Syntax.Tm_type uu____3120 when
                let uu____3121 =
                  (FStar_Options.print_implicits ()) ||
                    (FStar_Options.print_universes ()) in
                Prims.op_Negation uu____3121 -> term_to_string t
            | uu____3123 ->
                (match uopt with
                 | FStar_Pervasives_Native.Some u when
                     FStar_Options.print_universes () ->
                     let uu____3126 = univ_to_string u in
                     let uu____3128 = term_to_string t in
                     FStar_Util.format2 "Tot<%s> %s" uu____3126 uu____3128
                 | uu____3131 ->
                     let uu____3134 = term_to_string t in
                     FStar_Util.format1 "Tot %s" uu____3134))
       | FStar_Syntax_Syntax.GTotal (t, uopt) ->
           let uu____3147 =
             let uu____3148 = FStar_Syntax_Subst.compress t in
             uu____3148.FStar_Syntax_Syntax.n in
           (match uu____3147 with
            | FStar_Syntax_Syntax.Tm_type uu____3152 when
                let uu____3153 =
                  (FStar_Options.print_implicits ()) ||
                    (FStar_Options.print_universes ()) in
                Prims.op_Negation uu____3153 -> term_to_string t
            | uu____3155 ->
                (match uopt with
                 | FStar_Pervasives_Native.Some u when
                     FStar_Options.print_universes () ->
                     let uu____3158 = univ_to_string u in
                     let uu____3160 = term_to_string t in
                     FStar_Util.format2 "GTot<%s> %s" uu____3158 uu____3160
                 | uu____3163 ->
                     let uu____3166 = term_to_string t in
                     FStar_Util.format1 "GTot %s" uu____3166))
       | FStar_Syntax_Syntax.Comp c1 ->
           let basic =
             let uu____3172 = FStar_Options.print_effect_args () in
             if uu____3172
             then
               let uu____3176 = sli c1.FStar_Syntax_Syntax.effect_name in
               let uu____3178 =
                 let uu____3180 =
                   FStar_All.pipe_right c1.FStar_Syntax_Syntax.comp_univs
                     (FStar_List.map univ_to_string) in
                 FStar_All.pipe_right uu____3180 (FStar_String.concat ", ") in
               let uu____3195 =
                 term_to_string c1.FStar_Syntax_Syntax.result_typ in
               let uu____3197 =
                 let uu____3199 =
                   FStar_All.pipe_right c1.FStar_Syntax_Syntax.effect_args
                     (FStar_List.map arg_to_string) in
                 FStar_All.pipe_right uu____3199 (FStar_String.concat ", ") in
               let uu____3226 = cflags_to_string c1.FStar_Syntax_Syntax.flags in
               FStar_Util.format5 "%s<%s> (%s) %s (attributes %s)" uu____3176
                 uu____3178 uu____3195 uu____3197 uu____3226
             else
               (let uu____3231 =
                  (FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags
                     (FStar_Util.for_some
                        (fun uu___9_3237 ->
                           match uu___9_3237 with
                           | FStar_Syntax_Syntax.TOTAL -> true
                           | uu____3240 -> false)))
                    &&
                    (let uu____3243 = FStar_Options.print_effect_args () in
                     Prims.op_Negation uu____3243) in
                if uu____3231
                then
                  let uu____3247 =
                    term_to_string c1.FStar_Syntax_Syntax.result_typ in
                  FStar_Util.format1 "Tot %s" uu____3247
                else
                  (let uu____3252 =
                     ((let uu____3256 = FStar_Options.print_effect_args () in
                       Prims.op_Negation uu____3256) &&
                        (let uu____3259 = FStar_Options.print_implicits () in
                         Prims.op_Negation uu____3259))
                       &&
                       (FStar_Ident.lid_equals
                          c1.FStar_Syntax_Syntax.effect_name
                          FStar_Parser_Const.effect_ML_lid) in
                   if uu____3252
                   then term_to_string c1.FStar_Syntax_Syntax.result_typ
                   else
                     (let uu____3265 =
                        (let uu____3269 = FStar_Options.print_effect_args () in
                         Prims.op_Negation uu____3269) &&
                          (FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags
                             (FStar_Util.for_some
                                (fun uu___10_3275 ->
                                   match uu___10_3275 with
                                   | FStar_Syntax_Syntax.MLEFFECT -> true
                                   | uu____3278 -> false))) in
                      if uu____3265
                      then
                        let uu____3282 =
                          term_to_string c1.FStar_Syntax_Syntax.result_typ in
                        FStar_Util.format1 "ALL %s" uu____3282
                      else
                        (let uu____3287 =
                           sli c1.FStar_Syntax_Syntax.effect_name in
                         let uu____3289 =
                           term_to_string c1.FStar_Syntax_Syntax.result_typ in
                         FStar_Util.format2 "%s (%s)" uu____3287 uu____3289)))) in
           let dec =
             let uu____3294 =
               FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags
                 (FStar_List.collect
                    (fun uu___11_3307 ->
                       match uu___11_3307 with
                       | FStar_Syntax_Syntax.DECREASES e ->
                           let uu____3314 =
                             let uu____3316 = term_to_string e in
                             FStar_Util.format1 " (decreases %s)" uu____3316 in
                           [uu____3314]
                       | uu____3321 -> [])) in
             FStar_All.pipe_right uu____3294 (FStar_String.concat " ") in
           FStar_Util.format2 "%s%s" basic dec)
and (cflag_to_string : FStar_Syntax_Syntax.cflag -> Prims.string) =
  fun c ->
    match c with
    | FStar_Syntax_Syntax.TOTAL -> "total"
    | FStar_Syntax_Syntax.MLEFFECT -> "ml"
    | FStar_Syntax_Syntax.RETURN -> "return"
    | FStar_Syntax_Syntax.PARTIAL_RETURN -> "partial_return"
    | FStar_Syntax_Syntax.SOMETRIVIAL -> "sometrivial"
    | FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION -> "trivial_postcondition"
    | FStar_Syntax_Syntax.SHOULD_NOT_INLINE -> "should_not_inline"
    | FStar_Syntax_Syntax.LEMMA -> "lemma"
    | FStar_Syntax_Syntax.CPS -> "cps"
    | FStar_Syntax_Syntax.DECREASES uu____3340 -> ""
and (cflags_to_string : FStar_Syntax_Syntax.cflag Prims.list -> Prims.string)
  = fun fs -> FStar_Common.string_of_list cflag_to_string fs
and (formula_to_string :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> Prims.string) =
  fun phi -> term_to_string phi
and (metadata_to_string : FStar_Syntax_Syntax.metadata -> Prims.string) =
  fun uu___12_3350 ->
    match uu___12_3350 with
    | FStar_Syntax_Syntax.Meta_pattern (uu____3352, ps) ->
        let pats =
          let uu____3388 =
            FStar_All.pipe_right ps
              (FStar_List.map
                 (fun args ->
                    let uu____3425 =
                      FStar_All.pipe_right args
                        (FStar_List.map
                           (fun uu____3450 ->
                              match uu____3450 with
                              | (t, uu____3459) -> term_to_string t)) in
                    FStar_All.pipe_right uu____3425
                      (FStar_String.concat "; "))) in
          FStar_All.pipe_right uu____3388 (FStar_String.concat "\\/") in
        FStar_Util.format1 "{Meta_pattern %s}" pats
    | FStar_Syntax_Syntax.Meta_named lid ->
        let uu____3476 = sli lid in
        FStar_Util.format1 "{Meta_named %s}" uu____3476
    | FStar_Syntax_Syntax.Meta_labeled (l, r, uu____3481) ->
        let uu____3486 = FStar_Range.string_of_range r in
        FStar_Util.format2 "{Meta_labeled (%s, %s)}" l uu____3486
    | FStar_Syntax_Syntax.Meta_desugared msi -> "{Meta_desugared}"
    | FStar_Syntax_Syntax.Meta_monadic (m, t) ->
        let uu____3497 = sli m in
        let uu____3499 = term_to_string t in
        FStar_Util.format2 "{Meta_monadic(%s @ %s)}" uu____3497 uu____3499
    | FStar_Syntax_Syntax.Meta_monadic_lift (m, m', t) ->
        let uu____3509 = sli m in
        let uu____3511 = sli m' in
        let uu____3513 = term_to_string t in
        FStar_Util.format3 "{Meta_monadic_lift(%s -> %s @ %s)}" uu____3509
          uu____3511 uu____3513
let (aqual_to_string : FStar_Syntax_Syntax.aqual -> Prims.string) =
  fun aq -> aqual_to_string' "" aq
let (comp_to_string' :
  FStar_Syntax_DsEnv.env -> FStar_Syntax_Syntax.comp -> Prims.string) =
  fun env ->
    fun c ->
      let uu____3536 = FStar_Options.ugly () in
      if uu____3536
      then comp_to_string c
      else
        (let e = FStar_Syntax_Resugar.resugar_comp' env c in
         let d = FStar_Parser_ToDocument.term_to_document e in
         FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0")
           (Prims.of_int (100)) d)
let (term_to_string' :
  FStar_Syntax_DsEnv.env -> FStar_Syntax_Syntax.term -> Prims.string) =
  fun env ->
    fun x ->
      let uu____3558 = FStar_Options.ugly () in
      if uu____3558
      then term_to_string x
      else
        (let e = FStar_Syntax_Resugar.resugar_term' env x in
         let d = FStar_Parser_ToDocument.term_to_document e in
         FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0")
           (Prims.of_int (100)) d)
let (binder_to_json :
  FStar_Syntax_DsEnv.env -> FStar_Syntax_Syntax.binder -> FStar_Util.json) =
  fun env ->
    fun b ->
      let uu____3579 = b in
      match uu____3579 with
      | (a, imp) ->
          let n =
            let uu____3587 = FStar_Syntax_Syntax.is_null_binder b in
            if uu____3587
            then FStar_Util.JsonNull
            else
              (let uu____3592 =
                 let uu____3594 = nm_to_string a in
                 imp_to_string uu____3594 imp in
               FStar_Util.JsonStr uu____3592) in
          let t =
            let uu____3597 = term_to_string' env a.FStar_Syntax_Syntax.sort in
            FStar_Util.JsonStr uu____3597 in
          FStar_Util.JsonAssoc [("name", n); ("type", t)]
let (binders_to_json :
  FStar_Syntax_DsEnv.env -> FStar_Syntax_Syntax.binders -> FStar_Util.json) =
  fun env ->
    fun bs ->
      let uu____3629 = FStar_List.map (binder_to_json env) bs in
      FStar_Util.JsonList uu____3629
let (enclose_universes : Prims.string -> Prims.string) =
  fun s ->
    let uu____3647 = FStar_Options.print_universes () in
    if uu____3647 then Prims.op_Hat "<" (Prims.op_Hat s ">") else ""
let (tscheme_to_string : FStar_Syntax_Syntax.tscheme -> Prims.string) =
  fun s ->
    let uu____3663 =
      let uu____3665 = FStar_Options.ugly () in Prims.op_Negation uu____3665 in
    if uu____3663
    then
      let d = FStar_Syntax_Resugar.resugar_tscheme s in
      let d1 = FStar_Parser_ToDocument.decl_to_document d in
      FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0")
        (Prims.of_int (100)) d1
    else
      (let uu____3675 = s in
       match uu____3675 with
       | (us, t) ->
           let uu____3687 =
             let uu____3689 = univ_names_to_string us in
             FStar_All.pipe_left enclose_universes uu____3689 in
           let uu____3693 = term_to_string t in
           FStar_Util.format2 "%s%s" uu____3687 uu____3693)
let (action_to_string : FStar_Syntax_Syntax.action -> Prims.string) =
  fun a ->
    let uu____3703 = sli a.FStar_Syntax_Syntax.action_name in
    let uu____3705 =
      binders_to_string " " a.FStar_Syntax_Syntax.action_params in
    let uu____3708 =
      let uu____3710 =
        univ_names_to_string a.FStar_Syntax_Syntax.action_univs in
      FStar_All.pipe_left enclose_universes uu____3710 in
    let uu____3714 = term_to_string a.FStar_Syntax_Syntax.action_typ in
    let uu____3716 = term_to_string a.FStar_Syntax_Syntax.action_defn in
    FStar_Util.format5 "%s%s %s : %s = %s" uu____3703 uu____3705 uu____3708
      uu____3714 uu____3716
let (wp_eff_combinators_to_string :
  FStar_Syntax_Syntax.wp_eff_combinators -> Prims.string) =
  fun combs ->
    let tscheme_opt_to_string uu___13_3734 =
      match uu___13_3734 with
      | FStar_Pervasives_Native.Some ts -> tscheme_to_string ts
      | FStar_Pervasives_Native.None -> "None" in
    let uu____3740 =
      let uu____3744 = tscheme_to_string combs.FStar_Syntax_Syntax.ret_wp in
      let uu____3746 =
        let uu____3750 = tscheme_to_string combs.FStar_Syntax_Syntax.bind_wp in
        let uu____3752 =
          let uu____3756 =
            tscheme_to_string combs.FStar_Syntax_Syntax.stronger in
          let uu____3758 =
            let uu____3762 =
              tscheme_to_string combs.FStar_Syntax_Syntax.if_then_else in
            let uu____3764 =
              let uu____3768 =
                tscheme_to_string combs.FStar_Syntax_Syntax.ite_wp in
              let uu____3770 =
                let uu____3774 =
                  tscheme_to_string combs.FStar_Syntax_Syntax.close_wp in
                let uu____3776 =
                  let uu____3780 =
                    tscheme_to_string combs.FStar_Syntax_Syntax.trivial in
                  let uu____3782 =
                    let uu____3786 =
                      tscheme_opt_to_string combs.FStar_Syntax_Syntax.repr in
                    let uu____3788 =
                      let uu____3792 =
                        tscheme_opt_to_string
                          combs.FStar_Syntax_Syntax.return_repr in
                      let uu____3794 =
                        let uu____3798 =
                          tscheme_opt_to_string
                            combs.FStar_Syntax_Syntax.bind_repr in
                        [uu____3798] in
                      uu____3792 :: uu____3794 in
                    uu____3786 :: uu____3788 in
                  uu____3780 :: uu____3782 in
                uu____3774 :: uu____3776 in
              uu____3768 :: uu____3770 in
            uu____3762 :: uu____3764 in
          uu____3756 :: uu____3758 in
        uu____3750 :: uu____3752 in
      uu____3744 :: uu____3746 in
    FStar_Util.format
      "{\nret_wp       = %s\n; bind_wp      = %s\n; stronger     = %s\n; if_then_else = %s\n; ite_wp       = %s\n; close_wp     = %s\n; trivial      = %s\n; repr         = %s\n; return_repr  = %s\n; bind_repr    = %s\n}\n"
      uu____3740
let (layered_eff_combinators_to_string :
  FStar_Syntax_Syntax.layered_eff_combinators -> Prims.string) =
  fun combs ->
    let to_str uu____3829 =
      match uu____3829 with
      | (ts_t, ts_ty) ->
          let uu____3837 = tscheme_to_string ts_t in
          let uu____3839 = tscheme_to_string ts_ty in
          FStar_Util.format2 "(%s) : (%s)" uu____3837 uu____3839 in
    let uu____3842 =
      let uu____3846 = to_str combs.FStar_Syntax_Syntax.l_repr in
      let uu____3848 =
        let uu____3852 = to_str combs.FStar_Syntax_Syntax.l_return in
        let uu____3854 =
          let uu____3858 = to_str combs.FStar_Syntax_Syntax.l_bind in
          let uu____3860 =
            let uu____3864 = to_str combs.FStar_Syntax_Syntax.l_subcomp in
            let uu____3866 =
              let uu____3870 =
                to_str combs.FStar_Syntax_Syntax.l_if_then_else in
              [uu____3870] in
            uu____3864 :: uu____3866 in
          uu____3858 :: uu____3860 in
        uu____3852 :: uu____3854 in
      uu____3846 :: uu____3848 in
    FStar_Util.format
      "{\n; l_repr = %s\n; l_return = %s\n; l_bind = %s\n; l_subcomp = %s\n; l_if_then_else = %s\n\n  }\n"
      uu____3842
let (eff_combinators_to_string :
  FStar_Syntax_Syntax.eff_combinators -> Prims.string) =
  fun uu___14_3885 ->
    match uu___14_3885 with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        wp_eff_combinators_to_string combs
    | FStar_Syntax_Syntax.DM4F_eff combs ->
        wp_eff_combinators_to_string combs
    | FStar_Syntax_Syntax.Layered_eff combs ->
        layered_eff_combinators_to_string combs
let (eff_decl_to_string' :
  Prims.bool ->
    FStar_Range.range ->
      FStar_Syntax_Syntax.qualifier Prims.list ->
        FStar_Syntax_Syntax.eff_decl -> Prims.string)
  =
  fun for_free ->
    fun r ->
      fun q ->
        fun ed ->
          let uu____3918 =
            let uu____3920 = FStar_Options.ugly () in
            Prims.op_Negation uu____3920 in
          if uu____3918
          then
            let d = FStar_Syntax_Resugar.resugar_eff_decl r q ed in
            let d1 = FStar_Parser_ToDocument.decl_to_document d in
            FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0")
              (Prims.of_int (100)) d1
          else
            (let actions_to_string actions =
               let uu____3941 =
                 FStar_All.pipe_right actions
                   (FStar_List.map action_to_string) in
               FStar_All.pipe_right uu____3941 (FStar_String.concat ",\n\t") in
             let eff_name =
               let uu____3958 = FStar_Syntax_Util.is_layered ed in
               if uu____3958 then "layered_effect" else "new_effect" in
             let uu____3966 =
               let uu____3970 =
                 let uu____3974 =
                   let uu____3978 =
                     lid_to_string ed.FStar_Syntax_Syntax.mname in
                   let uu____3980 =
                     let uu____3984 =
                       let uu____3986 =
                         univ_names_to_string ed.FStar_Syntax_Syntax.univs in
                       FStar_All.pipe_left enclose_universes uu____3986 in
                     let uu____3990 =
                       let uu____3994 =
                         binders_to_string " " ed.FStar_Syntax_Syntax.binders in
                       let uu____3997 =
                         let uu____4001 =
                           tscheme_to_string ed.FStar_Syntax_Syntax.signature in
                         let uu____4003 =
                           let uu____4007 =
                             eff_combinators_to_string
                               ed.FStar_Syntax_Syntax.combinators in
                           let uu____4009 =
                             let uu____4013 =
                               actions_to_string
                                 ed.FStar_Syntax_Syntax.actions in
                             [uu____4013] in
                           uu____4007 :: uu____4009 in
                         uu____4001 :: uu____4003 in
                       uu____3994 :: uu____3997 in
                     uu____3984 :: uu____3990 in
                   uu____3978 :: uu____3980 in
                 (if for_free then "_for_free " else "") :: uu____3974 in
               eff_name :: uu____3970 in
             FStar_Util.format
               "%s%s { %s%s %s : %s \n  %s\nand effect_actions\n\t%s\n}\n"
               uu____3966)
let (eff_decl_to_string :
  Prims.bool -> FStar_Syntax_Syntax.eff_decl -> Prims.string) =
  fun for_free ->
    fun ed -> eff_decl_to_string' for_free FStar_Range.dummyRange [] ed
let (sub_eff_to_string : FStar_Syntax_Syntax.sub_eff -> Prims.string) =
  fun se ->
    let tsopt_to_string ts_opt =
      if FStar_Util.is_some ts_opt
      then
        let uu____4065 = FStar_All.pipe_right ts_opt FStar_Util.must in
        FStar_All.pipe_right uu____4065 tscheme_to_string
      else "<None>" in
    let uu____4072 = lid_to_string se.FStar_Syntax_Syntax.source in
    let uu____4074 = lid_to_string se.FStar_Syntax_Syntax.target in
    let uu____4076 = tsopt_to_string se.FStar_Syntax_Syntax.lift in
    let uu____4078 = tsopt_to_string se.FStar_Syntax_Syntax.lift_wp in
    FStar_Util.format4 "sub_effect %s ~> %s : lift = %s ;; lift_wp = %s"
      uu____4072 uu____4074 uu____4076 uu____4078
let rec (sigelt_to_string : FStar_Syntax_Syntax.sigelt -> Prims.string) =
  fun x ->
    let basic =
      match x.FStar_Syntax_Syntax.sigel with
      | FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.LightOff) ->
          "#light \"off\""
      | FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.ResetOptions
          (FStar_Pervasives_Native.None)) -> "#reset-options"
      | FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.ResetOptions
          (FStar_Pervasives_Native.Some s)) ->
          FStar_Util.format1 "#reset-options \"%s\"" s
      | FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.SetOptions s) ->
          FStar_Util.format1 "#set-options \"%s\"" s
      | FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.PushOptions
          (FStar_Pervasives_Native.None)) -> "#push-options"
      | FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.PushOptions
          (FStar_Pervasives_Native.Some s)) ->
          FStar_Util.format1 "#push-options \"%s\"" s
      | FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.RestartSolver) ->
          "#restart-solver"
      | FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.PopOptions) ->
          "#pop-options"
      | FStar_Syntax_Syntax.Sig_inductive_typ
          (lid, univs, tps, k, uu____4113, uu____4114) ->
          let quals_str = quals_to_string' x.FStar_Syntax_Syntax.sigquals in
          let binders_str = binders_to_string " " tps in
          let term_str = term_to_string k in
          let uu____4130 = FStar_Options.print_universes () in
          if uu____4130
          then
            let uu____4134 = FStar_Ident.string_of_lid lid in
            let uu____4136 = univ_names_to_string univs in
            FStar_Util.format5 "%stype %s<%s> %s : %s" quals_str uu____4134
              uu____4136 binders_str term_str
          else
            (let uu____4141 = FStar_Ident.string_of_lid lid in
             FStar_Util.format4 "%stype %s %s : %s" quals_str uu____4141
               binders_str term_str)
      | FStar_Syntax_Syntax.Sig_datacon
          (lid, univs, t, uu____4147, uu____4148, uu____4149) ->
          let uu____4156 = FStar_Options.print_universes () in
          if uu____4156
          then
            let uu____4160 = univ_names_to_string univs in
            let uu____4162 = FStar_Ident.string_of_lid lid in
            let uu____4164 = term_to_string t in
            FStar_Util.format3 "datacon<%s> %s : %s" uu____4160 uu____4162
              uu____4164
          else
            (let uu____4169 = FStar_Ident.string_of_lid lid in
             let uu____4171 = term_to_string t in
             FStar_Util.format2 "datacon %s : %s" uu____4169 uu____4171)
      | FStar_Syntax_Syntax.Sig_declare_typ (lid, univs, t) ->
          let uu____4177 = quals_to_string' x.FStar_Syntax_Syntax.sigquals in
          let uu____4179 = FStar_Ident.string_of_lid lid in
          let uu____4181 =
            let uu____4183 = FStar_Options.print_universes () in
            if uu____4183
            then
              let uu____4187 = univ_names_to_string univs in
              FStar_Util.format1 "<%s>" uu____4187
            else "" in
          let uu____4193 = term_to_string t in
          FStar_Util.format4 "%sval %s %s : %s" uu____4177 uu____4179
            uu____4181 uu____4193
      | FStar_Syntax_Syntax.Sig_assume (lid, us, f) ->
          let uu____4199 = FStar_Options.print_universes () in
          if uu____4199
          then
            let uu____4203 = FStar_Ident.string_of_lid lid in
            let uu____4205 = univ_names_to_string us in
            let uu____4207 = term_to_string f in
            FStar_Util.format3 "val %s<%s> : %s" uu____4203 uu____4205
              uu____4207
          else
            (let uu____4212 = FStar_Ident.string_of_lid lid in
             let uu____4214 = term_to_string f in
             FStar_Util.format2 "val %s : %s" uu____4212 uu____4214)
      | FStar_Syntax_Syntax.Sig_let (lbs, uu____4218) ->
          lbs_to_string x.FStar_Syntax_Syntax.sigquals lbs
      | FStar_Syntax_Syntax.Sig_bundle (ses, uu____4224) ->
          let uu____4233 =
            let uu____4235 = FStar_List.map sigelt_to_string ses in
            FStar_All.pipe_right uu____4235 (FStar_String.concat "\n") in
          Prims.op_Hat "(* Sig_bundle *)" uu____4233
      | FStar_Syntax_Syntax.Sig_fail (errs, lax, ses) ->
          let uu____4261 = FStar_Util.string_of_bool lax in
          let uu____4263 =
            FStar_Common.string_of_list FStar_Util.string_of_int errs in
          let uu____4266 =
            let uu____4268 = FStar_List.map sigelt_to_string ses in
            FStar_All.pipe_right uu____4268 (FStar_String.concat "\n") in
          FStar_Util.format3 "(* Sig_fail %s %s *)\n%s\n(* / Sig_fail*)\n"
            uu____4261 uu____4263 uu____4266
      | FStar_Syntax_Syntax.Sig_new_effect ed ->
          let uu____4280 = FStar_Syntax_Util.is_dm4f ed in
          eff_decl_to_string' uu____4280 x.FStar_Syntax_Syntax.sigrng
            x.FStar_Syntax_Syntax.sigquals ed
      | FStar_Syntax_Syntax.Sig_sub_effect se -> sub_eff_to_string se
      | FStar_Syntax_Syntax.Sig_effect_abbrev (l, univs, tps, c, flags) ->
          let uu____4292 = FStar_Options.print_universes () in
          if uu____4292
          then
            let uu____4296 =
              let uu____4301 =
                FStar_Syntax_Syntax.mk
                  (FStar_Syntax_Syntax.Tm_arrow (tps, c))
                  FStar_Range.dummyRange in
              FStar_Syntax_Subst.open_univ_vars univs uu____4301 in
            (match uu____4296 with
             | (univs1, t) ->
                 let uu____4315 =
                   let uu____4320 =
                     let uu____4321 = FStar_Syntax_Subst.compress t in
                     uu____4321.FStar_Syntax_Syntax.n in
                   match uu____4320 with
                   | FStar_Syntax_Syntax.Tm_arrow (bs, c1) -> (bs, c1)
                   | uu____4350 -> failwith "impossible" in
                 (match uu____4315 with
                  | (tps1, c1) ->
                      let uu____4359 = sli l in
                      let uu____4361 = univ_names_to_string univs1 in
                      let uu____4363 = binders_to_string " " tps1 in
                      let uu____4366 = comp_to_string c1 in
                      FStar_Util.format4 "effect %s<%s> %s = %s" uu____4359
                        uu____4361 uu____4363 uu____4366))
          else
            (let uu____4371 = sli l in
             let uu____4373 = binders_to_string " " tps in
             let uu____4376 = comp_to_string c in
             FStar_Util.format3 "effect %s %s = %s" uu____4371 uu____4373
               uu____4376)
      | FStar_Syntax_Syntax.Sig_splice (lids, t) ->
          let uu____4385 =
            let uu____4387 = FStar_List.map FStar_Ident.string_of_lid lids in
            FStar_All.pipe_left (FStar_String.concat "; ") uu____4387 in
          let uu____4397 = term_to_string t in
          FStar_Util.format2 "splice[%s] (%s)" uu____4385 uu____4397
      | FStar_Syntax_Syntax.Sig_polymonadic_bind (m, n, p, t, ty) ->
          let uu____4405 = FStar_Ident.string_of_lid m in
          let uu____4407 = FStar_Ident.string_of_lid n in
          let uu____4409 = FStar_Ident.string_of_lid p in
          let uu____4411 = tscheme_to_string t in
          let uu____4413 = tscheme_to_string ty in
          FStar_Util.format5 "polymonadic_bind (%s, %s) |> %s = (%s, %s)"
            uu____4405 uu____4407 uu____4409 uu____4411 uu____4413
      | FStar_Syntax_Syntax.Sig_polymonadic_subcomp (m, n, t, ty) ->
          let uu____4420 = FStar_Ident.string_of_lid m in
          let uu____4422 = FStar_Ident.string_of_lid n in
          let uu____4424 = tscheme_to_string t in
          let uu____4426 = tscheme_to_string ty in
          FStar_Util.format4 "polymonadic_subcomp %s <: %s = (%s, %s)"
            uu____4420 uu____4422 uu____4424 uu____4426 in
    match x.FStar_Syntax_Syntax.sigattrs with
    | [] -> Prims.op_Hat "[@ ]" (Prims.op_Hat "\n" basic)
    | uu____4432 ->
        let uu____4435 = attrs_to_string x.FStar_Syntax_Syntax.sigattrs in
        Prims.op_Hat uu____4435 (Prims.op_Hat "\n" basic)
let (format_error : FStar_Range.range -> Prims.string -> Prims.string) =
  fun r ->
    fun msg ->
      let uu____4452 = FStar_Range.string_of_range r in
      FStar_Util.format2 "%s: %s\n" uu____4452 msg
let (sigelt_to_string_short : FStar_Syntax_Syntax.sigelt -> Prims.string) =
  fun x ->
    match x.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_let
        ((uu____4463,
          { FStar_Syntax_Syntax.lbname = lb;
            FStar_Syntax_Syntax.lbunivs = uu____4465;
            FStar_Syntax_Syntax.lbtyp = t;
            FStar_Syntax_Syntax.lbeff = uu____4467;
            FStar_Syntax_Syntax.lbdef = uu____4468;
            FStar_Syntax_Syntax.lbattrs = uu____4469;
            FStar_Syntax_Syntax.lbpos = uu____4470;_}::[]),
         uu____4471)
        ->
        let uu____4494 = lbname_to_string lb in
        let uu____4496 = term_to_string t in
        FStar_Util.format2 "let %s : %s" uu____4494 uu____4496
    | uu____4499 ->
        let uu____4500 =
          FStar_All.pipe_right (FStar_Syntax_Util.lids_of_sigelt x)
            (FStar_List.map (fun l -> FStar_Ident.string_of_lid l)) in
        FStar_All.pipe_right uu____4500 (FStar_String.concat ", ")
let (tag_of_sigelt : FStar_Syntax_Syntax.sigelt -> Prims.string) =
  fun se ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_inductive_typ uu____4526 -> "Sig_inductive_typ"
    | FStar_Syntax_Syntax.Sig_bundle uu____4544 -> "Sig_bundle"
    | FStar_Syntax_Syntax.Sig_datacon uu____4554 -> "Sig_datacon"
    | FStar_Syntax_Syntax.Sig_declare_typ uu____4571 -> "Sig_declare_typ"
    | FStar_Syntax_Syntax.Sig_let uu____4579 -> "Sig_let"
    | FStar_Syntax_Syntax.Sig_assume uu____4587 -> "Sig_assume"
    | FStar_Syntax_Syntax.Sig_new_effect uu____4595 -> "Sig_new_effect"
    | FStar_Syntax_Syntax.Sig_sub_effect uu____4597 -> "Sig_sub_effect"
    | FStar_Syntax_Syntax.Sig_effect_abbrev uu____4599 -> "Sig_effect_abbrev"
    | FStar_Syntax_Syntax.Sig_pragma uu____4613 -> "Sig_pragma"
    | FStar_Syntax_Syntax.Sig_splice uu____4615 -> "Sig_splice"
    | FStar_Syntax_Syntax.Sig_polymonadic_bind uu____4623 ->
        "Sig_polymonadic_bind"
    | FStar_Syntax_Syntax.Sig_polymonadic_subcomp uu____4635 ->
        "Sig_polymonadic_subcomp"
    | FStar_Syntax_Syntax.Sig_fail uu____4645 -> "Sig_fail"
let (modul_to_string : FStar_Syntax_Syntax.modul -> Prims.string) =
  fun m ->
    let uu____4666 = sli m.FStar_Syntax_Syntax.name in
    let uu____4668 =
      let uu____4670 =
        FStar_List.map sigelt_to_string m.FStar_Syntax_Syntax.declarations in
      FStar_All.pipe_right uu____4670 (FStar_String.concat "\n") in
    let uu____4680 =
      let uu____4682 =
        FStar_List.map sigelt_to_string m.FStar_Syntax_Syntax.exports in
      FStar_All.pipe_right uu____4682 (FStar_String.concat "\n") in
    FStar_Util.format3
      "module %s\nDeclarations: [\n%s\n]\nExports: [\n%s\n]\n" uu____4666
      uu____4668 uu____4680
let list_to_string :
  'a . ('a -> Prims.string) -> 'a Prims.list -> Prims.string =
  fun f ->
    fun elts ->
      match elts with
      | [] -> "[]"
      | x::xs ->
          let strb = FStar_Util.new_string_builder () in
          (FStar_Util.string_builder_append strb "[";
           (let uu____4732 = f x in
            FStar_Util.string_builder_append strb uu____4732);
           FStar_List.iter
             (fun x1 ->
                FStar_Util.string_builder_append strb "; ";
                (let uu____4741 = f x1 in
                 FStar_Util.string_builder_append strb uu____4741)) xs;
           FStar_Util.string_builder_append strb "]";
           FStar_Util.string_of_string_builder strb)
let set_to_string :
  'a . ('a -> Prims.string) -> 'a FStar_Util.set -> Prims.string =
  fun f ->
    fun s ->
      let elts = FStar_Util.set_elements s in
      match elts with
      | [] -> "{}"
      | x::xs ->
          let strb = FStar_Util.new_string_builder () in
          (FStar_Util.string_builder_append strb "{";
           (let uu____4788 = f x in
            FStar_Util.string_builder_append strb uu____4788);
           FStar_List.iter
             (fun x1 ->
                FStar_Util.string_builder_append strb ", ";
                (let uu____4797 = f x1 in
                 FStar_Util.string_builder_append strb uu____4797)) xs;
           FStar_Util.string_builder_append strb "}";
           FStar_Util.string_of_string_builder strb)
let (bvs_to_string :
  Prims.string -> FStar_Syntax_Syntax.bv Prims.list -> Prims.string) =
  fun sep ->
    fun bvs ->
      let uu____4819 = FStar_List.map FStar_Syntax_Syntax.mk_binder bvs in
      binders_to_string sep uu____4819
let (ctx_uvar_to_string : FStar_Syntax_Syntax.ctx_uvar -> Prims.string) =
  fun ctx_uvar -> ctx_uvar_to_string_aux true ctx_uvar
let (ctx_uvar_to_string_no_reason :
  FStar_Syntax_Syntax.ctx_uvar -> Prims.string) =
  fun ctx_uvar -> ctx_uvar_to_string_aux false ctx_uvar
let rec (emb_typ_to_string : FStar_Syntax_Syntax.emb_typ -> Prims.string) =
  fun uu___15_4848 ->
    match uu___15_4848 with
    | FStar_Syntax_Syntax.ET_abstract -> "abstract"
    | FStar_Syntax_Syntax.ET_app (h, []) -> h
    | FStar_Syntax_Syntax.ET_app (h, args) ->
        let uu____4864 =
          let uu____4866 =
            let uu____4868 =
              let uu____4870 =
                let uu____4872 = FStar_List.map emb_typ_to_string args in
                FStar_All.pipe_right uu____4872 (FStar_String.concat " ") in
              Prims.op_Hat uu____4870 ")" in
            Prims.op_Hat " " uu____4868 in
          Prims.op_Hat h uu____4866 in
        Prims.op_Hat "(" uu____4864
    | FStar_Syntax_Syntax.ET_fun (a, b) ->
        let uu____4887 =
          let uu____4889 = emb_typ_to_string a in
          let uu____4891 =
            let uu____4893 = emb_typ_to_string b in
            Prims.op_Hat ") -> " uu____4893 in
          Prims.op_Hat uu____4889 uu____4891 in
        Prims.op_Hat "(" uu____4887