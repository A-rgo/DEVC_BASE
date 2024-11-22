class YCL_MAT_BOM_API_SEG_EXTN definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_MDG_BS_MAT_API_SEGMENTS_EXT .

  class-methods GET_BOMDATA
    importing
      !IS_SELECTION type MDG_BS_MAT_S_MAT_SELECTION
      !IV_FIELDNAME type FIELDNAME
    exporting
      !ET_DATA type ANY TABLE .
protected section.
private section.

  class-methods CHECK_BOM_DATA
    importing
      !IS_BOMHEADER type YMDGM_YBOMHDR_S
      !IT_BOMITEM type YMDGM_YBOMITM_T optional
    exporting
      !EV_EXIST type CHAR1
      !EV_ONLY_HEADER type CHAR1 .
  class-methods SAVE_BOM_DATA
    importing
      value(IS_BOMHEADER) type YMDGM_YBOMHDR_S optional
      !IT_HEADER type YMDGM_YBOMHDR_T optional
      !IV_EXIST type CHAR1 optional
      !IT_BOMITEM type YMDGM_YBOMITM_T optional
      !IT_BOMITEM_X type YMDGM_YBOMITM_T_X optional
    exporting
      !ET_MESSAGE type MDG_BS_MAT_T_MAT_MSG .
  class-methods GET_HEADERDATA
    changing
      !IS_BOMHEADER type YMDGM_YBOMHDR_S .
ENDCLASS.



CLASS YCL_MAT_BOM_API_SEG_EXTN IMPLEMENTATION.


  METHOD check_bom_data.

    CONSTANTS : lc_internal TYPE String VALUE 'INTERNAL'.
    CLEAR : ev_exist,ev_only_header.
    IF is_bomheader-stlnr NE lc_internal.

      SELECT SINGLE * FROM mast INTO @DATA(lw_mast) WHERE matnr = @is_bomheader-matnr
                                                      AND werks = @is_bomheader-werks
                                                      AND stlan = @is_bomheader-stlan
                                                      AND stlal = @is_bomheader-stlal.

      IF sy-subrc = 0.
        ev_exist = abap_true.
      ENDIF.

    ENDIF.

    IF NOT line_exists( it_bomitem[ matnr = is_bomheader-matnr werks = is_bomheader-werks
                               stlan = is_bomheader-stlan stlal = is_bomheader-stlal
                               stlty = is_bomheader-stlty ] ).
      ev_only_header = abap_true.
    ENDIF.


  ENDMETHOD.


  METHOD get_bomdata.
    "DATA : lt_stko TYPE TABLE OF stko.
    " DATA : lt_mast TYPE TABLE OF mast.
    TYPES: BEGIN OF ls_makt,
             matnr TYPE matnr,
             spras TYPE spras,
             maktx TYPE maktx,
             maktg TYPE maktg,
           END OF ls_makt.
    TYPES: BEGIN OF ls_stlnr,
             stlnr TYPE stnum,
           END OF ls_stlnr.
    DATA : lt_makt TYPE TABLE OF ls_makt.
    DATA : lw_makt TYPE ls_makt.
    DATA : it_bom_header TYPE ymdgm_ybomhdr_t.
    DATA : lw_bom_header TYPE ymdgm_ybomhdr_s.
    TYPES: BEGIN OF ls_stpo,
             stlty TYPE stlty,
             stlnr TYPE stnum,
             stlkn TYPE stlkn,
             idnrk TYPE idnrk,
           END OF ls_stpo.

    DATA: lt_stpo_tem TYPE TABLE OF ls_stpo.
    DATA: lw_stpo_temp TYPE ls_stpo.
    TYPES: BEGIN OF ls_mast,
             matnr TYPE matnr,
             werks TYPE werks_d,
             stlan TYPE stlan,
             stlnr TYPE stnum,
             stlal TYPE stalt,
           END OF ls_mast.

    DATA: lt_mast TYPE TABLE OF ls_mast.
    DATA: lw_mast TYPE ls_mast.
    DATA: lt_stko TYPE TABLE OF stko_api02.
    DATA: lt_stpo TYPE TABLE OF stpo_api02.
    DATA: lw_warning TYPE capiflag-flwarning.
    "  DATA: lt_stzu TYPE TABLE OF stzu.
    CONSTANTS: lc_m TYPE stlty VALUE 'M'.
    DATA : it_bom_item TYPE ymdgm_ybomitm_t.
    DATA : lw_bom_item TYPE ymdgm_ybomitm_s.
    DATA : lt_range_werks TYPE TABLE OF werks.
    DATA : lt_range_stlnr TYPE TABLE OF ls_stlnr.
    TYPES: BEGIN OF ls_mara,
             matnr TYPE matnr,
             labor TYPE labor,
             groes TYPE groes,
           END OF ls_mara.
    DATA: lt_mara TYPE TABLE OF ls_mara,
          lw_mara TYPE ls_mara.

    CLEAR : et_data.",et_message.

    CASE iv_fieldname.
      WHEN 'YMDGM_YBOMHDR_TAB'.
        IF is_selection-matnr_range IS NOT INITIAL." AND is_selection-werks_range IS NOT INITIAL.
          IF is_selection-werks_range IS NOT INITIAL.

            LOOP AT is_selection-werks_range INTO DATA(lw_werks).
              APPEND VALUE #( werks = lw_werks-low ) TO lt_range_werks.
            ENDLOOP.
          ELSE.
            SELECT werks FROM marc INTO TABLE lt_range_werks WHERE matnr IN is_selection-matnr_range.
            IF sy-subrc NE 0.
              RETURN.
            ENDIF.
          ENDIF.


          SELECT  matnr
                  werks
                  stlan
                  stlnr
                  stlal
                  FROM mast INTO TABLE lt_mast FOR ALL ENTRIES IN lt_range_werks
                  WHERE matnr IN is_selection-matnr_range
                  AND werks = lt_range_werks-werks.

          IF sy-subrc = 0.

            SORT : lt_mast.


            SELECT stlty,
                   stlnr,
                   stlan,
                   stlbe,
                   exstl,
                   ztext
                   FROM stzu INTO TABLE @DATA(lt_stzu)
                   FOR ALL ENTRIES IN @lt_mast
                   WHERE stlty = @lc_m
                   AND stlnr = @lt_mast-stlnr
                   AND stlan = @lt_mast-stlan.
            IF sy-subrc = 0.
              SORT lt_stzu BY stlty stlnr stlan.
            ENDIF.

            SELECT matnr
                   labor
                   groes
                   FROM mara INTO TABLE lt_mara
                   WHERE matnr IN is_selection-matnr_range.
            IF sy-subrc = 0.

            ENDIF.



            LOOP AT lt_mast INTO lw_mast.
              lw_bom_header-matnr = lw_mast-matnr.
              lw_bom_header-werks = lw_mast-werks.
              lw_bom_header-stlan = lw_mast-stlan.
              lw_bom_header-stlal = lw_mast-stlal.
              lw_bom_header-stlty = lc_m.


              CALL FUNCTION 'CSAP_MAT_BOM_READ'
                EXPORTING
                  material     = lw_bom_header-matnr
                  plant        = lw_bom_header-werks
                  bom_usage    = lw_bom_header-stlan
                  alternative  = lw_bom_header-stlal
*                 VALID_FROM   =
*                 VALID_TO     =
*                 CHANGE_NO    =
*                 REVISION_LEVEL       =
                  fl_doc_links = 'X'
*                 FL_DMU_TMX   =
                IMPORTING
                  fl_warning   = lw_warning
                TABLES
                  t_stpo       = lt_stpo
                  t_stko       = lt_stko
*                 T_DEP_DATA   =
*                 T_DEP_DESCR  =
*                 T_DEP_ORDER  =
*                 T_DEP_SOURCE =
*                 T_DEP_DOC    =
*                 T_DOC_LINK   =
*                 T_DMU_TMX    =
*                 T_LTX_LINE   =
*                 T_STPU       =
*                 T_FSH_BOMD   =
*                 T_SGT_BOMC   =
*           EXCEPTIONS
*                 ERROR        = 1
*                 OTHERS       = 2
                .
              IF sy-subrc <> 0.
* Implement suitable error handling here
              ENDIF.


              IF is_selection-stlal_range[] IS NOT INITIAL AND is_selection-stlnr_range IS NOT INITIAL
                 AND is_selection-stlan_range IS NOT INITIAL AND is_selection-stlty_range IS NOT INITIAL.
                DATA(lw_has_sel) = abap_true.
              ENDIF.

*            IF line_exists( is_selection-stlan_range[ low = space ] )
*              OR line_exists( is_selection-stlnr_range[ low = space ] )
*              OR line_exists( is_selection-stlal_range[ low = space ] ).
*
*              DATA(lw_has_nosel) = abap_true.
*            ENDIF.


              LOOP AT lt_stko INTO DATA(lw_stko).
                "MOVE-CORRESPONDING lw_stko TO lw_bom_header.
                IF is_selection-werks_range IS NOT INITIAL.
                  IF lw_has_sel = abap_true.

                    IF NOT line_exists( is_selection-stlan_range[ low = lw_bom_header-stlan ] )
                       OR NOT line_exists( is_selection-stlnr_range[ low = lw_stko-bom_no ] )
                       OR NOT line_exists( is_selection-stlal_range[ low = lw_bom_header-stlal ] ).
                      CONTINUE.
                    ENDIF.
                  ENDIF.
                ENDIF.

                lw_bom_header-stlnr = lw_stko-bom_no.
                lw_bom_header-stlst = lw_stko-bom_status.


