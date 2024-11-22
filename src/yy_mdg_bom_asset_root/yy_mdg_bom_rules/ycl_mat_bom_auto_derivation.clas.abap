class YCL_MAT_BOM_AUTO_DERIVATION definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE2 .
protected section.
private section.
ENDCLASS.



CLASS YCL_MAT_BOM_AUTO_DERIVATION IMPLEMENTATION.


  METHOD if_ex_usmd_rule_service2~derive.
*   IF sy-uname = 'ASWARUP'.
    "Data Declaration
    DATA: lv_ybomitm_ins TYPE REF TO data.
    DATA: lv_ybomitm_del TYPE REF TO data.
    DATA: lv_ybomhdr_ins TYPE REF TO data.
    DATA: lv_zzplko_mod  TYPE REF TO data.
    FIELD-SYMBOLS: <lfs_t_data_ins> TYPE SORTED TABLE.
    FIELD-SYMBOLS: <lfs_t_data_del> TYPE SORTED TABLE.
    FIELD-SYMBOLS: <lfs_lt_entity> TYPE INDEX TABLE,
                   <lfs_lw_entity> TYPE any.
    FIELD-SYMBOLS: <lfs_lt_material> TYPE INDEX TABLE,
                   <lfs_lw_material> TYPE any.
    DATA: lr_matnr TYPE RANGE OF idnrk,
          ls_matnr LIKE LINE OF lr_matnr.
    DATA: lr_itemno TYPE RANGE OF sposn,
          ls_itemno LIKE LINE OF lr_itemno.
    DATA: lr_stpoz TYPE RANGE OF cim_count,
          ls_stpoz LIKE LINE OF lr_stpoz.
    DATA: lv_itemnumber TYPE n LENGTH 4.
    DATA: lv_counter TYPE n LENGTH 8.
    DATA: lt_ybomitm_del TYPE TABLE OF ymdgm_ybomitm_s,
          lt_ybomitm_ins TYPE TABLE OF ymdgm_ybomitm_s,
          lt_ybomitm_upd TYPE TABLE OF ymdgm_ybomitm_s,
          ls_ybomitm     TYPE ymdgm_ybomitm_s.
    DATA: it_data_entity TYPE usmd_ts_data_entity,
          lw_data_entity LIKE LINE OF it_data_entity.
    TYPES: BEGIN OF ls_makt,
             matnr TYPE matnr,
             spras TYPE spras,
             maktx TYPE maktx,
             maktg TYPE maktg,
           END OF ls_makt.
    DATA : lt_makt TYPE TABLE OF ls_makt.
    DATA : lw_makt TYPE ls_makt.

    TYPES: BEGIN OF ls_ex_ybomitm,
             matnr TYPE matnr,
             werks TYPE werks_d,
             idnrk TYPE matnr,
             stlkn TYPE stlkn,
             stalt TYPE stalt, "test
           END OF ls_ex_ybomitm.
    DATA: lt_ex_ybomitm TYPE TABLE OF ls_ex_ybomitm,
          lw_ex_ybomitm LIKE LINE OF lt_ex_ybomitm.

    TYPES: BEGIN OF ls_zzplko,
             matnr   TYPE matnr,
             werks   TYPE werks_d,
             zzaehl  TYPE cim_count,
             zzplnal TYPE plnal,
             zzplnnr TYPE plnnr,
           END OF ls_zzplko.
    DATA: lt_zzplko TYPE TABLE OF ls_zzplko,
          lw_zzplko LIKE LINE OF lt_zzplko.

    DATA: lv_idnrk    TYPE matnr,
          lv_matnr    TYPE matnr,
          lv_werks    TYPE werks_d,
          lv_stlkn    TYPE stlkn,
          lv_stalt    TYPE stalt,
          lv_labor    TYPE labor,
          lv_groes    TYPE groes,
          lv_meins    TYPE meins,
          lv_material TYPE matnr.

    TYPES: BEGIN OF ls_mara,
             matnr TYPE matnr,
             meins TYPE meins,
           END OF ls_mara.
    DATA: lt_mara TYPE TABLE OF ls_mara,
          lw_mara TYPE ls_mara.

    DATA: lt_changed_field TYPE usmd_ts_fieldname,
          ls_changed_field LIKE LINE OF lt_changed_field.

    DATA: lt_changed_ent TYPE usmd_t_entity,
          ls_changed_ent TYPE usmd_entity,
          lt_entity_del	 TYPE	usmd_ts_entity_struct,
          lt_entity_mod	 TYPE	usmd_ts_entity_struct.

