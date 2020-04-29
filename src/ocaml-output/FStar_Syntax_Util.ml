open Prims
let (tts_f :
  (FStar_Syntax_Syntax.term -> Prims.string) FStar_Pervasives_Native.option
    FStar_ST.ref)
  = FStar_Util.mk_ref FStar_Pervasives_Native.None 
let (tts : FStar_Syntax_Syntax.term -> Prims.string) =
  fun t  ->
    let uu____26 = FStar_ST.op_Bang tts_f  in
    match uu____26 with
    | FStar_Pervasives_Native.None  -> "<<hook unset>>"
    | FStar_Pervasives_Native.Some f -> f t
  
let (mk_discriminator : FStar_Ident.lident -> FStar_Ident.lident) =
  fun lid  ->
    let uu____85 =
      let uu____86 = FStar_Ident.ns_of_lid lid  in
      let uu____89 =
        let uu____92 =
          let uu____93 =
            let uu____99 =
              let uu____101 =
                let uu____103 =
                  let uu____105 = FStar_Ident.ident_of_lid lid  in
                  FStar_Ident.text_of_id uu____105  in
                Prims.op_Hat "is_" uu____103  in
              Prims.op_Hat FStar_Ident.reserved_prefix uu____101  in
            let uu____107 = FStar_Ident.range_of_lid lid  in
            (uu____99, uu____107)  in
          FStar_Ident.mk_ident uu____93  in
        [uu____92]  in
      FStar_List.append uu____86 uu____89  in
    FStar_Ident.lid_of_ids uu____85
  
let (is_name : FStar_Ident.lident -> Prims.bool) =
  fun lid  ->
    let c =
      let uu____118 =
        let uu____120 = FStar_Ident.ident_of_lid lid  in
        FStar_Ident.text_of_id uu____120  in
      FStar_Util.char_at uu____118 Prims.int_zero  in
    FStar_Util.is_upper c
  
let arg_of_non_null_binder :
  'uuuuuu127 .
    (FStar_Syntax_Syntax.bv * 'uuuuuu127) ->
      (FStar_Syntax_Syntax.term * 'uuuuuu127)
  =
  fun uu____140  ->
    match uu____140 with
    | (b,imp) ->
        let uu____147 = FStar_Syntax_Syntax.bv_to_name b  in (uu____147, imp)
  
let (args_of_non_null_binders :
  FStar_Syntax_Syntax.binders ->
    (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) Prims.list)
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.collect
         (fun b  ->
            let uu____199 = FStar_Syntax_Syntax.is_null_binder b  in
            if uu____199
            then []
            else (let uu____218 = arg_of_non_null_binder b  in [uu____218])))
  
let (args_of_binders :
  FStar_Syntax_Syntax.binders ->
    (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.args))
  =
  fun binders  ->
    let uu____253 =
      FStar_All.pipe_right binders
        (FStar_List.map
           (fun b  ->
              let uu____335 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____335
              then
                let b1 =
                  let uu____361 =
                    FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None
                      (FStar_Pervasives_Native.fst b).FStar_Syntax_Syntax.sort
                     in
                  (uu____361, (FStar_Pervasives_Native.snd b))  in
                let uu____368 = arg_of_non_null_binder b1  in (b1, uu____368)
              else
                (let uu____391 = arg_of_non_null_binder b  in (b, uu____391))))
       in
    FStar_All.pipe_right uu____253 FStar_List.unzip
  
let (name_binders :
  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
    FStar_Pervasives_Native.option) Prims.list ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) Prims.list)
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.mapi
         (fun i  ->
            fun b  ->
              let uu____525 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____525
              then
                let uu____534 = b  in
                match uu____534 with
                | (a,imp) ->
                    let b1 =
                      let uu____554 =
                        let uu____556 = FStar_Util.string_of_int i  in
                        Prims.op_Hat "_" uu____556  in
                      FStar_Ident.id_of_text uu____554  in
                    let b2 =
                      {
                        FStar_Syntax_Syntax.ppname = b1;
                        FStar_Syntax_Syntax.index = Prims.int_zero;
                        FStar_Syntax_Syntax.sort =
                          (a.FStar_Syntax_Syntax.sort)
                      }  in
                    (b2, imp)
              else b))
  
let (name_function_binders :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_arrow (binders,comp) ->
        let uu____601 =
          let uu____608 =
            let uu____609 =
              let uu____624 = name_binders binders  in (uu____624, comp)  in
            FStar_Syntax_Syntax.Tm_arrow uu____609  in
          FStar_Syntax_Syntax.mk uu____608  in
        uu____601 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
    | uu____643 -> t
  
let (null_binders_of_tks :
  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.aqual) Prims.list ->
    FStar_Syntax_Syntax.binders)
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____680  ->
            match uu____680 with
            | (t,imp) ->
                let uu____691 =
                  let uu____692 = FStar_Syntax_Syntax.null_binder t  in
                  FStar_All.pipe_left FStar_Pervasives_Native.fst uu____692
                   in
                (uu____691, imp)))
  
let (binders_of_tks :
  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.aqual) Prims.list ->
    FStar_Syntax_Syntax.binders)
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____747  ->
            match uu____747 with
            | (t,imp) ->
                let uu____764 =
                  FStar_Syntax_Syntax.new_bv
                    (FStar_Pervasives_Native.Some (t.FStar_Syntax_Syntax.pos))
                    t
                   in
                (uu____764, imp)))
  
let (binders_of_freevars :
  FStar_Syntax_Syntax.bv FStar_Util.set ->
    FStar_Syntax_Syntax.binder Prims.list)
  =
  fun fvs  ->
    let uu____777 = FStar_Util.set_elements fvs  in
    FStar_All.pipe_right uu____777
      (FStar_List.map FStar_Syntax_Syntax.mk_binder)
  
let mk_subst : 'uuuuuu789 . 'uuuuuu789 -> 'uuuuuu789 Prims.list =
  fun s  -> [s] 
let (subst_of_list :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.subst_t)
  =
  fun formals  ->
    fun actuals  ->
      if (FStar_List.length formals) = (FStar_List.length actuals)
      then
        FStar_List.fold_right2
          (fun f  ->
             fun a  ->
               fun out  ->
                 (FStar_Syntax_Syntax.NT
                    ((FStar_Pervasives_Native.fst f),
                      (FStar_Pervasives_Native.fst a)))
                 :: out) formals actuals []
      else failwith "Ill-formed substitution"
  
let (rename_binders :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.binders -> FStar_Syntax_Syntax.subst_t)
  =
  fun replace_xs  ->
    fun with_ys  ->
      if (FStar_List.length replace_xs) = (FStar_List.length with_ys)
      then
        FStar_List.map2
          (fun uu____915  ->
             fun uu____916  ->
               match (uu____915, uu____916) with
               | ((x,uu____942),(y,uu____944)) ->
                   let uu____965 =
                     let uu____972 = FStar_Syntax_Syntax.bv_to_name y  in
                     (x, uu____972)  in
                   FStar_Syntax_Syntax.NT uu____965) replace_xs with_ys
      else failwith "Ill-formed substitution"
  
let rec (unmeta : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e2,uu____988) -> unmeta e2
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____994,uu____995) -> unmeta e2
    | uu____1036 -> e1
  