*
*            REPLACE ALL OCCURRENCES OF ',' IN lw_stko-base_quan WITH '.'.
*            SHIFT lw_stko-base_quan LEFT DELETING LEADING space.
**                lw_bom_header-bmeng = lw_stko-base_quan. " by ANand
                CALL FUNCTION 'CONVERSION_EXIT_QNTY1_OUTPUT'
                  EXPORTING
                    input  = lw_stko-base_quan
                  IMPORTING
                    output = lw_bom_header-bmeng
                .

                " lw_bom_header-bmein = lw_stko-base_unit.
                CALL FUNCTION 'CONVERSION_EXIT_CUNIT_INPUT'
                  EXPORTING
                    input          = lw_stko-base_unit
                    language       = sy-langu
                  IMPORTING
                    output         = lw_bom_header-bmein
                  EXCEPTIONS
                    unit_not_found = 1
                    OTHERS         = 2.
                IF sy-subrc <> 0.
                  " Implement suitable error handling here
                ENDIF.

                lw_bom_header-alekz = lw_stko-ale_ind.
                lw_bom_header-cadkz = lw_stko-cad_ind.
                "Covert format of date Valid From
                CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
                  EXPORTING
                    date_external = lw_stko-valid_from              " external date formatting
*                   accept_initial_date      =                  " Single-Character Indicator
                  IMPORTING
                    date_internal = lw_stko-valid_from              " internal date formatting
*              EXCEPTIONS
*                   date_external_is_invalid = 1                " the external date is invalid (not plausible)
*                   others        = 2
                  .
                IF sy-subrc <> 0.
*             MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
                ENDIF.
                " Convert format of date for Valid To
                CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
                  EXPORTING
                    date_external = lw_stko-valid_to                " external date formatting
*                   accept_initial_date      =                  " Single-Character Indicator
                  IMPORTING
                    date_internal = lw_stko-valid_to               " internal date formatting
*              EXCEPTIONS
*                   date_external_is_invalid = 1                " the external date is invalid (not plausible)
*                   others        = 2
                  .
                IF sy-subrc <> 0.
*             MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
                ENDIF.
                lw_bom_header-datub = lw_stko-valid_to.
                lw_bom_header-datuv = lw_stko-valid_from.
                lw_bom_header-exstl = lw_stko-bom_group.
                lw_bom_header-labor = lw_stko-laboratory.
                lw_bom_header-lkenz = lw_stko-delete_ind.
                lw_bom_header-stlbe = lw_stko-auth_group.
                lw_bom_header-exstl = lw_stko-bom_group.
                lw_bom_header-ztext = lw_stko-bom_text.
                lw_bom_header-stktx = lw_stko-alt_text.
*            lw_bom_header-labor = '001'."test will be changing
*            lw_bom_header-groes =  '16*17*18'. "test will be changing



*              READ TABLE lt_stzu INTO DATA(Lw_stzu) WITH KEY stlty = lc_m
*                                                             stlnr = lw_bom_header-stlnr
*                                                             stlan = lw_bom_header-stlan
*                                                             BINARY SEARCH.
*              IF sy-subrc = 0.
*                lw_bom_header-stlbe = lw_stzu-stlbe.
*                lw_bom_header-exstl = lw_stzu-exstl.
*                lw_bom_header-ztext = lw_stzu-ztext.
*              ENDIF.
                LOOP AT lt_mara INTO lw_mara.
                  lw_bom_header-labor = lw_mara-labor.
                  lw_bom_header-groes = lw_mara-groes.
                ENDLOOP.

*            APPEND lw_bom_header TO it_bom_header.
                INSERT lw_bom_header INTO TABLE it_bom_header.
                CLEAR lw_stko.
              ENDLOOP.



              CLEAR : lt_stko, lw_bom_header.

            ENDLOOP.

            INSERT LINES OF it_bom_header INTO TABLE et_data.

          ENDIF.

        ENDIF.

        "Begining of Code to populate YBOMITM

      WHEN 'YMDGM_YBOMITM_TAB'.
        DATA: lt_ystlkn TYPE ystlkn_t_range,
              lw_ystlkn TYPE LINE OF ystlkn_t_range.


        IF is_selection-matnr_range IS NOT INITIAL.

          IF is_selection-werks_range IS NOT INITIAL.

            LOOP AT is_selection-werks_range INTO lw_werks.
              APPEND VALUE #( werks = lw_werks-low ) TO lt_range_werks.
            ENDLOOP.
          ELSE.
            SELECT werks FROM marc INTO TABLE lt_range_werks WHERE matnr IN is_selection-matnr_range.
            IF sy-subrc NE 0.
              RETURN.
            ENDIF.
          ENDIF.



          SELECT  matnr
                  werks
                  stlan
                  stlnr
                  stlal
                  FROM mast INTO TABLE lt_mast FOR ALL ENTRIES IN lt_range_werks
                  WHERE matnr IN is_selection-matnr_range
                  AND werks = lt_range_werks-werks
                  AND stlan IN is_selection-stlan_range
                  AND stlnr IN is_selection-stlnr_range
                  AND stlal IN is_selection-stlal_range.

          IF sy-subrc = 0.
            SORT: lt_mast.
            IF is_selection-stlnr_range IS INITIAL.
              SELECT stlnr
                     FROM mast INTO TABLE lt_range_stlnr FOR ALL ENTRIES IN lt_range_werks
                     WHERE matnr IN is_selection-matnr_range
                     AND werks = lt_range_werks-werks.
              IF sy-subrc = 0.
                SELECT stlty
                       stlnr
                       stlkn
                       idnrk
                       FROM stpo INTO TABLE lt_stpo_tem FOR ALL ENTRIES IN lt_range_stlnr
                       WHERE stlty EQ lc_m
                       AND stlnr = lt_range_stlnr-stlnr.
                "AND stlnr IN is_selection-stlnr_range.
                IF sy-subrc = 0.
                  SELECT matnr
                         spras
                         maktx
                         maktg
                         FROM makt INTO TABLE lt_makt
                         FOR ALL ENTRIES IN lt_stpo_tem
                         WHERE matnr EQ lt_stpo_tem-idnrk
                         AND spras EQ 'E'.
                  IF sy-subrc EQ 0.

                  ENDIF.
                ENDIF.

              ENDIF.
            ELSE.
              SELECT stlty
                     stlnr
                     stlkn
                     idnrk
                     FROM stpo INTO TABLE lt_stpo_tem
                     WHERE stlty EQ lc_m
*                 AND stlnr = lt_range_stlnr-stlnr.
                     AND stlnr IN is_selection-stlnr_range.
              IF sy-subrc = 0.
                SELECT matnr
                       spras
                       maktx
                       maktg
                       FROM makt INTO TABLE lt_makt
                       FOR ALL ENTRIES IN lt_stpo_tem
                       WHERE matnr EQ lt_stpo_tem-idnrk
                       AND spras EQ 'E'.
                IF sy-subrc EQ 0.

                ENDIF.
              ENDIF.

            ENDIF.
***          SELECT stlty
***                 stlnr
***                 stlkn
***                 idnrk
***                 FROM stpo INTO TABLE lt_stpo_tem FOR ALL ENTRIES IN lt_range_stlnr
***                 WHERE stlty EQ lc_m
***                 AND stlnr = lt_range_stlnr-stlnr.
***                 "AND stlnr IN is_selection-stlnr_range.
***            IF sy-subrc = 0.
***                 SELECT matnr
***                        spras
***                        maktx
***                        maktg
***                        FROM makt INTO TABLE lt_makt
***                        FOR ALL ENTRIES IN lt_stpo_tem
***                        WHERE matnr EQ lt_stpo_tem-idnrk
***                        AND spras EQ 'E'.
***                        IF sy-subrc EQ 0.
***
***                        ENDIF.
***            ENDIF.


            LOOP AT lt_mast INTO lw_mast.
              lw_bom_item-matnr = lw_mast-matnr.
              lw_bom_item-werks = lw_mast-werks.
              lw_bom_item-stlan = lw_mast-stlan.
              lw_bom_item-stlnr = lw_mast-stlnr.
              lw_bom_item-stlal = lw_mast-stlal.
              lw_bom_item-stlty = lc_m.

              CALL FUNCTION 'CSAP_MAT_BOM_READ'
                EXPORTING
                  material     = lw_bom_item-matnr
                  plant        = lw_bom_item-werks
                  bom_usage    = lw_bom_item-stlan
                  alternative  = lw_bom_item-stlal
*                 VALID_FROM   =
*                 VALID_TO     =
*                 CHANGE_NO    =
*                 REVISION_LEVEL       =
                  fl_doc_links = 'X'
*                 FL_DMU_TMX   =
                IMPORTING
                  fl_warning   = lw_warning
                TABLES
                  t_stpo       = lt_stpo
                  t_stko       = lt_stko
*                 T_DEP_DATA   =
*                 T_DEP_DESCR  =
*                 T_DEP_ORDER  =
*                 T_DEP_SOURCE =
*                 T_DEP_DOC    =
*                 T_DOC_LINK   =
*                 T_DMU_TMX    =
*                 T_LTX_LINE   =
*                 T_STPU       =
*                 T_FSH_BOMD   =
*                 T_SGT_BOMC   =
*            EXCEPTIONS
*                 ERROR        = 1
*                 OTHERS       = 2
                .
              IF sy-subrc <> 0.
* Implement suitable error handling here
              ENDIF.
              LOOP AT lt_stpo INTO DATA(lw_stpo).
                "MOVE-CORRESPONDING lw_stpo TO lw_bom_item.
                lw_bom_item-idnrk = lw_stpo-component.
                CALL FUNCTION 'CONVERSION_EXIT_MATN1_INPUT'
                  EXPORTING
                    input  = lw_bom_item-idnrk
                  IMPORTING
                    output = lw_bom_item-idnrk
*             EXCEPTIONS
*                   LENGTH_ERROR       = 1
*                   OTHERS = 2
                  .
                IF sy-subrc <> 0.