*    CLEAR mv_run.
    DATA:  lv_crequest   TYPE usmd_crequest. "change request

    DATA(lo_context) = cl_usmd_app_context=>get_context( ).

    CHECK lo_context IS BOUND.
    CHECK lo_context IS NOT INITIAL.

    lv_crequest = lo_context->mv_crequest_id.

    CHECK lv_crequest <> '000000000000'.
*    IF sy-uname = 'ASWARUP'.
    "Get existing data
    CALL METHOD io_model->read_entity_data_all
      EXPORTING
        i_fieldname    = 'MATERIAL'             " Financial MDM: Field Name
        if_active      = abap_false             " Financial MDM: General Indicator
        i_crequest     = lv_crequest             " Change Request
*       it_sel         =                  " Sorted Table: Selection Condition (Range per Field)
*       it_entity_filter =                  " Ent.Types for Which Data Is Expected; Default: All Ent.Types
      IMPORTING
*       et_message     =                  " Messages
        et_data_entity = it_data_entity.               " Data for Entity Types

    READ TABLE it_data_entity INTO lw_data_entity WITH KEY usmd_entity_cont = 'YBOMITM'.
    IF sy-subrc = 0.
      ASSIGN lw_data_entity-r_t_data->* TO <lfs_lt_entity>.
      IF <lfs_lt_entity> IS ASSIGNED.
        LOOP AT <lfs_lt_entity> ASSIGNING <lfs_lw_entity>.
          CLEAR: lw_ex_ybomitm.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_lw_entity> TO FIELD-SYMBOL(<lfs_material_ex>).
          IF <lfs_material_ex> IS ASSIGNED.
            lw_ex_ybomitm-matnr = <lfs_material_ex>.
          ENDIF.
          ASSIGN COMPONENT 'WERKS' OF STRUCTURE <lfs_lw_entity> TO FIELD-SYMBOL(<lfs_werks_ex>).
          IF <lfs_werks_ex> IS ASSIGNED.
            lw_ex_ybomitm-werks = <lfs_werks_ex>.
          ENDIF.
          ASSIGN COMPONENT 'YYITMCOMP' OF STRUCTURE <lfs_lw_entity> TO FIELD-SYMBOL(<lfs_yyitmcomp_ex>).
          IF <lfs_yyitmcomp_ex> IS ASSIGNED.
            lw_ex_ybomitm-idnrk = <lfs_yyitmcomp_ex>.
          ENDIF.
          ASSIGN COMPONENT 'YITEMID' OF STRUCTURE <lfs_lw_entity> TO FIELD-SYMBOL(<lfs_yitemid_ex>).
          IF <lfs_yitemid_ex> IS ASSIGNED.
            lw_ex_ybomitm-stlkn = <lfs_yitemid_ex>.
          ENDIF.
          ASSIGN COMPONENT 'YSTALT' OF STRUCTURE <lfs_lw_entity> TO FIELD-SYMBOL(<lfs_ystalt_ex>).
          IF <lfs_ystalt_ex> IS ASSIGNED.
            lw_ex_ybomitm-stalt = <lfs_ystalt_ex>.
          ENDIF.
          APPEND lw_ex_ybomitm TO lt_ex_ybomitm.

        ENDLOOP.
      ENDIF.
    ENDIF.