let rec (unmeta_safe : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e',m) ->
        (match m with
         | FStar_Syntax_Syntax.Meta_monadic uu____1050 -> e1
         | FStar_Syntax_Syntax.Meta_monadic_lift uu____1057 -> e1
         | uu____1066 -> unmeta_safe e')
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____1068,uu____1069) ->
        unmeta_safe e2
    | uu____1110 -> e1
  
let (unmeta_lift : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____1117 =
      let uu____1118 = FStar_Syntax_Subst.compress t  in
      uu____1118.FStar_Syntax_Syntax.n  in
    match uu____1117 with
    | FStar_Syntax_Syntax.Tm_meta
        (t1,FStar_Syntax_Syntax.Meta_monadic_lift uu____1122) -> t1
    | uu____1135 -> t
  
let rec (univ_kernel :
  FStar_Syntax_Syntax.universe -> (FStar_Syntax_Syntax.universe * Prims.int))
  =
  fun u  ->
    match u with
    | FStar_Syntax_Syntax.U_unknown  -> (u, Prims.int_zero)
    | FStar_Syntax_Syntax.U_name uu____1154 -> (u, Prims.int_zero)
    | FStar_Syntax_Syntax.U_unif uu____1157 -> (u, Prims.int_zero)
    | FStar_Syntax_Syntax.U_max uu____1170 -> (u, Prims.int_zero)
    | FStar_Syntax_Syntax.U_zero  -> (u, Prims.int_zero)
    | FStar_Syntax_Syntax.U_succ u1 ->
        let uu____1178 = univ_kernel u1  in
        (match uu____1178 with | (k,n) -> (k, (n + Prims.int_one)))
    | FStar_Syntax_Syntax.U_bvar uu____1195 ->
        failwith "Imposible: univ_kernel (U_bvar _)"
  
let (constant_univ_as_nat : FStar_Syntax_Syntax.universe -> Prims.int) =
  fun u  ->
    let uu____1210 = univ_kernel u  in FStar_Pervasives_Native.snd uu____1210
  
let rec (compare_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.int)
  =
  fun u1  ->
    fun u2  ->
      let rec compare_kernel uk1 uk2 =
        match (uk1, uk2) with
        | (FStar_Syntax_Syntax.U_bvar uu____1243,uu____1244) ->
            failwith "Impossible: compare_kernel bvar"
        | (uu____1248,FStar_Syntax_Syntax.U_bvar uu____1249) ->
            failwith "Impossible: compare_kernel bvar"
        | (FStar_Syntax_Syntax.U_succ uu____1253,uu____1254) ->
            failwith "Impossible: compare_kernel succ"
        | (uu____1257,FStar_Syntax_Syntax.U_succ uu____1258) ->
            failwith "Impossible: compare_kernel succ"
        | (FStar_Syntax_Syntax.U_unknown ,FStar_Syntax_Syntax.U_unknown ) ->
            Prims.int_zero
        | (FStar_Syntax_Syntax.U_unknown ,uu____1262) -> ~- Prims.int_one
        | (uu____1264,FStar_Syntax_Syntax.U_unknown ) -> Prims.int_one
        | (FStar_Syntax_Syntax.U_zero ,FStar_Syntax_Syntax.U_zero ) ->
            Prims.int_zero
        | (FStar_Syntax_Syntax.U_zero ,uu____1267) -> ~- Prims.int_one
        | (uu____1269,FStar_Syntax_Syntax.U_zero ) -> Prims.int_one
        | (FStar_Syntax_Syntax.U_name u11,FStar_Syntax_Syntax.U_name u21) ->
            let uu____1273 = FStar_Ident.text_of_id u11  in
            let uu____1275 = FStar_Ident.text_of_id u21  in
            FStar_String.compare uu____1273 uu____1275
        | (FStar_Syntax_Syntax.U_name uu____1277,uu____1278) ->
            ~- Prims.int_one
        | (uu____1280,FStar_Syntax_Syntax.U_name uu____1281) -> Prims.int_one
        | (FStar_Syntax_Syntax.U_unif u11,FStar_Syntax_Syntax.U_unif u21) ->
            let uu____1305 = FStar_Syntax_Unionfind.univ_uvar_id u11  in
            let uu____1307 = FStar_Syntax_Unionfind.univ_uvar_id u21  in
            uu____1305 - uu____1307
        | (FStar_Syntax_Syntax.U_unif uu____1309,uu____1310) ->
            ~- Prims.int_one
        | (uu____1322,FStar_Syntax_Syntax.U_unif uu____1323) -> Prims.int_one
        | (FStar_Syntax_Syntax.U_max us1,FStar_Syntax_Syntax.U_max us2) ->
            let n1 = FStar_List.length us1  in
            let n2 = FStar_List.length us2  in
            if n1 <> n2
            then n1 - n2
            else
              (let copt =
                 let uu____1351 = FStar_List.zip us1 us2  in
                 FStar_Util.find_map uu____1351
                   (fun uu____1367  ->
                      match uu____1367 with
                      | (u11,u21) ->
                          let c = compare_univs u11 u21  in
                          if c <> Prims.int_zero
                          then FStar_Pervasives_Native.Some c
                          else FStar_Pervasives_Native.None)
                  in
               match copt with
               | FStar_Pervasives_Native.None  -> Prims.int_zero
               | FStar_Pervasives_Native.Some c -> c)
         in
      let uu____1395 = univ_kernel u1  in
      match uu____1395 with
      | (uk1,n1) ->
          let uu____1406 = univ_kernel u2  in
          (match uu____1406 with
           | (uk2,n2) ->
               let uu____1417 = compare_kernel uk1 uk2  in
               (match uu____1417 with
                | uu____1420 when uu____1420 = Prims.int_zero -> n1 - n2
                | n -> n))
  
let (eq_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.bool)
  =
  fun u1  ->
    fun u2  ->
      let uu____1435 = compare_univs u1 u2  in uu____1435 = Prims.int_zero
  
let (ml_comp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Range.range -> FStar_Syntax_Syntax.comp)
  =
  fun t  ->
    fun r  ->
      let uu____1454 =
        let uu____1455 =
          FStar_Ident.set_lid_range FStar_Parser_Const.effect_ML_lid r  in
        {
          FStar_Syntax_Syntax.comp_univs = [FStar_Syntax_Syntax.U_zero];
          FStar_Syntax_Syntax.effect_name = uu____1455;
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = [FStar_Syntax_Syntax.MLEFFECT]
        }  in
      FStar_Syntax_Syntax.mk_Comp uu____1454
  
let (comp_effect_name :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> FStar_Ident.lident)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1.FStar_Syntax_Syntax.effect_name
    | FStar_Syntax_Syntax.Total uu____1475 ->
        FStar_Parser_Const.effect_Tot_lid
    | FStar_Syntax_Syntax.GTotal uu____1484 ->
        FStar_Parser_Const.effect_GTot_lid
  
let (comp_flags :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.cflag Prims.list)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____1507 -> [FStar_Syntax_Syntax.TOTAL]
    | FStar_Syntax_Syntax.GTotal uu____1516 ->
        [FStar_Syntax_Syntax.SOMETRIVIAL]
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.flags
  
let (comp_to_comp_typ_nouniv :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1
    | FStar_Syntax_Syntax.Total (t,u_opt) ->
        let uu____1543 =
          let uu____1544 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
          FStar_Util.dflt [] uu____1544  in
        {
          FStar_Syntax_Syntax.comp_univs = uu____1543;
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | FStar_Syntax_Syntax.GTotal (t,u_opt) ->
        let uu____1573 =
          let uu____1574 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
          FStar_Util.dflt [] uu____1574  in
        {
          FStar_Syntax_Syntax.comp_univs = uu____1573;
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
  
let (comp_set_flags :
  FStar_Syntax_Syntax.comp ->
    FStar_Syntax_Syntax.cflag Prims.list ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax)
  =
  fun c  ->
    fun f  ->
      let uu___238_1610 = c  in
      let uu____1611 =
        let uu____1612 =
          let uu___240_1613 = comp_to_comp_typ_nouniv c  in
          {
            FStar_Syntax_Syntax.comp_univs =
              (uu___240_1613.FStar_Syntax_Syntax.comp_univs);
            FStar_Syntax_Syntax.effect_name =
              (uu___240_1613.FStar_Syntax_Syntax.effect_name);
            FStar_Syntax_Syntax.result_typ =
              (uu___240_1613.FStar_Syntax_Syntax.result_typ);
            FStar_Syntax_Syntax.effect_args =
              (uu___240_1613.FStar_Syntax_Syntax.effect_args);
            FStar_Syntax_Syntax.flags = f
          }  in
        FStar_Syntax_Syntax.Comp uu____1612  in
      {
        FStar_Syntax_Syntax.n = uu____1611;
        FStar_Syntax_Syntax.pos = (uu___238_1610.FStar_Syntax_Syntax.pos);
        FStar_Syntax_Syntax.vars = (uu___238_1610.FStar_Syntax_Syntax.vars)
      }
  
let (comp_to_comp_typ :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1
    | FStar_Syntax_Syntax.Total (t,FStar_Pervasives_Native.Some u) ->
        {
          FStar_Syntax_Syntax.comp_univs = [u];
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | FStar_Syntax_Syntax.GTotal (t,FStar_Pervasives_Native.Some u) ->
        {
          FStar_Syntax_Syntax.comp_univs = [u];
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | uu____1653 ->
        failwith "Assertion failed: Computation type without universe"
  
let (destruct_comp :
  FStar_Syntax_Syntax.comp_typ ->
    (FStar_Syntax_Syntax.universe * FStar_Syntax_Syntax.typ *
      FStar_Syntax_Syntax.typ))
  =
  fun c  ->
    let wp =
      match c.FStar_Syntax_Syntax.effect_args with
      | (wp,uu____1675)::[] -> wp
      | uu____1700 ->
          let uu____1711 =
            let uu____1713 =
              FStar_Ident.string_of_lid c.FStar_Syntax_Syntax.effect_name  in
            let uu____1715 =
              let uu____1717 =
                FStar_All.pipe_right c.FStar_Syntax_Syntax.effect_args
                  FStar_List.length
                 in
              FStar_All.pipe_right uu____1717 FStar_Util.string_of_int  in
            FStar_Util.format2
              "Impossible: Got a computation %s with %s effect args"
              uu____1713 uu____1715
             in
          failwith uu____1711
       in
    let uu____1741 = FStar_List.hd c.FStar_Syntax_Syntax.comp_univs  in
    (uu____1741, (c.FStar_Syntax_Syntax.result_typ), wp)
  
let (is_named_tot :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 ->
        FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name
          FStar_Parser_Const.effect_Tot_lid
    | FStar_Syntax_Syntax.Total uu____1755 -> true
    | FStar_Syntax_Syntax.GTotal uu____1765 -> false
  
let (is_total_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    (FStar_Ident.lid_equals (comp_effect_name c)
       FStar_Parser_Const.effect_Tot_lid)
      ||
      (FStar_All.pipe_right (comp_flags c)
         (FStar_Util.for_some
            (fun uu___0_1790  ->
               match uu___0_1790 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1794 -> false)))
  
let (is_partial_return :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right (comp_flags c)
      (FStar_Util.for_some
         (fun uu___1_1811  ->
            match uu___1_1811 with
            | FStar_Syntax_Syntax.RETURN  -> true
            | FStar_Syntax_Syntax.PARTIAL_RETURN  -> true
            | uu____1815 -> false))
  
let (is_tot_or_gtot_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    (is_total_comp c) ||
      (FStar_Ident.lid_equals FStar_Parser_Const.effect_GTot_lid
         (comp_effect_name c))
  
let (is_pure_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    ((FStar_Ident.lid_equals l FStar_Parser_Const.effect_Tot_lid) ||
       (FStar_Ident.lid_equals l FStar_Parser_Const.effect_PURE_lid))
      || (FStar_Ident.lid_equals l FStar_Parser_Const.effect_Pure_lid)
  
let (is_pure_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____1847 -> true
    | FStar_Syntax_Syntax.GTotal uu____1857 -> false
    | FStar_Syntax_Syntax.Comp ct ->
        ((is_total_comp c) ||
           (is_pure_effect ct.FStar_Syntax_Syntax.effect_name))
          ||
          (FStar_All.pipe_right ct.FStar_Syntax_Syntax.flags
             (FStar_Util.for_some
                (fun uu___2_1872  ->
                   match uu___2_1872 with
                   | FStar_Syntax_Syntax.LEMMA  -> true
                   | uu____1875 -> false)))
  
let (is_ghost_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    ((FStar_Ident.lid_equals FStar_Parser_Const.effect_GTot_lid l) ||
       (FStar_Ident.lid_equals FStar_Parser_Const.effect_GHOST_lid l))
      || (FStar_Ident.lid_equals FStar_Parser_Const.effect_Ghost_lid l)
  
let (is_div_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    ((FStar_Ident.lid_equals l FStar_Parser_Const.effect_DIV_lid) ||
       (FStar_Ident.lid_equals l FStar_Parser_Const.effect_Div_lid))
      || (FStar_Ident.lid_equals l FStar_Parser_Const.effect_Dv_lid)
  
let (is_pure_or_ghost_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  -> (is_pure_comp c) || (is_ghost_effect (comp_effect_name c)) 
let (is_pure_or_ghost_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  -> (is_pure_effect l) || (is_ghost_effect l) 
let (is_pure_or_ghost_function : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1916 =
      let uu____1917 = FStar_Syntax_Subst.compress t  in
      uu____1917.FStar_Syntax_Syntax.n  in
    match uu____1916 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1921,c) -> is_pure_or_ghost_comp c
    | uu____1943 -> true
  
let (is_lemma_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp ct ->
        FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
          FStar_Parser_Const.effect_Lemma_lid
    | uu____1958 -> false
  
let (is_lemma : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1967 =
      let uu____1968 = FStar_Syntax_Subst.compress t  in
      uu____1968.FStar_Syntax_Syntax.n  in
    match uu____1967 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1972,c) -> is_lemma_comp c
    | uu____1994 -> false
  
let rec (head_of : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____2002 =
      let uu____2003 = FStar_Syntax_Subst.compress t  in
      uu____2003.FStar_Syntax_Syntax.n  in
    match uu____2002 with
    | FStar_Syntax_Syntax.Tm_app (t1,uu____2007) -> head_of t1
    | FStar_Syntax_Syntax.Tm_match (t1,uu____2033) -> head_of t1
    | FStar_Syntax_Syntax.Tm_abs (uu____2070,t1,uu____2072) -> head_of t1
    | FStar_Syntax_Syntax.Tm_ascribed (t1,uu____2098,uu____2099) ->
        head_of t1
    | FStar_Syntax_Syntax.Tm_meta (t1,uu____2141) -> head_of t1
    | uu____2146 -> t
  
let (head_and_args :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax *
      (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax *
      FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option)
      Prims.list))
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head,args) -> (head, args)
    | uu____2224 -> (t1, [])
  
let rec (head_and_args' :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term * (FStar_Syntax_Syntax.term'
      FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) Prims.list))
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head,args) ->
        let uu____2306 = head_and_args' head  in
        (match uu____2306 with
         | (head1,args') -> (head1, (FStar_List.append args' args)))
    | uu____2375 -> (t1, [])
  
let (un_uinst : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____2402) ->
        FStar_Syntax_Subst.compress t2
    | uu____2407 -> t1
  
let (is_ml_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 ->
        (FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name
           FStar_Parser_Const.effect_ML_lid)
          ||
          (FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags
             (FStar_Util.for_some
                (fun uu___3_2425  ->
                   match uu___3_2425 with
                   | FStar_Syntax_Syntax.MLEFFECT  -> true
                   | uu____2428 -> false)))
    | uu____2430 -> false
  
let (comp_result :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total (t,uu____2447) -> t
    | FStar_Syntax_Syntax.GTotal (t,uu____2457) -> t
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.result_typ
  
let (set_result_typ :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.comp)
  =
  fun c  ->
    fun t  ->
      match c.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Total uu____2486 ->
          FStar_Syntax_Syntax.mk_Total t
      | FStar_Syntax_Syntax.GTotal uu____2495 ->
          FStar_Syntax_Syntax.mk_GTotal t
      | FStar_Syntax_Syntax.Comp ct ->
          FStar_Syntax_Syntax.mk_Comp
            (let uu___379_2507 = ct  in
             {
               FStar_Syntax_Syntax.comp_univs =
                 (uu___379_2507.FStar_Syntax_Syntax.comp_univs);
               FStar_Syntax_Syntax.effect_name =
                 (uu___379_2507.FStar_Syntax_Syntax.effect_name);
               FStar_Syntax_Syntax.result_typ = t;
               FStar_Syntax_Syntax.effect_args =
                 (uu___379_2507.FStar_Syntax_Syntax.effect_args);
               FStar_Syntax_Syntax.flags =
                 (uu___379_2507.FStar_Syntax_Syntax.flags)
             })
  
let (is_trivial_wp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right (comp_flags c)
      (FStar_Util.for_some
         (fun uu___4_2523  ->
            match uu___4_2523 with
            | FStar_Syntax_Syntax.TOTAL  -> true
            | FStar_Syntax_Syntax.RETURN  -> true
            | uu____2527 -> false))
  
let (comp_effect_args : FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.args)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____2535 -> []
    | FStar_Syntax_Syntax.GTotal uu____2552 -> []
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.effect_args
  
let (primops : FStar_Ident.lident Prims.list) =
  [FStar_Parser_Const.op_Eq;
  FStar_Parser_Const.op_notEq;
  FStar_Parser_Const.op_LT;
  FStar_Parser_Const.op_LTE;
  FStar_Parser_Const.op_GT;
  FStar_Parser_Const.op_GTE;
  FStar_Parser_Const.op_Subtraction;
  FStar_Parser_Const.op_Minus;
  FStar_Parser_Const.op_Addition;
  FStar_Parser_Const.op_Multiply;
  FStar_Parser_Const.op_Division;
  FStar_Parser_Const.op_Modulus;
  FStar_Parser_Const.op_And;
  FStar_Parser_Const.op_Or;
  FStar_Parser_Const.op_Negation] 
let (is_primop_lid : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    FStar_All.pipe_right primops
      (FStar_Util.for_some (FStar_Ident.lid_equals l))
  
let (is_primop :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun f  ->
    match f.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        is_primop_lid (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____2596 -> false
  
let rec (unascribe : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____2606,uu____2607) ->
        unascribe e2
    | uu____2648 -> e1
  
let rec (ascribe :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    ((FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.comp'
                                                             FStar_Syntax_Syntax.syntax)
      FStar_Util.either * FStar_Syntax_Syntax.term'
      FStar_Syntax_Syntax.syntax FStar_Pervasives_Native.option) ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    fun k  ->
      match t.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_ascribed (t',uu____2701,uu____2702) ->
          ascribe t' k
      | uu____2743 ->
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_ascribed
               (t, k, FStar_Pervasives_Native.None))
            FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
  
let (unfold_lazy : FStar_Syntax_Syntax.lazyinfo -> FStar_Syntax_Syntax.term)
  =
  fun i  ->
    let uu____2770 =
      let uu____2779 = FStar_ST.op_Bang FStar_Syntax_Syntax.lazy_chooser  in
      FStar_Util.must uu____2779  in
    uu____2770 i.FStar_Syntax_Syntax.lkind i
  
let rec (unlazy : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____2835 =
      let uu____2836 = FStar_Syntax_Subst.compress t  in
      uu____2836.FStar_Syntax_Syntax.n  in
    match uu____2835 with
    | FStar_Syntax_Syntax.Tm_lazy i ->
        let uu____2840 = unfold_lazy i  in
        FStar_All.pipe_left unlazy uu____2840
    | uu____2841 -> t
  
let (unlazy_emb : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____2848 =
      let uu____2849 = FStar_Syntax_Subst.compress t  in
      uu____2849.FStar_Syntax_Syntax.n  in
    match uu____2848 with
    | FStar_Syntax_Syntax.Tm_lazy i ->
        (match i.FStar_Syntax_Syntax.lkind with
         | FStar_Syntax_Syntax.Lazy_embedding uu____2853 ->
             let uu____2862 = unfold_lazy i  in
             FStar_All.pipe_left unlazy uu____2862
         | uu____2863 -> t)
    | uu____2864 -> t
  
let (eq_lazy_kind :
  FStar_Syntax_Syntax.lazy_kind ->
    FStar_Syntax_Syntax.lazy_kind -> Prims.bool)
  =
  fun k  ->
    fun k'  ->
      match (k, k') with
      | (FStar_Syntax_Syntax.BadLazy ,FStar_Syntax_Syntax.BadLazy ) -> true
      | (FStar_Syntax_Syntax.Lazy_bv ,FStar_Syntax_Syntax.Lazy_bv ) -> true
      | (FStar_Syntax_Syntax.Lazy_binder ,FStar_Syntax_Syntax.Lazy_binder )
          -> true
      | (FStar_Syntax_Syntax.Lazy_optionstate
         ,FStar_Syntax_Syntax.Lazy_optionstate ) -> true
      | (FStar_Syntax_Syntax.Lazy_fvar ,FStar_Syntax_Syntax.Lazy_fvar ) ->
          true
      | (FStar_Syntax_Syntax.Lazy_comp ,FStar_Syntax_Syntax.Lazy_comp ) ->
          true
      | (FStar_Syntax_Syntax.Lazy_env ,FStar_Syntax_Syntax.Lazy_env ) -> true
      | (FStar_Syntax_Syntax.Lazy_proofstate
         ,FStar_Syntax_Syntax.Lazy_proofstate ) -> true
      | (FStar_Syntax_Syntax.Lazy_goal ,FStar_Syntax_Syntax.Lazy_goal ) ->
          true
      | (FStar_Syntax_Syntax.Lazy_sigelt ,FStar_Syntax_Syntax.Lazy_sigelt )
          -> true
      | (FStar_Syntax_Syntax.Lazy_uvar ,FStar_Syntax_Syntax.Lazy_uvar ) ->
          true
      | uu____2889 -> false
  
let unlazy_as_t :
  'uuuuuu2902 .
    FStar_Syntax_Syntax.lazy_kind -> FStar_Syntax_Syntax.term -> 'uuuuuu2902
  =
  fun k  ->
    fun t  ->
      let uu____2913 =
        let uu____2914 = FStar_Syntax_Subst.compress t  in
        uu____2914.FStar_Syntax_Syntax.n  in
      match uu____2913 with
      | FStar_Syntax_Syntax.Tm_lazy
          { FStar_Syntax_Syntax.blob = v; FStar_Syntax_Syntax.lkind = k';
            FStar_Syntax_Syntax.ltyp = uu____2919;
            FStar_Syntax_Syntax.rng = uu____2920;_}
          when eq_lazy_kind k k' -> FStar_Dyn.undyn v
      | uu____2923 -> failwith "Not a Tm_lazy of the expected kind"
  
let mk_lazy :
  'a .
    'a ->
      FStar_Syntax_Syntax.typ ->
        FStar_Syntax_Syntax.lazy_kind ->
          FStar_Range.range FStar_Pervasives_Native.option ->
            FStar_Syntax_Syntax.term
  =
  fun t  ->
    fun typ  ->
      fun k  ->
        fun r  ->
          let rng =
            match r with
            | FStar_Pervasives_Native.Some r1 -> r1
            | FStar_Pervasives_Native.None  -> FStar_Range.dummyRange  in
          let i =
            let uu____2964 = FStar_Dyn.mkdyn t  in
            {
              FStar_Syntax_Syntax.blob = uu____2964;
              FStar_Syntax_Syntax.lkind = k;
              FStar_Syntax_Syntax.ltyp = typ;
              FStar_Syntax_Syntax.rng = rng
            }  in
          FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_lazy i)
            FStar_Pervasives_Native.None rng
  
let (canon_app :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let uu____2977 =
      let uu____2992 = unascribe t  in head_and_args' uu____2992  in
    match uu____2977 with
    | (hd,args) ->
        FStar_Syntax_Syntax.mk_Tm_app hd args FStar_Pervasives_Native.None
          t.FStar_Syntax_Syntax.pos
  
type eq_result =
  | Equal 
  | NotEqual 
  | Unknown 
let (uu___is_Equal : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | Equal  -> true | uu____3026 -> false
  
let (uu___is_NotEqual : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | NotEqual  -> true | uu____3037 -> false
  
let (uu___is_Unknown : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | Unknown  -> true | uu____3048 -> false
  
let (injectives : Prims.string Prims.list) =
  ["FStar.Int8.int_to_t";
  "FStar.Int16.int_to_t";
  "FStar.Int32.int_to_t";
  "FStar.Int64.int_to_t";
  "FStar.UInt8.uint_to_t";
  "FStar.UInt16.uint_to_t";
  "FStar.UInt32.uint_to_t";
  "FStar.UInt64.uint_to_t";
  "FStar.Int8.__int_to_t";
  "FStar.Int16.__int_to_t";
  "FStar.Int32.__int_to_t";
  "FStar.Int64.__int_to_t";
  "FStar.UInt8.__uint_to_t";
  "FStar.UInt16.__uint_to_t";
  "FStar.UInt32.__uint_to_t";
  "FStar.UInt64.__uint_to_t"] 
let (eq_inj : eq_result -> eq_result -> eq_result) =
  fun f  ->
    fun g  ->
      match (f, g) with
      | (Equal ,Equal ) -> Equal
      | (NotEqual ,uu____3098) -> NotEqual
      | (uu____3099,NotEqual ) -> NotEqual
      | (Unknown ,uu____3100) -> Unknown
      | (uu____3101,Unknown ) -> Unknown
  
let rec (eq_tm :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> eq_result) =
  fun t1  ->
    fun t2  ->
      let t11 = canon_app t1  in
      let t21 = canon_app t2  in
      let equal_if uu___5_3210 = if uu___5_3210 then Equal else Unknown  in
      let equal_iff uu___6_3221 = if uu___6_3221 then Equal else NotEqual  in
      let eq_and f g = match f with | Equal  -> g () | uu____3242 -> Unknown
         in
      let equal_data f1 args1 f2 args2 =
        let uu____3264 = FStar_Syntax_Syntax.fv_eq f1 f2  in
        if uu____3264
        then
          let uu____3268 = FStar_List.zip args1 args2  in
          FStar_All.pipe_left
            (FStar_List.fold_left
               (fun acc  ->
                  fun uu____3345  ->
                    match uu____3345 with
                    | ((a1,q1),(a2,q2)) ->
                        let uu____3386 = eq_tm a1 a2  in
                        eq_inj acc uu____3386) Equal) uu____3268
        else NotEqual  in
      let heads_and_args_in_case_both_data =
        let uu____3400 =
          let uu____3417 = FStar_All.pipe_right t11 unmeta  in
          FStar_All.pipe_right uu____3417 head_and_args  in
        match uu____3400 with
        | (head1,args1) ->
            let uu____3470 =
              let uu____3487 = FStar_All.pipe_right t21 unmeta  in
              FStar_All.pipe_right uu____3487 head_and_args  in
            (match uu____3470 with
             | (head2,args2) ->
                 let uu____3540 =
                   let uu____3545 =
                     let uu____3546 = un_uinst head1  in
                     uu____3546.FStar_Syntax_Syntax.n  in
                   let uu____3549 =
                     let uu____3550 = un_uinst head2  in
                     uu____3550.FStar_Syntax_Syntax.n  in
                   (uu____3545, uu____3549)  in
                 (match uu____3540 with
                  | (FStar_Syntax_Syntax.Tm_fvar
                     f,FStar_Syntax_Syntax.Tm_fvar g) when
                      (f.FStar_Syntax_Syntax.fv_qual =
                         (FStar_Pervasives_Native.Some
                            FStar_Syntax_Syntax.Data_ctor))
                        &&
                        (g.FStar_Syntax_Syntax.fv_qual =
                           (FStar_Pervasives_Native.Some
                              FStar_Syntax_Syntax.Data_ctor))
                      -> FStar_Pervasives_Native.Some (f, args1, g, args2)
                  | uu____3577 -> FStar_Pervasives_Native.None))
         in
      let t12 = unmeta t11  in
      let t22 = unmeta t21  in
      match ((t12.FStar_Syntax_Syntax.n), (t22.FStar_Syntax_Syntax.n)) with
      | (FStar_Syntax_Syntax.Tm_bvar bv1,FStar_Syntax_Syntax.Tm_bvar bv2) ->
          equal_if
            (bv1.FStar_Syntax_Syntax.index = bv2.FStar_Syntax_Syntax.index)
      | (FStar_Syntax_Syntax.Tm_lazy uu____3595,uu____3596) ->
          let uu____3597 = unlazy t12  in eq_tm uu____3597 t22
      | (uu____3598,FStar_Syntax_Syntax.Tm_lazy uu____3599) ->
          let uu____3600 = unlazy t22  in eq_tm t12 uu____3600
      | (FStar_Syntax_Syntax.Tm_name a,FStar_Syntax_Syntax.Tm_name b) ->
          let uu____3603 = FStar_Syntax_Syntax.bv_eq a b  in
          equal_if uu____3603
      | uu____3605 when
          FStar_All.pipe_right heads_and_args_in_case_both_data
            FStar_Util.is_some
          ->
          let uu____3629 =
            FStar_All.pipe_right heads_and_args_in_case_both_data
              FStar_Util.must
             in
          FStar_All.pipe_right uu____3629
            (fun uu____3677  ->
               match uu____3677 with
               | (f,args1,g,args2) -> equal_data f args1 g args2)
      | (FStar_Syntax_Syntax.Tm_fvar f,FStar_Syntax_Syntax.Tm_fvar g) ->
          let uu____3692 = FStar_Syntax_Syntax.fv_eq f g  in
          equal_if uu____3692
      | (FStar_Syntax_Syntax.Tm_uinst (f,us),FStar_Syntax_Syntax.Tm_uinst
         (g,vs)) ->
          let uu____3706 = eq_tm f g  in
          eq_and uu____3706
            (fun uu____3709  ->
               let uu____3710 = eq_univs_list us vs  in equal_if uu____3710)
      | (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range
         uu____3712),uu____3713) -> Unknown
      | (uu____3714,FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range
         uu____3715)) -> Unknown
      | (FStar_Syntax_Syntax.Tm_constant c,FStar_Syntax_Syntax.Tm_constant d)
          ->
          let uu____3718 = FStar_Const.eq_const c d  in equal_iff uu____3718
      | (FStar_Syntax_Syntax.Tm_uvar
         (u1,([],uu____3721)),FStar_Syntax_Syntax.Tm_uvar
         (u2,([],uu____3723))) ->
          let uu____3752 =
            FStar_Syntax_Unionfind.equiv u1.FStar_Syntax_Syntax.ctx_uvar_head
              u2.FStar_Syntax_Syntax.ctx_uvar_head
             in
          equal_if uu____3752
      | (FStar_Syntax_Syntax.Tm_app (h1,args1),FStar_Syntax_Syntax.Tm_app
         (h2,args2)) ->
          let uu____3806 =
            let uu____3811 =
              let uu____3812 = un_uinst h1  in
              uu____3812.FStar_Syntax_Syntax.n  in
            let uu____3815 =
              let uu____3816 = un_uinst h2  in
              uu____3816.FStar_Syntax_Syntax.n  in
            (uu____3811, uu____3815)  in
          (match uu____3806 with
           | (FStar_Syntax_Syntax.Tm_fvar f1,FStar_Syntax_Syntax.Tm_fvar f2)
               when
               (FStar_Syntax_Syntax.fv_eq f1 f2) &&
                 (let uu____3822 =
                    let uu____3824 = FStar_Syntax_Syntax.lid_of_fv f1  in
                    FStar_Ident.string_of_lid uu____3824  in
                  FStar_List.mem uu____3822 injectives)
               -> equal_data f1 args1 f2 args2
           | uu____3826 ->
               let uu____3831 = eq_tm h1 h2  in
               eq_and uu____3831 (fun uu____3833  -> eq_args args1 args2))
      | (FStar_Syntax_Syntax.Tm_match (t13,bs1),FStar_Syntax_Syntax.Tm_match
         (t23,bs2)) ->
          if (FStar_List.length bs1) = (FStar_List.length bs2)
          then
            let uu____3939 = FStar_List.zip bs1 bs2  in
            let uu____4002 = eq_tm t13 t23  in
            FStar_List.fold_right
              (fun uu____4039  ->
                 fun a  ->
                   match uu____4039 with
                   | (b1,b2) ->
                       eq_and a (fun uu____4132  -> branch_matches b1 b2))
              uu____3939 uu____4002
          else Unknown
      | (FStar_Syntax_Syntax.Tm_type u,FStar_Syntax_Syntax.Tm_type v) ->
          let uu____4137 = eq_univs u v  in equal_if uu____4137
      | (FStar_Syntax_Syntax.Tm_quoted (t13,q1),FStar_Syntax_Syntax.Tm_quoted
         (t23,q2)) ->
          let uu____4151 = eq_quoteinfo q1 q2  in
          eq_and uu____4151 (fun uu____4153  -> eq_tm t13 t23)
      | (FStar_Syntax_Syntax.Tm_refine
         (t13,phi1),FStar_Syntax_Syntax.Tm_refine (t23,phi2)) ->
          let uu____4166 =
            eq_tm t13.FStar_Syntax_Syntax.sort t23.FStar_Syntax_Syntax.sort
             in
          eq_and uu____4166 (fun uu____4168  -> eq_tm phi1 phi2)
      | uu____4169 -> Unknown

and (eq_quoteinfo :
  FStar_Syntax_Syntax.quoteinfo -> FStar_Syntax_Syntax.quoteinfo -> eq_result)
  =
  fun q1  ->
    fun q2  ->
      if q1.FStar_Syntax_Syntax.qkind <> q2.FStar_Syntax_Syntax.qkind
      then NotEqual
      else
        eq_antiquotes q1.FStar_Syntax_Syntax.antiquotes
          q2.FStar_Syntax_Syntax.antiquotes

and (eq_antiquotes :
  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term'
    FStar_Syntax_Syntax.syntax) Prims.list ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term'
      FStar_Syntax_Syntax.syntax) Prims.list -> eq_result)
  =
  fun a1  ->
    fun a2  ->
      match (a1, a2) with
      | ([],[]) -> Equal
      | ([],uu____4241) -> NotEqual
      | (uu____4272,[]) -> NotEqual
      | ((x1,t1)::a11,(x2,t2)::a21) ->
          let uu____4361 =
            let uu____4363 = FStar_Syntax_Syntax.bv_eq x1 x2  in
            Prims.op_Negation uu____4363  in
          if uu____4361
          then NotEqual
          else
            (let uu____4368 = eq_tm t1 t2  in
             match uu____4368 with
             | NotEqual  -> NotEqual
             | Unknown  ->
                 let uu____4369 = eq_antiquotes a11 a21  in
                 (match uu____4369 with
                  | NotEqual  -> NotEqual
                  | uu____4370 -> Unknown)
             | Equal  -> eq_antiquotes a11 a21)

and (branch_matches :
  (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t *
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
    FStar_Pervasives_Native.option * FStar_Syntax_Syntax.term'
    FStar_Syntax_Syntax.syntax) ->
    (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t *
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option * FStar_Syntax_Syntax.term'
      FStar_Syntax_Syntax.syntax) -> eq_result)
  =
  fun b1  ->
    fun b2  ->
      let related_by f o1 o2 =
        match (o1, o2) with
        | (FStar_Pervasives_Native.None ,FStar_Pervasives_Native.None ) ->
            true
        | (FStar_Pervasives_Native.Some x,FStar_Pervasives_Native.Some y) ->
            f x y
        | (uu____4454,uu____4455) -> false  in
      let uu____4465 = b1  in
      match uu____4465 with
      | (p1,w1,t1) ->
          let uu____4499 = b2  in
          (match uu____4499 with
           | (p2,w2,t2) ->
               let uu____4533 = FStar_Syntax_Syntax.eq_pat p1 p2  in
               if uu____4533
               then
                 let uu____4536 =
                   (let uu____4540 = eq_tm t1 t2  in uu____4540 = Equal) &&
                     (related_by
                        (fun t11  ->
                           fun t21  ->
                             let uu____4549 = eq_tm t11 t21  in
                             uu____4549 = Equal) w1 w2)
                    in
                 (if uu____4536 then Equal else Unknown)
               else Unknown)

and (eq_args :
  FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.args -> eq_result) =
  fun a1  ->
    fun a2  ->
      match (a1, a2) with
      | ([],[]) -> Equal
      | ((a,uu____4614)::a11,(b,uu____4617)::b1) ->
          let uu____4691 = eq_tm a b  in
          (match uu____4691 with
           | Equal  -> eq_args a11 b1
           | uu____4692 -> Unknown)
      | uu____4693 -> Unknown

and (eq_univs_list :
  FStar_Syntax_Syntax.universes ->
    FStar_Syntax_Syntax.universes -> Prims.bool)
  =
  fun us  ->
    fun vs  ->
      ((FStar_List.length us) = (FStar_List.length vs)) &&
        (FStar_List.forall2 eq_univs us vs)

let (eq_aqual :
  FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option ->
    FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option ->
      eq_result)
  =
  fun a1  ->
    fun a2  ->
      match (a1, a2) with
      | (FStar_Pervasives_Native.None ,FStar_Pervasives_Native.None ) ->
          Equal
      | (FStar_Pervasives_Native.None ,uu____4748) -> NotEqual
      | (uu____4755,FStar_Pervasives_Native.None ) -> NotEqual
      | (FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Implicit
         b1),FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Implicit b2))
          when b1 = b2 -> Equal
      | (FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Meta
         t1),FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Meta t2)) ->
          eq_tm t1 t2
      | (FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Equality
         ),FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Equality )) ->
          Equal
      | uu____4785 -> NotEqual
  
let rec (unrefine : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____4802) ->
        unrefine x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____4808,uu____4809) ->
        unrefine t2
    | uu____4850 -> t1
  
let rec (is_uvar : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____4858 =
      let uu____4859 = FStar_Syntax_Subst.compress t  in
      uu____4859.FStar_Syntax_Syntax.n  in
    match uu____4858 with
    | FStar_Syntax_Syntax.Tm_uvar uu____4863 -> true
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____4878) -> is_uvar t1
    | FStar_Syntax_Syntax.Tm_app uu____4883 ->
        let uu____4900 =
          let uu____4901 = FStar_All.pipe_right t head_and_args  in
          FStar_All.pipe_right uu____4901 FStar_Pervasives_Native.fst  in
        FStar_All.pipe_right uu____4900 is_uvar
    | FStar_Syntax_Syntax.Tm_ascribed (t1,uu____4964,uu____4965) ->
        is_uvar t1
    | uu____5006 -> false
  
let rec (is_unit : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____5015 =
      let uu____5016 = unrefine t  in uu____5016.FStar_Syntax_Syntax.n  in
    match uu____5015 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        ((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.unit_lid) ||
           (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid))
          ||
          (FStar_Syntax_Syntax.fv_eq_lid fv
             FStar_Parser_Const.auto_squash_lid)
    | FStar_Syntax_Syntax.Tm_app (head,uu____5022) -> is_unit head
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____5048) -> is_unit t1
    | uu____5053 -> false
  
let (is_eqtype_no_unrefine : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____5062 =
      let uu____5063 = FStar_Syntax_Subst.compress t  in
      uu____5063.FStar_Syntax_Syntax.n  in
    match uu____5062 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.eqtype_lid
    | uu____5068 -> false
  
let (is_fun : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun e  ->
    let uu____5077 =
      let uu____5078 = FStar_Syntax_Subst.compress e  in
      uu____5078.FStar_Syntax_Syntax.n  in
    match uu____5077 with
    | FStar_Syntax_Syntax.Tm_abs uu____5082 -> true
    | uu____5102 -> false
  
let (is_function_typ : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____5111 =
      let uu____5112 = FStar_Syntax_Subst.compress t  in
      uu____5112.FStar_Syntax_Syntax.n  in
    match uu____5111 with
    | FStar_Syntax_Syntax.Tm_arrow uu____5116 -> true
    | uu____5132 -> false
  
let rec (pre_typ : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____5142) ->
        pre_typ x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____5148,uu____5149) ->
        pre_typ t2
    | uu____5190 -> t1
  
let (destruct :
  FStar_Syntax_Syntax.term ->
    FStar_Ident.lident ->
      (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax *
        FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option)
        Prims.list FStar_Pervasives_Native.option)
  =
  fun typ  ->
    fun lid  ->
      let typ1 = FStar_Syntax_Subst.compress typ  in
      let uu____5215 =
        let uu____5216 = un_uinst typ1  in uu____5216.FStar_Syntax_Syntax.n
         in
      match uu____5215 with
      | FStar_Syntax_Syntax.Tm_app (head,args) ->
          let head1 = un_uinst head  in
          (match head1.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Tm_fvar tc when
               FStar_Syntax_Syntax.fv_eq_lid tc lid ->
               FStar_Pervasives_Native.Some args
           | uu____5281 -> FStar_Pervasives_Native.None)
      | FStar_Syntax_Syntax.Tm_fvar tc when
          FStar_Syntax_Syntax.fv_eq_lid tc lid ->
          FStar_Pervasives_Native.Some []
      | uu____5311 -> FStar_Pervasives_Native.None
  
let (lids_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Ident.lident Prims.list) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_let (uu____5332,lids) -> lids
    | FStar_Syntax_Syntax.Sig_splice (lids,uu____5339) -> lids
    | FStar_Syntax_Syntax.Sig_bundle (uu____5344,lids) -> lids
    | FStar_Syntax_Syntax.Sig_inductive_typ
        (lid,uu____5355,uu____5356,uu____5357,uu____5358,uu____5359) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_effect_abbrev
        (lid,uu____5369,uu____5370,uu____5371,uu____5372) -> [lid]
    | FStar_Syntax_Syntax.Sig_datacon
        (lid,uu____5378,uu____5379,uu____5380,uu____5381,uu____5382) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_declare_typ (lid,uu____5390,uu____5391) ->
        [lid]
    | FStar_Syntax_Syntax.Sig_assume (lid,uu____5393,uu____5394) -> [lid]
    | FStar_Syntax_Syntax.Sig_new_effect n -> [n.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_sub_effect uu____5396 -> []
    | FStar_Syntax_Syntax.Sig_pragma uu____5397 -> []
    | FStar_Syntax_Syntax.Sig_fail uu____5398 -> []
    | FStar_Syntax_Syntax.Sig_polymonadic_bind uu____5411 -> []
  
let (lid_of_sigelt :
  FStar_Syntax_Syntax.sigelt ->
    FStar_Ident.lident FStar_Pervasives_Native.option)
  =
  fun se  ->
    match lids_of_sigelt se with
    | l::[] -> FStar_Pervasives_Native.Some l
    | uu____5435 -> FStar_Pervasives_Native.None
  
let (quals_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.qualifier Prims.list) =
  fun x  -> x.FStar_Syntax_Syntax.sigquals 
let (range_of_sigelt : FStar_Syntax_Syntax.sigelt -> FStar_Range.range) =
  fun x  -> x.FStar_Syntax_Syntax.sigrng 
let (range_of_lbname :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
    FStar_Range.range)
  =
  fun uu___7_5461  ->
    match uu___7_5461 with
    | FStar_Util.Inl x -> FStar_Syntax_Syntax.range_of_bv x
    | FStar_Util.Inr fv ->
        FStar_Ident.range_of_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
  
let range_of_arg :
  'uuuuuu5475 'uuuuuu5476 .
    ('uuuuuu5475 FStar_Syntax_Syntax.syntax * 'uuuuuu5476) ->
      FStar_Range.range
  =
  fun uu____5487  ->
    match uu____5487 with | (hd,uu____5495) -> hd.FStar_Syntax_Syntax.pos
  
let range_of_args :
  'uuuuuu5509 'uuuuuu5510 .
    ('uuuuuu5509 FStar_Syntax_Syntax.syntax * 'uuuuuu5510) Prims.list ->
      FStar_Range.range -> FStar_Range.range
  =
  fun args  ->
    fun r  ->
      FStar_All.pipe_right args
        (FStar_List.fold_left
           (fun r1  -> fun a  -> FStar_Range.union_ranges r1 (range_of_arg a))
           r)
  
let (mk_app :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax *
      FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option)
      Prims.list -> FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun f  ->
    fun args  ->
      match args with
      | [] -> f
      | uu____5608 ->
          let r = range_of_args args f.FStar_Syntax_Syntax.pos  in
          FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (f, args))
            FStar_Pervasives_Native.None r
  
let (mk_app_binders :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun f  ->
    fun bs  ->
      let uu____5667 =
        FStar_List.map
          (fun uu____5694  ->
             match uu____5694 with
             | (bv,aq) ->
                 let uu____5713 = FStar_Syntax_Syntax.bv_to_name bv  in
                 (uu____5713, aq)) bs
         in
      mk_app f uu____5667
  
let (field_projector_prefix : Prims.string) = "__proj__" 
let (field_projector_sep : Prims.string) = "__item__" 
let (field_projector_contains_constructor : Prims.string -> Prims.bool) =
  fun s  -> FStar_Util.starts_with s field_projector_prefix 
let (mk_field_projector_name_from_string :
  Prims.string -> Prims.string -> Prims.string) =
  fun constr  ->
    fun field  ->
      Prims.op_Hat field_projector_prefix
        (Prims.op_Hat constr (Prims.op_Hat field_projector_sep field))
  
let (mk_field_projector_name_from_ident :
  FStar_Ident.lident -> FStar_Ident.ident -> FStar_Ident.lident) =
  fun lid  ->
    fun i  ->
      let itext = FStar_Ident.text_of_id i  in
      let newi =
        if field_projector_contains_constructor itext
        then i
        else
          (let uu____5764 =
             let uu____5770 =
               let uu____5772 =
                 let uu____5774 = FStar_Ident.ident_of_lid lid  in
                 FStar_Ident.text_of_id uu____5774  in
               mk_field_projector_name_from_string uu____5772 itext  in
             let uu____5775 = FStar_Ident.range_of_id i  in
             (uu____5770, uu____5775)  in
           FStar_Ident.mk_ident uu____5764)
         in
      let uu____5777 =
        let uu____5778 = FStar_Ident.ns_of_lid lid  in
        FStar_List.append uu____5778 [newi]  in
      FStar_Ident.lid_of_ids uu____5777
  
let (mk_field_projector_name :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.bv -> Prims.int -> FStar_Ident.lident)
  =
  fun lid  ->
    fun x  ->
      fun i  ->
        let nm =
          let uu____5800 = FStar_Syntax_Syntax.is_null_bv x  in
          if uu____5800
          then
            let uu____5803 =
              let uu____5809 =
                let uu____5811 = FStar_Util.string_of_int i  in
                Prims.op_Hat "_" uu____5811  in
              let uu____5814 = FStar_Syntax_Syntax.range_of_bv x  in
              (uu____5809, uu____5814)  in
            FStar_Ident.mk_ident uu____5803
          else x.FStar_Syntax_Syntax.ppname  in
        mk_field_projector_name_from_ident lid nm
  
let (ses_of_sigbundle :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.sigelt Prims.list) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_bundle (ses,uu____5829) -> ses
    | uu____5838 -> failwith "ses_of_sigbundle: not a Sig_bundle"
  
let (set_uvar : FStar_Syntax_Syntax.uvar -> FStar_Syntax_Syntax.term -> unit)
  =
  fun uv  ->
    fun t  ->
      let uu____5853 = FStar_Syntax_Unionfind.find uv  in
      match uu____5853 with
      | FStar_Pervasives_Native.Some uu____5856 ->
          let uu____5857 =
            let uu____5859 =
              let uu____5861 = FStar_Syntax_Unionfind.uvar_id uv  in
              FStar_All.pipe_left FStar_Util.string_of_int uu____5861  in
            FStar_Util.format1 "Changing a fixed uvar! ?%s\n" uu____5859  in
          failwith uu____5857
      | uu____5866 -> FStar_Syntax_Unionfind.change uv t
  
let (qualifier_equal :
  FStar_Syntax_Syntax.qualifier ->
    FStar_Syntax_Syntax.qualifier -> Prims.bool)
  =
  fun q1  ->
    fun q2  ->
      match (q1, q2) with
      | (FStar_Syntax_Syntax.Discriminator
         l1,FStar_Syntax_Syntax.Discriminator l2) ->
          FStar_Ident.lid_equals l1 l2
      | (FStar_Syntax_Syntax.Projector
         (l1a,l1b),FStar_Syntax_Syntax.Projector (l2a,l2b)) ->
          (FStar_Ident.lid_equals l1a l2a) &&
            (let uu____5890 = FStar_Ident.text_of_id l1b  in
             let uu____5892 = FStar_Ident.text_of_id l2b  in
             uu____5890 = uu____5892)
      | (FStar_Syntax_Syntax.RecordType
         (ns1,f1),FStar_Syntax_Syntax.RecordType (ns2,f2)) ->
          ((((FStar_List.length ns1) = (FStar_List.length ns2)) &&
              (FStar_List.forall2
                 (fun x1  ->
                    fun x2  ->
                      let uu____5921 = FStar_Ident.text_of_id x1  in
                      let uu____5923 = FStar_Ident.text_of_id x2  in
                      uu____5921 = uu____5923) f1 f2))
             && ((FStar_List.length f1) = (FStar_List.length f2)))
            &&
            (FStar_List.forall2
               (fun x1  ->
                  fun x2  ->
                    let uu____5932 = FStar_Ident.text_of_id x1  in
                    let uu____5934 = FStar_Ident.text_of_id x2  in
                    uu____5932 = uu____5934) f1 f2)
      | (FStar_Syntax_Syntax.RecordConstructor
         (ns1,f1),FStar_Syntax_Syntax.RecordConstructor (ns2,f2)) ->
          ((((FStar_List.length ns1) = (FStar_List.length ns2)) &&
              (FStar_List.forall2
                 (fun x1  ->
                    fun x2  ->
                      let uu____5963 = FStar_Ident.text_of_id x1  in
                      let uu____5965 = FStar_Ident.text_of_id x2  in
                      uu____5963 = uu____5965) f1 f2))
             && ((FStar_List.length f1) = (FStar_List.length f2)))
            &&
            (FStar_List.forall2
               (fun x1  ->
                  fun x2  ->
                    let uu____5974 = FStar_Ident.text_of_id x1  in
                    let uu____5976 = FStar_Ident.text_of_id x2  in
                    uu____5974 = uu____5976) f1 f2)
      | uu____5979 -> q1 = q2
  
let (abs :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.residual_comp FStar_Pervasives_Native.option ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun t  ->
      fun lopt  ->
        let close_lopt lopt1 =
          match lopt1 with
          | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
          | FStar_Pervasives_Native.Some rc ->
              let uu____6025 =
                let uu___1007_6026 = rc  in
                let uu____6027 =
                  FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                    (FStar_Syntax_Subst.close bs)
                   in
                {
                  FStar_Syntax_Syntax.residual_effect =
                    (uu___1007_6026.FStar_Syntax_Syntax.residual_effect);
                  FStar_Syntax_Syntax.residual_typ = uu____6027;
                  FStar_Syntax_Syntax.residual_flags =
                    (uu___1007_6026.FStar_Syntax_Syntax.residual_flags)
                }  in
              FStar_Pervasives_Native.Some uu____6025
           in
        match bs with
        | [] -> t
        | uu____6044 ->
            let body =
              let uu____6046 = FStar_Syntax_Subst.close bs t  in
              FStar_Syntax_Subst.compress uu____6046  in
            (match body.FStar_Syntax_Syntax.n with
             | FStar_Syntax_Syntax.Tm_abs (bs',t1,lopt') ->
                 let uu____6076 =
                   let uu____6083 =
                     let uu____6084 =
                       let uu____6103 =
                         let uu____6112 = FStar_Syntax_Subst.close_binders bs
                            in
                         FStar_List.append uu____6112 bs'  in
                       let uu____6127 = close_lopt lopt'  in
                       (uu____6103, t1, uu____6127)  in
                     FStar_Syntax_Syntax.Tm_abs uu____6084  in
                   FStar_Syntax_Syntax.mk uu____6083  in
                 uu____6076 FStar_Pervasives_Native.None
                   t1.FStar_Syntax_Syntax.pos
             | uu____6142 ->
                 let uu____6143 =
                   let uu____6150 =
                     let uu____6151 =
                       let uu____6170 = FStar_Syntax_Subst.close_binders bs
                          in
                       let uu____6179 = close_lopt lopt  in
                       (uu____6170, body, uu____6179)  in
                     FStar_Syntax_Syntax.Tm_abs uu____6151  in
                   FStar_Syntax_Syntax.mk uu____6150  in
                 uu____6143 FStar_Pervasives_Native.None
                   t.FStar_Syntax_Syntax.pos)
  
let (arrow :
  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
    FStar_Pervasives_Native.option) Prims.list ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun c  ->
      match bs with
      | [] -> comp_result c
      | uu____6235 ->
          let uu____6244 =
            let uu____6251 =
              let uu____6252 =
                let uu____6267 = FStar_Syntax_Subst.close_binders bs  in
                let uu____6276 = FStar_Syntax_Subst.close_comp bs c  in
                (uu____6267, uu____6276)  in
              FStar_Syntax_Syntax.Tm_arrow uu____6252  in
            FStar_Syntax_Syntax.mk uu____6251  in
          uu____6244 FStar_Pervasives_Native.None c.FStar_Syntax_Syntax.pos
  
let (flat_arrow :
  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
    FStar_Pervasives_Native.option) Prims.list ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun c  ->
      let t = arrow bs c  in
      let uu____6325 =
        let uu____6326 = FStar_Syntax_Subst.compress t  in
        uu____6326.FStar_Syntax_Syntax.n  in
      match uu____6325 with
      | FStar_Syntax_Syntax.Tm_arrow (bs1,c1) ->
          (match c1.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Total (tres,uu____6356) ->
               let uu____6365 =
                 let uu____6366 = FStar_Syntax_Subst.compress tres  in
                 uu____6366.FStar_Syntax_Syntax.n  in
               (match uu____6365 with
                | FStar_Syntax_Syntax.Tm_arrow (bs',c') ->
                    FStar_Syntax_Syntax.mk
                      (FStar_Syntax_Syntax.Tm_arrow
                         ((FStar_List.append bs1 bs'), c'))
                      FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
                | uu____6409 -> t)
           | uu____6410 -> t)
      | uu____6411 -> t
  
let rec (canon_arrow :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let uu____6424 =
      let uu____6425 = FStar_Syntax_Subst.compress t  in
      uu____6425.FStar_Syntax_Syntax.n  in
    match uu____6424 with
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let cn =
          match c.FStar_Syntax_Syntax.n with
          | FStar_Syntax_Syntax.Total (t1,u) ->
              let uu____6463 =
                let uu____6472 = canon_arrow t1  in (uu____6472, u)  in
              FStar_Syntax_Syntax.Total uu____6463
          | uu____6479 -> c.FStar_Syntax_Syntax.n  in
        let c1 =
          let uu___1051_6483 = c  in
          {
            FStar_Syntax_Syntax.n = cn;
            FStar_Syntax_Syntax.pos =
              (uu___1051_6483.FStar_Syntax_Syntax.pos);
            FStar_Syntax_Syntax.vars =
              (uu___1051_6483.FStar_Syntax_Syntax.vars)
          }  in
        flat_arrow bs c1
    | uu____6486 -> t
  
let (refine :
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun b  ->
    fun t  ->
      let uu____6504 =
        let uu____6505 = FStar_Syntax_Syntax.range_of_bv b  in
        FStar_Range.union_ranges uu____6505 t.FStar_Syntax_Syntax.pos  in
      let uu____6506 =
        let uu____6513 =
          let uu____6514 =
            let uu____6521 =
              let uu____6524 =
                let uu____6525 = FStar_Syntax_Syntax.mk_binder b  in
                [uu____6525]  in
              FStar_Syntax_Subst.close uu____6524 t  in
            (b, uu____6521)  in
          FStar_Syntax_Syntax.Tm_refine uu____6514  in
        FStar_Syntax_Syntax.mk uu____6513  in
      uu____6506 FStar_Pervasives_Native.None uu____6504
  
let (branch : FStar_Syntax_Syntax.branch -> FStar_Syntax_Syntax.branch) =
  fun b  -> FStar_Syntax_Subst.close_branch b 
let rec (arrow_formals_comp_ln :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) Prims.list * FStar_Syntax_Syntax.comp))
  =
  fun k  ->
    let k1 = FStar_Syntax_Subst.compress k  in
    match k1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____6605 = is_total_comp c  in
        if uu____6605
        then
          let uu____6620 = arrow_formals_comp_ln (comp_result c)  in
          (match uu____6620 with
           | (bs',k2) -> ((FStar_List.append bs bs'), k2))
        else (bs, c)
    | FStar_Syntax_Syntax.Tm_refine
        ({ FStar_Syntax_Syntax.ppname = uu____6687;
           FStar_Syntax_Syntax.index = uu____6688;
           FStar_Syntax_Syntax.sort = s;_},uu____6690)
        ->
        let rec aux s1 k2 =
          let uu____6721 =
            let uu____6722 = FStar_Syntax_Subst.compress s1  in
            uu____6722.FStar_Syntax_Syntax.n  in
          match uu____6721 with
          | FStar_Syntax_Syntax.Tm_arrow uu____6737 ->
              arrow_formals_comp_ln s1
          | FStar_Syntax_Syntax.Tm_refine
              ({ FStar_Syntax_Syntax.ppname = uu____6752;
                 FStar_Syntax_Syntax.index = uu____6753;
                 FStar_Syntax_Syntax.sort = s2;_},uu____6755)
              -> aux s2 k2
          | uu____6763 ->
              let uu____6764 = FStar_Syntax_Syntax.mk_Total k2  in
              ([], uu____6764)
           in
        aux s k1
    | uu____6779 ->
        let uu____6780 = FStar_Syntax_Syntax.mk_Total k1  in ([], uu____6780)
  
let (arrow_formals_comp :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.comp))
  =
  fun k  ->
    let uu____6805 = arrow_formals_comp_ln k  in
    match uu____6805 with | (bs,c) -> FStar_Syntax_Subst.open_comp bs c
  
let (arrow_formals_ln :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) Prims.list * FStar_Syntax_Syntax.term'
      FStar_Syntax_Syntax.syntax))
  =
  fun k  ->
    let uu____6860 = arrow_formals_comp_ln k  in
    match uu____6860 with | (bs,c) -> (bs, (comp_result c))
  
let (arrow_formals :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.term'
      FStar_Syntax_Syntax.syntax))
  =
  fun k  ->
    let uu____6927 = arrow_formals_comp k  in
    match uu____6927 with | (bs,c) -> (bs, (comp_result c))
  
let (let_rec_arity :
  FStar_Syntax_Syntax.letbinding ->
    (Prims.int * Prims.bool Prims.list FStar_Pervasives_Native.option))
  =
  fun lb  ->
    let rec arrow_until_decreases k =
      let k1 = FStar_Syntax_Subst.compress k  in
      match k1.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
          let uu____7029 = FStar_Syntax_Subst.open_comp bs c  in
          (match uu____7029 with
           | (bs1,c1) ->
               let ct = comp_to_comp_typ c1  in
               let uu____7053 =
                 FStar_All.pipe_right ct.FStar_Syntax_Syntax.flags
                   (FStar_Util.find_opt
                      (fun uu___8_7062  ->
                         match uu___8_7062 with
                         | FStar_Syntax_Syntax.DECREASES uu____7064 -> true
                         | uu____7068 -> false))
                  in
               (match uu____7053 with
                | FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.DECREASES
                    d) -> (bs1, (FStar_Pervasives_Native.Some d))
                | uu____7103 ->
                    let uu____7106 = is_total_comp c1  in
                    if uu____7106
                    then
                      let uu____7125 = arrow_until_decreases (comp_result c1)
                         in
                      (match uu____7125 with
                       | (bs',d) -> ((FStar_List.append bs1 bs'), d))
                    else (bs1, FStar_Pervasives_Native.None)))
      | FStar_Syntax_Syntax.Tm_refine
          ({ FStar_Syntax_Syntax.ppname = uu____7218;
             FStar_Syntax_Syntax.index = uu____7219;
             FStar_Syntax_Syntax.sort = k2;_},uu____7221)
          -> arrow_until_decreases k2
      | uu____7229 -> ([], FStar_Pervasives_Native.None)  in
    let uu____7250 = arrow_until_decreases lb.FStar_Syntax_Syntax.lbtyp  in
    match uu____7250 with
    | (bs,dopt) ->
        let n_univs = FStar_List.length lb.FStar_Syntax_Syntax.lbunivs  in
        let uu____7304 =
          FStar_Util.map_opt dopt
            (fun d  ->
               let d_bvs = FStar_Syntax_Free.names d  in
               let uu____7325 =
                 FStar_Common.tabulate n_univs (fun uu____7331  -> false)  in
               let uu____7334 =
                 FStar_All.pipe_right bs
                   (FStar_List.map
                      (fun uu____7359  ->
                         match uu____7359 with
                         | (x,uu____7368) -> FStar_Util.set_mem x d_bvs))
                  in
               FStar_List.append uu____7325 uu____7334)
           in
        ((n_univs + (FStar_List.length bs)), uu____7304)
  
let (abs_formals :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.term *
      FStar_Syntax_Syntax.residual_comp FStar_Pervasives_Native.option))
  =
  fun t  ->
    let subst_lcomp_opt s l =
      match l with
      | FStar_Pervasives_Native.Some rc ->
          let uu____7424 =
            let uu___1149_7425 = rc  in
            let uu____7426 =
              FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                (FStar_Syntax_Subst.subst s)
               in
            {
              FStar_Syntax_Syntax.residual_effect =
                (uu___1149_7425.FStar_Syntax_Syntax.residual_effect);
              FStar_Syntax_Syntax.residual_typ = uu____7426;
              FStar_Syntax_Syntax.residual_flags =
                (uu___1149_7425.FStar_Syntax_Syntax.residual_flags)
            }  in
          FStar_Pervasives_Native.Some uu____7424
      | uu____7435 -> l  in
    let rec aux t1 abs_body_lcomp =
      let uu____7469 =
        let uu____7470 =
          let uu____7473 = FStar_Syntax_Subst.compress t1  in
          FStar_All.pipe_left unascribe uu____7473  in
        uu____7470.FStar_Syntax_Syntax.n  in
      match uu____7469 with
      | FStar_Syntax_Syntax.Tm_abs (bs,t2,what) ->
          let uu____7519 = aux t2 what  in
          (match uu____7519 with
           | (bs',t3,what1) -> ((FStar_List.append bs bs'), t3, what1))
      | uu____7591 -> ([], t1, abs_body_lcomp)  in
    let uu____7608 = aux t FStar_Pervasives_Native.None  in
    match uu____7608 with
    | (bs,t1,abs_body_lcomp) ->
        let uu____7656 = FStar_Syntax_Subst.open_term' bs t1  in
        (match uu____7656 with
         | (bs1,t2,opening) ->
             let abs_body_lcomp1 = subst_lcomp_opt opening abs_body_lcomp  in
             (bs1, t2, abs_body_lcomp1))
  
let (remove_inacc : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let no_acc uu____7690 =
      match uu____7690 with
      | (b,aq) ->
          let aq1 =
            match aq with
            | FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Implicit
                (true )) ->
                FStar_Pervasives_Native.Some
                  (FStar_Syntax_Syntax.Implicit false)
            | uu____7704 -> aq  in
          (b, aq1)
       in
    let uu____7709 = arrow_formals_comp_ln t  in
    match uu____7709 with
    | (bs,c) ->
        (match bs with
         | [] -> t
         | uu____7746 ->
             let uu____7755 =
               let uu____7762 =
                 let uu____7763 =
                   let uu____7778 = FStar_List.map no_acc bs  in
                   (uu____7778, c)  in
                 FStar_Syntax_Syntax.Tm_arrow uu____7763  in
               FStar_Syntax_Syntax.mk uu____7762  in
             uu____7755 FStar_Pervasives_Native.None
               t.FStar_Syntax_Syntax.pos)
  
let (mk_letbinding :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
    FStar_Syntax_Syntax.univ_name Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Ident.lident ->
          FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
            FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list
              -> FStar_Range.range -> FStar_Syntax_Syntax.letbinding)
  =
  fun lbname  ->
    fun univ_vars  ->
      fun typ  ->
        fun eff  ->
          fun def  ->
            fun lbattrs  ->
              fun pos  ->
                {
                  FStar_Syntax_Syntax.lbname = lbname;
                  FStar_Syntax_Syntax.lbunivs = univ_vars;
                  FStar_Syntax_Syntax.lbtyp = typ;
                  FStar_Syntax_Syntax.lbeff = eff;
                  FStar_Syntax_Syntax.lbdef = def;
                  FStar_Syntax_Syntax.lbattrs = lbattrs;
                  FStar_Syntax_Syntax.lbpos = pos
                }
  
let (close_univs_and_mk_letbinding :
  FStar_Syntax_Syntax.fv Prims.list FStar_Pervasives_Native.option ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
      FStar_Syntax_Syntax.univ_name Prims.list ->
        FStar_Syntax_Syntax.term ->
          FStar_Ident.lident ->
            FStar_Syntax_Syntax.term ->
              FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list
                -> FStar_Range.range -> FStar_Syntax_Syntax.letbinding)
  =
  fun recs  ->
    fun lbname  ->
      fun univ_vars  ->
        fun typ  ->
          fun eff  ->
            fun def  ->
              fun attrs  ->
                fun pos  ->
                  let def1 =
                    match (recs, univ_vars) with
                    | (FStar_Pervasives_Native.None ,uu____7949) -> def
                    | (uu____7960,[]) -> def
                    | (FStar_Pervasives_Native.Some fvs,uu____7972) ->
                        let universes =
                          FStar_All.pipe_right univ_vars
                            (FStar_List.map
                               (fun uu____7988  ->
                                  FStar_Syntax_Syntax.U_name uu____7988))
                           in
                        let inst =
                          FStar_All.pipe_right fvs
                            (FStar_List.map
                               (fun fv  ->
                                  (((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v),
                                    universes)))
                           in
                        FStar_Syntax_InstFV.instantiate inst def
                     in
                  let typ1 = FStar_Syntax_Subst.close_univ_vars univ_vars typ
                     in
                  let def2 =
                    FStar_Syntax_Subst.close_univ_vars univ_vars def1  in
                  mk_letbinding lbname univ_vars typ1 eff def2 attrs pos
  
let (open_univ_vars_binders_and_comp :
  FStar_Syntax_Syntax.univ_names ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) Prims.list ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
        (FStar_Syntax_Syntax.univ_names * (FStar_Syntax_Syntax.bv *
          FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option)
          Prims.list * FStar_Syntax_Syntax.comp))
  =
  fun uvs  ->
    fun binders  ->
      fun c  ->
        match binders with
        | [] ->
            let uu____8070 = FStar_Syntax_Subst.open_univ_vars_comp uvs c  in
            (match uu____8070 with | (uvs1,c1) -> (uvs1, [], c1))
        | uu____8105 ->
            let t' = arrow binders c  in
            let uu____8117 = FStar_Syntax_Subst.open_univ_vars uvs t'  in
            (match uu____8117 with
             | (uvs1,t'1) ->
                 let uu____8138 =
                   let uu____8139 = FStar_Syntax_Subst.compress t'1  in
                   uu____8139.FStar_Syntax_Syntax.n  in
                 (match uu____8138 with
                  | FStar_Syntax_Syntax.Tm_arrow (binders1,c1) ->
                      (uvs1, binders1, c1)
                  | uu____8188 -> failwith "Impossible"))
  
let (is_tuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        let uu____8213 =
          FStar_Ident.string_of_lid
            (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
           in
        FStar_Parser_Const.is_tuple_constructor_string uu____8213
    | uu____8215 -> false
  
let (is_dtuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Parser_Const.is_dtuple_constructor_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____8226 -> false
  
let (is_lid_equality : FStar_Ident.lident -> Prims.bool) =
  fun x  -> FStar_Ident.lid_equals x FStar_Parser_Const.eq2_lid 
let (is_forall : FStar_Ident.lident -> Prims.bool) =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Parser_Const.forall_lid 
let (is_exists : FStar_Ident.lident -> Prims.bool) =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Parser_Const.exists_lid 
let (is_qlid : FStar_Ident.lident -> Prims.bool) =
  fun lid  -> (is_forall lid) || (is_exists lid) 
let (is_equality :
  FStar_Ident.lident FStar_Syntax_Syntax.withinfo_t -> Prims.bool) =
  fun x  -> is_lid_equality x.FStar_Syntax_Syntax.v 
let (lid_is_connective : FStar_Ident.lident -> Prims.bool) =
  let lst =
    [FStar_Parser_Const.and_lid;
    FStar_Parser_Const.or_lid;
    FStar_Parser_Const.not_lid;
    FStar_Parser_Const.iff_lid;
    FStar_Parser_Const.imp_lid]  in
  fun lid  -> FStar_Util.for_some (FStar_Ident.lid_equals lid) lst 
let (is_constructor :
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool) =
  fun t  ->
    fun lid  ->
      let uu____8289 =
        let uu____8290 = pre_typ t  in uu____8290.FStar_Syntax_Syntax.n  in
      match uu____8289 with
      | FStar_Syntax_Syntax.Tm_fvar tc ->
          FStar_Ident.lid_equals
            (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v lid
      | uu____8295 -> false
  
let rec (is_constructed_typ :
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool) =
  fun t  ->
    fun lid  ->
      let uu____8309 =
        let uu____8310 = pre_typ t  in uu____8310.FStar_Syntax_Syntax.n  in
      match uu____8309 with
      | FStar_Syntax_Syntax.Tm_fvar uu____8314 -> is_constructor t lid
      | FStar_Syntax_Syntax.Tm_app (t1,uu____8316) ->
          is_constructed_typ t1 lid
      | FStar_Syntax_Syntax.Tm_uinst (t1,uu____8342) ->
          is_constructed_typ t1 lid
      | uu____8347 -> false
  
let rec (get_tycon :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term FStar_Pervasives_Native.option)
  =
  fun t  ->
    let t1 = pre_typ t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_bvar uu____8360 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_name uu____8361 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_fvar uu____8362 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_app (t2,uu____8364) -> get_tycon t2
    | uu____8389 -> FStar_Pervasives_Native.None
  
let (is_fstar_tactics_by_tactic : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____8397 =
      let uu____8398 = un_uinst t  in uu____8398.FStar_Syntax_Syntax.n  in
    match uu____8397 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.by_tactic_lid
    | uu____8403 -> false
  
let (is_builtin_tactic : FStar_Ident.lident -> Prims.bool) =
  fun md  ->
    let path = FStar_Ident.path_of_lid md  in
    if (FStar_List.length path) > (Prims.of_int (2))
    then
      let uu____8417 =
        let uu____8421 = FStar_List.splitAt (Prims.of_int (2)) path  in
        FStar_Pervasives_Native.fst uu____8421  in
      match uu____8417 with
      | "FStar"::"Tactics"::[] -> true
      | "FStar"::"Reflection"::[] -> true
      | uu____8453 -> false
    else false
  
let (ktype : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_unknown)
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (ktype0 : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_zero)
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (type_u :
  unit -> (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.universe)) =
  fun uu____8472  ->
    let u =
      let uu____8478 =
        FStar_Syntax_Unionfind.univ_fresh FStar_Range.dummyRange  in
      FStar_All.pipe_left
        (fun uu____8499  -> FStar_Syntax_Syntax.U_unif uu____8499) uu____8478
       in
    let uu____8500 =
      FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type u)
        FStar_Pervasives_Native.None FStar_Range.dummyRange
       in
    (uu____8500, u)
  
let (attr_eq :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun a  ->
    fun a'  ->
      let uu____8513 = eq_tm a a'  in
      match uu____8513 with | Equal  -> true | uu____8516 -> false
  
let (attr_substitute : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  let uu____8521 =
    let uu____8528 =
      let uu____8529 =
        let uu____8530 =
          FStar_Ident.lid_of_path ["FStar"; "Pervasives"; "Substitute"]
            FStar_Range.dummyRange
           in
        FStar_Syntax_Syntax.lid_as_fv uu____8530
          FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
         in
      FStar_Syntax_Syntax.Tm_fvar uu____8529  in
    FStar_Syntax_Syntax.mk uu____8528  in
  uu____8521 FStar_Pervasives_Native.None FStar_Range.dummyRange 
let (exp_true_bool : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_bool true))
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_false_bool : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_bool false))
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_unit : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_constant FStar_Const.Const_unit)
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_int : Prims.string -> FStar_Syntax_Syntax.term) =
  fun s  ->
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant
         (FStar_Const.Const_int (s, FStar_Pervasives_Native.None)))
      FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_char : FStar_BaseTypes.char -> FStar_Syntax_Syntax.term) =
  fun c  ->
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_char c))
      FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_string : Prims.string -> FStar_Syntax_Syntax.term) =
  fun s  ->
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant
         (FStar_Const.Const_string (s, FStar_Range.dummyRange)))
      FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (fvar_const : FStar_Ident.lident -> FStar_Syntax_Syntax.term) =
  fun l  ->
    FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.delta_constant
      FStar_Pervasives_Native.None
  
let (tand : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.and_lid 
let (tor : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.or_lid 
let (timp : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.imp_lid
    (FStar_Syntax_Syntax.Delta_constant_at_level Prims.int_one)
    FStar_Pervasives_Native.None
  
let (tiff : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.iff_lid
    (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.of_int (2)))
    FStar_Pervasives_Native.None
  
let (t_bool : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.bool_lid 
let (b2t_v : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.b2t_lid 
let (t_not : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.not_lid 
let (t_false : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.false_lid 
let (t_true : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.true_lid 
let (tac_opaque_attr : FStar_Syntax_Syntax.term) = exp_string "tac_opaque" 
let (dm4f_bind_range_attr : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.dm4f_bind_range_attr 
let (tcdecltime_attr : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.tcdecltime_attr 
let (inline_let_attr : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.inline_let_attr 
let (rename_let_attr : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.rename_let_attr 
let (t_ctx_uvar_and_sust : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.ctx_uvar_and_subst_lid 
let (mk_conj_opt :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
    FStar_Pervasives_Native.option ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
        FStar_Pervasives_Native.option)
  =
  fun phi1  ->
    fun phi2  ->
      match phi1 with
      | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.Some phi2
      | FStar_Pervasives_Native.Some phi11 ->
          let uu____8643 =
            let uu____8646 =
              FStar_Range.union_ranges phi11.FStar_Syntax_Syntax.pos
                phi2.FStar_Syntax_Syntax.pos
               in
            let uu____8647 =
              let uu____8654 =
                let uu____8655 =
                  let uu____8672 =
                    let uu____8683 = FStar_Syntax_Syntax.as_arg phi11  in
                    let uu____8692 =
                      let uu____8703 = FStar_Syntax_Syntax.as_arg phi2  in
                      [uu____8703]  in
                    uu____8683 :: uu____8692  in
                  (tand, uu____8672)  in
                FStar_Syntax_Syntax.Tm_app uu____8655  in
              FStar_Syntax_Syntax.mk uu____8654  in
            uu____8647 FStar_Pervasives_Native.None uu____8646  in
          FStar_Pervasives_Native.Some uu____8643
  
let (mk_binop :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun op_t  ->
    fun phi1  ->
      fun phi2  ->
        let uu____8780 =
          FStar_Range.union_ranges phi1.FStar_Syntax_Syntax.pos
            phi2.FStar_Syntax_Syntax.pos
           in
        let uu____8781 =
          let uu____8788 =
            let uu____8789 =
              let uu____8806 =
                let uu____8817 = FStar_Syntax_Syntax.as_arg phi1  in
                let uu____8826 =
                  let uu____8837 = FStar_Syntax_Syntax.as_arg phi2  in
                  [uu____8837]  in
                uu____8817 :: uu____8826  in
              (op_t, uu____8806)  in
            FStar_Syntax_Syntax.Tm_app uu____8789  in
          FStar_Syntax_Syntax.mk uu____8788  in
        uu____8781 FStar_Pervasives_Native.None uu____8780
  
let (mk_neg :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    let uu____8894 =
      let uu____8901 =
        let uu____8902 =
          let uu____8919 =
            let uu____8930 = FStar_Syntax_Syntax.as_arg phi  in [uu____8930]
             in
          (t_not, uu____8919)  in
        FStar_Syntax_Syntax.Tm_app uu____8902  in
      FStar_Syntax_Syntax.mk uu____8901  in
    uu____8894 FStar_Pervasives_Native.None phi.FStar_Syntax_Syntax.pos
  
let (mk_conj :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  = fun phi1  -> fun phi2  -> mk_binop tand phi1 phi2 
let (mk_conj_l :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    match phi with
    | [] ->
        FStar_Syntax_Syntax.fvar FStar_Parser_Const.true_lid
          FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
    | hd::tl -> FStar_List.fold_right mk_conj tl hd
  
let (mk_disj :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  = fun phi1  -> fun phi2  -> mk_binop tor phi1 phi2 
let (mk_disj_l :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    match phi with
    | [] -> t_false
    | hd::tl -> FStar_List.fold_right mk_disj tl hd
  
let (mk_imp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term)
  = fun phi1  -> fun phi2  -> mk_binop timp phi1 phi2 
let (mk_iff :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term)
  = fun phi1  -> fun phi2  -> mk_binop tiff phi1 phi2 
let (b2t :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun e  ->
    let uu____9127 =
      let uu____9134 =
        let uu____9135 =
          let uu____9152 =
            let uu____9163 = FStar_Syntax_Syntax.as_arg e  in [uu____9163]
             in
          (b2t_v, uu____9152)  in
        FStar_Syntax_Syntax.Tm_app uu____9135  in
      FStar_Syntax_Syntax.mk uu____9134  in
    uu____9127 FStar_Pervasives_Native.None e.FStar_Syntax_Syntax.pos
  
let (unb2t :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term FStar_Pervasives_Native.option)
  =
  fun e  ->
    let uu____9210 = head_and_args e  in
    match uu____9210 with
    | (hd,args) ->
        let uu____9255 =
          let uu____9270 =
            let uu____9271 = FStar_Syntax_Subst.compress hd  in
            uu____9271.FStar_Syntax_Syntax.n  in
          (uu____9270, args)  in
        (match uu____9255 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,(e1,uu____9288)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.b2t_lid ->
             FStar_Pervasives_Native.Some e1
         | uu____9323 -> FStar_Pervasives_Native.None)
  
let (is_t_true : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____9345 =
      let uu____9346 = unmeta t  in uu____9346.FStar_Syntax_Syntax.n  in
    match uu____9345 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.true_lid
    | uu____9351 -> false
  
let (mk_conj_simp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t1  ->
    fun t2  ->
      let uu____9374 = is_t_true t1  in
      if uu____9374
      then t2
      else
        (let uu____9381 = is_t_true t2  in
         if uu____9381 then t1 else mk_conj t1 t2)
  
let (mk_disj_simp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t1  ->
    fun t2  ->
      let uu____9409 = is_t_true t1  in
      if uu____9409
      then t_true
      else
        (let uu____9416 = is_t_true t2  in
         if uu____9416 then t_true else mk_disj t1 t2)
  
let (teq : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.eq2_lid 
let (mk_untyped_eq2 :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun e1  ->
    fun e2  ->
      let uu____9445 =
        FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
          e2.FStar_Syntax_Syntax.pos
         in
      let uu____9446 =
        let uu____9453 =
          let uu____9454 =
            let uu____9471 =
              let uu____9482 = FStar_Syntax_Syntax.as_arg e1  in
              let uu____9491 =
                let uu____9502 = FStar_Syntax_Syntax.as_arg e2  in
                [uu____9502]  in
              uu____9482 :: uu____9491  in
            (teq, uu____9471)  in
          FStar_Syntax_Syntax.Tm_app uu____9454  in
        FStar_Syntax_Syntax.mk uu____9453  in
      uu____9446 FStar_Pervasives_Native.None uu____9445
  
let (mk_eq2 :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun u  ->
    fun t  ->
      fun e1  ->
        fun e2  ->
          let eq_inst = FStar_Syntax_Syntax.mk_Tm_uinst teq [u]  in
          let uu____9569 =
            FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
              e2.FStar_Syntax_Syntax.pos
             in
          let uu____9570 =
            let uu____9577 =
              let uu____9578 =
                let uu____9595 =
                  let uu____9606 = FStar_Syntax_Syntax.iarg t  in
                  let uu____9615 =
                    let uu____9626 = FStar_Syntax_Syntax.as_arg e1  in
                    let uu____9635 =
                      let uu____9646 = FStar_Syntax_Syntax.as_arg e2  in
                      [uu____9646]  in
                    uu____9626 :: uu____9635  in
                  uu____9606 :: uu____9615  in
                (eq_inst, uu____9595)  in
              FStar_Syntax_Syntax.Tm_app uu____9578  in
            FStar_Syntax_Syntax.mk uu____9577  in
          uu____9570 FStar_Pervasives_Native.None uu____9569
  
let (mk_has_type :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    fun x  ->
      fun t'  ->
        let t_has_type = fvar_const FStar_Parser_Const.has_type_lid  in
        let t_has_type1 =
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_uinst
               (t_has_type,
                 [FStar_Syntax_Syntax.U_zero; FStar_Syntax_Syntax.U_zero]))
            FStar_Pervasives_Native.None FStar_Range.dummyRange
           in
        let uu____9723 =
          let uu____9730 =
            let uu____9731 =
              let uu____9748 =
                let uu____9759 = FStar_Syntax_Syntax.iarg t  in
                let uu____9768 =
                  let uu____9779 = FStar_Syntax_Syntax.as_arg x  in
                  let uu____9788 =
                    let uu____9799 = FStar_Syntax_Syntax.as_arg t'  in
                    [uu____9799]  in
                  uu____9779 :: uu____9788  in
                uu____9759 :: uu____9768  in
              (t_has_type1, uu____9748)  in
            FStar_Syntax_Syntax.Tm_app uu____9731  in
          FStar_Syntax_Syntax.mk uu____9730  in
        uu____9723 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (mk_with_type :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun u  ->
    fun t  ->
      fun e  ->
        let t_with_type =
          FStar_Syntax_Syntax.fvar FStar_Parser_Const.with_type_lid
            FStar_Syntax_Syntax.delta_equational FStar_Pervasives_Native.None
           in
        let t_with_type1 =
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_uinst (t_with_type, [u]))
            FStar_Pervasives_Native.None FStar_Range.dummyRange
           in
        let uu____9876 =
          let uu____9883 =
            let uu____9884 =
              let uu____9901 =
                let uu____9912 = FStar_Syntax_Syntax.iarg t  in
                let uu____9921 =
                  let uu____9932 = FStar_Syntax_Syntax.as_arg e  in
                  [uu____9932]  in
                uu____9912 :: uu____9921  in
              (t_with_type1, uu____9901)  in
            FStar_Syntax_Syntax.Tm_app uu____9884  in
          FStar_Syntax_Syntax.mk uu____9883  in
        uu____9876 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (lex_t : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.lex_t_lid 
let (lex_top : FStar_Syntax_Syntax.term) =
  let uu____9979 =
    let uu____9986 =
      let uu____9987 =
        let uu____9994 =
          FStar_Syntax_Syntax.fvar FStar_Parser_Const.lextop_lid
            FStar_Syntax_Syntax.delta_constant
            (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
           in
        (uu____9994, [FStar_Syntax_Syntax.U_zero])  in
      FStar_Syntax_Syntax.Tm_uinst uu____9987  in
    FStar_Syntax_Syntax.mk uu____9986  in
  uu____9979 FStar_Pervasives_Native.None FStar_Range.dummyRange 
let (lex_pair : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.lexcons_lid
    FStar_Syntax_Syntax.delta_constant
    (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
  
let (tforall : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.forall_lid
    (FStar_Syntax_Syntax.Delta_constant_at_level Prims.int_one)
    FStar_Pervasives_Native.None
  
let (t_haseq : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.haseq_lid
    FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
  
let (mk_residual_comp :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option ->
      FStar_Syntax_Syntax.cflag Prims.list ->
        FStar_Syntax_Syntax.residual_comp)
  =
  fun l  ->
    fun t  ->
      fun f  ->
        {
          FStar_Syntax_Syntax.residual_effect = l;
          FStar_Syntax_Syntax.residual_typ = t;
          FStar_Syntax_Syntax.residual_flags = f
        }
  
let (residual_tot :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.residual_comp)
  =
  fun t  ->
    {
      FStar_Syntax_Syntax.residual_effect = FStar_Parser_Const.effect_Tot_lid;
      FStar_Syntax_Syntax.residual_typ = (FStar_Pervasives_Native.Some t);
      FStar_Syntax_Syntax.residual_flags = [FStar_Syntax_Syntax.TOTAL]
    }
  
let (residual_comp_of_comp :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.residual_comp) =
  fun c  ->
    {
      FStar_Syntax_Syntax.residual_effect = (comp_effect_name c);
      FStar_Syntax_Syntax.residual_typ =
        (FStar_Pervasives_Native.Some (comp_result c));
      FStar_Syntax_Syntax.residual_flags = (comp_flags c)
    }
  
let (mk_forall_aux :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun fa  ->
    fun x  ->
      fun body  ->
        let uu____10077 =
          let uu____10084 =
            let uu____10085 =
              let uu____10102 =
                let uu____10113 =
                  FStar_Syntax_Syntax.iarg x.FStar_Syntax_Syntax.sort  in
                let uu____10122 =
                  let uu____10133 =
                    let uu____10142 =
                      let uu____10143 =
                        let uu____10144 = FStar_Syntax_Syntax.mk_binder x  in
                        [uu____10144]  in
                      abs uu____10143 body
                        (FStar_Pervasives_Native.Some (residual_tot ktype0))
                       in
                    FStar_Syntax_Syntax.as_arg uu____10142  in
                  [uu____10133]  in
                uu____10113 :: uu____10122  in
              (fa, uu____10102)  in
            FStar_Syntax_Syntax.Tm_app uu____10085  in
          FStar_Syntax_Syntax.mk uu____10084  in
        uu____10077 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (mk_forall_no_univ :
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  = fun x  -> fun body  -> mk_forall_aux tforall x body 
let (mk_forall :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.bv ->
      FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun u  ->
    fun x  ->
      fun body  ->
        let tforall1 = FStar_Syntax_Syntax.mk_Tm_uinst tforall [u]  in
        mk_forall_aux tforall1 x body
  
let (close_forall_no_univs :
  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
    FStar_Pervasives_Native.option) Prims.list ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun bs  ->
    fun f  ->
      FStar_List.fold_right
        (fun b  ->
           fun f1  ->
             let uu____10271 = FStar_Syntax_Syntax.is_null_binder b  in
             if uu____10271
             then f1
             else mk_forall_no_univ (FStar_Pervasives_Native.fst b) f1) bs f
  
let (is_wild_pat :
  FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t -> Prims.bool) =
  fun p  ->
    match p.FStar_Syntax_Syntax.v with
    | FStar_Syntax_Syntax.Pat_wild uu____10290 -> true
    | uu____10292 -> false
  
let (if_then_else :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun b  ->
    fun t1  ->
      fun t2  ->
        let then_branch =
          let uu____10339 =
            FStar_Syntax_Syntax.withinfo
              (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool true))
              t1.FStar_Syntax_Syntax.pos
             in
          (uu____10339, FStar_Pervasives_Native.None, t1)  in
        let else_branch =
          let uu____10368 =
            FStar_Syntax_Syntax.withinfo
              (FStar_Syntax_Syntax.Pat_constant
                 (FStar_Const.Const_bool false)) t2.FStar_Syntax_Syntax.pos
             in
          (uu____10368, FStar_Pervasives_Native.None, t2)  in
        let uu____10382 =
          let uu____10383 =
            FStar_Range.union_ranges t1.FStar_Syntax_Syntax.pos
              t2.FStar_Syntax_Syntax.pos
             in
          FStar_Range.union_ranges b.FStar_Syntax_Syntax.pos uu____10383  in
        FStar_Syntax_Syntax.mk
          (FStar_Syntax_Syntax.Tm_match (b, [then_branch; else_branch]))
          FStar_Pervasives_Native.None uu____10382
  
let (mk_squash :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun u  ->
    fun p  ->
      let sq =
        FStar_Syntax_Syntax.fvar FStar_Parser_Const.squash_lid
          (FStar_Syntax_Syntax.Delta_constant_at_level Prims.int_one)
          FStar_Pervasives_Native.None
         in
      let uu____10459 = FStar_Syntax_Syntax.mk_Tm_uinst sq [u]  in
      let uu____10462 =
        let uu____10473 = FStar_Syntax_Syntax.as_arg p  in [uu____10473]  in
      mk_app uu____10459 uu____10462
  
let (mk_auto_squash :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun u  ->
    fun p  ->
      let sq =
        FStar_Syntax_Syntax.fvar FStar_Parser_Const.auto_squash_lid
          (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.of_int (2)))
          FStar_Pervasives_Native.None
         in
      let uu____10513 = FStar_Syntax_Syntax.mk_Tm_uinst sq [u]  in
      let uu____10516 =
        let uu____10527 = FStar_Syntax_Syntax.as_arg p  in [uu____10527]  in
      mk_app uu____10513 uu____10516
  
let (un_squash :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____10562 = head_and_args t  in
    match uu____10562 with
    | (head,args) ->
        let head1 = unascribe head  in
        let head2 = un_uinst head1  in
        let uu____10611 =
          let uu____10626 =
            let uu____10627 = FStar_Syntax_Subst.compress head2  in
            uu____10627.FStar_Syntax_Syntax.n  in
          (uu____10626, args)  in
        (match uu____10611 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,(p,uu____10646)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid
             -> FStar_Pervasives_Native.Some p
         | (FStar_Syntax_Syntax.Tm_refine (b,p),[]) ->
             (match (b.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.n with
              | FStar_Syntax_Syntax.Tm_fvar fv when
                  FStar_Syntax_Syntax.fv_eq_lid fv
                    FStar_Parser_Const.unit_lid
                  ->
                  let uu____10712 =
                    let uu____10717 =
                      let uu____10718 = FStar_Syntax_Syntax.mk_binder b  in
                      [uu____10718]  in
                    FStar_Syntax_Subst.open_term uu____10717 p  in
                  (match uu____10712 with
                   | (bs,p1) ->
                       let b1 =
                         match bs with
                         | b1::[] -> b1
                         | uu____10775 -> failwith "impossible"  in
                       let uu____10783 =
                         let uu____10785 = FStar_Syntax_Free.names p1  in
                         FStar_Util.set_mem (FStar_Pervasives_Native.fst b1)
                           uu____10785
                          in
                       if uu____10783
                       then FStar_Pervasives_Native.None
                       else FStar_Pervasives_Native.Some p1)
              | uu____10801 -> FStar_Pervasives_Native.None)
         | uu____10804 -> FStar_Pervasives_Native.None)
  
let (is_squash :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.universe * FStar_Syntax_Syntax.term'
      FStar_Syntax_Syntax.syntax) FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____10835 = head_and_args t  in
    match uu____10835 with
    | (head,args) ->
        let uu____10886 =
          let uu____10901 =
            let uu____10902 = FStar_Syntax_Subst.compress head  in
            uu____10902.FStar_Syntax_Syntax.n  in
          (uu____10901, args)  in
        (match uu____10886 with
         | (FStar_Syntax_Syntax.Tm_uinst
            ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
               FStar_Syntax_Syntax.pos = uu____10924;
               FStar_Syntax_Syntax.vars = uu____10925;_},u::[]),(t1,uu____10928)::[])
             when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid
             -> FStar_Pervasives_Native.Some (u, t1)
         | uu____10975 -> FStar_Pervasives_Native.None)
  
let (is_auto_squash :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.universe * FStar_Syntax_Syntax.term'
      FStar_Syntax_Syntax.syntax) FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____11010 = head_and_args t  in
    match uu____11010 with
    | (head,args) ->
        let uu____11061 =
          let uu____11076 =
            let uu____11077 = FStar_Syntax_Subst.compress head  in
            uu____11077.FStar_Syntax_Syntax.n  in
          (uu____11076, args)  in
        (match uu____11061 with
         | (FStar_Syntax_Syntax.Tm_uinst
            ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
               FStar_Syntax_Syntax.pos = uu____11099;
               FStar_Syntax_Syntax.vars = uu____11100;_},u::[]),(t1,uu____11103)::[])
             when
             FStar_Syntax_Syntax.fv_eq_lid fv
               FStar_Parser_Const.auto_squash_lid
             -> FStar_Pervasives_Native.Some (u, t1)
         | uu____11150 -> FStar_Pervasives_Native.None)
  
let (is_sub_singleton : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____11178 =
      let uu____11195 = unmeta t  in head_and_args uu____11195  in
    match uu____11178 with
    | (head,uu____11198) ->
        let uu____11223 =
          let uu____11224 = un_uinst head  in
          uu____11224.FStar_Syntax_Syntax.n  in
        (match uu____11223 with
         | FStar_Syntax_Syntax.Tm_fvar fv ->
             (((((((((((((((((FStar_Syntax_Syntax.fv_eq_lid fv
                                FStar_Parser_Const.squash_lid)
                               ||
                               (FStar_Syntax_Syntax.fv_eq_lid fv
                                  FStar_Parser_Const.auto_squash_lid))
                              ||
                              (FStar_Syntax_Syntax.fv_eq_lid fv
                                 FStar_Parser_Const.and_lid))
                             ||
                             (FStar_Syntax_Syntax.fv_eq_lid fv
                                FStar_Parser_Const.or_lid))
                            ||
                            (FStar_Syntax_Syntax.fv_eq_lid fv
                               FStar_Parser_Const.not_lid))
                           ||
                           (FStar_Syntax_Syntax.fv_eq_lid fv
                              FStar_Parser_Const.imp_lid))
                          ||
                          (FStar_Syntax_Syntax.fv_eq_lid fv
                             FStar_Parser_Const.iff_lid))
                         ||
                         (FStar_Syntax_Syntax.fv_eq_lid fv
                            FStar_Parser_Const.ite_lid))
                        ||
                        (FStar_Syntax_Syntax.fv_eq_lid fv
                           FStar_Parser_Const.exists_lid))
                       ||
                       (FStar_Syntax_Syntax.fv_eq_lid fv
                          FStar_Parser_Const.forall_lid))
                      ||
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.true_lid))
                     ||
                     (FStar_Syntax_Syntax.fv_eq_lid fv
                        FStar_Parser_Const.false_lid))
                    ||
                    (FStar_Syntax_Syntax.fv_eq_lid fv
                       FStar_Parser_Const.eq2_lid))
                   ||
                   (FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Parser_Const.eq3_lid))
                  ||
                  (FStar_Syntax_Syntax.fv_eq_lid fv
                     FStar_Parser_Const.b2t_lid))
                 ||
                 (FStar_Syntax_Syntax.fv_eq_lid fv
                    FStar_Parser_Const.haseq_lid))
                ||
                (FStar_Syntax_Syntax.fv_eq_lid fv
                   FStar_Parser_Const.has_type_lid))
               ||
               (FStar_Syntax_Syntax.fv_eq_lid fv
                  FStar_Parser_Const.precedes_lid)
         | uu____11229 -> false)
  
let (arrow_one_ln :
  FStar_Syntax_Syntax.typ ->
    (FStar_Syntax_Syntax.binder * FStar_Syntax_Syntax.comp)
      FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____11249 =
      let uu____11250 = FStar_Syntax_Subst.compress t  in
      uu____11250.FStar_Syntax_Syntax.n  in
    match uu____11249 with
    | FStar_Syntax_Syntax.Tm_arrow ([],c) ->
        failwith "fatal: empty binders on arrow?"
    | FStar_Syntax_Syntax.Tm_arrow (b::[],c) ->
        FStar_Pervasives_Native.Some (b, c)
    | FStar_Syntax_Syntax.Tm_arrow (b::bs,c) ->
        let uu____11356 =
          let uu____11361 =
            let uu____11362 = arrow bs c  in
            FStar_Syntax_Syntax.mk_Total uu____11362  in
          (b, uu____11361)  in
        FStar_Pervasives_Native.Some uu____11356
    | uu____11367 -> FStar_Pervasives_Native.None
  
let (arrow_one :
  FStar_Syntax_Syntax.typ ->
    (FStar_Syntax_Syntax.binder * FStar_Syntax_Syntax.comp)
      FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____11390 = arrow_one_ln t  in
    FStar_Util.bind_opt uu____11390
      (fun uu____11418  ->
         match uu____11418 with
         | (b,c) ->
             let uu____11437 = FStar_Syntax_Subst.open_comp [b] c  in
             (match uu____11437 with
              | (bs,c1) ->
                  let b1 =
                    match bs with
                    | b1::[] -> b1
                    | uu____11500 ->
                        failwith
                          "impossible: open_comp returned different amount of binders"
                     in
                  FStar_Pervasives_Native.Some (b1, c1)))
  
let (is_free_in :
  FStar_Syntax_Syntax.bv -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun bv  ->
    fun t  ->
      let uu____11537 = FStar_Syntax_Free.names t  in
      FStar_Util.set_mem bv uu____11537
  
type qpats = FStar_Syntax_Syntax.args Prims.list
type connective =
  | QAll of (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ) 
  | QEx of (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ) 
  | BaseConn of (FStar_Ident.lident * FStar_Syntax_Syntax.args) 
let (uu___is_QAll : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | QAll _0 -> true | uu____11589 -> false
  
let (__proj__QAll__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ))
  = fun projectee  -> match projectee with | QAll _0 -> _0 
let (uu___is_QEx : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | QEx _0 -> true | uu____11632 -> false
  
let (__proj__QEx__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ))
  = fun projectee  -> match projectee with | QEx _0 -> _0 
let (uu___is_BaseConn : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | BaseConn _0 -> true | uu____11673 -> false
  
let (__proj__BaseConn__item___0 :
  connective -> (FStar_Ident.lident * FStar_Syntax_Syntax.args)) =
  fun projectee  -> match projectee with | BaseConn _0 -> _0 
let (destruct_base_table :
  (Prims.int * (FStar_Ident.lident * FStar_Ident.lident) Prims.list)
    Prims.list)
  =
  let f x = (x, x)  in
  [(Prims.int_zero,
     [f FStar_Parser_Const.true_lid; f FStar_Parser_Const.false_lid]);
  ((Prims.of_int (2)),
    [f FStar_Parser_Const.and_lid;
    f FStar_Parser_Const.or_lid;
    f FStar_Parser_Const.imp_lid;
    f FStar_Parser_Const.iff_lid;
    f FStar_Parser_Const.eq2_lid;
    f FStar_Parser_Const.eq3_lid]);
  (Prims.int_one, [f FStar_Parser_Const.not_lid]);
  ((Prims.of_int (3)),
    [f FStar_Parser_Const.ite_lid; f FStar_Parser_Const.eq2_lid]);
  ((Prims.of_int (4)), [f FStar_Parser_Const.eq3_lid])] 
let (destruct_sq_base_table :
  (Prims.int * (FStar_Ident.lident * FStar_Ident.lident) Prims.list)
    Prims.list)
  =
  [((Prims.of_int (2)),
     [(FStar_Parser_Const.c_and_lid, FStar_Parser_Const.and_lid);
     (FStar_Parser_Const.c_or_lid, FStar_Parser_Const.or_lid);
     (FStar_Parser_Const.c_eq2_lid, FStar_Parser_Const.c_eq2_lid);
     (FStar_Parser_Const.c_eq3_lid, FStar_Parser_Const.c_eq3_lid)]);
  ((Prims.of_int (3)),
    [(FStar_Parser_Const.c_eq2_lid, FStar_Parser_Const.c_eq2_lid)]);
  ((Prims.of_int (4)),
    [(FStar_Parser_Const.c_eq3_lid, FStar_Parser_Const.c_eq3_lid)]);
  (Prims.int_zero,
    [(FStar_Parser_Const.c_true_lid, FStar_Parser_Const.true_lid);
    (FStar_Parser_Const.c_false_lid, FStar_Parser_Const.false_lid)])]
  
let (destruct_typ_as_formula :
  FStar_Syntax_Syntax.term -> connective FStar_Pervasives_Native.option) =
  fun f  ->
    let rec unmeta_monadic f1 =
      let f2 = FStar_Syntax_Subst.compress f1  in
      match f2.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta
          (t,FStar_Syntax_Syntax.Meta_monadic uu____12059) ->
          unmeta_monadic t
      | FStar_Syntax_Syntax.Tm_meta
          (t,FStar_Syntax_Syntax.Meta_monadic_lift uu____12071) ->
          unmeta_monadic t
      | uu____12084 -> f2  in
    let lookup_arity_lid table target_lid args =
      let arg_len = FStar_List.length args  in
      let aux uu____12153 =
        match uu____12153 with
        | (arity,lids) ->
            if arg_len = arity
            then
              FStar_Util.find_map lids
                (fun uu____12191  ->
                   match uu____12191 with
                   | (lid,out_lid) ->
                       let uu____12200 =
                         FStar_Ident.lid_equals target_lid lid  in
                       if uu____12200
                       then
                         FStar_Pervasives_Native.Some
                           (BaseConn (out_lid, args))
                       else FStar_Pervasives_Native.None)
            else FStar_Pervasives_Native.None
         in
      FStar_Util.find_map table aux  in
    let destruct_base_conn t =
      let uu____12227 = head_and_args t  in
      match uu____12227 with
      | (hd,args) ->
          let uu____12272 =
            let uu____12273 = un_uinst hd  in
            uu____12273.FStar_Syntax_Syntax.n  in
          (match uu____12272 with
           | FStar_Syntax_Syntax.Tm_fvar fv ->
               lookup_arity_lid destruct_base_table
                 (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v args
           | uu____12279 -> FStar_Pervasives_Native.None)
       in
    let destruct_sq_base_conn t =
      let uu____12288 = un_squash t  in
      FStar_Util.bind_opt uu____12288
        (fun t1  ->
           let uu____12304 = head_and_args' t1  in
           match uu____12304 with
           | (hd,args) ->
               let uu____12343 =
                 let uu____12344 = un_uinst hd  in
                 uu____12344.FStar_Syntax_Syntax.n  in
               (match uu____12343 with
                | FStar_Syntax_Syntax.Tm_fvar fv ->
                    lookup_arity_lid destruct_sq_base_table
                      (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                      args
                | uu____12350 -> FStar_Pervasives_Native.None))
       in
    let patterns t =
      let t1 = FStar_Syntax_Subst.compress t  in
      match t1.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta
          (t2,FStar_Syntax_Syntax.Meta_pattern (uu____12391,pats)) ->
          let uu____12429 = FStar_Syntax_Subst.compress t2  in
          (pats, uu____12429)
      | uu____12442 -> ([], t1)  in
    let destruct_q_conn t =
      let is_q fa fv =
        if fa
        then is_forall (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
        else is_exists (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
         in
      let flat t1 =
        let uu____12509 = head_and_args t1  in
        match uu____12509 with
        | (t2,args) ->
            let uu____12564 = un_uinst t2  in
            let uu____12565 =
              FStar_All.pipe_right args
                (FStar_List.map
                   (fun uu____12606  ->
                      match uu____12606 with
                      | (t3,imp) ->
                          let uu____12625 = unascribe t3  in
                          (uu____12625, imp)))
               in
            (uu____12564, uu____12565)
         in
      let rec aux qopt out t1 =
        let uu____12676 = let uu____12700 = flat t1  in (qopt, uu____12700)
           in
        match uu____12676 with
        | (FStar_Pervasives_Native.Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.pos = uu____12740;
                 FStar_Syntax_Syntax.vars = uu____12741;_},({
                                                              FStar_Syntax_Syntax.n
                                                                =
                                                                FStar_Syntax_Syntax.Tm_abs
                                                                (b::[],t2,uu____12744);
                                                              FStar_Syntax_Syntax.pos
                                                                = uu____12745;
                                                              FStar_Syntax_Syntax.vars
                                                                = uu____12746;_},uu____12747)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (FStar_Pervasives_Native.Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.pos = uu____12849;
                 FStar_Syntax_Syntax.vars = uu____12850;_},uu____12851::
               ({
                  FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs
                    (b::[],t2,uu____12854);
                  FStar_Syntax_Syntax.pos = uu____12855;
                  FStar_Syntax_Syntax.vars = uu____12856;_},uu____12857)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (FStar_Pervasives_Native.None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.pos = uu____12974;
               FStar_Syntax_Syntax.vars = uu____12975;_},({
                                                            FStar_Syntax_Syntax.n
                                                              =
                                                              FStar_Syntax_Syntax.Tm_abs
                                                              (b::[],t2,uu____12978);
                                                            FStar_Syntax_Syntax.pos
                                                              = uu____12979;
                                                            FStar_Syntax_Syntax.vars
                                                              = uu____12980;_},uu____12981)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            let uu____13074 =
              let uu____13078 =
                is_forall
                  (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                 in
              FStar_Pervasives_Native.Some uu____13078  in
            aux uu____13074 (b :: out) t2
        | (FStar_Pervasives_Native.None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.pos = uu____13088;
               FStar_Syntax_Syntax.vars = uu____13089;_},uu____13090::
             ({
                FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs
                  (b::[],t2,uu____13093);
                FStar_Syntax_Syntax.pos = uu____13094;
                FStar_Syntax_Syntax.vars = uu____13095;_},uu____13096)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            let uu____13205 =
              let uu____13209 =
                is_forall
                  (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                 in
              FStar_Pervasives_Native.Some uu____13209  in
            aux uu____13205 (b :: out) t2
        | (FStar_Pervasives_Native.Some b,uu____13219) ->
            let bs = FStar_List.rev out  in
            let uu____13272 = FStar_Syntax_Subst.open_term bs t1  in
            (match uu____13272 with
             | (bs1,t2) ->
                 let uu____13281 = patterns t2  in
                 (match uu____13281 with
                  | (pats,body) ->
                      if b
                      then
                        FStar_Pervasives_Native.Some (QAll (bs1, pats, body))
                      else
                        FStar_Pervasives_Native.Some (QEx (bs1, pats, body))))
        | uu____13331 -> FStar_Pervasives_Native.None  in
      aux FStar_Pervasives_Native.None [] t  in
    let rec destruct_sq_forall t =
      let uu____13386 = un_squash t  in
      FStar_Util.bind_opt uu____13386
        (fun t1  ->
           let uu____13401 = arrow_one t1  in
           match uu____13401 with
           | FStar_Pervasives_Native.Some (b,c) ->
               let uu____13416 =
                 let uu____13418 = is_tot_or_gtot_comp c  in
                 Prims.op_Negation uu____13418  in
               if uu____13416
               then FStar_Pervasives_Native.None
               else
                 (let q =
                    let uu____13428 = comp_to_comp_typ_nouniv c  in
                    uu____13428.FStar_Syntax_Syntax.result_typ  in
                  let uu____13429 =
                    is_free_in (FStar_Pervasives_Native.fst b) q  in
                  if uu____13429
                  then
                    let uu____13436 = patterns q  in
                    match uu____13436 with
                    | (pats,q1) ->
                        FStar_All.pipe_left maybe_collect
                          (FStar_Pervasives_Native.Some
                             (QAll ([b], pats, q1)))
                  else
                    (let uu____13499 =
                       let uu____13500 =
                         let uu____13505 =
                           let uu____13506 =
                             FStar_Syntax_Syntax.as_arg
                               (FStar_Pervasives_Native.fst b).FStar_Syntax_Syntax.sort
                              in
                           let uu____13517 =
                             let uu____13528 = FStar_Syntax_Syntax.as_arg q
                                in
                             [uu____13528]  in
                           uu____13506 :: uu____13517  in
                         (FStar_Parser_Const.imp_lid, uu____13505)  in
                       BaseConn uu____13500  in
                     FStar_Pervasives_Native.Some uu____13499))
           | uu____13561 -> FStar_Pervasives_Native.None)
    
    and destruct_sq_exists t =
      let uu____13569 = un_squash t  in
      FStar_Util.bind_opt uu____13569
        (fun t1  ->
           let uu____13600 = head_and_args' t1  in
           match uu____13600 with
           | (hd,args) ->
               let uu____13639 =
                 let uu____13654 =
                   let uu____13655 = un_uinst hd  in
                   uu____13655.FStar_Syntax_Syntax.n  in
                 (uu____13654, args)  in
               (match uu____13639 with
                | (FStar_Syntax_Syntax.Tm_fvar
                   fv,(a1,uu____13672)::(a2,uu____13674)::[]) when
                    FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Parser_Const.dtuple2_lid
                    ->
                    let uu____13725 =
                      let uu____13726 = FStar_Syntax_Subst.compress a2  in
                      uu____13726.FStar_Syntax_Syntax.n  in
                    (match uu____13725 with
                     | FStar_Syntax_Syntax.Tm_abs (b::[],q,uu____13733) ->
                         let uu____13768 = FStar_Syntax_Subst.open_term [b] q
                            in
                         (match uu____13768 with
                          | (bs,q1) ->
                              let b1 =
                                match bs with
                                | b1::[] -> b1
                                | uu____13821 -> failwith "impossible"  in
                              let uu____13829 = patterns q1  in
                              (match uu____13829 with
                               | (pats,q2) ->
                                   FStar_All.pipe_left maybe_collect
                                     (FStar_Pervasives_Native.Some
                                        (QEx ([b1], pats, q2)))))
                     | uu____13890 -> FStar_Pervasives_Native.None)
                | uu____13891 -> FStar_Pervasives_Native.None))
    
    and maybe_collect f1 =
      match f1 with
      | FStar_Pervasives_Native.Some (QAll (bs,pats,phi)) ->
          let uu____13914 = destruct_sq_forall phi  in
          (match uu____13914 with
           | FStar_Pervasives_Native.Some (QAll (bs',pats',psi)) ->
               FStar_All.pipe_left
                 (fun uu____13924  ->
                    FStar_Pervasives_Native.Some uu____13924)
                 (QAll
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____13931 -> f1)
      | FStar_Pervasives_Native.Some (QEx (bs,pats,phi)) ->
          let uu____13937 = destruct_sq_exists phi  in
          (match uu____13937 with
           | FStar_Pervasives_Native.Some (QEx (bs',pats',psi)) ->
               FStar_All.pipe_left
                 (fun uu____13947  ->
                    FStar_Pervasives_Native.Some uu____13947)
                 (QEx
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____13954 -> f1)
      | uu____13957 -> f1
     in
    let phi = unmeta_monadic f  in
    let uu____13961 = destruct_base_conn phi  in
    FStar_Util.catch_opt uu____13961
      (fun uu____13966  ->
         let uu____13967 = destruct_q_conn phi  in
         FStar_Util.catch_opt uu____13967
           (fun uu____13972  ->
              let uu____13973 = destruct_sq_base_conn phi  in
              FStar_Util.catch_opt uu____13973
                (fun uu____13978  ->
                   let uu____13979 = destruct_sq_forall phi  in
                   FStar_Util.catch_opt uu____13979
                     (fun uu____13984  ->
                        let uu____13985 = destruct_sq_exists phi  in
                        FStar_Util.catch_opt uu____13985
                          (fun uu____13989  -> FStar_Pervasives_Native.None)))))
  
let (action_as_lb :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.action ->
      FStar_Range.range -> FStar_Syntax_Syntax.sigelt)
  =
  fun eff_lid  ->
    fun a  ->
      fun pos  ->
        let lb =
          let uu____14007 =
            let uu____14012 =
              FStar_Syntax_Syntax.lid_as_fv a.FStar_Syntax_Syntax.action_name
                FStar_Syntax_Syntax.delta_equational
                FStar_Pervasives_Native.None
               in
            FStar_Util.Inr uu____14012  in
          let uu____14013 =
            let uu____14014 =
              FStar_Syntax_Syntax.mk_Total a.FStar_Syntax_Syntax.action_typ
               in
            arrow a.FStar_Syntax_Syntax.action_params uu____14014  in
          let uu____14017 =
            abs a.FStar_Syntax_Syntax.action_params
              a.FStar_Syntax_Syntax.action_defn FStar_Pervasives_Native.None
             in
          close_univs_and_mk_letbinding FStar_Pervasives_Native.None
            uu____14007 a.FStar_Syntax_Syntax.action_univs uu____14013
            FStar_Parser_Const.effect_Tot_lid uu____14017 [] pos
           in
        {
          FStar_Syntax_Syntax.sigel =
            (FStar_Syntax_Syntax.Sig_let
               ((false, [lb]), [a.FStar_Syntax_Syntax.action_name]));
          FStar_Syntax_Syntax.sigrng =
            ((a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos);
          FStar_Syntax_Syntax.sigquals =
            [FStar_Syntax_Syntax.Visible_default;
            FStar_Syntax_Syntax.Action eff_lid];
          FStar_Syntax_Syntax.sigmeta = FStar_Syntax_Syntax.default_sigmeta;
          FStar_Syntax_Syntax.sigattrs = [];
          FStar_Syntax_Syntax.sigopts = FStar_Pervasives_Native.None
        }
  
let (mk_reify :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let reify_ =
      FStar_Syntax_Syntax.mk
        (FStar_Syntax_Syntax.Tm_constant FStar_Const.Const_reify)
        FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
       in
    let uu____14043 =
      let uu____14050 =
        let uu____14051 =
          let uu____14068 =
            let uu____14079 = FStar_Syntax_Syntax.as_arg t  in [uu____14079]
             in
          (reify_, uu____14068)  in
        FStar_Syntax_Syntax.Tm_app uu____14051  in
      FStar_Syntax_Syntax.mk uu____14050  in
    uu____14043 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
  
let (mk_reflect :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let reflect_ =
      let uu____14131 =
        let uu____14138 =
          let uu____14139 =
            let uu____14140 = FStar_Ident.lid_of_str "Bogus.Effect"  in
            FStar_Const.Const_reflect uu____14140  in
          FStar_Syntax_Syntax.Tm_constant uu____14139  in
        FStar_Syntax_Syntax.mk uu____14138  in
      uu____14131 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos  in
    let uu____14142 =
      let uu____14149 =
        let uu____14150 =
          let uu____14167 =
            let uu____14178 = FStar_Syntax_Syntax.as_arg t  in [uu____14178]
             in
          (reflect_, uu____14167)  in
        FStar_Syntax_Syntax.Tm_app uu____14150  in
      FStar_Syntax_Syntax.mk uu____14149  in
    uu____14142 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
  
let rec (delta_qualifier :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____14222 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_lazy i ->
        let uu____14239 = unfold_lazy i  in delta_qualifier uu____14239
    | FStar_Syntax_Syntax.Tm_fvar fv -> fv.FStar_Syntax_Syntax.fv_delta
    | FStar_Syntax_Syntax.Tm_bvar uu____14241 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_name uu____14242 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_match uu____14243 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_uvar uu____14266 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_unknown  -> FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_type uu____14279 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_quoted uu____14280 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_constant uu____14287 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_arrow uu____14288 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____14304) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_refine
        ({ FStar_Syntax_Syntax.ppname = uu____14309;
           FStar_Syntax_Syntax.index = uu____14310;
           FStar_Syntax_Syntax.sort = t2;_},uu____14312)
        -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_meta (t2,uu____14321) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____14327,uu____14328) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_app (t2,uu____14370) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_abs (uu____14395,t2,uu____14397) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_let (uu____14422,t2) -> delta_qualifier t2
  
let rec (incr_delta_depth :
  FStar_Syntax_Syntax.delta_depth -> FStar_Syntax_Syntax.delta_depth) =
  fun d  ->
    match d with
    | FStar_Syntax_Syntax.Delta_constant_at_level i ->
        FStar_Syntax_Syntax.Delta_constant_at_level (i + Prims.int_one)
    | FStar_Syntax_Syntax.Delta_equational_at_level i ->
        FStar_Syntax_Syntax.Delta_equational_at_level (i + Prims.int_one)
    | FStar_Syntax_Syntax.Delta_abstract d1 -> incr_delta_depth d1
  
let (incr_delta_qualifier :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth) =
  fun t  ->
    let uu____14461 = delta_qualifier t  in incr_delta_depth uu____14461
  
let (is_unknown : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____14469 =
      let uu____14470 = FStar_Syntax_Subst.compress t  in
      uu____14470.FStar_Syntax_Syntax.n  in
    match uu____14469 with
    | FStar_Syntax_Syntax.Tm_unknown  -> true
    | uu____14475 -> false
  
let rec apply_last :
  'uuuuuu14484 .
    ('uuuuuu14484 -> 'uuuuuu14484) ->
      'uuuuuu14484 Prims.list -> 'uuuuuu14484 Prims.list
  =
  fun f  ->
    fun l  ->
      match l with
      | [] -> failwith "apply_last: got empty list"
      | a::[] -> let uu____14510 = f a  in [uu____14510]
      | x::xs -> let uu____14515 = apply_last f xs  in x :: uu____14515
  
let (dm4f_lid :
  FStar_Syntax_Syntax.eff_decl -> Prims.string -> FStar_Ident.lident) =
  fun ed  ->
    fun name  ->
      let p = FStar_Ident.path_of_lid ed.FStar_Syntax_Syntax.mname  in
      let p' =
        apply_last
          (fun s  ->
             Prims.op_Hat "_dm4f_" (Prims.op_Hat s (Prims.op_Hat "_" name)))
          p
         in
      FStar_Ident.lid_of_path p' FStar_Range.dummyRange
  
let (mk_list :
  FStar_Syntax_Syntax.term ->
    FStar_Range.range ->
      FStar_Syntax_Syntax.term Prims.list -> FStar_Syntax_Syntax.term)
  =
  fun typ  ->
    fun rng  ->
      fun l  ->
        let ctor l1 =
          let uu____14570 =
            let uu____14577 =
              let uu____14578 =
                FStar_Syntax_Syntax.lid_as_fv l1
                  FStar_Syntax_Syntax.delta_constant
                  (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
                 in
              FStar_Syntax_Syntax.Tm_fvar uu____14578  in
            FStar_Syntax_Syntax.mk uu____14577  in
          uu____14570 FStar_Pervasives_Native.None rng  in
        let cons args pos =
          let uu____14592 =
            let uu____14597 =
              let uu____14598 = ctor FStar_Parser_Const.cons_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____14598
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____14597 args  in
          uu____14592 FStar_Pervasives_Native.None pos  in
        let nil args pos =
          let uu____14612 =
            let uu____14617 =
              let uu____14618 = ctor FStar_Parser_Const.nil_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____14618
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____14617 args  in
          uu____14612 FStar_Pervasives_Native.None pos  in
        let uu____14619 =
          let uu____14620 =
            let uu____14621 = FStar_Syntax_Syntax.iarg typ  in [uu____14621]
             in
          nil uu____14620 rng  in
        FStar_List.fold_right
          (fun t  ->
             fun a  ->
               let uu____14655 =
                 let uu____14656 = FStar_Syntax_Syntax.iarg typ  in
                 let uu____14665 =
                   let uu____14676 = FStar_Syntax_Syntax.as_arg t  in
                   let uu____14685 =
                     let uu____14696 = FStar_Syntax_Syntax.as_arg a  in
                     [uu____14696]  in
                   uu____14676 :: uu____14685  in
                 uu____14656 :: uu____14665  in
               cons uu____14655 t.FStar_Syntax_Syntax.pos) l uu____14619
  
let rec eqlist :
  'a .
    ('a -> 'a -> Prims.bool) -> 'a Prims.list -> 'a Prims.list -> Prims.bool
  =
  fun eq  ->
    fun xs  ->
      fun ys  ->
        match (xs, ys) with
        | ([],[]) -> true
        | (x::xs1,y::ys1) -> (eq x y) && (eqlist eq xs1 ys1)
        | uu____14805 -> false
  
let eqsum :
  'a 'b .
    ('a -> 'a -> Prims.bool) ->
      ('b -> 'b -> Prims.bool) ->
        ('a,'b) FStar_Util.either -> ('a,'b) FStar_Util.either -> Prims.bool
  =
  fun e1  ->
    fun e2  ->
      fun x  ->
        fun y  ->
          match (x, y) with
          | (FStar_Util.Inl x1,FStar_Util.Inl y1) -> e1 x1 y1
          | (FStar_Util.Inr x1,FStar_Util.Inr y1) -> e2 x1 y1
          | uu____14919 -> false
  
let eqprod :
  'a 'b .
    ('a -> 'a -> Prims.bool) ->
      ('b -> 'b -> Prims.bool) -> ('a * 'b) -> ('a * 'b) -> Prims.bool
  =
  fun e1  ->
    fun e2  ->
      fun x  ->
        fun y  ->
          match (x, y) with | ((x1,x2),(y1,y2)) -> (e1 x1 y1) && (e2 x2 y2)
  
let eqopt :
  'a .
    ('a -> 'a -> Prims.bool) ->
      'a FStar_Pervasives_Native.option ->
        'a FStar_Pervasives_Native.option -> Prims.bool
  =
  fun e  ->
    fun x  ->
      fun y  ->
        match (x, y) with
        | (FStar_Pervasives_Native.Some x1,FStar_Pervasives_Native.Some y1)
            -> e x1 y1
        | uu____15085 -> false
  
let (debug_term_eq : Prims.bool FStar_ST.ref) = FStar_Util.mk_ref false 
let (check : Prims.string -> Prims.bool -> Prims.bool) =
  fun msg  ->
    fun cond  ->
      if cond
      then true
      else
        ((let uu____15123 = FStar_ST.op_Bang debug_term_eq  in
          if uu____15123
          then FStar_Util.print1 ">>> term_eq failing: %s\n" msg
          else ());
         false)
  
let (fail : Prims.string -> Prims.bool) = fun msg  -> check msg false 
let rec (term_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool)
  =
  fun dbg  ->
    fun t1  ->
      fun t2  ->
        let t11 = let uu____15327 = unmeta_safe t1  in canon_app uu____15327
           in
        let t21 = let uu____15333 = unmeta_safe t2  in canon_app uu____15333
           in
        let uu____15336 =
          let uu____15341 =
            let uu____15342 =
              let uu____15345 = un_uinst t11  in
              FStar_Syntax_Subst.compress uu____15345  in
            uu____15342.FStar_Syntax_Syntax.n  in
          let uu____15346 =
            let uu____15347 =
              let uu____15350 = un_uinst t21  in
              FStar_Syntax_Subst.compress uu____15350  in
            uu____15347.FStar_Syntax_Syntax.n  in
          (uu____15341, uu____15346)  in
        match uu____15336 with
        | (FStar_Syntax_Syntax.Tm_uinst uu____15352,uu____15353) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____15362,FStar_Syntax_Syntax.Tm_uinst uu____15363) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_delayed uu____15372,uu____15373) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____15390,FStar_Syntax_Syntax.Tm_delayed uu____15391) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_ascribed uu____15408,uu____15409) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____15438,FStar_Syntax_Syntax.Tm_ascribed uu____15439) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_bvar x,FStar_Syntax_Syntax.Tm_bvar y) ->
            check "bvar"
              (x.FStar_Syntax_Syntax.index = y.FStar_Syntax_Syntax.index)
        | (FStar_Syntax_Syntax.Tm_name x,FStar_Syntax_Syntax.Tm_name y) ->
            check "name"
              (x.FStar_Syntax_Syntax.index = y.FStar_Syntax_Syntax.index)
        | (FStar_Syntax_Syntax.Tm_fvar x,FStar_Syntax_Syntax.Tm_fvar y) ->
            let uu____15478 = FStar_Syntax_Syntax.fv_eq x y  in
            check "fvar" uu____15478
        | (FStar_Syntax_Syntax.Tm_constant c1,FStar_Syntax_Syntax.Tm_constant
           c2) ->
            let uu____15483 = FStar_Const.eq_const c1 c2  in
            check "const" uu____15483
        | (FStar_Syntax_Syntax.Tm_type
           uu____15486,FStar_Syntax_Syntax.Tm_type uu____15487) -> true
        | (FStar_Syntax_Syntax.Tm_abs (b1,t12,k1),FStar_Syntax_Syntax.Tm_abs
           (b2,t22,k2)) ->
            (let uu____15545 = eqlist (binder_eq_dbg dbg) b1 b2  in
             check "abs binders" uu____15545) &&
              (let uu____15555 = term_eq_dbg dbg t12 t22  in
               check "abs bodies" uu____15555)
        | (FStar_Syntax_Syntax.Tm_arrow (b1,c1),FStar_Syntax_Syntax.Tm_arrow
           (b2,c2)) ->
            (let uu____15604 = eqlist (binder_eq_dbg dbg) b1 b2  in
             check "arrow binders" uu____15604) &&
              (let uu____15614 = comp_eq_dbg dbg c1 c2  in
               check "arrow comp" uu____15614)
        | (FStar_Syntax_Syntax.Tm_refine
           (b1,t12),FStar_Syntax_Syntax.Tm_refine (b2,t22)) ->
            (let uu____15631 =
               term_eq_dbg dbg b1.FStar_Syntax_Syntax.sort
                 b2.FStar_Syntax_Syntax.sort
                in
             check "refine bv sort" uu____15631) &&
              (let uu____15635 = term_eq_dbg dbg t12 t22  in
               check "refine formula" uu____15635)
        | (FStar_Syntax_Syntax.Tm_app (f1,a1),FStar_Syntax_Syntax.Tm_app
           (f2,a2)) ->
            (let uu____15692 = term_eq_dbg dbg f1 f2  in
             check "app head" uu____15692) &&
              (let uu____15696 = eqlist (arg_eq_dbg dbg) a1 a2  in
               check "app args" uu____15696)
        | (FStar_Syntax_Syntax.Tm_match
           (t12,bs1),FStar_Syntax_Syntax.Tm_match (t22,bs2)) ->
            (let uu____15785 = term_eq_dbg dbg t12 t22  in
             check "match head" uu____15785) &&
              (let uu____15789 = eqlist (branch_eq_dbg dbg) bs1 bs2  in
               check "match branches" uu____15789)
        | (FStar_Syntax_Syntax.Tm_lazy uu____15806,uu____15807) ->
            let uu____15808 =
              let uu____15810 = unlazy t11  in
              term_eq_dbg dbg uu____15810 t21  in
            check "lazy_l" uu____15808
        | (uu____15812,FStar_Syntax_Syntax.Tm_lazy uu____15813) ->
            let uu____15814 =
              let uu____15816 = unlazy t21  in
              term_eq_dbg dbg t11 uu____15816  in
            check "lazy_r" uu____15814
        | (FStar_Syntax_Syntax.Tm_let
           ((b1,lbs1),t12),FStar_Syntax_Syntax.Tm_let ((b2,lbs2),t22)) ->
            ((check "let flag" (b1 = b2)) &&
               (let uu____15861 = eqlist (letbinding_eq_dbg dbg) lbs1 lbs2
                   in
                check "let lbs" uu____15861))
              &&
              (let uu____15865 = term_eq_dbg dbg t12 t22  in
               check "let body" uu____15865)
        | (FStar_Syntax_Syntax.Tm_uvar
           (u1,uu____15869),FStar_Syntax_Syntax.Tm_uvar (u2,uu____15871)) ->
            check "uvar"
              (u1.FStar_Syntax_Syntax.ctx_uvar_head =
                 u2.FStar_Syntax_Syntax.ctx_uvar_head)
        | (FStar_Syntax_Syntax.Tm_quoted
           (qt1,qi1),FStar_Syntax_Syntax.Tm_quoted (qt2,qi2)) ->
            (let uu____15931 =
               let uu____15933 = eq_quoteinfo qi1 qi2  in uu____15933 = Equal
                in
             check "tm_quoted qi" uu____15931) &&
              (let uu____15936 = term_eq_dbg dbg qt1 qt2  in
               check "tm_quoted payload" uu____15936)
        | (FStar_Syntax_Syntax.Tm_meta (t12,m1),FStar_Syntax_Syntax.Tm_meta
           (t22,m2)) ->
            (match (m1, m2) with
             | (FStar_Syntax_Syntax.Meta_monadic
                (n1,ty1),FStar_Syntax_Syntax.Meta_monadic (n2,ty2)) ->
                 (let uu____15966 = FStar_Ident.lid_equals n1 n2  in
                  check "meta_monadic lid" uu____15966) &&
                   (let uu____15970 = term_eq_dbg dbg ty1 ty2  in
                    check "meta_monadic type" uu____15970)
             | (FStar_Syntax_Syntax.Meta_monadic_lift
                (s1,t13,ty1),FStar_Syntax_Syntax.Meta_monadic_lift
                (s2,t23,ty2)) ->
                 ((let uu____15989 = FStar_Ident.lid_equals s1 s2  in
                   check "meta_monadic_lift src" uu____15989) &&
                    (let uu____15993 = FStar_Ident.lid_equals t13 t23  in
                     check "meta_monadic_lift tgt" uu____15993))
                   &&
                   (let uu____15997 = term_eq_dbg dbg ty1 ty2  in
                    check "meta_monadic_lift type" uu____15997)
             | uu____16000 -> fail "metas")
        | (FStar_Syntax_Syntax.Tm_unknown ,uu____16006) -> fail "unk"
        | (uu____16008,FStar_Syntax_Syntax.Tm_unknown ) -> fail "unk"
        | (FStar_Syntax_Syntax.Tm_bvar uu____16010,uu____16011) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_name uu____16013,uu____16014) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_fvar uu____16016,uu____16017) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_constant uu____16019,uu____16020) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_type uu____16022,uu____16023) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_abs uu____16025,uu____16026) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_arrow uu____16046,uu____16047) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_refine uu____16063,uu____16064) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_app uu____16072,uu____16073) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_match uu____16091,uu____16092) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_let uu____16116,uu____16117) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_uvar uu____16132,uu____16133) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_meta uu____16147,uu____16148) ->
            fail "bottom"
        | (uu____16156,FStar_Syntax_Syntax.Tm_bvar uu____16157) ->
            fail "bottom"
        | (uu____16159,FStar_Syntax_Syntax.Tm_name uu____16160) ->
            fail "bottom"
        | (uu____16162,FStar_Syntax_Syntax.Tm_fvar uu____16163) ->
            fail "bottom"
        | (uu____16165,FStar_Syntax_Syntax.Tm_constant uu____16166) ->
            fail "bottom"
        | (uu____16168,FStar_Syntax_Syntax.Tm_type uu____16169) ->
            fail "bottom"
        | (uu____16171,FStar_Syntax_Syntax.Tm_abs uu____16172) ->
            fail "bottom"
        | (uu____16192,FStar_Syntax_Syntax.Tm_arrow uu____16193) ->
            fail "bottom"
        | (uu____16209,FStar_Syntax_Syntax.Tm_refine uu____16210) ->
            fail "bottom"
        | (uu____16218,FStar_Syntax_Syntax.Tm_app uu____16219) ->
            fail "bottom"
        | (uu____16237,FStar_Syntax_Syntax.Tm_match uu____16238) ->
            fail "bottom"
        | (uu____16262,FStar_Syntax_Syntax.Tm_let uu____16263) ->
            fail "bottom"
        | (uu____16278,FStar_Syntax_Syntax.Tm_uvar uu____16279) ->
            fail "bottom"
        | (uu____16293,FStar_Syntax_Syntax.Tm_meta uu____16294) ->
            fail "bottom"

and (arg_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax *
      FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option) ->
      (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax *
        FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option) ->
        Prims.bool)
  =
  fun dbg  ->
    fun a1  ->
      fun a2  ->
        eqprod
          (fun t1  ->
             fun t2  ->
               let uu____16329 = term_eq_dbg dbg t1 t2  in
               check "arg tm" uu____16329)
          (fun q1  ->
             fun q2  ->
               let uu____16341 =
                 let uu____16343 = eq_aqual q1 q2  in uu____16343 = Equal  in
               check "arg qual" uu____16341) a1 a2

and (binder_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
      FStar_Pervasives_Native.option) ->
      (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier
        FStar_Pervasives_Native.option) -> Prims.bool)
  =
  fun dbg  ->
    fun b1  ->
      fun b2  ->
        eqprod
          (fun b11  ->
             fun b21  ->
               let uu____16368 =
                 term_eq_dbg dbg b11.FStar_Syntax_Syntax.sort
                   b21.FStar_Syntax_Syntax.sort
                  in
               check "binder sort" uu____16368)
          (fun q1  ->
             fun q2  ->
               let uu____16380 =
                 let uu____16382 = eq_aqual q1 q2  in uu____16382 = Equal  in
               check "binder qual" uu____16380) b1 b2

and (comp_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool)
  =
  fun dbg  ->
    fun c1  ->
      fun c2  ->
        let c11 = comp_to_comp_typ_nouniv c1  in
        let c21 = comp_to_comp_typ_nouniv c2  in
        ((let uu____16396 =
            FStar_Ident.lid_equals c11.FStar_Syntax_Syntax.effect_name
              c21.FStar_Syntax_Syntax.effect_name
             in
          check "comp eff" uu____16396) &&
           (let uu____16400 =
              term_eq_dbg dbg c11.FStar_Syntax_Syntax.result_typ
                c21.FStar_Syntax_Syntax.result_typ
               in
            check "comp result typ" uu____16400))
          && true

and (eq_flags_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.cflag -> FStar_Syntax_Syntax.cflag -> Prims.bool)
  = fun dbg  -> fun f1  -> fun f2  -> true

and (branch_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t *
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option * FStar_Syntax_Syntax.term'
      FStar_Syntax_Syntax.syntax) ->
      (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t *
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
        FStar_Pervasives_Native.option * FStar_Syntax_Syntax.term'
        FStar_Syntax_Syntax.syntax) -> Prims.bool)
  =
  fun dbg  ->
    fun uu____16410  ->
      fun uu____16411  ->
        match (uu____16410, uu____16411) with
        | ((p1,w1,t1),(p2,w2,t2)) ->
            ((let uu____16538 = FStar_Syntax_Syntax.eq_pat p1 p2  in
              check "branch pat" uu____16538) &&
               (let uu____16542 = term_eq_dbg dbg t1 t2  in
                check "branch body" uu____16542))
              &&
              (let uu____16546 =
                 match (w1, w2) with
                 | (FStar_Pervasives_Native.Some
                    x,FStar_Pervasives_Native.Some y) -> term_eq_dbg dbg x y
                 | (FStar_Pervasives_Native.None
                    ,FStar_Pervasives_Native.None ) -> true
                 | uu____16588 -> false  in
               check "branch when" uu____16546)

and (letbinding_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.letbinding ->
      FStar_Syntax_Syntax.letbinding -> Prims.bool)
  =
  fun dbg  ->
    fun lb1  ->
      fun lb2  ->
        ((let uu____16609 =
            eqsum (fun bv1  -> fun bv2  -> true) FStar_Syntax_Syntax.fv_eq
              lb1.FStar_Syntax_Syntax.lbname lb2.FStar_Syntax_Syntax.lbname
             in
          check "lb bv" uu____16609) &&
           (let uu____16618 =
              term_eq_dbg dbg lb1.FStar_Syntax_Syntax.lbtyp
                lb2.FStar_Syntax_Syntax.lbtyp
               in
            check "lb typ" uu____16618))
          &&
          (let uu____16622 =
             term_eq_dbg dbg lb1.FStar_Syntax_Syntax.lbdef
               lb2.FStar_Syntax_Syntax.lbdef
              in
           check "lb def" uu____16622)

let (term_eq :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t1  ->
    fun t2  ->
      let r =
        let uu____16639 = FStar_ST.op_Bang debug_term_eq  in
        term_eq_dbg uu____16639 t1 t2  in
      FStar_ST.op_Colon_Equals debug_term_eq false; r
  
let rec (sizeof : FStar_Syntax_Syntax.term -> Prims.int) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____16693 ->
        let uu____16708 =
          let uu____16710 = FStar_Syntax_Subst.compress t  in
          sizeof uu____16710  in
        Prims.int_one + uu____16708
    | FStar_Syntax_Syntax.Tm_bvar bv ->
        let uu____16713 = sizeof bv.FStar_Syntax_Syntax.sort  in
        Prims.int_one + uu____16713
    | FStar_Syntax_Syntax.Tm_name bv ->
        let uu____16717 = sizeof bv.FStar_Syntax_Syntax.sort  in
        Prims.int_one + uu____16717
    | FStar_Syntax_Syntax.Tm_uinst (t1,us) ->
        let uu____16726 = sizeof t1  in (FStar_List.length us) + uu____16726
    | FStar_Syntax_Syntax.Tm_abs (bs,t1,uu____16730) ->
        let uu____16755 = sizeof t1  in
        let uu____16757 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____16772  ->
                 match uu____16772 with
                 | (bv,uu____16782) ->
                     let uu____16787 = sizeof bv.FStar_Syntax_Syntax.sort  in
                     acc + uu____16787) Prims.int_zero bs
           in
        uu____16755 + uu____16757
    | FStar_Syntax_Syntax.Tm_app (hd,args) ->
        let uu____16816 = sizeof hd  in
        let uu____16818 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____16833  ->
                 match uu____16833 with
                 | (arg,uu____16843) ->
                     let uu____16848 = sizeof arg  in acc + uu____16848)
            Prims.int_zero args
           in
        uu____16816 + uu____16818
    | uu____16851 -> Prims.int_one
  
let (is_fvar : FStar_Ident.lident -> FStar_Syntax_Syntax.term -> Prims.bool)
  =
  fun lid  ->
    fun t  ->
      let uu____16865 =
        let uu____16866 = un_uinst t  in uu____16866.FStar_Syntax_Syntax.n
         in
      match uu____16865 with
      | FStar_Syntax_Syntax.Tm_fvar fv ->
          FStar_Syntax_Syntax.fv_eq_lid fv lid
      | uu____16871 -> false
  
let (is_synth_by_tactic : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  -> is_fvar FStar_Parser_Const.synth_lid t 
let (has_attribute :
  FStar_Syntax_Syntax.attribute Prims.list ->
    FStar_Ident.lident -> Prims.bool)
  = fun attrs  -> fun attr  -> FStar_Util.for_some (is_fvar attr) attrs 
let (get_attribute :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.attribute Prims.list ->
      FStar_Syntax_Syntax.args FStar_Pervasives_Native.option)
  =
  fun attr  ->
    fun attrs  ->
      FStar_List.tryPick
        (fun t  ->
           let uu____16932 = head_and_args t  in
           match uu____16932 with
           | (head,args) ->
               let uu____16987 =
                 let uu____16988 = FStar_Syntax_Subst.compress head  in
                 uu____16988.FStar_Syntax_Syntax.n  in
               (match uu____16987 with
                | FStar_Syntax_Syntax.Tm_fvar fv when
                    FStar_Syntax_Syntax.fv_eq_lid fv attr ->
                    FStar_Pervasives_Native.Some args
                | uu____17014 -> FStar_Pervasives_Native.None)) attrs
  
let (remove_attr :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.attribute Prims.list ->
      FStar_Syntax_Syntax.attribute Prims.list)
  =
  fun attr  ->
    fun attrs  ->
      FStar_List.filter
        (fun a  ->
           let uu____17047 = is_fvar attr a  in Prims.op_Negation uu____17047)
        attrs
  
let (process_pragma :
  FStar_Syntax_Syntax.pragma -> FStar_Range.range -> unit) =
  fun p  ->
    fun r  ->
      FStar_Errors.set_option_warning_callback_range
        (FStar_Pervasives_Native.Some r);
      (let set_options s =
         let uu____17069 = FStar_Options.set_options s  in
         match uu____17069 with
         | FStar_Getopt.Success  -> ()
         | FStar_Getopt.Help  ->
             FStar_Errors.raise_error
               (FStar_Errors.Fatal_FailToProcessPragma,
                 "Failed to process pragma: use 'fstar --help' to see which options are available")
               r
         | FStar_Getopt.Error s1 ->
             FStar_Errors.raise_error
               (FStar_Errors.Fatal_FailToProcessPragma,
                 (Prims.op_Hat "Failed to process pragma: " s1)) r
          in
       match p with
       | FStar_Syntax_Syntax.LightOff  -> FStar_Options.set_ml_ish ()
       | FStar_Syntax_Syntax.SetOptions o -> set_options o
       | FStar_Syntax_Syntax.ResetOptions sopt ->
           ((let uu____17083 = FStar_Options.restore_cmd_line_options false
                in
             FStar_All.pipe_right uu____17083 (fun uu____17085  -> ()));
            (match sopt with
             | FStar_Pervasives_Native.None  -> ()
             | FStar_Pervasives_Native.Some s -> set_options s))
       | FStar_Syntax_Syntax.PushOptions sopt ->
           (FStar_Options.internal_push ();
            (match sopt with
             | FStar_Pervasives_Native.None  -> ()
             | FStar_Pervasives_Native.Some s -> set_options s))
       | FStar_Syntax_Syntax.RestartSolver  -> ()
       | FStar_Syntax_Syntax.PopOptions  ->
           let uu____17099 = FStar_Options.internal_pop ()  in
           if uu____17099
           then ()
           else
             FStar_Errors.raise_error
               (FStar_Errors.Fatal_FailToProcessPragma,
                 "Cannot #pop-options, stack would become empty") r)
  
let rec (unbound_variables :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv Prims.list)
  =
  fun tm  ->
    let t = FStar_Syntax_Subst.compress tm  in
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____17131 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_name x -> []
    | FStar_Syntax_Syntax.Tm_uvar uu____17150 -> []
    | FStar_Syntax_Syntax.Tm_type u -> []
    | FStar_Syntax_Syntax.Tm_bvar x -> [x]
    | FStar_Syntax_Syntax.Tm_fvar uu____17165 -> []
    | FStar_Syntax_Syntax.Tm_constant uu____17166 -> []
    | FStar_Syntax_Syntax.Tm_lazy uu____17167 -> []
    | FStar_Syntax_Syntax.Tm_unknown  -> []
    | FStar_Syntax_Syntax.Tm_uinst (t1,us) -> unbound_variables t1
    | FStar_Syntax_Syntax.Tm_abs (bs,t1,uu____17176) ->
        let uu____17201 = FStar_Syntax_Subst.open_term bs t1  in
        (match uu____17201 with
         | (bs1,t2) ->
             let uu____17210 =
               FStar_List.collect
                 (fun uu____17222  ->
                    match uu____17222 with
                    | (b,uu____17232) ->
                        unbound_variables b.FStar_Syntax_Syntax.sort) bs1
                in
             let uu____17237 = unbound_variables t2  in
             FStar_List.append uu____17210 uu____17237)
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____17262 = FStar_Syntax_Subst.open_comp bs c  in
        (match uu____17262 with
         | (bs1,c1) ->
             let uu____17271 =
               FStar_List.collect
                 (fun uu____17283  ->
                    match uu____17283 with
                    | (b,uu____17293) ->
                        unbound_variables b.FStar_Syntax_Syntax.sort) bs1
                in
             let uu____17298 = unbound_variables_comp c1  in
             FStar_List.append uu____17271 uu____17298)
    | FStar_Syntax_Syntax.Tm_refine (b,t1) ->
        let uu____17307 =
          FStar_Syntax_Subst.open_term [(b, FStar_Pervasives_Native.None)] t1
           in
        (match uu____17307 with
         | (bs,t2) ->
             let uu____17330 =
               FStar_List.collect
                 (fun uu____17342  ->
                    match uu____17342 with
                    | (b1,uu____17352) ->
                        unbound_variables b1.FStar_Syntax_Syntax.sort) bs
                in
             let uu____17357 = unbound_variables t2  in
             FStar_List.append uu____17330 uu____17357)
    | FStar_Syntax_Syntax.Tm_app (t1,args) ->
        let uu____17386 =
          FStar_List.collect
            (fun uu____17400  ->
               match uu____17400 with
               | (x,uu____17412) -> unbound_variables x) args
           in
        let uu____17421 = unbound_variables t1  in
        FStar_List.append uu____17386 uu____17421
    | FStar_Syntax_Syntax.Tm_match (t1,pats) ->
        let uu____17462 = unbound_variables t1  in
        let uu____17465 =
          FStar_All.pipe_right pats
            (FStar_List.collect
               (fun br  ->
                  let uu____17480 = FStar_Syntax_Subst.open_branch br  in
                  match uu____17480 with
                  | (p,wopt,t2) ->
                      let uu____17502 = unbound_variables t2  in
                      let uu____17505 =
                        match wopt with
                        | FStar_Pervasives_Native.None  -> []
                        | FStar_Pervasives_Native.Some t3 ->
                            unbound_variables t3
                         in
                      FStar_List.append uu____17502 uu____17505))
           in
        FStar_List.append uu____17462 uu____17465
    | FStar_Syntax_Syntax.Tm_ascribed (t1,asc,uu____17519) ->
        let uu____17560 = unbound_variables t1  in
        let uu____17563 =
          let uu____17566 =
            match FStar_Pervasives_Native.fst asc with
            | FStar_Util.Inl t2 -> unbound_variables t2
            | FStar_Util.Inr c2 -> unbound_variables_comp c2  in
          let uu____17597 =
            match FStar_Pervasives_Native.snd asc with
            | FStar_Pervasives_Native.None  -> []
            | FStar_Pervasives_Native.Some tac -> unbound_variables tac  in
          FStar_List.append uu____17566 uu____17597  in
        FStar_List.append uu____17560 uu____17563
    | FStar_Syntax_Syntax.Tm_let ((false ,lb::[]),t1) ->
        let uu____17638 = unbound_variables lb.FStar_Syntax_Syntax.lbtyp  in
        let uu____17641 =
          let uu____17644 = unbound_variables lb.FStar_Syntax_Syntax.lbdef
             in
          let uu____17647 =
            match lb.FStar_Syntax_Syntax.lbname with
            | FStar_Util.Inr uu____17652 -> unbound_variables t1
            | FStar_Util.Inl bv ->
                let uu____17654 =
                  FStar_Syntax_Subst.open_term
                    [(bv, FStar_Pervasives_Native.None)] t1
                   in
                (match uu____17654 with
                 | (uu____17675,t2) -> unbound_variables t2)
             in
          FStar_List.append uu____17644 uu____17647  in
        FStar_List.append uu____17638 uu____17641
    | FStar_Syntax_Syntax.Tm_let ((uu____17677,lbs),t1) ->
        let uu____17697 = FStar_Syntax_Subst.open_let_rec lbs t1  in
        (match uu____17697 with
         | (lbs1,t2) ->
             let uu____17712 = unbound_variables t2  in
             let uu____17715 =
               FStar_List.collect
                 (fun lb  ->
                    let uu____17722 =
                      unbound_variables lb.FStar_Syntax_Syntax.lbtyp  in
                    let uu____17725 =
                      unbound_variables lb.FStar_Syntax_Syntax.lbdef  in
                    FStar_List.append uu____17722 uu____17725) lbs1
                in
             FStar_List.append uu____17712 uu____17715)
    | FStar_Syntax_Syntax.Tm_quoted (tm1,qi) ->
        (match qi.FStar_Syntax_Syntax.qkind with
         | FStar_Syntax_Syntax.Quote_static  -> []
         | FStar_Syntax_Syntax.Quote_dynamic  -> unbound_variables tm1)
    | FStar_Syntax_Syntax.Tm_meta (t1,m) ->
        let uu____17742 = unbound_variables t1  in
        let uu____17745 =
          match m with
          | FStar_Syntax_Syntax.Meta_pattern (uu____17750,args) ->
              FStar_List.collect
                (FStar_List.collect
                   (fun uu____17805  ->
                      match uu____17805 with
                      | (a,uu____17817) -> unbound_variables a)) args
          | FStar_Syntax_Syntax.Meta_monadic_lift
              (uu____17826,uu____17827,t') -> unbound_variables t'
          | FStar_Syntax_Syntax.Meta_monadic (uu____17833,t') ->
              unbound_variables t'
          | FStar_Syntax_Syntax.Meta_labeled uu____17839 -> []
          | FStar_Syntax_Syntax.Meta_desugared uu____17848 -> []
          | FStar_Syntax_Syntax.Meta_named uu____17849 -> []  in
        FStar_List.append uu____17742 uu____17745

and (unbound_variables_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv Prims.list)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.GTotal (t,uu____17856) -> unbound_variables t
    | FStar_Syntax_Syntax.Total (t,uu____17866) -> unbound_variables t
    | FStar_Syntax_Syntax.Comp ct ->
        let uu____17876 = unbound_variables ct.FStar_Syntax_Syntax.result_typ
           in
        let uu____17879 =
          FStar_List.collect
            (fun uu____17893  ->
               match uu____17893 with
               | (a,uu____17905) -> unbound_variables a)
            ct.FStar_Syntax_Syntax.effect_args
           in
        FStar_List.append uu____17876 uu____17879

let (extract_attr' :
  FStar_Ident.lid ->
    FStar_Syntax_Syntax.term Prims.list ->
      (FStar_Syntax_Syntax.term Prims.list * FStar_Syntax_Syntax.args)
        FStar_Pervasives_Native.option)
  =
  fun attr_lid  ->
    fun attrs  ->
      let rec aux acc attrs1 =
        match attrs1 with
        | [] -> FStar_Pervasives_Native.None
        | h::t ->
            let uu____18020 = head_and_args h  in
            (match uu____18020 with
             | (head,args) ->
                 let uu____18081 =
                   let uu____18082 = FStar_Syntax_Subst.compress head  in
                   uu____18082.FStar_Syntax_Syntax.n  in
                 (match uu____18081 with
                  | FStar_Syntax_Syntax.Tm_fvar fv when
                      FStar_Syntax_Syntax.fv_eq_lid fv attr_lid ->
                      let attrs' = FStar_List.rev_acc acc t  in
                      FStar_Pervasives_Native.Some (attrs', args)
                  | uu____18135 -> aux (h :: acc) t))
         in
      aux [] attrs
  
let (extract_attr :
  FStar_Ident.lid ->
    FStar_Syntax_Syntax.sigelt ->
      (FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.args)
        FStar_Pervasives_Native.option)
  =
  fun attr_lid  ->
    fun se  ->
      let uu____18159 =
        extract_attr' attr_lid se.FStar_Syntax_Syntax.sigattrs  in
      match uu____18159 with
      | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
      | FStar_Pervasives_Native.Some (attrs',t) ->
          FStar_Pervasives_Native.Some
            ((let uu___2505_18201 = se  in
              {
                FStar_Syntax_Syntax.sigel =
                  (uu___2505_18201.FStar_Syntax_Syntax.sigel);
                FStar_Syntax_Syntax.sigrng =
                  (uu___2505_18201.FStar_Syntax_Syntax.sigrng);
                FStar_Syntax_Syntax.sigquals =
                  (uu___2505_18201.FStar_Syntax_Syntax.sigquals);
                FStar_Syntax_Syntax.sigmeta =
                  (uu___2505_18201.FStar_Syntax_Syntax.sigmeta);
                FStar_Syntax_Syntax.sigattrs = attrs';
                FStar_Syntax_Syntax.sigopts =
                  (uu___2505_18201.FStar_Syntax_Syntax.sigopts)
              }), t)
  
let (is_smt_lemma : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____18209 =
      let uu____18210 = FStar_Syntax_Subst.compress t  in
      uu____18210.FStar_Syntax_Syntax.n  in
    match uu____18209 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____18214,c) ->
        (match c.FStar_Syntax_Syntax.n with
         | FStar_Syntax_Syntax.Comp ct when
             FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
               FStar_Parser_Const.effect_Lemma_lid
             ->
             (match ct.FStar_Syntax_Syntax.effect_args with
              | _req::_ens::(pats,uu____18242)::uu____18243 ->
                  let pats' = unmeta pats  in
                  let uu____18303 = head_and_args pats'  in
                  (match uu____18303 with
                   | (head,uu____18322) ->
                       let uu____18347 =
                         let uu____18348 = un_uinst head  in
                         uu____18348.FStar_Syntax_Syntax.n  in
                       (match uu____18347 with
                        | FStar_Syntax_Syntax.Tm_fvar fv ->
                            FStar_Syntax_Syntax.fv_eq_lid fv
                              FStar_Parser_Const.cons_lid
                        | uu____18353 -> false))
              | uu____18355 -> false)
         | uu____18367 -> false)
    | uu____18369 -> false
  
let rec (list_elements :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term Prims.list FStar_Pervasives_Native.option)
  =
  fun e  ->
    let uu____18385 =
      let uu____18402 = unmeta e  in head_and_args uu____18402  in
    match uu____18385 with
    | (head,args) ->
        let uu____18433 =
          let uu____18448 =
            let uu____18449 = un_uinst head  in
            uu____18449.FStar_Syntax_Syntax.n  in
          (uu____18448, args)  in
        (match uu____18433 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,uu____18467) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.nil_lid ->
             FStar_Pervasives_Native.Some []
         | (FStar_Syntax_Syntax.Tm_fvar
            fv,uu____18491::(hd,uu____18493)::(tl,uu____18495)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.cons_lid ->
             let uu____18562 =
               let uu____18565 =
                 let uu____18568 = list_elements tl  in
                 FStar_Util.must uu____18568  in
               hd :: uu____18565  in
             FStar_Pervasives_Native.Some uu____18562
         | uu____18577 -> FStar_Pervasives_Native.None)
  
let (unthunk : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____18600 =
      let uu____18601 = FStar_Syntax_Subst.compress t  in
      uu____18601.FStar_Syntax_Syntax.n  in
    match uu____18600 with
    | FStar_Syntax_Syntax.Tm_abs (b::[],e,uu____18606) ->
        let uu____18641 = FStar_Syntax_Subst.open_term [b] e  in
        (match uu____18641 with
         | (bs,e1) ->
             let b1 = FStar_List.hd bs  in
             let uu____18673 = is_free_in (FStar_Pervasives_Native.fst b1) e1
                in
             if uu____18673
             then
               let uu____18678 =
                 let uu____18689 = FStar_Syntax_Syntax.as_arg exp_unit  in
                 [uu____18689]  in
               mk_app t uu____18678
             else e1)
    | uu____18716 ->
        let uu____18717 =
          let uu____18728 = FStar_Syntax_Syntax.as_arg exp_unit  in
          [uu____18728]  in
        mk_app t uu____18717
  
let (unthunk_lemma_post :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) = fun t  -> unthunk t 
let (smt_lemma_as_forall :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.binders -> FStar_Syntax_Syntax.universe Prims.list)
      -> FStar_Syntax_Syntax.term)
  =
  fun t  ->
    fun universe_of_binders  ->
      let list_elements1 e =
        let uu____18789 = list_elements e  in
        match uu____18789 with
        | FStar_Pervasives_Native.Some l -> l
        | FStar_Pervasives_Native.None  ->
            (FStar_Errors.log_issue e.FStar_Syntax_Syntax.pos
               (FStar_Errors.Warning_NonListLiteralSMTPattern,
                 "SMT pattern is not a list literal; ignoring the pattern");
             [])
         in
      let one_pat p =
        let uu____18824 =
          let uu____18841 = unmeta p  in
          FStar_All.pipe_right uu____18841 head_and_args  in
        match uu____18824 with
        | (head,args) ->
            let uu____18892 =
              let uu____18907 =
                let uu____18908 = un_uinst head  in
                uu____18908.FStar_Syntax_Syntax.n  in
              (uu____18907, args)  in
            (match uu____18892 with
             | (FStar_Syntax_Syntax.Tm_fvar
                fv,(uu____18930,uu____18931)::arg::[]) when
                 FStar_Syntax_Syntax.fv_eq_lid fv
                   FStar_Parser_Const.smtpat_lid
                 -> arg
             | uu____18983 ->
                 let uu____18998 =
                   let uu____19004 =
                     let uu____19006 = tts p  in
                     FStar_Util.format1
                       "Not an atomic SMT pattern: %s; patterns on lemmas must be a list of simple SMTPat's or a single SMTPatOr containing a list of lists of patterns"
                       uu____19006
                      in
                   (FStar_Errors.Error_IllSMTPat, uu____19004)  in
                 FStar_Errors.raise_error uu____18998
                   p.FStar_Syntax_Syntax.pos)
         in
      let lemma_pats p =
        let elts = list_elements1 p  in
        let smt_pat_or t1 =
          let uu____19049 =
            let uu____19066 = unmeta t1  in
            FStar_All.pipe_right uu____19066 head_and_args  in
          match uu____19049 with
          | (head,args) ->
              let uu____19113 =
                let uu____19128 =
                  let uu____19129 = un_uinst head  in
                  uu____19129.FStar_Syntax_Syntax.n  in
                (uu____19128, args)  in
              (match uu____19113 with
               | (FStar_Syntax_Syntax.Tm_fvar fv,(e,uu____19148)::[]) when
                   FStar_Syntax_Syntax.fv_eq_lid fv
                     FStar_Parser_Const.smtpatOr_lid
                   -> FStar_Pervasives_Native.Some e
               | uu____19185 -> FStar_Pervasives_Native.None)
           in
        match elts with
        | t1::[] ->
            let uu____19215 = smt_pat_or t1  in
            (match uu____19215 with
             | FStar_Pervasives_Native.Some e ->
                 let uu____19237 = list_elements1 e  in
                 FStar_All.pipe_right uu____19237
                   (FStar_List.map
                      (fun branch1  ->
                         let uu____19267 = list_elements1 branch1  in
                         FStar_All.pipe_right uu____19267
                           (FStar_List.map one_pat)))
             | uu____19296 ->
                 let uu____19301 =
                   FStar_All.pipe_right elts (FStar_List.map one_pat)  in
                 [uu____19301])
        | uu____19356 ->
            let uu____19359 =
              FStar_All.pipe_right elts (FStar_List.map one_pat)  in
            [uu____19359]
         in
      let uu____19414 =
        let uu____19445 =
          let uu____19446 = FStar_Syntax_Subst.compress t  in
          uu____19446.FStar_Syntax_Syntax.n  in
        match uu____19445 with
        | FStar_Syntax_Syntax.Tm_arrow (binders,c) ->
            let uu____19501 = FStar_Syntax_Subst.open_comp binders c  in
            (match uu____19501 with
             | (binders1,c1) ->
                 (match c1.FStar_Syntax_Syntax.n with
                  | FStar_Syntax_Syntax.Comp
                      { FStar_Syntax_Syntax.comp_univs = uu____19568;
                        FStar_Syntax_Syntax.effect_name = uu____19569;
                        FStar_Syntax_Syntax.result_typ = uu____19570;
                        FStar_Syntax_Syntax.effect_args =
                          (pre,uu____19572)::(post,uu____19574)::(pats,uu____19576)::[];
                        FStar_Syntax_Syntax.flags = uu____19577;_}
                      ->
                      let uu____19638 = lemma_pats pats  in
                      (binders1, pre, post, uu____19638)
                  | uu____19673 -> failwith "impos"))
        | uu____19705 -> failwith "Impos"  in
      match uu____19414 with
      | (binders,pre,post,patterns) ->
          let post1 = unthunk_lemma_post post  in
          let body =
            let uu____19789 =
              let uu____19796 =
                let uu____19797 =
                  let uu____19804 = mk_imp pre post1  in
                  let uu____19807 =
                    let uu____19808 =
                      let uu____19829 =
                        FStar_Syntax_Syntax.binders_to_names binders  in
                      (uu____19829, patterns)  in
                    FStar_Syntax_Syntax.Meta_pattern uu____19808  in
                  (uu____19804, uu____19807)  in
                FStar_Syntax_Syntax.Tm_meta uu____19797  in
              FStar_Syntax_Syntax.mk uu____19796  in
            uu____19789 FStar_Pervasives_Native.None
              t.FStar_Syntax_Syntax.pos
             in
          let quant =
            let uu____19853 = universe_of_binders binders  in
            FStar_List.fold_right2
              (fun b  ->
                 fun u  ->
                   fun out  ->
                     mk_forall u (FStar_Pervasives_Native.fst b) out) binders
              uu____19853 body
             in
          quant
  
let (eff_decl_of_new_effect :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.eff_decl) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_new_effect ne -> ne
    | uu____19883 -> failwith "eff_decl_of_new_effect: not a Sig_new_effect"
  
let (is_layered : FStar_Syntax_Syntax.eff_decl -> Prims.bool) =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Layered_eff uu____19894 -> true
    | uu____19896 -> false
  
let (is_dm4f : FStar_Syntax_Syntax.eff_decl -> Prims.bool) =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.DM4F_eff uu____19907 -> true
    | uu____19909 -> false
  
let (apply_wp_eff_combinators :
  (FStar_Syntax_Syntax.tscheme -> FStar_Syntax_Syntax.tscheme) ->
    FStar_Syntax_Syntax.wp_eff_combinators ->
      FStar_Syntax_Syntax.wp_eff_combinators)
  =
  fun f  ->
    fun combs  ->
      let uu____19927 = f combs.FStar_Syntax_Syntax.ret_wp  in
      let uu____19928 = f combs.FStar_Syntax_Syntax.bind_wp  in
      let uu____19929 = f combs.FStar_Syntax_Syntax.stronger  in
      let uu____19930 = f combs.FStar_Syntax_Syntax.if_then_else  in
      let uu____19931 = f combs.FStar_Syntax_Syntax.ite_wp  in
      let uu____19932 = f combs.FStar_Syntax_Syntax.close_wp  in
      let uu____19933 = f combs.FStar_Syntax_Syntax.trivial  in
      let uu____19934 =
        FStar_Util.map_option f combs.FStar_Syntax_Syntax.repr  in
      let uu____19937 =
        FStar_Util.map_option f combs.FStar_Syntax_Syntax.return_repr  in
      let uu____19940 =
        FStar_Util.map_option f combs.FStar_Syntax_Syntax.bind_repr  in
      {
        FStar_Syntax_Syntax.ret_wp = uu____19927;
        FStar_Syntax_Syntax.bind_wp = uu____19928;
        FStar_Syntax_Syntax.stronger = uu____19929;
        FStar_Syntax_Syntax.if_then_else = uu____19930;
        FStar_Syntax_Syntax.ite_wp = uu____19931;
        FStar_Syntax_Syntax.close_wp = uu____19932;
        FStar_Syntax_Syntax.trivial = uu____19933;
        FStar_Syntax_Syntax.repr = uu____19934;
        FStar_Syntax_Syntax.return_repr = uu____19937;
        FStar_Syntax_Syntax.bind_repr = uu____19940
      }
  
let (apply_layered_eff_combinators :
  (FStar_Syntax_Syntax.tscheme -> FStar_Syntax_Syntax.tscheme) ->
    FStar_Syntax_Syntax.layered_eff_combinators ->
      FStar_Syntax_Syntax.layered_eff_combinators)
  =
  fun f  ->
    fun combs  ->
      let map_tuple uu____19972 =
        match uu____19972 with
        | (ts1,ts2) ->
            let uu____19983 = f ts1  in
            let uu____19984 = f ts2  in (uu____19983, uu____19984)
         in
      let uu____19985 = map_tuple combs.FStar_Syntax_Syntax.l_repr  in
      let uu____19990 = map_tuple combs.FStar_Syntax_Syntax.l_return  in
      let uu____19995 = map_tuple combs.FStar_Syntax_Syntax.l_bind  in
      let uu____20000 = map_tuple combs.FStar_Syntax_Syntax.l_subcomp  in
      let uu____20005 = map_tuple combs.FStar_Syntax_Syntax.l_if_then_else
         in
      {
        FStar_Syntax_Syntax.l_base_effect =
          (combs.FStar_Syntax_Syntax.l_base_effect);
        FStar_Syntax_Syntax.l_repr = uu____19985;
        FStar_Syntax_Syntax.l_return = uu____19990;
        FStar_Syntax_Syntax.l_bind = uu____19995;
        FStar_Syntax_Syntax.l_subcomp = uu____20000;
        FStar_Syntax_Syntax.l_if_then_else = uu____20005
      }
  
let (apply_eff_combinators :
  (FStar_Syntax_Syntax.tscheme -> FStar_Syntax_Syntax.tscheme) ->
    FStar_Syntax_Syntax.eff_combinators ->
      FStar_Syntax_Syntax.eff_combinators)
  =
  fun f  ->
    fun combs  ->
      match combs with
      | FStar_Syntax_Syntax.Primitive_eff combs1 ->
          let uu____20027 = apply_wp_eff_combinators f combs1  in
          FStar_Syntax_Syntax.Primitive_eff uu____20027
      | FStar_Syntax_Syntax.DM4F_eff combs1 ->
          let uu____20029 = apply_wp_eff_combinators f combs1  in
          FStar_Syntax_Syntax.DM4F_eff uu____20029
      | FStar_Syntax_Syntax.Layered_eff combs1 ->
          let uu____20031 = apply_layered_eff_combinators f combs1  in
          FStar_Syntax_Syntax.Layered_eff uu____20031
  
let (get_wp_close_combinator :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        FStar_Pervasives_Native.Some (combs.FStar_Syntax_Syntax.close_wp)
    | FStar_Syntax_Syntax.DM4F_eff combs ->
        FStar_Pervasives_Native.Some (combs.FStar_Syntax_Syntax.close_wp)
    | uu____20046 -> FStar_Pervasives_Native.None
  
let (get_eff_repr :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        combs.FStar_Syntax_Syntax.repr
    | FStar_Syntax_Syntax.DM4F_eff combs -> combs.FStar_Syntax_Syntax.repr
    | FStar_Syntax_Syntax.Layered_eff combs ->
        let uu____20060 =
          FStar_All.pipe_right combs.FStar_Syntax_Syntax.l_repr
            FStar_Pervasives_Native.fst
           in
        FStar_All.pipe_right uu____20060
          (fun uu____20067  -> FStar_Pervasives_Native.Some uu____20067)
  
let (get_bind_vc_combinator :
  FStar_Syntax_Syntax.eff_decl -> FStar_Syntax_Syntax.tscheme) =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        combs.FStar_Syntax_Syntax.bind_wp
    | FStar_Syntax_Syntax.DM4F_eff combs -> combs.FStar_Syntax_Syntax.bind_wp
    | FStar_Syntax_Syntax.Layered_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.l_bind
          FStar_Pervasives_Native.snd
  
let (get_return_vc_combinator :
  FStar_Syntax_Syntax.eff_decl -> FStar_Syntax_Syntax.tscheme) =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        combs.FStar_Syntax_Syntax.ret_wp
    | FStar_Syntax_Syntax.DM4F_eff combs -> combs.FStar_Syntax_Syntax.ret_wp
    | FStar_Syntax_Syntax.Layered_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.l_return
          FStar_Pervasives_Native.snd
  
let (get_bind_repr :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        combs.FStar_Syntax_Syntax.bind_repr
    | FStar_Syntax_Syntax.DM4F_eff combs ->
        combs.FStar_Syntax_Syntax.bind_repr
    | FStar_Syntax_Syntax.Layered_eff combs ->
        let uu____20107 =
          FStar_All.pipe_right combs.FStar_Syntax_Syntax.l_bind
            FStar_Pervasives_Native.fst
           in
        FStar_All.pipe_right uu____20107
          (fun uu____20114  -> FStar_Pervasives_Native.Some uu____20114)
  
let (get_return_repr :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        combs.FStar_Syntax_Syntax.return_repr
    | FStar_Syntax_Syntax.DM4F_eff combs ->
        combs.FStar_Syntax_Syntax.return_repr
    | FStar_Syntax_Syntax.Layered_eff combs ->
        let uu____20128 =
          FStar_All.pipe_right combs.FStar_Syntax_Syntax.l_return
            FStar_Pervasives_Native.fst
           in
        FStar_All.pipe_right uu____20128
          (fun uu____20135  -> FStar_Pervasives_Native.Some uu____20135)
  
let (get_wp_trivial_combinator :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.trivial
          (fun uu____20149  -> FStar_Pervasives_Native.Some uu____20149)
    | FStar_Syntax_Syntax.DM4F_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.trivial
          (fun uu____20153  -> FStar_Pervasives_Native.Some uu____20153)
    | uu____20154 -> FStar_Pervasives_Native.None
  
let (get_layered_if_then_else_combinator :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Layered_eff combs ->
        let uu____20166 =
          FStar_All.pipe_right combs.FStar_Syntax_Syntax.l_if_then_else
            FStar_Pervasives_Native.fst
           in
        FStar_All.pipe_right uu____20166
          (fun uu____20173  -> FStar_Pervasives_Native.Some uu____20173)
    | uu____20174 -> FStar_Pervasives_Native.None
  
let (get_wp_if_then_else_combinator :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.if_then_else
          (fun uu____20188  -> FStar_Pervasives_Native.Some uu____20188)
    | FStar_Syntax_Syntax.DM4F_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.if_then_else
          (fun uu____20192  -> FStar_Pervasives_Native.Some uu____20192)
    | uu____20193 -> FStar_Pervasives_Native.None
  
let (get_wp_ite_combinator :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.ite_wp
          (fun uu____20207  -> FStar_Pervasives_Native.Some uu____20207)
    | FStar_Syntax_Syntax.DM4F_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.ite_wp
          (fun uu____20211  -> FStar_Pervasives_Native.Some uu____20211)
    | uu____20212 -> FStar_Pervasives_Native.None
  
let (get_stronger_vc_combinator :
  FStar_Syntax_Syntax.eff_decl -> FStar_Syntax_Syntax.tscheme) =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff combs ->
        combs.FStar_Syntax_Syntax.stronger
    | FStar_Syntax_Syntax.DM4F_eff combs ->
        combs.FStar_Syntax_Syntax.stronger
    | FStar_Syntax_Syntax.Layered_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.l_subcomp
          FStar_Pervasives_Native.snd
  
let (get_stronger_repr :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Primitive_eff uu____20236 ->
        FStar_Pervasives_Native.None
    | FStar_Syntax_Syntax.DM4F_eff uu____20237 ->
        FStar_Pervasives_Native.None
    | FStar_Syntax_Syntax.Layered_eff combs ->
        let uu____20239 =
          FStar_All.pipe_right combs.FStar_Syntax_Syntax.l_subcomp
            FStar_Pervasives_Native.fst
           in
        FStar_All.pipe_right uu____20239
          (fun uu____20246  -> FStar_Pervasives_Native.Some uu____20246)
  
let (get_layered_effect_base :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Ident.lident FStar_Pervasives_Native.option)
  =
  fun ed  ->
    match ed.FStar_Syntax_Syntax.combinators with
    | FStar_Syntax_Syntax.Layered_eff combs ->
        FStar_All.pipe_right combs.FStar_Syntax_Syntax.l_base_effect
          (fun uu____20260  -> FStar_Pervasives_Native.Some uu____20260)
    | uu____20261 -> FStar_Pervasives_Native.None
  