* Implement suitable error handling here
                ENDIF.


                lw_bom_item-stlkn = lw_stpo-item_node.
                lw_bom_item-stpoz = lw_stpo-item_count.
                lw_bom_item-menge = lw_stpo-comp_qty.
                lw_bom_item-alpgr = lw_stpo-ai_group.
                lw_bom_item-alprf = lw_stpo-ai_prio.
                lw_bom_item-alpst = lw_stpo-ai_strateg.
*            --------BOC: To resolve the dump- Anand---------
                "
**            "REPLACE ALL OCCURRENCES OF ',' IN lw_stpo-comp_scrap WITH '.'.
**            SHIFT lw_stpo-comp_scrap LEFT DELETING LEADING space.
**            lw_bom_item-ausch = lw_stpo-comp_scrap.
**            "REPLACE ALL OCCURRENCES OF ',' IN lw_stpo-op_scrap WITH '.'.
**            SHIFT lw_stpo-op_scrap LEFT DELETING LEADING space.
**            lw_bom_item-avoau = lw_stpo-op_scrap.
*            -----------EOC: to resolve the dump- Anand------------
                lw_bom_item-beikz = lw_stpo-mat_provis.
                lw_bom_item-class = lw_stpo-class.
                lw_bom_item-clmul = lw_stpo-mult_selec.
                lw_bom_item-clobk = lw_stpo-reqd_comp.
                CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
                  EXPORTING
                    date_external = lw_stpo-valid_to
*                   ACCEPT_INITIAL_DATE            =
                  IMPORTING
                    date_internal = lw_stpo-valid_to
*             EXCEPTIONS
*                   DATE_EXTERNAL_IS_INVALID       = 1
*                   OTHERS        = 2
                  .
                IF sy-subrc <> 0.
* Implement suitable error handling here
                ENDIF.

                CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
                  EXPORTING
                    date_external = lw_stpo-valid_from
*                   ACCEPT_INITIAL_DATE            =
                  IMPORTING
                    date_internal = lw_stpo-valid_from
*             EXCEPTIONS
*                   DATE_EXTERNAL_IS_INVALID       = 1
*                   OTHERS        = 2
                  .
                IF sy-subrc <> 0.
* Implement suitable error handling here
                ENDIF.


                lw_bom_item-datub = lw_stpo-valid_to. "Need to convert after this
                lw_bom_item-datuv = lw_stpo-valid_from. "Need to convert after this
                lw_bom_item-dspst = lw_stpo-expl_type.
                lw_bom_item-ekgrp = lw_stpo-purch_grp.
                lw_bom_item-ekorg = lw_stpo-purch_org.
                lw_bom_item-erskz = lw_stpo-spare_part.
                lw_bom_item-ewahr = lw_stpo-usage_prob.
                lw_bom_item-fmeng = lw_stpo-fixed_qty.
                lw_bom_item-kzclb = lw_stpo-sel_cond.
                lw_bom_item-kzkup = lw_stpo-co_product.
                lw_bom_item-lifnr = lw_stpo-vendor.
                lw_bom_item-lifzt = lw_stpo-deliv_time.
                lw_bom_item-matkl = lw_stpo-mat_group.
                lw_bom_item-meins = lw_stpo-comp_unit.

                CALL FUNCTION 'CONVERSION_EXIT_CUNIT_INPUT'
                  EXPORTING
                    input          = lw_stpo-comp_unit
                    language       = sy-langu
                  IMPORTING
                    output         = lw_bom_item-meins
                  EXCEPTIONS
                    unit_not_found = 1
                    OTHERS         = 2.
                IF sy-subrc <> 0.
                  "Implement suitable error handling here
                ENDIF.


                lw_bom_item-netau = lw_stpo-op_net_ind.
                lw_bom_item-nfeag = lw_stpo-discon_grp.
                lw_bom_item-nfgrp = lw_stpo-follow_grp.
                lw_bom_item-nlfmv = lw_stpo-op_lt_unit.
                lw_bom_item-nlfzt = lw_stpo-op_lead_tm.
                lw_bom_item-peinh = lw_stpo-price_unit.
                lw_bom_item-posnr = lw_stpo-item_no.
                lw_bom_item-postp = lw_stpo-item_categ.
                lw_bom_item-potx1 = lw_stpo-item_text1.
                lw_bom_item-potx2 = lw_stpo-item_text2.


**            "REPLACE ALL OCCURRENCES OF ',' IN lw_stpo-price WITH '.'.
**            SHIFT lw_stpo-price LEFT DELETING LEADING space.
**            lw_bom_item-preis = lw_stpo-price.

                lw_bom_item-rekrs = lw_stpo-rec_allowd.
                lw_bom_item-rform = lw_stpo-vsi_formul.
                "REPLACE ALL OCCURRENCES OF ',' IN lw_stpo-vsi_no WITH '.'.
**            SHIFT lw_stpo-vsi_no LEFT DELETING LEADING space.
**
**            lw_bom_item-roanz = lw_stpo-vsi_no.
                lw_bom_item-romei = lw_stpo-vsi_szunit.

                CALL FUNCTION 'CONVERSION_EXIT_CUNIT_INPUT'
                  EXPORTING
                    input          = lw_stpo-vsi_szunit
                    language       = sy-langu
                  IMPORTING
                    output         = lw_bom_item-romei
                  EXCEPTIONS
                    unit_not_found = 1
                    OTHERS         = 2.
                IF sy-subrc <> 0.
                  "Implement suitable error handling here
                ENDIF.


**            "REPLACE ALL OCCURRENCES OF ',' IN lw_stpo-vsi_qty WITH '.'.
**            SHIFT lw_stpo-vsi_qty LEFT DELETING LEADING space.
**            lw_bom_item-romen = lw_stpo-vsi_qty.

**            "REPLACE ALL OCCURRENCES OF ',' IN lw_stpo-vsi_size1 WITH '.'.
**            SHIFT lw_stpo-vsi_size1 LEFT DELETING LEADING space.
**            lw_bom_item-roms1 = lw_stpo-vsi_size1.

**            "REPLACE ALL OCCURRENCES OF ',' IN lw_stpo-vsi_size2 WITH '.'.
**            SHIFT lw_stpo-vsi_size2 LEFT DELETING LEADING space.
**            lw_bom_item-roms2 = lw_stpo-vsi_size2.

**            "REPLACE ALL OCCURRENCES OF ',' IN lw_stpo-vsi_size3 WITH '.'.
**            SHIFT lw_stpo-vsi_size3 LEFT DELETING LEADING space.
**
**            lw_bom_item-roms3 = lw_stpo-vsi_size3.
                lw_bom_item-sanka = lw_stpo-rel_cost.
                lw_bom_item-schgt = lw_stpo-bulk_mat.
                lw_bom_item-sortf = lw_stpo-sortstring.
                lw_bom_item-stkkz = lw_stpo-pm_assmbly.
                lw_bom_item-waers = lw_stpo-currency.
                lw_bom_item-webaz = lw_stpo-grp_time.
                "Populating the description- MAKTX
                LOOP AT lt_makt INTO lw_makt.

                  "Removing leading 0s from lw_makt-matnr
                  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
                    EXPORTING
                      input  = lw_makt-matnr
                    IMPORTING
                      output = lw_makt-matnr.

                  IF lw_stpo-component = lw_makt-matnr.
                    lw_bom_item-maktx = lw_makt-maktx.
                  ENDIF.
                ENDLOOP.
                " Filter of data based on Item Id-STLKN
*            LOOP AT is_selection-stlkn_range INTO lw_ystlkn.
*              IF lw_ystlkn-low IS INITIAL.
*                APPEND lw_bom_item TO it_bom_item.
*              ELSEIF lw_ystlkn-low EQ lw_bom_item-stlkn.
*                APPEND lw_bom_item TO it_bom_item.
*              ENDIF.
*            ENDLOOP.
                APPEND lw_bom_item TO it_bom_item.

              ENDLOOP.

            ENDLOOP.


            INSERT LINES OF it_bom_item INTO TABLE et_data.
          ENDIF.
        ENDIF.
        "End of Code to popultae YBOMITM


    ENDCASE.


  ENDMETHOD.


  METHOD get_headerdata.


    SELECT SINGLE a~stlnr,a~stlal,a~stlty,a~alekz,a~bmeng,a~bmein,a~stlst,a~cadkz,a~loekz,a~lkenz,a~datuv,a~labor,a~stktx,a~valid_to as datub
                  ,b~stlbe,b~exstl,b~ztext FROM stko AS a INNER JOIN stzu AS b ON a~stlty = b~stlty AND a~stlnr = b~stlnr INTO @DATA(lw_header)
                                            WHERE a~stlty = @is_bomheader-stlty AND a~stlnr = @is_bomheader-stlnr
                                              AND a~stlal = @is_bomheader-stlal.
      IF sy-subrc = 0.
        MOVE-CORRESPONDING lw_header TO IS_BOMHEADER.
      ENDIF.


  ENDMETHOD.


  METHOD if_mdg_bs_mat_api_segments_ext~check_and_save.
   " BREAK pgodkar.

    DATA: lw_exist TYPE char1,
          lw_only_header TYPE char1.
    DATA: lt_message TYPE mdg_bs_mat_t_mat_msg.
    DATA: lt_items_temp TYPE ymdgm_ybomitm_t.
    DATA: lt_header_temp TYPE ymdgm_ybomhdr_t.

    IF iv_test_mode NE abap_true.

    "  IF 1 = 2.

    CASE iv_segment.
      WHEN 'YMDGM_YBOMHDR_S'.

          LOOP AT is_data-ymdgm_ybomhdr_tab INTO DATA(lw_bomheader).

          check_bom_data(
            EXPORTING
              is_bomheader   = lw_bomheader                 " MDG Material API BOM Extension
              it_bomitem     = is_data-ymdgm_ybomitm_tab                 " MDG Material API BOM Extension
            IMPORTING
              ev_exist       =  lw_exist                " Exist in Active area
              ev_only_header =  lw_only_header                " Check only data Exist for Header
          ).

           IF lw_only_header  = abap_true.

              save_bom_data(
                EXPORTING
                  is_bomheader = lw_bomheader                 " MDG Material API BOM Extension
                  iv_exist     = lw_exist                 " Single-Character Flag
                  it_bomitem   = is_data-ymdgm_ybomitm_tab                 " Table type for Structure YMDGM_YBOMITM_S
                IMPORTING
                  et_message   =   lt_message               " MDG BS MAT: Material Error Message Table
              ).

           APPEND LINES OF lt_message TO et_message.

           ELSE.
             CONTINUE.
           ENDIF.

          ENDLOOP.

      WHEN 'YMDGM_YBOMITM_S'.

       lt_items_temp = is_data-ymdgm_ybomitm_tab.
       lt_header_temp = is_data-ymdgm_ybomhdr_tab.

       DELETE lt_header_temp WHERE stlnr NE 'INTERNAL'.

       DELETE lt_items_temp WHERE stlnr EQ 'INTERNAL'.

       DELETE ADJACENT DUPLICATES FROM lt_items_temp COMPARING matnr werks stlan stlnr stlal stlty.