*    ENDIF.
    READ TABLE it_data_entity INTO lw_data_entity WITH KEY usmd_entity = 'MATERIAL' struct = 'KATTR'.
    IF sy-subrc = 0.
      ASSIGN lw_data_entity-r_t_data->* TO <lfs_lt_material>.
      IF <lfs_lt_material> IS ASSIGNED.
        LOOP AT <lfs_lt_material> ASSIGNING <lfs_lw_material>.
          ASSIGN COMPONENT 'LABOR' OF STRUCTURE <lfs_lw_material> TO FIELD-SYMBOL(<lfs_labor_ex>).
          IF <lfs_labor_ex> IS ASSIGNED.
            lv_labor = <lfs_labor_ex>.
          ENDIF.
          ASSIGN COMPONENT 'GROES' OF STRUCTURE <lfs_lw_material> TO FIELD-SYMBOL(<lfs_groes_ex>).
          IF <lfs_groes_ex> IS ASSIGNED.
            lv_groes = <lfs_groes_ex>.
          ENDIF.
          ASSIGN COMPONENT 'MEINS' OF STRUCTURE <lfs_lw_material> TO FIELD-SYMBOL(<lfs_meins_ex>).
          IF <lfs_meins_ex> IS ASSIGNED.
            lv_meins = <lfs_meins_ex>.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
    SORT lr_itemno BY low DESCENDING.
**    SORT lr_stpoz  BY low DESCENDING.

*** Start of Code Changes for Recipe Master - Mbera***

    IF sy-uname = 'PBITLING' OR sy-uname = 'MBERA'.

      READ TABLE it_data_entity INTO lw_data_entity WITH KEY usmd_entity = 'MATERIAL' usmd_entity_cont = 'MARCBASIC' struct = 'KATTR'.
      IF sy-subrc = 0.
        ASSIGN lw_data_entity-r_t_data->* TO <lfs_lt_entity>.
        IF <lfs_lt_entity> IS ASSIGNED.
          LOOP AT <lfs_lt_entity> ASSIGNING <lfs_lw_entity>.
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_lw_entity> TO <lfs_material_ex>.
            IF <lfs_material_ex> IS ASSIGNED.
              lw_zzplko-matnr = <lfs_material_ex>.
            ENDIF.
            ASSIGN COMPONENT 'WERKS' OF STRUCTURE <lfs_lw_entity> TO <lfs_werks_ex>.
            IF <lfs_werks_ex> IS ASSIGNED.
              lw_zzplko-werks = <lfs_werks_ex>.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.

    ENDIF.
*** End of Code Changes for Recipe Master - Mbera***

    CALL METHOD io_changed_data->get_entity_types
      IMPORTING
        et_entity     = lt_changed_ent
        et_entity_del = lt_entity_del
        et_entity_mod = lt_entity_mod.

    CHECK lt_changed_ent IS NOT INITIAL.

    LOOP AT lt_changed_ent INTO ls_changed_ent.
      CASE ls_changed_ent.
        WHEN 'YBOMITM'.
          CALL METHOD io_changed_data->read_data
            EXPORTING
              i_entity      = 'YBOMITM'                                     " Entity Type
*             i_struct      = if_usmd_model_ext=>gc_struct_key_attr " Type of Data Structure
            IMPORTING
*             er_t_data_ins = lv_ybomitm_ins                                  " Newly Added Data Records
*             er_t_data_upd = lv_ybomitm_ins                                " Data Records Changed
              er_t_data_del = lv_ybomitm_del                                " Data Records Deleted
              er_t_data_mod = lv_ybomitm_ins                                  " "Modified" Data Records (INSERT+UPDATE)