******* New/Multiple Alternative BOM Creation Together
          IF lt_header_temp IS NOT INITIAL.
                 save_bom_data(
                EXPORTING
*                  is_bomheader = lw_bomheader                 " MDG Material API BOM Extension
                  iv_exist     = lw_exist                 " Single-Character Flag
                  it_header     = lt_header_temp
                  it_bomitem   = is_data-ymdgm_ybomitm_tab                 " Table type for Structure YMDGM_YBOMITM_S
                  it_bomitem_x  = is_data-ymdgm_ybomitm_x_tab
                IMPORTING
                  et_message   =   lt_message               " MDG BS MAT: Material Error Message Table
              ).


              APPEND LINES OF lt_message TO et_message.

         ENDIF.

****** Existing BOM Change.

       LOOP AT lt_items_temp INTO DATA(LW_items_temp).

          TRY.
          lw_bomheader = is_data-ymdgm_ybomhdr_tab[ matnr = LW_items_temp-matnr werks = LW_items_temp-werks stlan = LW_items_temp-stlan
                                                    stlnr = LW_items_temp-stlnr stlal = LW_items_temp-stlal stlty = LW_items_temp-stlty ].
          CATCH cx_sy_itab_line_not_found.
            DATA(lw_no_header) = abap_true.
          ENDTRY.

          IF lw_no_header = abap_true.

             MOVE-CORRESPONDING LW_items_temp TO lw_bomheader.

             get_headerdata(
               CHANGING
                 is_bomheader =  lw_bomheader    " MDG Material API BOM Extension
             ).

           ENDIF.

          check_bom_data(
            EXPORTING
              is_bomheader   = lw_bomheader                 " MDG Material API BOM Extension
*              it_bomitem     = is_data-ymdgm_ybomitm_tab                 " MDG Material API BOM Extension
            IMPORTING
              ev_exist       =  lw_exist                " Exist in Active area
*              ev_only_header =  lw_only_header                " Check only data Exist for Header
          ).

             save_bom_data(
                EXPORTING
                  is_bomheader = lw_bomheader                 " MDG Material API BOM Extension
                  iv_exist     = lw_exist                 " Single-Character Flag
*                  it_header     = is_data-ymdgm_ybomhdr_tab
                  it_bomitem   = is_data-ymdgm_ybomitm_tab                 " Table type for Structure YMDGM_YBOMITM_S
                  it_bomitem_x  = is_data-ymdgm_ybomitm_x_tab
                IMPORTING
                  et_message   =   lt_message               " MDG BS MAT: Material Error Message Table
              ).

        APPEND LINES OF lt_message TO et_message.
        CLEAR lw_no_header.

       ENDLOOP.
      endcase.
   " ENDIF.

    ENDIF.


  ENDMETHOD.


  method IF_MDG_BS_MAT_API_SEGMENTS_EXT~GET_ES_NODEINFO.
  endmethod.


  METHOD if_mdg_bs_mat_api_segments_ext~read.

    "DATA : lt_stko TYPE TABLE OF stko.
   " DATA : lt_mast TYPE TABLE OF mast.


   get_bomdata(
     EXPORTING
       is_selection =     is_selection             " MDG BS MAT: Material API READ Select Structure
       iv_fieldname =     iv_fieldname             " Field Name
     IMPORTING
       et_data      = et_Data
   ).

*
*    TYPES: BEGIN OF ls_makt,
*           matnr TYPE matnr,
*           spras TYPE spras,
*           maktx TYPE maktx,
*           maktg TYPE maktg,
*           END OF ls_makt.
*    DATA : lt_makt TYPE TABLE OF ls_makt.
*    DATA : lw_makt TYPE ls_makt.
*    DATA : it_bom_header TYPE ymdgm_ybomhdr_t.
*    DATA : lw_bom_header TYPE ymdgm_ybomhdr_s.
*    TYPES: BEGIN OF ls_stpo,
*              stlty TYPE stlty,
*              stlnr TYPE stnum,
*              stlkn TYPE stlkn,
*              idnrk TYPE idnrk,
*           END OF ls_stpo.
*
*    DATA: lt_stpo_tem TYPE TABLE OF ls_stpo.
*    DATA: lw_stpo_temp TYPE ls_stpo.
*    TYPES: BEGIN OF ls_mast,
*              matnr TYPE matnr,
*              werks TYPE werks_d,
*              stlan TYPE stlan,
*              stlnr TYPE stnum,
*              stlal TYPE stalt,
*           END OF ls_mast.
*
*    DATA: lt_mast TYPE TABLE OF ls_mast.
*    DATA: lw_mast TYPE ls_mast.
*    DATA: lt_stko TYPE TABLE OF stko_api02.
*    DATA: lt_stpo TYPE TABLE OF stpo_api02.
*    DATA: lw_warning TYPE capiflag-flwarning.
*    DATA: lt_stzu TYPE TABLE OF stzu.
*    CONSTANTS: lc_m TYPE stlty VALUE 'M'.
*    DATA : it_bom_item TYPE ymdgm_ybomitm_t.
*    DATA : lw_bom_item TYPE ymdgm_ybomitm_s.
*
*    CLEAR : et_data,et_message.
*
*  CASE iv_fieldname.
*   WHEN 'YMDGM_YBOMHDR_TAB'.
*    IF is_selection-matnr_range IS NOT INITIAL AND is_selection-werks_range IS NOT INITIAL.
*
*      SELECT  matnr
*              werks
*              stlan
*              stlnr
*              stlal
*              FROM mast INTO TABLE lt_mast
*              WHERE matnr IN is_selection-matnr_range
*              AND werks IN is_selection-werks_range.
*
*        IF sy-subrc = 0.
*
*
*          SELECT stlbe
*                 exstl
*                 ztext
*                 FROM stzu INTO TABLE lt_stzu
*                 FOR ALL ENTRIES IN lt_mast
*                 WHERE stlty = lc_m
*                 AND stlnr = lt_mast-stlnr
*                 AND stlan = lt_mast-stlan.
*            IF sy-subrc = 0.
*              SORT lt_stzu BY stlty stlnr stlan.
*            ENDIF.
*
*
*
*          LOOP AT lt_mast INTO lw_mast.
*              lw_bom_header-matnr = lw_mast-matnr.
*              lw_bom_header-werks = lw_mast-werks.
*              lw_bom_header-stlan = lw_mast-stlan.
*              lw_bom_header-stlal = lw_mast-stlal.
*              lw_bom_header-stlty = lc_m.
*
*
*          CALL FUNCTION 'CSAP_MAT_BOM_READ'
*            EXPORTING
*              material             = lw_bom_header-matnr
*              plant                = lw_bom_header-werks
*              bom_usage            = lw_bom_header-stlan
*              alternative          = lw_bom_header-stlal
**             VALID_FROM           =
**             VALID_TO             =
**             CHANGE_NO            =
**             REVISION_LEVEL       =
*              fl_doc_links         = 'X'
**             FL_DMU_TMX           =
*           IMPORTING
*             fl_warning           =  lw_warning
*            TABLES
*              t_stpo               = lt_stpo
*              t_stko               = lt_stko
**             T_DEP_DATA           =
**             T_DEP_DESCR          =
**             T_DEP_ORDER          =
**             T_DEP_SOURCE         =
**             T_DEP_DOC            =
**             T_DOC_LINK           =
**             T_DMU_TMX            =
**             T_LTX_LINE           =
**             T_STPU               =
**             T_FSH_BOMD           =
**             T_SGT_BOMC           =
**           EXCEPTIONS
**             ERROR                = 1
**             OTHERS               = 2
*                    .
*          IF sy-subrc <> 0.
** Implement suitable error handling here
*          ENDIF.
*
*
**         IF is_selection-stlal_range[] IS NOT INITIAL AND is_selection-stlnr_range IS NOT INITIAL
**            AND is_selection-stlan_range IS NOT INITIAL AND is_selection-stlty_range IS NOT INITIAL.
**
**          ENDIF.
*
*            IF line_exists( is_selection-stlan_range[ low = space ] )
*              OR line_exists( is_selection-stlnr_range[ low = space ] )
*              OR line_exists( is_selection-stlal_range[ low = space ] ).
*
*              DATA(lw_has_nosel) = abap_true.
*            ENDIF.
*
*
*          LOOP AT lt_stko INTO DATA(lw_stko).
*            "MOVE-CORRESPONDING lw_stko TO lw_bom_header.
*
*            IF lw_has_nosel NE abap_true.
*
*               IF NOT line_exists( is_selection-stlan_range[ low = lw_bom_header-stlan ] )
*                  OR NOT line_exists( is_selection-stlnr_range[ low = lw_stko-bom_no ] )
*                  OR NOT line_exists( is_selection-stlal_range[ low = lw_bom_header-stlal ] ).
*                 CONTINUE.
*               ENDIF.
*            ENDIF.
*
*            lw_bom_header-stlnr = lw_stko-bom_no.
*            lw_bom_header-bmeng = lw_stko-base_quan.
*            lw_bom_header-bmein = lw_stko-base_unit.
*            lw_bom_header-alekz = lw_stko-ale_ind.
*            lw_bom_header-cadkz = lw_stko-cad_ind.
*            "Covert format of date Valid From
*            CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
*              EXPORTING
*                date_external            =    lw_stko-valid_from              " external date formatting
**                accept_initial_date      =                  " Single-Character Indicator
*              IMPORTING
*                date_internal            =    lw_stko-valid_from              " internal date formatting
**              EXCEPTIONS
**                date_external_is_invalid = 1                " the external date is invalid (not plausible)
**                others                   = 2
*              .
*            IF sy-subrc <> 0.
**             MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*            ENDIF.
*            " Convert format of date for Valid To
*            CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
*              EXPORTING
*                date_external            =  lw_stko-valid_to                " external date formatting
**                accept_initial_date      =                  " Single-Character Indicator
*              IMPORTING
*                date_internal            =  lw_stko-valid_to               " internal date formatting
**              EXCEPTIONS
**                date_external_is_invalid = 1                " the external date is invalid (not plausible)
**                others                   = 2
*              .
*            IF sy-subrc <> 0.
**             MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*            ENDIF.
*            lw_bom_header-datub = lw_stko-valid_to.
*            lw_bom_header-datuv = lw_stko-valid_from.
*            lw_bom_header-exstl = lw_stko-bom_group.
*            lw_bom_header-labor = lw_stko-laboratory.
*            lw_bom_header-lkenz = lw_stko-delete_ind.
*
*              READ TABLE lt_stzu INTO DATA(Lw_stzu) WITH KEY stlty = lc_m
*                                                             stlnr = lw_bom_header-stlnr
*                                                             stlan = lw_bom_header-stlan
*                                                             BINARY SEARCH.
*              IF sy-subrc = 0.
*                lw_bom_header-stlbe = lw_stzu-stlbe.
*                lw_bom_header-exstl = lw_stzu-exstl.
*                lw_bom_header-ztext = lw_stzu-ztext.
*              ENDIF.
*
*
*            APPEND lw_bom_header TO it_bom_header.
*            CLEAR lw_stko.
*          ENDLOOP.
*
*           CLEAR : lt_stko, lw_bom_header.
*
*          ENDLOOP.
*
*          INSERT LINES OF it_bom_header INTO TABLE et_data.
*
*        ENDIF.
*
*    ENDIF.
*
*    "Begining of Code to populate YBOMITM
*
*    WHEN 'YMDGM_YBOMITM_TAB'.
*      DATA: lt_ystlkn TYPE ystlkn_t_range,
*            lw_ystlkn TYPE LINE OF ystlkn_t_range.
*
*
*      IF is_selection-matnr_range IS NOT INITIAL AND is_selection-werks_range IS NOT INITIAL.
*
*      SELECT  matnr
*              werks
*              stlan
*              stlnr
*              stlal
*              FROM mast INTO TABLE lt_mast
*              WHERE matnr IN is_selection-matnr_range
*              AND werks IN is_selection-werks_range
*              AND stlan IN is_selection-stlan_range
*              AND stlnr IN is_selection-stlnr_range
*              AND stlal IN is_selection-stlal_range.
*
*       IF sy-subrc = 0.
*          SELECT stlty
*                 stlnr
*                 stlkn
*                 idnrk
*                 FROM stpo INTO  TABLE lt_stpo_tem
*                 WHERE stlty EQ lc_m
*                 AND stlnr IN is_selection-stlnr_range.
*            IF sy-subrc = 0.
*                 SELECT matnr
*                        spras
*                        maktx
*                        maktg
*                        FROM makt INTO TABLE lt_makt
*                        FOR ALL ENTRIES IN lt_stpo_tem
*                        WHERE matnr EQ lt_stpo_tem-idnrk
*                        AND spras EQ 'E'.
*                        IF sy-subrc EQ 0.
*
*                        ENDIF.
*            ENDIF.
*
*
*         LOOP AT lt_mast INTO lw_mast.
*           lw_bom_item-matnr = lw_mast-matnr.
*           lw_bom_item-werks = lw_mast-werks.
*           lw_bom_item-stlan = lw_mast-stlan.
*           lw_bom_item-stlnr = lw_mast-stlnr.
*           lw_bom_item-stlal = lw_mast-stlal.
*           lw_bom_item-stlty = lc_m.
*
*           CALL FUNCTION 'CSAP_MAT_BOM_READ'
*             EXPORTING
*               material             = lw_bom_item-matnr
*               plant                = lw_bom_item-werks
*               bom_usage            = lw_bom_item-stlan
*               alternative          = lw_bom_item-stlal
**              VALID_FROM           =
**              VALID_TO             =
**              CHANGE_NO            =
**              REVISION_LEVEL       =
*               fl_doc_links         = 'X'
**              FL_DMU_TMX           =
*            IMPORTING
*               fl_warning           = lw_warning
*            TABLES
*               t_stpo               = lt_stpo
*               t_stko               = lt_stko
**              T_DEP_DATA           =
**              T_DEP_DESCR          =
**              T_DEP_ORDER          =
**              T_DEP_SOURCE         =
**              T_DEP_DOC            =
**              T_DOC_LINK           =
**              T_DMU_TMX            =
**              T_LTX_LINE           =
**              T_STPU               =
**              T_FSH_BOMD           =
**              T_SGT_BOMC           =
**            EXCEPTIONS
**              ERROR                = 1
**              OTHERS               = 2
*                     .
*           IF sy-subrc <> 0.
** Implement suitable error handling here
*           ENDIF.
*           LOOP AT lt_stpo INTO DATA(lw_stpo).
*            "MOVE-CORRESPONDING lw_stpo TO lw_bom_item.
*            lw_bom_item-idnrk = lw_stpo-component.
*            lw_bom_item-stlkn = lw_stpo-item_node.
*            lw_bom_item-menge = lw_stpo-comp_qty.
*            lw_bom_item-alpgr = lw_stpo-ai_group.
*            lw_bom_item-alprf = lw_stpo-ai_prio.
*            lw_bom_item-alpst = lw_stpo-ai_strateg.
*            lw_bom_item-ausch = lw_stpo-comp_scrap.
*            lw_bom_item-avoau = lw_stpo-op_scrap.
*            lw_bom_item-beikz = lw_stpo-mat_provis.
*            lw_bom_item-class = lw_stpo-class.
*            lw_bom_item-clmul = lw_stpo-mult_selec.
*            lw_bom_item-clobk = lw_stpo-reqd_comp.
*            CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
*              EXPORTING
*                date_external                  = lw_stpo-valid_to
**               ACCEPT_INITIAL_DATE            =
*             IMPORTING
*                date_internal                  =  lw_stpo-valid_to
**             EXCEPTIONS
**               DATE_EXTERNAL_IS_INVALID       = 1
**               OTHERS                         = 2
*                      .
*            IF sy-subrc <> 0.
** Implement suitable error handling here
*            ENDIF.
*
*            CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
*              EXPORTING
*                date_external                  = lw_stpo-valid_from
**               ACCEPT_INITIAL_DATE            =
*             IMPORTING
*                date_internal                  = lw_stpo-valid_from
**             EXCEPTIONS
**               DATE_EXTERNAL_IS_INVALID       = 1
**               OTHERS                         = 2
*                      .
*            IF sy-subrc <> 0.
** Implement suitable error handling here
*            ENDIF.
*
*
*            lw_bom_item-datub = lw_stpo-valid_to. "Need to convert after this
*            lw_bom_item-datuv = lw_stpo-valid_from. "Need to convert after this
*            lw_bom_item-dspst = lw_stpo-expl_type.
*            lw_bom_item-ekgrp = lw_stpo-purch_grp.
*            lw_bom_item-ekorg = lw_stpo-purch_org.
*            lw_bom_item-erskz = lw_stpo-spare_part.
*            lw_bom_item-ewahr = lw_stpo-usage_prob.
*            lw_bom_item-fmeng = lw_stpo-fixed_qty.
*            lw_bom_item-kzclb = lw_stpo-sel_cond.
*            lw_bom_item-kzkup = lw_stpo-co_product.
*            lw_bom_item-lifnr = lw_stpo-vendor.
*            lw_bom_item-lifzt = lw_stpo-deliv_time.
*            lw_bom_item-matkl = lw_stpo-mat_group.
*            lw_bom_item-meins = lw_stpo-comp_unit.
*            lw_bom_item-netau = lw_stpo-op_net_ind.
*            lw_bom_item-nfeag = lw_stpo-discon_grp.
*            lw_bom_item-nfgrp = lw_stpo-follow_grp.
*            lw_bom_item-nlfmv = lw_stpo-op_lt_unit.
*            lw_bom_item-nlfzt = lw_stpo-op_lead_tm.
*            lw_bom_item-peinh = lw_stpo-price_unit.
*            lw_bom_item-posnr = lw_stpo-item_no.
*            lw_bom_item-postp = lw_stpo-item_categ.
*            lw_bom_item-potx1 = lw_stpo-item_text1.
*            lw_bom_item-potx2 = lw_stpo-item_text2.
*            lw_bom_item-preis = lw_stpo-price.
*            lw_bom_item-rekrs = lw_stpo-rec_allowd.
*            lw_bom_item-rform = lw_stpo-vsi_formul.
*            lw_bom_item-roanz = lw_stpo-vsi_no.
*            lw_bom_item-romei = lw_stpo-vsi_szunit.
*            lw_bom_item-romen = lw_stpo-vsi_qty.
*            lw_bom_item-roms1 = lw_stpo-vsi_size1.
*            lw_bom_item-roms2 = lw_stpo-vsi_size2.
*            lw_bom_item-roms3 = lw_stpo-vsi_size3.
*            lw_bom_item-sanka = lw_stpo-rel_cost.
*            lw_bom_item-schgt = lw_stpo-bulk_mat.
*            lw_bom_item-sortf = lw_stpo-sortstring.
*            lw_bom_item-stkkz = lw_stpo-pm_assmbly.
*            lw_bom_item-waers = lw_stpo-currency.
*            lw_bom_item-webaz = lw_stpo-grp_time.
*            "Populating the description- MAKTX
*            LOOP AT lt_makt INTO lw_makt.
*              "Removing leading 0s from lw_makt-matnr
*              CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
*                EXPORTING
*                  input         = lw_makt-matnr
*               IMPORTING
*                  output        = lw_makt-matnr
*                        .
*
*              IF lw_stpo-component = lw_makt-matnr.
*                lw_bom_item-maktx = lw_makt-maktx.
*              ENDIF.
*            ENDLOOP.
*            " Filter of data based on Item Id-STLKN
*            LOOP AT is_selection-stlkn_range INTO lw_ystlkn.
*              IF lw_ystlkn-low IS INITIAL.
*                APPEND lw_bom_item TO it_bom_item.
*              ELSEIF lw_ystlkn-low EQ lw_bom_item-stlkn.
*                APPEND lw_bom_item TO it_bom_item.
*              ENDIF.
*
*            ENDLOOP.
**              APPEND lw_bom_item TO it_bom_item.
*
*           ENDLOOP.
*
*         ENDLOOP.
*
*
*        INSERT LINES OF it_bom_item INTO TABLE et_data.
*       ENDIF.
*      ENDIF.
*    "End of Code to popultae YBOMITM
*
*
*   ENDCASE.
  ENDMETHOD.


  method save_bom_data.

    data : lw_stko type stko_api01.
    data : lw_stko_get type stko_api02.
    data : lt_stpo type table of stpo_api03.
    data : lt_stpo_change type table of stpo_api03.
    data : lt_stpo_d type table of stpo_api03.
    data : lw_stpo like line of lt_stpo.
    data : lw_warning type capiflag-flwarning.
    data : lt_message type mdg_bs_mat_t_mat_msg.
    data : lw_message like line of et_message.
    data : lw_validfrm type csap_mbom-datuv.
    data : lw_flg_no_commit_work type  csdata-xfeld.
    data : lw_flg_no_commit_work_change type  csdata-xfeld.