*             ef_t_data_upd_complete =                                       " Unchanged Attributes Are Also Filled
            .
          ASSIGN lv_ybomitm_ins->* TO <lfs_t_data_ins>.
          IF <lfs_t_data_ins> IS ASSIGNED.
            LOOP AT <lfs_t_data_ins> ASSIGNING FIELD-SYMBOL(<lfs_ybomitm>).
              ASSIGN COMPONENT 'YYITMCOMP' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_yyitmcomp>).
              IF <lfs_yyitmcomp> IS ASSIGNED AND <lfs_yyitmcomp> IS NOT INITIAL.
                ls_matnr-sign = 'I'.
                ls_matnr-option = 'EQ'.
                ls_matnr-low = <lfs_yyitmcomp>.
*                lv_idnrk = <lfs_yyitmcomp>.
                APPEND ls_matnr TO lr_matnr.
                DATA(lv_lr_matnr_has_value) = abap_true.
              ENDIF.

            ENDLOOP.
          ENDIF.
          ASSIGN lv_ybomitm_del->* TO  <lfs_t_data_del>.
          IF <lfs_t_data_del> IS ASSIGNED.
            io_write_data->delete_data(
              EXPORTING
                i_entity = 'YBOMITM'                 " Entity Type
*                it_key   =                  " A Fixed (Partial) Key
                it_data  =   <lfs_t_data_del> " Key to be Deleted
            ).
*CATCH cx_usmd_write_error. " Error while writing to buffer
          ENDIF.


          IF lv_lr_matnr_has_value = abap_true.
            SELECT matnr
                   spras
                   maktx
                   maktg
                   FROM makt INTO TABLE lt_makt
                   FOR ALL ENTRIES IN lr_matnr
                   WHERE matnr = lr_matnr-low.
            IF sy-subrc EQ 0.
              DATA(lv_has_lt_makt) = abap_true.
            ENDIF.

            SELECT matnr
                   meins
                   FROM mara INTO TABLE lt_mara
                   FOR ALL ENTRIES IN lr_matnr
                   WHERE matnr = lr_matnr-low.
            IF sy-subrc EQ 0.
              DATA(lv_has_lt_mara) = abap_true.
            ENDIF.
          ENDIF.


*   IF sy-subrc EQ 0.
          IF <lfs_t_data_ins> IS ASSIGNED.
            LOOP AT <lfs_t_data_ins> ASSIGNING <lfs_ybomitm>.
              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_material>).
              IF <lfs_material> IS ASSIGNED.
                lv_matnr = <lfs_material>.
              ENDIF.
              ASSIGN COMPONENT 'WERKS' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_werks>).
              IF <lfs_werks> IS ASSIGNED.
                lv_werks = <lfs_werks>.
              ENDIF.
              ASSIGN COMPONENT 'YYITMCOMP' OF STRUCTURE <lfs_ybomitm> TO <lfs_yyitmcomp>.
              IF <lfs_yyitmcomp> IS ASSIGNED.
                lv_idnrk = <lfs_yyitmcomp>.
              ENDIF.
              ASSIGN COMPONENT 'YITEMID' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_yitemid>).
              IF <lfs_yitemid> IS ASSIGNED.
                lv_stlkn = <lfs_yitemid>.
              ENDIF.
              ASSIGN COMPONENT 'YSTALT' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_ystalt>).
              IF <lfs_ystalt> IS ASSIGNED.
                lv_stalt = <lfs_ystalt>.
              ENDIF.
              "Derivation will happen only for newly added item