********** Alternative BOM Create
    data : lt_BOMGROUP type table of bapi1080_bgr_c.
    data : lt_variants type table of bapi1080_bom_c.
    data : lw_variants type bapi1080_bom_c.
    data : lt_items     type table of bapi1080_itm_c.
    data : lt_matrelation type table of bapi1080_mbm_c.
    data : lw_matrelation type bapi1080_mbm_c.
    data : lt_itemassignments type table of bapi1080_rel_itm_bom_c.
    data : lw_itemassignments type bapi1080_rel_itm_bom_c.
    data : lt_return type bapiret2_t."TECHNICAL_TYPE
    data : lw_items type  bapi1080_itm_c.
    data : lw_bom_grp type string.

********* Multiple plant defect : fix ***********
    data: lv_call_from_update_task type sy-subrc.

    if iv_exist = abap_false." and is_bomheader-STLAL = 1.


      loop at it_header into is_bomheader.
        clear: lt_BOMGROUP, lt_variants , lt_items , lt_matrelation , lt_itemassignments.

        lw_bom_grp = 'BOMGROUP1'.

        lt_BOMGROUP = value #( ( bom_group_identification = lw_bom_grp  object_type = 'BGR' object_id = is_bomheader-matnr
                               technical_type  = 'M' bom_usage = is_bomheader-stlan bom_group =  is_bomheader-exstl created_in_plant = is_bomheader-werks
                              auth_group = is_bomheader-stlbe bom_text = is_bomheader-ztext ) ).

        lw_variants = value #( bom_group_identification = lw_bom_grp  object_type = 'BOM' object_id = is_bomheader-stlal
                                   alternative_bom = is_bomheader-stlal bom_status = is_bomheader-stlst deletion_ind = is_bomheader-loekz
                                   base_qty = is_bomheader-bmeng base_unit = is_bomheader-bmein lab_design = is_bomheader-labor
                                   alt_text = is_bomheader-stktx valid_from_date = is_bomheader-datuv function = 'NEW' ).

        call function 'CONVERSION_EXIT_CUNIT_INPUT'
          exporting
            input          = lw_variants-base_unit
            language       = sy-langu
          importing
            output         = lw_variants-base_unit
          exceptions
            unit_not_found = 1
            others         = 2.
        if sy-subrc <> 0.
* Implement suitable error handling here
        endif.


        append lw_variants to lt_variants.
        clear lw_variants.

        loop at it_bomitem into data(lw_bom_item) where matnr = is_bomheader-matnr and werks = is_bomheader-werks
                                                 and stlan = is_bomheader-stlan and stlnr = is_bomheader-stlnr and stlal = is_bomheader-stlal
                                                 and stlty =  is_bomheader-stlty.

          lw_items = value #( bom_group_identification = lw_bom_grp  object_type = 'ITM' object_id = is_bomheader-stlal
                              item_no  =  lw_bom_item-posnr item_cat = lw_bom_item-postp sort_string = lw_bom_item-sortf component = lw_bom_item-idnrk
                              reqd_comp = lw_bom_item-clobk sel_cond  =  lw_bom_item-kzclb multselect  = lw_bom_item-clmul item_text1  =  lw_bom_item-potx1
                              item_text2  =  lw_bom_item-potx2 comp_qty  = lw_bom_item-menge comp_unit  =  lw_bom_item-meins fixed_qty  =  lw_bom_item-fmeng
                              vsi_no  =  lw_bom_item-roanz vsi_size1 =  lw_bom_item-roms1 vsi_size2  =  lw_bom_item-roms2 vsi_size3  =  lw_bom_item-roms3
                              vsi_size_unit  =  lw_bom_item-romei vsi_qty  =  lw_bom_item-romen vsi_formula = lw_bom_item-rform comp_scrap  = lw_bom_item-ausch
                              opr_scrap  = lw_bom_item-avoau net_scrap_ind = lw_bom_item-netau spare_part  =  lw_bom_item-erskz mat_provision = lw_bom_item-beikz
                              pm_assembly  =  lw_bom_item-stkkz cost_rel  =  lw_bom_item-sanka bulk_mat  =  lw_bom_item-schgt pur_group  =  lw_bom_item-ekgrp
                              purch_org  =  lw_bom_item-ekorg delivery_days  =  lw_bom_item-lifzt vendor_no  =  lw_bom_item-lifnr gr_pr_time  =  lw_bom_item-webaz
                              price  =  lw_bom_item-preis currency  =  lw_bom_item-waers price_unit  =  lw_bom_item-peinh rec_allowed =  lw_bom_item-rekrs
                              lead_time_offset = lw_bom_item-nlfzt co_product  =  lw_bom_item-kzkup alt_item_strategy  = lw_bom_item-alpst alt_item_prio  =  lw_bom_item-alprf
                              alt_item_group  =  lw_bom_item-alpgr usage_prob  =  lw_bom_item-ewahr follow_up_group  =  lw_bom_item-nfgrp discon_group  =  lw_bom_item-nfeag
                              expl_type  = lw_bom_item-dspst ).

          call function 'CONVERSION_EXIT_CUNIT_INPUT'
            exporting
              input          = lw_items-comp_unit
              language       = sy-langu
            importing
              output         = lw_items-comp_unit
            exceptions
              unit_not_found = 1
              others         = 2.
          if sy-subrc <> 0.
* Implement suitable error handling here
          endif.

          call function 'CONVERSION_EXIT_CUNIT_INPUT'
            exporting
              input          = lw_items-vsi_size_unit
              language       = sy-langu
            importing
              output         = lw_items-vsi_size_unit
            exceptions
              unit_not_found = 1
              others         = 2.
          if sy-subrc <> 0.
* Implement suitable error handling here
          endif.

          append lw_items to lt_items.
          clear lw_items.
        endloop.

        lw_matrelation = value #( bom_group_identification = lw_bom_grp  material = is_bomheader-matnr plant = is_bomheader-werks
                                    bom_usage = is_bomheader-stlan alternative_bom = is_bomheader-stlal ).

        append lw_matrelation to lt_matrelation.
        clear lw_matrelation.

        lw_itemassignments = value #( bom_group_identification = lw_bom_grp  sub_object_type = 'ITM' sub_object_id = is_bomheader-stlal
                                         super_object_type = 'BOM' super_object_id = is_bomheader-stlal valid_from_date = is_bomheader-datuv
                                         function = 'NEW' ).

        append lw_itemassignments to lt_itemassignments.
        clear lw_itemassignments.

      endloop. "Anand
        if lt_BOMGROUP is not initial.


          call function 'BAPI_MATERIAL_BOM_GROUP_CREATE' " Commented by Anand
             exporting
*             TESTRUN           = ' '
               all_error         = abap_true
             tables
               bomgroup          = lt_BOMGROUP
               variants          = lt_variants
               items             = lt_items
*             SUBITEMS          =
               materialrelations = lt_matrelation
               itemassignments   = lt_itemassignments
*             SUBITEMASSIGNMENTS       =
*             TEXTS             =
               return            = lt_return.