*         IF NOT line_exists( lt_ex_ybomitm[ matnr = lv_matnr werks = lv_werks idnrk = lv_idnrk stlkn = lv_stlkn stalt = lv_stalt ] ).
              ASSIGN COMPONENT 'YYITMCOMP' OF STRUCTURE <lfs_ybomitm> TO <lfs_yyitmcomp>.
              IF <lfs_yyitmcomp> IS ASSIGNED.
                "Assigning the Component description
                IF lv_has_lt_makt = abap_true.
                  LOOP AT lt_makt INTO lw_makt.
                    IF lw_makt-matnr = <lfs_yyitmcomp>.
                      ASSIGN COMPONENT 'YYCOMPDES' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_yycompdes>).
                      IF <lfs_yycompdes> IS ASSIGNED.
                        <lfs_yycompdes> = lw_makt-maktx.
                      ENDIF.
                    ENDIF.
                  ENDLOOP.
                ENDIF.
                IF lv_has_lt_mara = abap_true.
                  "Assigning the Base UOM for Components
                  LOOP AT lt_mara INTO lw_mara.
                    IF lw_mara-matnr = <lfs_yyitmcomp>.
                      ASSIGN COMPONENT 'YYITMUOM' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_yyitmuom>).
                      IF <lfs_yyitmuom> IS ASSIGNED.
                        <lfs_yyitmuom> = lw_mara-meins.
                      ENDIF.
                    ENDIF.
                  ENDLOOP.
                ENDIF.
              ENDIF.
              "Assigning the Valid From as current system date
              ASSIGN COMPONENT 'YYIVLDFRM' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_yyivldfrm>).
              IF <lfs_yyivldfrm> IS ASSIGNED.
                <lfs_yyivldfrm> = sy-datum.
              ENDIF.
              "Assigning the Valid To date as infinity
              ASSIGN COMPONENT 'YYIVLDTO' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_yyivldto>).
              IF <lfs_yyivldto> IS ASSIGNED.
                <lfs_yyivldto> = '99991231'.
              ENDIF.
              "Deriving the Net ID as X if Opreration Scrap% is provided
              ASSIGN COMPONENT 'YYOPRSCRP' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_yyoprscrp>).
              IF <lfs_yyoprscrp> IS ASSIGNED.
                ASSIGN COMPONENT 'YYCOMPNET' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_yycompnet>).
                IF <lfs_yycompnet> IS ASSIGNED.
                  IF <lfs_yyoprscrp> IS NOT INITIAL.
                    <lfs_yycompnet> = abap_true.
                  ELSE.
                    <lfs_yycompnet> = abap_false.
                  ENDIF.
                  ASSIGN COMPONENT 'USMDX_S_UPDATE-YYCOMPNET' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_usmd_s_update_yycompnet>).
                  IF <lfs_usmd_s_update_yycompnet> IS  ASSIGNED.
                    <lfs_usmd_s_update_yycompnet> = abap_true.
                  ENDIF.
                ENDIF.
              ENDIF.
              ASSIGN COMPONENT 'YYPMASMLY' OF STRUCTURE <lfs_ybomitm> TO FIELD-SYMBOL(<lfs_yypmasmly>).
              IF <lfs_yypmasmly> IS ASSIGNED.
                SELECT SINGLE matnr FROM mast INTO @DATA(lw_matnr) WHERE matnr = @lv_idnrk.
                IF sy-subrc = 0.
                  <lfs_yypmasmly> = abap_true.
                ENDIF.
              ENDIF.

            ENDLOOP.
          ENDIF.

*    IF <lfs_t_data_del>  IS ASSIGNED.
*      LOOP AT <lfs_t_data_del> ASSIGNING <lfs_ybomitm>.
*
*      ENDLOOP.
*    ENDIF.


          "Writing the data back to the screen
          ls_changed_field = 'YYCOMPDES'.
          INSERT ls_changed_field INTO TABLE lt_changed_field.

          ls_changed_field = 'YYITMUOM'.
          INSERT ls_changed_field INTO TABLE lt_changed_field.

          ls_changed_field = 'YYIVLDFRM'.
          INSERT ls_changed_field INTO TABLE lt_changed_field.

          ls_changed_field = 'YYIVLDTO'.
          INSERT ls_changed_field INTO TABLE lt_changed_field.

          ls_changed_field = 'YYCOMPNET'.
          INSERT ls_changed_field INTO TABLE lt_changed_field.

          ls_changed_field = 'YYPMASMLY'.
          INSERT ls_changed_field INTO TABLE lt_changed_field.

          IF <lfs_t_data_ins> IS ASSIGNED.
            CALL METHOD io_write_data->write_data
              EXPORTING
                i_entity     = 'YBOMITM'              " Entity Type
*               it_key       =                 " Fixings
                it_attribute = lt_changed_field             " Financials MDM: Field Name
                it_data      = <lfs_t_data_ins>.
            .
*   CATCH cx_usmd_write_error. " Error while writing to buffer
          ENDIF.
        WHEN 'YBOMHDR'.
          CALL METHOD io_changed_data->read_data
            EXPORTING
              i_entity      = 'YBOMHDR'                                       " Entity Type
*             i_struct      = if_usmd_model_ext=>gc_struct_key_attr " Type of Data Structure
            IMPORTING
*             er_t_data_ins =                                       " Newly Added Data Records
*             er_t_data_upd =                                       " Data Records Changed
*             er_t_data_del =                                       " Data Records Deleted
              er_t_data_mod = lv_ybomhdr_ins                                     " "Modified" Data Records (INSERT+UPDATE)
*             ef_t_data_upd_complete =                                       " Unchanged Attributes Are Also Filled
            .
          ASSIGN lv_ybomhdr_ins->* TO <lfs_t_data_ins>.
          IF <lfs_t_data_ins> IS ASSIGNED.
            LOOP AT <lfs_t_data_ins> ASSIGNING FIELD-SYMBOL(<lfs_ybomhdr>).
              ASSIGN COMPONENT 'YYLABOFC' OF STRUCTURE <lfs_ybomhdr> TO FIELD-SYMBOL(<lfs_yylabofc>).
              IF <lfs_yylabofc> IS ASSIGNED.
                <lfs_yylabofc> = lv_labor.
              ENDIF.

              ASSIGN COMPONENT 'YYSIZDIM' OF STRUCTURE <lfs_ybomhdr> TO FIELD-SYMBOL(<lfs_yysizdim>).
              IF <lfs_yysizdim> IS ASSIGNED.
                <lfs_yysizdim> = lv_groes.
              ENDIF.

              ASSIGN COMPONENT 'YYBASEUOM' OF STRUCTURE <lfs_ybomhdr> TO FIELD-SYMBOL(<lfs_yybaseuom>).
              IF <lfs_yybaseuom> IS ASSIGNED.
                <lfs_yybaseuom> = lv_meins.
              ENDIF.
            ENDLOOP.

            "Writing the data to the screen
            ls_changed_field = 'YYLABOFC'.
            INSERT ls_changed_field INTO TABLE lt_changed_field.

            ls_changed_field = 'YYSIZDIM'.
            INSERT ls_changed_field INTO TABLE lt_changed_field.

            ls_changed_field = 'YYBASEUOM'.
            INSERT ls_changed_field INTO TABLE lt_changed_field.

            CALL METHOD io_write_data->write_data
              EXPORTING
                i_entity     = 'YBOMHDR'             " Entity Type
*               it_key       =                  " Fixings
                it_attribute = lt_changed_field             " Financials MDM: Field Name
                it_data      = <lfs_t_data_ins>.
*            CATCH cx_usmd_write_error. " Error while writing to buffer


          ENDIF.