* Check for errors during bom creation
*          if sy-subrc <> 0.
*            message 'Error occurred while creating BOM' type 'E'.
*          else.
*            call function 'TH_IN_UPDATE_TASK'
*              importing
*                in_update_task = lv_call_from_update_task.
*            if lv_call_from_update_task <> '1'.
*              call function 'BAPI_TRANSACTION_COMMIT'
*                exporting
*                  wait = 'X'.                                  " Wait for database update to complete
*            endif.
*          endif.
*        CALL FUNCTION 'YBAPI_MAT_BOM_GROUP_CREATE' IN UPDATE TASK " Added by ANand
*          EXPORTING
**           iv_testrun           = space            " Switch to Simulation Session for Write BAPIs
*            iv_all_error         = abap_true            " Output All Errors
*          TABLES
*            lt_bomgroup          = lt_bomgroup                " BOM group CREATE-/CHANGE BAPI material BOM
*            lt_variants          = lt_variants               " Alternative/Variant CREATE-/CHANGE BAPI Material BOM
*            lt_items             = lt_items               " Components CREATE-/CHANGE BAPI Material BOM
**           lt_subitems          =                  " Sub item CREATE-/CHANGE BAPI Material BOM
*            lt_materialrelations = lt_matrelation                  " Material assignment CREATE-/CHANGE BAPI Material BOM
*            lt_itemassignments   = lt_itemassignments                 " Assignments CREATE-/CHANGE BAPI ITM/BOM material BOMs
**           lt_subitemassignments =                  " Assignments CREATE-/CHANGE BAPI SUI/ITM Mat.BOMs
**           lt_texts             =                  " Long text line: CREATE-/CHANGE BAPI for material BOMs
**           lt_return            = lt_return.                " Return Parameter
*            .

          if line_exists( lt_return[ type = 'E' ] ) or line_exists( lt_return[ type = 'A' ] ).

            loop at lt_return into data(lw_return).

              lw_message = value #( msgty = lw_return-type  msgid = lw_return-id
                                      msgno = lw_return-number msgv1 = lw_return-message msgv2 = lw_return-message_v1 msgv3 = lw_return-message_v2
                                      msgv4 = lw_return-message_v4
                                      matnr = is_bomheader-matnr werks = is_bomheader-werks ).
              append lw_message to lt_message.
            endloop.

            et_message = lt_message.

          else.

            lt_message = value #( ( msgty = 'S' msgid = 'YMDMBOM' msgno = 000 matnr = is_bomheader-matnr ) ).
            et_message = lt_message.

          endif.

        endif.

*     ENDLOOP. "Anand

    else.
      "Read if bom item exists in stpo or not - Anand
      if is_bomheader-stlnr is not initial and is_bomheader-stlnr ne 'INTERNAL'.
        select * from stpo into table @data(lt_stpo_check) where stlnr = @is_bomheader-stlnr.
      endif.


      lw_stko-base_quan = is_bomheader-bmeng.

      shift lw_stko-base_quan left deleting leading space.

      "lw_stko-base_unit = is_bomheader-bmein.
      call function 'CONVERSION_EXIT_CUNIT_INPUT'
        exporting
          input          = is_bomheader-bmein
          language       = sy-langu
        importing
          output         = is_bomheader-bmein
        exceptions
          unit_not_found = 1
          others         = 2.
      if sy-subrc <> 0.
* Implement suitable error handling here
      endif.


      lw_stko-bom_status = is_bomheader-stlst.
      lw_stko-alt_text = is_bomheader-stktx.
      lw_stko-laboratory = is_bomheader-labor.
      lw_stko-delete_ind = is_bomheader-loekz.
      lw_stko-bom_text = is_bomheader-ztext.
      lw_stko-bom_group = is_bomheader-exstl.
      lw_stko-auth_group = is_bomheader-stlbe.
      lw_stko-cad_ind = is_bomheader-cadkz.

      lw_validfrm = |{ is_bomheader-datuv date = user }|.

      loop at it_bomitem into lw_bom_item where matnr = is_bomheader-matnr and werks = is_bomheader-werks
                                                 and stlan = is_bomheader-stlan and stlnr = is_bomheader-stlnr and stlal = is_bomheader-stlal
                                                 and stlty =  is_bomheader-stlty.





        lw_stpo-component  = lw_bom_item-idnrk.
        lw_stpo-comp_qty  = lw_bom_item-menge.

**        SHIFT lw_stpo-comp_qty LEFT DELETING LEADING space. " Commented by Anand
        "Added by ANand
        call function 'CONVERSION_EXIT_QNTY1_OUTPUT'
          exporting
            input  = lw_stpo-comp_qty
          importing
            output = lw_stpo-comp_qty.

        lw_stpo-ai_group  =  lw_bom_item-alpgr.
        lw_stpo-ai_prio  =  lw_bom_item-alprf.
        lw_stpo-ai_strateg  = lw_bom_item-alpst.
        lw_stpo-comp_scrap  = lw_bom_item-ausch.

        shift lw_stpo-comp_scrap left deleting leading space.

        lw_stpo-op_scrap  = lw_bom_item-avoau.

        shift lw_stpo-op_scrap left deleting leading space.

        lw_stpo-mat_provis  = lw_bom_item-beikz.
        lw_stpo-class  = lw_bom_item-class.
        lw_stpo-mult_selec  = lw_bom_item-clmul.
        lw_stpo-reqd_comp  = lw_bom_item-clobk.
        lw_stpo-expl_type  = lw_bom_item-dspst.
        lw_stpo-purch_grp  =  lw_bom_item-ekgrp.
        lw_stpo-purch_org  =  lw_bom_item-ekorg.
        lw_stpo-spare_part  =  lw_bom_item-erskz.
        lw_stpo-usage_prob  =  lw_bom_item-ewahr.
        lw_stpo-fixed_qty  =  lw_bom_item-fmeng.
        lw_stpo-sel_cond  =  lw_bom_item-kzclb.
        lw_stpo-co_product  =  lw_bom_item-kzkup.
        lw_stpo-vendor  =  lw_bom_item-lifnr.
        lw_stpo-mat_group  =  lw_bom_item-matkl.
        "lw_stpo-comp_unit  =  lw_bom_item-meins.

        call function 'CONVERSION_EXIT_CUNIT_INPUT'
          exporting
            input          = lw_bom_item-meins
            language       = sy-langu
          importing
            output         = lw_stpo-comp_unit
          exceptions
            unit_not_found = 1
            others         = 2.
        if sy-subrc <> 0.
* Implement suitable error handling here
        endif.
        lw_stpo-op_net_ind  =  lw_bom_item-netau.
        lw_stpo-discon_grp  =  lw_bom_item-nfeag.
        lw_stpo-follow_grp  =  lw_bom_item-nfgrp.
        lw_stpo-op_lt_unit  =  lw_bom_item-nlfmv.
        lw_stpo-op_lead_tm  =  lw_bom_item-nlfzt.
        lw_stpo-price_unit  =  lw_bom_item-peinh.
        lw_stpo-item_no  =  lw_bom_item-posnr.
        lw_stpo-deliv_time  =  lw_bom_item-lifzt.
        lw_stpo-item_categ  =  lw_bom_item-postp.
        lw_stpo-item_text1  =  lw_bom_item-potx1.
        lw_stpo-item_text2  =  lw_bom_item-potx2.
        lw_stpo-price  =  lw_bom_item-preis.

        shift lw_stpo-price left deleting leading space.

        lw_stpo-rec_allowd  =  lw_bom_item-rekrs.
        lw_stpo-vsi_formul  =  lw_bom_item-rform.
        lw_stpo-vsi_no  =  lw_bom_item-roanz.
        lw_stpo-vsi_szunit  =  lw_bom_item-romei.

        call function 'CONVERSION_EXIT_CUNIT_INPUT'
          exporting
            input          = lw_bom_item-romei
            language       = sy-langu
          importing
            output         = lw_stpo-vsi_szunit
          exceptions
            unit_not_found = 1
            others         = 2.
        if sy-subrc <> 0.
* Implement suitable error handling here
        endif.

        lw_stpo-vsi_qty  =  lw_bom_item-romen.

        shift lw_stpo-vsi_qty left deleting leading space.

        lw_stpo-vsi_size1  =  lw_bom_item-roms1.

        shift lw_stpo-vsi_size1 left deleting leading space.

        lw_stpo-vsi_size2  =  lw_bom_item-roms2.

        shift lw_stpo-vsi_size2 left deleting leading space.

        lw_stpo-vsi_size3  =  lw_bom_item-roms3.

        shift lw_stpo-vsi_size2 left deleting leading space.

        lw_stpo-rel_cost  =  lw_bom_item-sanka.
        lw_stpo-bulk_mat  =  lw_bom_item-schgt.
        lw_stpo-sortstring  =  lw_bom_item-sortf.
        lw_stpo-pm_assmbly  =  lw_bom_item-stkkz.
        lw_stpo-currency  =  lw_bom_item-waers.
        lw_stpo-grp_time  =  lw_bom_item-webaz.
        if lw_bom_item-stlnr is not initial and lw_bom_item-stlnr ne 'INTERNAL'.
          lw_stpo-bom_no    = lw_bom_item-stlnr.
        endif.

****** Check Line Item Deleted ?
        if line_exists( it_bomitem_x[ matnr = lw_bom_item-matnr werks = lw_bom_item-werks stlan = lw_bom_item-stlan stlnr = lw_bom_item-stlnr
                        stlal = lw_bom_item-stlal stlty =  lw_bom_item-stlty stlkn =  lw_bom_item-stlkn delete_row = abap_true ] ).
          lw_stpo-fldelete = abap_true.
*          lw_stpo-component  = lw_bom_item-idnrk.
*          lw_stpo-item_no  =  lw_bom_item-posnr.

          if lw_bom_item-stpoz is not initial.
            lw_stpo-item_node  = lw_bom_item-stlkn.
            lw_stpo-item_count  = lw_bom_item-stpoz.
          endif.
*         APPEND  lw_stpo TO lt_stpo.
*         CLEAR lw_stpo.
*         CONTINUE.

        endif.
*      APPEND  lw_stpo TO lt_stpo.
*      CLEAR lw_stpo.
*------------------------BOC: Anand for Change Scenarios-----17.5.2023----------
        if not line_exists( lt_stpo_check[ stlnr = lw_bom_item-stlnr posnr = lw_bom_item-posnr idnrk = lw_bom_item-idnrk ] ). " Anand
          append  lw_stpo to lt_stpo. "New Item during Change
***        CLEAR lw_stpo.
        elseif line_exists( lt_stpo_check[ stlnr = lw_bom_item-stlnr posnr = lw_bom_item-posnr idnrk = lw_bom_item-idnrk ] )
           and lw_stpo-fldelete = abap_true.
          append  lw_stpo to lt_stpo. "Deletion of item during change
        elseif line_exists( lt_stpo_check[ stlnr = lw_bom_item-stlnr posnr = lw_bom_item-posnr idnrk = lw_bom_item-idnrk ] )
          and lw_stpo-fldelete = abap_false.
          lw_stpo-id_item_no = lw_bom_item-posnr.
          lw_stpo-id_itm_ctg = lw_bom_item-postp.
          lw_stpo-id_comp = lw_bom_item-idnrk.
          append  lw_stpo to lt_stpo_change. "Change of item Quantity during change
        endif.
        clear lw_stpo.
*------------------------------EOC--------------------------------------------
      endloop.

      if lt_stpo is not initial.
        lw_flg_no_commit_work = abap_true.
        export flg_no_commit_work = lw_flg_no_commit_work to memory id 'CS_CSAP'.

        call function 'CALO_INIT_API'
          exporting
            flag_db_log_on           = 'X'
            flag_msg_on              = 'X'
*           FLAG_API_API_CALL_ON     = ' '
*           FLAG_COLLECT_MSG_ON      = ' '
*           EXTERNAL_LOG_NO          = 'API'
*           DEL_LOG_AFTER_DAYS       = '10'
*           DATA_RESET_SIGN          = '!'
          exceptions
            log_object_not_found     = 1
            log_sub_object_not_found = 2
            others                   = 3.
        if sy-subrc <> 0.
* Implement suitable error handling here
        endif.


        call function 'CSAP_MAT_BOM_MAINTAIN'
          exporting
            material           = is_bomheader-matnr
            plant              = is_bomheader-werks
            bom_usage          = is_bomheader-stlan
            alternative        = is_bomheader-stlal
            valid_from         = lw_validfrm
*           CHANGE_NO          =
*           REVISION_LEVEL     =
            i_stko             = lw_stko
*           FL_NO_CHANGE_DOC   = ' '
            fl_commit_and_wait = ' '
*           FL_CAD             = ' '
*           fl_bom_create      = 'X'
            fl_new_item        = 'X'
            fl_complete        = 'X'
*           FL_DEFAULT_VALUES  = 'X'
*           FL_IDENTIFY_BY_GUID       = ' '
*           FL_RECURSIVE       = ' '
          importing
            fl_warning         = lw_warning
            o_stko             = lw_stko_get
          tables
            t_stpo             = lt_stpo
*           T_DEP_DATA         =
*           T_DEP_DESCR        =
*           T_DEP_ORDER        =
*           T_DEP_SOURCE       =
*           T_DEP_DOC          =
*           T_DOC_LINK         =
*           T_DMU_TMX          =
*           T_LTX_LINE         =
*           T_STPU             =
*           T_FSH_BOMD         =
*           T_SGT_BOMC         =
          exceptions
            error              = 1
            others             = 2.
        if sy-subrc <> 0.
*       Implement suitable error handling here

          data : lt_error_msg type table of messages.

          call function 'CALO_LOG_READ_MESSAGES'
*             EXPORTING
*               LOG_CLASS                     = '4'
*               LANGUAGE                      = SY-LANGU
            tables
              messages_and_parameters = lt_error_msg
            exceptions
              warning                 = 1
              error                   = 2
              others                  = 3.
          if sy-subrc <> 0.
*             Implement suitable error handling here
          endif.

          et_message = value #( ( msgty = 'E' msgid = 'YMDMBOM' msgno = 001 matnr = is_bomheader-matnr werks = is_bomheader-werks ) ).
          loop at lt_error_msg into data(lw_error_msg).
            lw_message = value #( msgty = lw_error_msg-msg_type msgid = lw_error_msg-msg_id msgno = lw_error_msg-msg_no msgv1 = lw_error_msg-msg_v1
               msgv2 = lw_error_msg-msg_v2 msgv3 = lw_error_msg-msg_v3 msgv4 = lw_error_msg-msg_v4
               matnr = is_bomheader-matnr werks = is_bomheader-werks ).
            append lw_message to lt_message.
            clear lw_message.
          endloop.
          append lines of lt_message to et_message.

        else.

          lt_message = value #( ( msgty = 'S' msgid = 'YMDMBOM' msgno = 000 matnr = is_bomheader-matnr ) ).
          et_message = lt_message.

        endif.

*      -------------------BOC: For BAPI for Change Scenario- Anand-------------
*        IF lt_stpo_change IS NOT INITIAL.
**          WAIT UP TO 10 SECONDS.
*           CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
*        ENDIF.
        lw_flg_no_commit_work = abap_false.
        export flg_no_commit_work = lw_flg_no_commit_work to memory id 'CS_CSAP'.


      endif.

      if lt_stpo_change is not initial.
        lw_flg_no_commit_work_change = abap_true.
        export flg_no_commit_work = lw_flg_no_commit_work_change to memory id 'CS_CSAP'.
*
        call function 'CALO_INIT_API'
          exporting
            flag_db_log_on           = 'X'
            flag_msg_on              = 'X'
*           FLAG_API_API_CALL_ON     = ' '
*           FLAG_COLLECT_MSG_ON      = ' '
*           EXTERNAL_LOG_NO          = 'API'
*           DEL_LOG_AFTER_DAYS       = '10'
*           DATA_RESET_SIGN          = '!'
          exceptions
            log_object_not_found     = 1
            log_sub_object_not_found = 2
            others                   = 3.
        if sy-subrc <> 0.
* Implement suitable error handling here
        endif.
        call function 'CSAP_MAT_BOM_MAINTAIN'
          exporting
            material           = is_bomheader-matnr
            plant              = is_bomheader-werks
            bom_usage          = is_bomheader-stlan
            alternative        = is_bomheader-stlal
            valid_from         = lw_validfrm
*           CHANGE_NO          =
*           REVISION_LEVEL     =
            i_stko             = lw_stko
*           FL_NO_CHANGE_DOC   = ' '
            fl_commit_and_wait = ' '
*           FL_CAD             = ' '
*           fl_bom_create      = 'X'
            fl_new_item        = ' '
            fl_complete        = 'X'
*           FL_DEFAULT_VALUES  = 'X'
*           FL_IDENTIFY_BY_GUID       = ' '
*           FL_RECURSIVE       = ' '
          importing
            fl_warning         = lw_warning
            o_stko             = lw_stko_get
          tables
            t_stpo             = lt_stpo_change
*           T_DEP_DATA         =
*           T_DEP_DESCR        =
*           T_DEP_ORDER        =
*           T_DEP_SOURCE       =
*           T_DEP_DOC          =
*           T_DOC_LINK         =
*           T_DMU_TMX          =
*           T_LTX_LINE         =
*           T_STPU             =
*           T_FSH_BOMD         =
*           T_SGT_BOMC         =
          exceptions
            error              = 1
            others             = 2.
        if sy-subrc <> 0.
*       Implement suitable error handling here

          data : lt_error_msg_change type table of messages.

          call function 'CALO_LOG_READ_MESSAGES'
*             EXPORTING
*               LOG_CLASS                     = '4'
*               LANGUAGE                      = SY-LANGU
            tables
              messages_and_parameters = lt_error_msg_change
            exceptions
              warning                 = 1
              error                   = 2
              others                  = 3.
          if sy-subrc <> 0.
*             Implement suitable error handling here
          endif.

          et_message = value #( ( msgty = 'E' msgid = 'YMDMBOM' msgno = 001 matnr = is_bomheader-matnr werks = is_bomheader-werks ) ).
          loop at lt_error_msg into data(lw_error_msg_change).
            lw_message = value #( msgty = lw_error_msg_change-msg_type msgid = lw_error_msg_change-msg_id msgno = lw_error_msg_change-msg_no msgv1 = lw_error_msg_change-msg_v1
               msgv2 = lw_error_msg_change-msg_v2 msgv3 = lw_error_msg_change-msg_v3 msgv4 = lw_error_msg_change-msg_v4
               matnr = is_bomheader-matnr werks = is_bomheader-werks ).
            append lw_message to lt_message.
            clear lw_message.
          endloop.
          append lines of lt_message to et_message.

        else.

          lt_message = value #( ( msgty = 'S' msgid = 'YMDMBOM' msgno = 000 matnr = is_bomheader-matnr ) ).
          et_message = lt_message.
*          CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
*            EXPORTING
*              wait = abap_true.                 " Use of Command `COMMIT AND WAIT`

        endif.
        lw_flg_no_commit_work_change = abap_false.
        export flg_no_commit_work = lw_flg_no_commit_work_change to memory id 'CS_CSAP'.
      endif.

*      --------------------------EOC by Aanad----------------------------

*      lw_flg_no_commit_work = abap_false.
*      EXPORT flg_no_commit_work = lw_flg_no_commit_work TO MEMORY ID 'CS_CSAP'.



    endif.

  endmethod.
ENDCLASS.