*** Start of Code changes for Recipe Master***
*        WHEN 'ZZPLKO'.
*          CALL METHOD io_changed_data->read_data
*            EXPORTING
*              i_entity      = 'ZZPLKO'                                       " Entity Type
**             i_struct      = if_usmd_model_ext=>gc_struct_key_attr " Type of Data Structure
*            IMPORTING
**             er_t_data_ins =                                       " Newly Added Data Records
**             er_t_data_upd =                                       " Data Records Changed
**             er_t_data_del =                                       " Data Records Deleted
*              er_t_data_mod = lv_zzplko_mod                   " "Modified" Data Records (INSERT+UPDATE)
**             ef_t_data_upd_complete =                                       " Unchanged Attributes Are Also Filled
*            .
*          ASSIGN lv_zzplko_mod->* TO <lfs_t_data_ins>.
*          IF <lfs_t_data_ins> IS ASSIGNED.
*            LOOP AT <lfs_t_data_ins> ASSIGNING FIELD-SYMBOL(<lfs_zzplko>).
*              ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_zzplko> TO FIELD-SYMBOL(<lfs_mat>).
**              IF <lfs_mat> IS ASSIGNED.
**                <lfs_mat> = lw_zzplko-matnr.
**                ls_changed_field = 'MATERIAL'.
**                INSERT ls_changed_field INTO TABLE lt_changed_field.
**              ENDIF.
*
*              ASSIGN COMPONENT 'WERKS' OF STRUCTURE <lfs_zzplko> TO <lfs_werks>.
*              IF <lfs_werks> IS ASSIGNED.
*                <lfs_werks> = lw_zzplko-werks.
*                ls_changed_field = 'WERKS'.
*                INSERT ls_changed_field INTO TABLE lt_changed_field.
*              ENDIF.
*
**              ASSIGN COMPONENT 'ZZPLNNR' OF STRUCTURE <lfs_zzplko> TO FIELD-SYMBOL(<lfs_plnnr>).
**              IF <lfs_plnnr> IS ASSIGNED.
**                <lfs_plnnr> = '$5404875'.
**                ls_changed_field = 'ZZPLNNR'.
**                INSERT ls_changed_field INTO TABLE lt_changed_field.
**              ENDIF.
**
**              ASSIGN COMPONENT 'ZZPLNAL' OF STRUCTURE <lfs_zzplko> TO FIELD-SYMBOL(<lfs_plnal>).
**              IF <lfs_plnal> IS ASSIGNED.
**                <lfs_plnal> = '1'. "Single Recipe Creation
**                ls_changed_field = 'ZZPLNAL'.
**                INSERT ls_changed_field INTO TABLE lt_changed_field.
**              ENDIF.
**
**              ASSIGN COMPONENT 'ZZPLNTY' OF STRUCTURE <lfs_zzplko> TO FIELD-SYMBOL(<lfs_pln>).
**              IF <lfs_pln> IS ASSIGNED.
**                <lfs_pln> = '2'. "Single Recipe Creation
**                ls_changed_field = 'ZZPLNTY'.
**                INSERT ls_changed_field INTO TABLE lt_changed_field.
**              ENDIF.
*            ENDLOOP.
*
*            CALL METHOD io_write_data->write_data
*              EXPORTING
*                i_entity     = 'ZZPLKO'             " Entity Type
**               it_key       =                  " Fixings
*                it_attribute = lt_changed_field             " Financials MDM: Field Name
*                it_data      = <lfs_t_data_ins>.
**            CATCH cx_usmd_write_error. " Error while writing to buffer
*
*          ENDIF.
*** End of Code changes for Recipe Master***
        WHEN OTHERS.

      ENDCASE.
    ENDLOOP.

    IF sy-uname = 'RAJGOPAL'.
      io_changed_data->read_data(
        EXPORTING
          i_entity               =  'YBOMHDR'                                          " Entity Type
          i_struct               = if_usmd_model_ext=>gc_struct_key_attr " Type of Data Structure
        IMPORTING
          er_t_data_ins          =  DATA(lt_ins)                                     " Newly Added Data Records
          er_t_data_upd          =  DATA(lt_upd)                                     " Data Records Changed
          er_t_data_del          =  DATA(lt_del)                                     " Data Records Deleted
          er_t_data_mod          =  DATA(lt_mod)                                     " "Modified" Data Records (INSERT+UPDATE)
          ef_t_data_upd_complete =  DATA(lt_comp)                                     " Unchanged Attributes Are Also Filled
      ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
