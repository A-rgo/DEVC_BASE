class ZZMDG_CL_BS_MAT_MM_PIR_API_EXT definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_MDG_BS_MAT_API_SEGMENTS_EXT .

  types:
    GTT_KONH TYPE STANDARD TABLE OF KONH .
  types:
    GTT_KONP TYPE STANDARD TABLE OF KONP .
  types:
    BEGIN OF gty_a017,
                lifnr TYPE elifn,
                matnr TYPE matnr,
                ekorg TYPE ekorg,
                werks TYPE werks_d,
                esokz TYPE esokz,
                knumh TYPE knumh,
                datab TYPE datab,
                datbi TYPE kodatbi,
        END OF gty_a017 .
  types:
    BEGIN OF gty_a018,
                lifnr TYPE elifn,
                matnr TYPE matnr,
                ekorg TYPE ekorg,
                esokz TYPE esokz,
                knumh TYPE knumh,
                datab TYPE datab,
                datbi TYPE kodatbi,
        END OF gty_a018 .
  types:
    gtt_a017 TYPE STANDARD TABLE OF gty_a017 .
  types:
    gtt_a018 TYPE STANDARD TABLE OF gty_a018 .

  methods GET_INTERMEDIATE_DATES
    importing
      !IM_PERIODS type ZZMDG_T_PERIOD_DATES
    exporting
      !EX_PREV_DATE type DATUM
      !EX_NEXT_DATE type DATUM .
  methods GET_CONDITION_RECORDS
    importing
      value(GT_PCOND_LIST) type ZZMDG_BS_MAT_T_COND optional
    exporting
      value(GT_A017) type GTT_A017
      value(GT_A018) type GTT_A018
      value(GT_KONH) type GTT_KONH
      value(GT_KONP) type GTT_KONP .
  class-methods GET_CR_TYPE
    importing
      !IV_CREQUEST type USMD_CREQUEST optional
    returning
      value(RV_USMD_CREQUEST_TYPE) type USMD_CREQUEST_TYPE .
protected section.
private section.
ENDCLASS.



CLASS ZZMDG_CL_BS_MAT_MM_PIR_API_EXT IMPLEMENTATION.


  method GET_CONDITION_RECORDS.
 DATA : lt_pcond_data TYPE zzmdg_bs_mat_t_cond,
         lt_a017       TYPE gtt_a017,
         lt_cond_tab   TYPE gtt_a017,
         lt_a018       TYPE gtt_a018,
         lt_konh       TYPE gtt_konh,
         lt_konp       TYPE gtt_konp,

         ls_a018       TYPE gty_a018,
         ls_cond_tab   TYPE gty_a017.
CHECK 1 = 0.

  IF gt_pcond_list IS NOT INITIAL.
    lt_pcond_data = gt_pcond_list.
    SELECT lifnr matnr ekorg werks esokz knumh datab datbi
                FROM a017
                INTO TABLE lt_a017
                FOR ALL ENTRIES IN lt_pcond_data
                WHERE matnr = lt_pcond_data-matnr
                AND lifnr = lt_pcond_data-lifnr
                AND ekorg = lt_pcond_data-ekorg
                AND werks = lt_pcond_data-werks.
    IF sy-subrc IS INITIAL.
      SORT lt_a017 BY knumh.
    ENDIF.

    APPEND LINES OF lt_a017 TO lt_cond_tab.
    IF lt_pcond_data IS NOT INITIAL.
      SELECT lifnr matnr ekorg esokz knumh datab datbi
       FROM a018
       INTO TABLE lt_a018
       FOR ALL ENTRIES IN lt_pcond_data
       WHERE matnr = lt_pcond_data-matnr
       AND lifnr = lt_pcond_data-lifnr
       AND ekorg = lt_pcond_data-ekorg.
      IF sy-subrc IS INITIAL.
        SORT lt_a018 BY knumh.
      ENDIF.
    ENDIF.

    LOOP AT lt_a018 INTO ls_a018.
      ls_cond_tab-matnr = ls_a018-matnr.
      ls_cond_tab-ekorg = ls_a018-ekorg.
      ls_cond_tab-esokz = ls_a018-esokz.
      ls_cond_tab-knumh = ls_a018-knumh.
      ls_cond_tab-lifnr = ls_a018-lifnr.
      ls_cond_tab-datab = ls_a018-datab.
      ls_cond_tab-datbi = ls_a018-datbi.
      APPEND ls_cond_tab TO lt_cond_tab.
      CLEAR ls_cond_tab.
    ENDLOOP.
    SORT lt_cond_tab BY knumh.

    IF lt_cond_tab IS NOT INITIAL.
      SELECT *
        FROM konh
        INTO TABLE lt_konh
        FOR ALL ENTRIES IN lt_cond_tab
        WHERE knumh = lt_cond_tab-knumh.
      IF sy-subrc IS INITIAL.
        SORT lt_konh BY knumh.
      ENDIF.

      SELECT *
        FROM konp
        INTO TABLE lt_konp
        FOR ALL ENTRIES IN lt_cond_tab
        WHERE knumh = lt_cond_tab-knumh.      "#EC CI_ALL_FIELDS_NEEDED
      IF sy-subrc IS INITIAL.
        SORT lt_konp BY knumh.
      ENDIF.
    ENDIF.
  ENDIF.

  IF lt_cond_tab IS NOT INITIAL.
    gt_a017 = lt_cond_tab.
    gt_konh = lt_konh.
    gt_konp = lt_konp.
  ENDIF.



  endmethod.


  method GET_CR_TYPE.

    rv_usmd_crequest_type = COND #( WHEN cl_usmd_app_context=>get_context( ) IS BOUND THEN cl_usmd_app_context=>get_context( )->mv_crequest_type  ).

* #FallBack API Code
    IF rv_usmd_crequest_type IS INITIAL.
    DATA lo_usmd_model_util TYPE REF TO cl_usmd_crequest_util.
    DATA lo_model           TYPE REF TO if_usmd_model.

    CREATE OBJECT lo_usmd_model_util.

    lo_usmd_model_util->get_data_model(
      EXPORTING id_crequest = iv_crequest
      IMPORTING eo_model    = lo_model ).

    lo_usmd_model_util->get_crequest(
      EXPORTING id_crequest     = iv_crequest
                io_model        = lo_model
      IMPORTING es_crequest     = DATA(rs_crequest) ).

      rv_usmd_crequest_type = rs_crequest-usmd_creq_type.

    ENDIF.

* #Fallback API Code
    IF rv_usmd_crequest_type IS INITIAL.

        cl_usmd_model=>get_instance(
         EXPORTING
           i_usmd_model = 'MM'
         IMPORTING
          eo_instance  = DATA(ro_model) ).

      CALL METHOD cl_usmd_crequest_util=>get_cr_type_by_cr
        EXPORTING
          i_crequest = COND #( WHEN iv_crequest IS NOT INITIAL THEN iv_crequest ELSE COND #( WHEN cl_usmd_app_context=>get_context( ) IS BOUND THEN cl_usmd_app_context=>get_context( )->mv_crequest_id  ) )
          io_model   = ro_model
        RECEIVING
          e_cr_type  = rv_usmd_crequest_type.
    ENDIF.

* #FallBack API Code
    IF rv_usmd_crequest_type IS INITIAL.

    IF cl_usmd_conv_som_gov_api=>check_instance_exists( 'MM' ) = abap_false.

     cl_usmd_crequest_api=>get_instance(
      EXPORTING
        iv_crequest          = COND #( WHEN cl_usmd_app_context=>get_context( ) IS BOUND THEN cl_usmd_app_context=>get_context( )->mv_crequest_id  )
        iv_model_name        = 'MM'
      IMPORTING
        re_inst_crequest_api = DATA(lo_cr_api)
    ).
    ENDIF.

      IF lo_cr_api IS BOUND.
        lo_cr_api->read_crequest( IMPORTING es_crequest = DATA(ls_crequest) ).
        rv_usmd_crequest_type = ls_crequest-usmd_creq_type.
      ENDIF.
    ENDIF.


* #FallBack API Code
    IF rv_usmd_crequest_type IS INITIAL.

    IF cl_usmd_conv_som_gov_api=>check_instance_exists( 'MM' ) = abap_false.
      TRY.
          cl_usmd_gov_api=>get_instance(
            EXPORTING
              iv_model_name = 'MM'
            RECEIVING
              ro_gov_api    = DATA(lo_gov)
          ).
        CATCH cx_usmd_gov_api.
*          Read exception and PAss it to ET_message
      ENDTRY.
    ENDIF.

      IF lo_gov IS BOUND.
        TRY.
            rv_usmd_crequest_type = lo_gov->get_crequest_attributes( iv_crequest_id =  COND #( WHEN iv_crequest IS NOT INITIAL THEN iv_crequest ELSE COND #( WHEN cl_usmd_app_context=>get_context( ) IS BOUND
                                                                                               THEN cl_usmd_app_context=>get_context( )->mv_crequest_id  ) ) )-usmd_creq_type.
          CATCH cx_usmd_gov_api_core_error. " CX_USMD_CORE_DYNAMIC_CHECK
          CATCH cx_usmd_gov_api.            " General Processing Error GOV_API
        ENDTRY.
      ENDIF.
    ENDIF.

*--------------------------------------------------------------------*
*While tesitng using Test Class since APIs are not Active we can check DB
*--------------------------------------------------------------------*
    IF rv_usmd_crequest_type IS INITIAL.
      SELECT SINGLE FROM usmd120c
                  FIELDS usmd_creq_type
                   WHERE usmd_crequest = @iv_crequest
                    INTO  @rv_usmd_crequest_type
                       .
    ENDIF.

  endmethod.


  method GET_INTERMEDIATE_DATES.
 DATA  : lt_dates      TYPE zzmdg_t_period_dates,
          ls_dates     TYPE zzmdg_s_period_dates,
          lv_prev_date TYPE p0001-begda,
          lv_next_date TYPE p0001-begda,
          lv_f_date    TYPE p0001-begda,
          lv_t_date    TYPE p0001-begda.


  IF im_periods IS NOT INITIAL.

    lt_dates = im_periods.

    LOOP AT lt_dates INTO ls_dates.
      lv_f_date = ls_dates-from_date.
      lv_t_date = ls_dates-to_date.
      CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
        EXPORTING
          date      = lv_f_date
          days      = '01'
          months    = '00'
          signum    = '-'
          years     = '00'
        IMPORTING
          calc_date = lv_prev_date.

      CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
        EXPORTING
          date      = lv_t_date
          days      = '01'
          months    = '00'
          signum    = '+'
          years     = '00'
        IMPORTING
          calc_date = lv_next_date.
    ENDLOOP.
    IF lv_prev_date IS NOT INITIAL AND lv_next_date IS NOT INITIAL.
      ex_prev_date = lv_prev_date.
      ex_next_date = lv_next_date.
    ENDIF.
  ENDIF.

  endmethod.


  METHOD if_mdg_bs_mat_api_segments_ext~check_and_save.

 CHECK 1 = 0.
    TYPES : BEGIN OF lty_cond_tab,
              lifnr TYPE  elifn,
              matnr	TYPE matnr,
              ekorg	TYPE ekorg,
              werks	TYPE werks_d,
              esokz	TYPE esokz,
              knumh	TYPE knumh,
              datab TYPE datab,
              datbi	TYPE kodatbi,
            END OF lty_cond_tab,

            BEGIN OF lty_cond_tab1,
              lifnr TYPE  elifn,
              matnr	TYPE matnr,
              ekorg	TYPE ekorg,
              esokz	TYPE esokz,
              knumh	TYPE knumh,
              datab TYPE datab,
              datbi TYPE  kodatbi,
            END OF lty_cond_tab1.

    DATA : lt_pir_data       TYPE zzmdg_bs_mat_t_eina,
           lt_pir_data_x     TYPE zzmdg_bs_mat_t_eina_x,
           lt_pog_data       TYPE zzmdg_bs_mat_t_eine,
           lt_pog_data_x     TYPE zzmdg_bs_mat_t_eine_x,
           lt_pcond_data     TYPE zzmdg_bs_mat_t_cond,
           lt_pcond_data_x   TYPE zzmdg_bs_mat_t_cond_x,
*         lt_konh           TYPE TABLE OF konh,
*         lt_konp           TYPE TABLE OF konp,
           lt_cond_tab       TYPE TABLE OF lty_cond_tab,
           lt_cond_tab_tmp   TYPE TABLE OF lty_cond_tab,
           lt_pcond_ins      TYPE STANDARD TABLE OF zzmdg_bs_mat_s_cond,
           lt_pcond_ins1     TYPE STANDARD TABLE OF zzmdg_bs_mat_s_cond,
           lt_pcond_upd      TYPE STANDARD TABLE OF zzmdg_bs_mat_s_cond,
           lt_pcond_upd1     TYPE STANDARD TABLE OF zzmdg_bs_mat_s_cond,
*         lt_eina           TYPE STANDARD TABLE OF eina,
*         lt_eina_ck        TYPE STANDARD TABLE OF eina,
*         lt_eine_o         TYPE STANDARD TABLE OF eine,
           lt_a017           TYPE STANDARD TABLE OF lty_cond_tab,
           lt_a018           TYPE STANDARD TABLE OF lty_cond_tab1,
*         lt_eine           TYPE STANDARD TABLE OF eine,
           lt_bapicondct     TYPE STANDARD TABLE OF bapicondct,
           lt_bapicondhd     TYPE STANDARD TABLE OF bapicondhd,
           lt_bapicondit     TYPE STANDARD TABLE OF bapicondit,
           lt_bapicondqs     TYPE STANDARD TABLE OF bapicondqs,
           lt_bapicondvs     TYPE STANDARD TABLE OF bapicondvs,
           lt_return         TYPE STANDARD TABLE OF bapiret2,
           lt_bapiknumhs     TYPE STANDARD TABLE OF bapiknumhs,
           lt_to_mem_initial TYPE STANDARD TABLE OF cnd_mem_initial,
           lt_periods        TYPE zzmdg_t_period_dates,
           ls_periods        TYPE zzmdg_s_period_dates,
           ls_pog_data       TYPE zzmdg_bs_mat_s_eine,
           ls_pcond_data     TYPE zzmdg_bs_mat_s_cond,
           ls_new_pcond      TYPE zzmdg_bs_mat_s_cond,
           ls_cond_tab       TYPE lty_cond_tab,
*         ls_eina           TYPE eina,
*         ls_konh           TYPE konh,
*         ls_konp           TYPE konp,
*         ls_a018           TYPE lty_cond_tab1,
           ls_pir_data       TYPE zzmdg_bs_mat_s_eina,
           ls_eina_s         TYPE eina,
           ls_eina_o         TYPE eina,
           ls_eine_s         TYPE eine,
           ls_eine_o         TYPE eine,
           ls_bapicondct     TYPE bapicondct,
           ls_bapicondhd     TYPE bapicondhd,
           ls_bapicondit     TYPE bapicondit,
           ls_bapicondqs     TYPE bapicondqs,
           ls_bapicondvs     TYPE bapicondvs,
           ls_return         TYPE bapiret2,
           ls_bapiknumhs     TYPE bapiknumhs,
           lt_eina_upd       TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eina,
           lt_eina_ins       TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eina,
           ls_eina_upd       LIKE LINE OF lt_eina_upd,
           lt_eine_upd       TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eine,
           lt_eine_ins       TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eine,
           lv_matnr          TYPE matnr,
           lv_varkey         TYPE char100,
           lv_cond_no        TYPE knumh,
           lv_count          TYPE knumh,
           lv_amount         TYPE bapicurext,
           lt_matnr_eina     TYPE TABLE OF matnr,
           lt_matnr_eine     TYPE TABLE OF matnr,
           ls_matnr_eine     LIKE LINE OF lt_matnr_eine,
           ls_matnr_eina     LIKE LINE OF lt_matnr_eina,
           lt_matnr_qinf     TYPE TABLE OF matnr,
           ls_matnr_qinf     LIKE LINE OF lt_matnr_qinf,
           lt_eina_temp      TYPE STANDARD TABLE OF eina,
           lt_eine_temp      TYPE STANDARD TABLE OF eine,
           lv_count_c        TYPE i,
           lv_prv_date       TYPE datum,
           lv_nxt_date       TYPE datum.


    DATA: ls_balhdri   TYPE balhdri,
          lt_balmi     TYPE TABLE OF balmi,
          ls_balmi     TYPE balmi,
          ls_return_pr TYPE mewi_ty_return.

    FIELD-SYMBOLS : <ls_konp>     TYPE zzmdg_bs_mat_s_cond,
                    <ls_cond_tab> TYPE lty_cond_tab.


    CONSTANTS: lc_log_obj    TYPE balobj_d  VALUE 'ZZMDG_MM_LOG',
               lc_log_subobj TYPE balsubobj VALUE 'ZZMDG_PIR_LOG'.

    DATA(lv_crtype) = get_cr_type( ).

    IF lv_crtype EQ 'ZMAT01' OR lv_crtype EQ 'ZMAT02'.

* For Application logging:
      CLEAR: ls_balmi, ls_balhdri.
      ls_balhdri-object     = lc_log_obj.
      ls_balhdri-subobject  = lc_log_subobj.

*    lt_matnr = is_data-mara_tab.
      lt_pir_data = is_data-zpurchgen_tab.
      lt_pog_data = is_data-zpurchinf_tab.
      lt_pcond_data = is_data-zpircond_tab.
      lt_pir_data_x = is_data-zpurchgen_x_tab.
      lt_pog_data_x = is_data-zpurchinf_x_tab.
      lt_pcond_data_x = is_data-zpircond_x_tab.

      IF lt_pir_data IS NOT INITIAL.
        SELECT *
         FROM eina
         INTO TABLE @DATA(lt_eina)
         FOR ALL ENTRIES IN @lt_pir_data
         WHERE matnr = @lt_pir_data-matnr.
        IF lt_eina IS NOT INITIAL.
          SORT lt_eina BY infnr matnr.
        ENDIF.
      ENDIF.

      IF lt_pog_data IS NOT INITIAL.
        SELECT *
          FROM eine
          INTO TABLE @DATA(lt_eine_o)
          FOR ALL ENTRIES IN @lt_pog_data
          WHERE infnr = @lt_pog_data-infnr
            AND esokz = @lt_pog_data-esokz.
        IF lt_eine_o IS NOT INITIAL.
          SORT lt_eine_o BY infnr esokz.
        ENDIF.
      ENDIF.

      IF lt_pcond_data IS NOT INITIAL.
        SELECT lifnr matnr ekorg werks esokz knumh datab datbi
          FROM a017
          INTO TABLE lt_a017
          FOR ALL ENTRIES IN lt_pcond_data
          WHERE matnr = lt_pcond_data-matnr
          AND lifnr = lt_pcond_data-lifnr
          AND ekorg = lt_pcond_data-ekorg
          AND werks = lt_pcond_data-werks.
*      AND datbi = lt_pcond_data-datbi.
        IF sy-subrc IS INITIAL.
          SORT lt_a017 BY knumh.
        ENDIF.

        APPEND LINES OF lt_a017 TO lt_cond_tab.
        IF lt_pcond_data IS NOT INITIAL.
          SELECT lifnr matnr ekorg esokz knumh datab datbi
           FROM a018
           INTO TABLE lt_a018
           FOR ALL ENTRIES IN lt_pcond_data
           WHERE matnr = lt_pcond_data-matnr
           AND lifnr = lt_pcond_data-lifnr
           AND ekorg = lt_pcond_data-ekorg.
*       AND datbi = lt_pcond_data-datbi.
          IF sy-subrc IS INITIAL.
            SORT lt_a018 BY knumh.
          ENDIF.
        ENDIF.

        LOOP AT lt_a018 INTO DATA(ls_a018).
          ls_cond_tab-matnr = ls_a018-matnr.
          ls_cond_tab-ekorg = ls_a018-ekorg.
          ls_cond_tab-esokz = ls_a018-esokz.
          ls_cond_tab-knumh = ls_a018-knumh.
          ls_cond_tab-lifnr = ls_a018-lifnr.
          ls_cond_tab-datab = ls_a018-datab.
          ls_cond_tab-datbi = ls_a018-datbi.
          APPEND ls_cond_tab TO lt_cond_tab.
          CLEAR ls_cond_tab.
        ENDLOOP.
        SORT lt_cond_tab BY knumh.

        IF lt_cond_tab IS NOT INITIAL.

          SELECT *
            FROM konh
            INTO TABLE @DATA(lt_konh)
            FOR ALL ENTRIES IN @lt_cond_tab
            WHERE knumh = @lt_cond_tab-knumh.

          IF sy-subrc IS INITIAL.
            SORT lt_konh BY knumh.
          ENDIF.
        ENDIF.

        IF lt_cond_tab IS NOT INITIAL.
          SELECT *
            FROM konp
            INTO TABLE @DATA(lt_konp)
            FOR ALL ENTRIES IN @lt_cond_tab
            WHERE knumh = @lt_cond_tab-knumh.
          IF sy-subrc IS INITIAL.
            SORT lt_konp BY knumh.
          ENDIF.
        ENDIF.
      ENDIF.


      "Separate Update and Insert cases
      LOOP AT lt_pir_data INTO ls_pir_data.
        AT NEW matnr.
          ls_matnr_eina = ls_pir_data-matnr.
          APPEND ls_matnr_eina TO lt_matnr_eina.
        ENDAT.
*      READ TABLE lt_eina TRANSPORTING NO FIELDS WITH KEY matnr = ls_pir_data-matnr infnr = ls_pir_data-infnr." BINARY SEARCH.
        IF line_exists( lt_eina[ matnr = ls_pir_data-matnr infnr = ls_pir_data-infnr ] ).
          APPEND ls_pir_data TO lt_eina_upd.
        ELSE.
          APPEND ls_pir_data TO lt_eina_ins.
        ENDIF.
      ENDLOOP.

      LOOP AT lt_pog_data INTO ls_pog_data.
*      READ TABLE lt_eine_o TRANSPORTING NO FIELDS WITH KEY infnr = ls_pog_data-infnr esokz = ls_pog_data-esokz." BINARY SEARCH.
        IF line_exists( lt_eine_o[ infnr = ls_pog_data-infnr esokz = ls_pog_data-esokz ] ).
          APPEND ls_pog_data TO lt_eine_upd.
        ELSE.
          APPEND ls_pog_data TO lt_eine_ins.
        ENDIF.

        CLEAR ls_pog_data.
      ENDLOOP.

      LOOP AT lt_pcond_data INTO ls_pcond_data.

*      READ TABLE lt_cond_tab TRANSPORTING NO FIELDS WITH KEY matnr = ls_pcond_data-matnr
*                                                             lifnr = ls_pcond_data-lifnr
*                                                             ekorg = ls_pcond_data-ekorg
*                                                             werks = ls_pcond_data-werks
*                                                             datab = ls_pcond_data-datab
*                                                             datbi = ls_pcond_data-datbi
*                                                             esokz = ls_pcond_data-esokz.

        IF line_exists( lt_cond_tab[ matnr = ls_pcond_data-matnr lifnr = ls_pcond_data-lifnr ekorg = ls_pcond_data-ekorg
                                     werks = ls_pcond_data-werks datab = ls_pcond_data-datab datbi = ls_pcond_data-datbi
                                     esokz = ls_pcond_data-esokz ] ).
          APPEND ls_pcond_data TO lt_pcond_upd.

        ELSE.
          APPEND ls_pcond_data TO lt_pcond_ins.
        ENDIF.

        CLEAR ls_pcond_data.
      ENDLOOP.

      SORT lt_matnr_eina.
      DELETE ADJACENT DUPLICATES FROM lt_matnr_eina.

      IF iv_segment EQ 'ZZMDG_BS_MAT_S_EINA'  AND iv_test_mode IS INITIAL.
        "Insert
        IF lt_eina_ins IS NOT INITIAL.
          DATA : lv_lines TYPE i.
          DESCRIBE TABLE lt_matnr_eina LINES lv_lines.
          CALL FUNCTION 'ZZMDG_PURCHASE_INFO_REC_SAVE' IN UPDATE TASK
            EXPORTING
              iv_matnr = lv_matnr
              iv_count = lv_lines
            TABLES
              t_eina   = lt_eina_ins
              t_eine   = lt_eine_ins
              t_konp   = lt_pcond_ins.

        ENDIF.

        "Update Case
        IF lt_eina_upd IS NOT INITIAL OR lt_eine_upd IS NOT INITIAL.
          IF lt_pog_data IS NOT INITIAL.
            SELECT *
              FROM eina
              INTO TABLE lt_eina_temp
              FOR ALL ENTRIES IN lt_pog_data
              WHERE infnr = lt_pog_data-infnr.
          ENDIF.

          IF lt_pir_data IS NOT INITIAL.
            SELECT *
              FROM eine
              INTO TABLE lt_eine_temp
              FOR ALL ENTRIES IN lt_pir_data
              WHERE infnr = lt_pir_data-infnr.
          ENDIF.

          IF lt_eina_temp IS NOT INITIAL.
            INSERT LINES OF lt_eina_temp INTO TABLE lt_eina.
            SORT lt_eina BY matnr infnr.
            DELETE ADJACENT DUPLICATES FROM lt_eina COMPARING matnr infnr .

            INSERT LINES OF lt_eina_temp INTO TABLE lt_eina_upd.
            SORT lt_eina_upd BY matnr infnr.
            DELETE ADJACENT DUPLICATES FROM lt_eina_upd.
          ENDIF.

          IF lt_eine_temp IS NOT INITIAL.
            INSERT LINES OF lt_eine_temp INTO TABLE lt_eine_o.
            SORT lt_eine_o BY infnr esokz.
            DELETE ADJACENT DUPLICATES FROM lt_eine_o COMPARING infnr esokz .
          ENDIF.

          LOOP AT lt_eina_upd INTO ls_eina_upd.
            MOVE-CORRESPONDING ls_eina_upd TO ls_eina_s.

            LOOP AT lt_eine_upd INTO ls_pog_data WHERE infnr = ls_eina_upd-infnr.

              MOVE-CORRESPONDING ls_pog_data TO ls_eine_s.


*            READ TABLE lt_eina INTO ls_eina_o WITH KEY infnr = ls_eina_s-infnr.
*
*            READ TABLE lt_eine_o INTO ls_eine_o WITH KEY infnr = ls_eine_s-infnr esokz = ls_eine_s-esokz.

              ls_eina_o = lt_eina[ infnr = ls_eina_s-infnr ].
              ls_eine_o = lt_eine_o[ infnr = ls_eine_s-infnr esokz = ls_eine_s-esokz ].

              ls_eina_s-lmein = ls_eina_o-lmein.
              ls_eine_s-effpr = ls_eine_s-netpr.

              ls_eine_s-esokz = ls_eine_o-esokz.
              ls_eina_s-erdat = ls_eina_o-erdat.
              ls_eina_s-ernam = ls_eina_o-ernam.
              ls_eine_s-erdat = ls_eine_o-erdat.
              ls_eine_s-ernam = ls_eine_o-ernam.

              CALL FUNCTION 'ME_UPDATE_INFORECORD' IN UPDATE TASK
                EXPORTING
                  xeina    = ls_eina_s
                  xeine    = ls_eine_s
                  yeina    = ls_eina_o
                  yeine    = ls_eine_o
                  reg_eina = ls_eina_o.

              CLEAR : ls_eina_s, ls_eine_s, ls_eina_o, ls_eine_o.
            ENDLOOP.
          ENDLOOP.
**        code to only update PIR general data
          LOOP AT lt_eina_upd INTO ls_eina_upd.
            MOVE-CORRESPONDING ls_eina_upd TO ls_eina_s.
*          READ TABLE lt_eina INTO ls_eina_o WITH KEY infnr = ls_eina_s-infnr.

            ls_eina_o = lt_eina[ infnr = ls_eina_s-infnr ].

            IF sy-subrc = 0.
              ls_eina_s-lmein = ls_eina_o-lmein.
              ls_eina_s-erdat = ls_eina_o-erdat.
              ls_eina_s-ernam = ls_eina_o-ernam.
              CALL FUNCTION 'ME_UPDATE_INFORECORD' IN UPDATE TASK
                EXPORTING
                  xeina    = ls_eina_s
                  xeine    = ls_eine_s
                  yeina    = ls_eina_o
                  yeine    = ls_eine_o
                  reg_eina = ls_eina_o.
              CLEAR : ls_eina_s, ls_eine_s, ls_eina_o, ls_eine_o.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.

****PIR Condition insert and update
      IF iv_segment EQ 'ZZMDG_BS_MAT_S_COND' AND iv_test_mode EQ abap_false.
        SELECT *
          FROM eina
          INTO TABLE @DATA(lt_eina_ck)
          FOR ALL ENTRIES IN @lt_pcond_data
          WHERE matnr = @lt_pcond_data-matnr. "#EC CI_ALL_FIELDS_NEEDED
        IF sy-subrc IS INITIAL.
          IF lt_pcond_ins IS NOT INITIAL.
            IF lt_cond_tab IS INITIAL.
              me->get_condition_records(
                EXPORTING
                  gt_pcond_list =  lt_pcond_data
                IMPORTING
                  gt_a017       = lt_cond_tab
                  gt_konh       =   lt_konh
                  gt_konp       =  lt_konp
              ).
            ENDIF.

            LOOP AT lt_pcond_ins INTO ls_pcond_data WHERE werks IS INITIAL.
              APPEND ls_pcond_data TO lt_pcond_ins1.
              CLEAR : ls_pcond_data.
            ENDLOOP.

            lt_cond_tab_tmp = lt_cond_tab.
            SORT lt_cond_tab_tmp BY datab DESCENDING.
            SORT lt_pcond_ins BY lifnr ekorg werks datab.
            LOOP AT lt_pcond_ins INTO ls_pcond_data WHERE werks IS NOT INITIAL.
              CLEAR : lv_prv_date, lv_nxt_date.
              READ TABLE lt_cond_tab_tmp ASSIGNING <ls_cond_tab> WITH KEY matnr = ls_pcond_data-matnr
                                                                          lifnr = ls_pcond_data-lifnr
                                                                          ekorg = ls_pcond_data-ekorg
                                                                          werks = ls_pcond_data-werks
                                                                          esokz = ls_pcond_data-esokz.
              IF sy-subrc IS INITIAL.
                IF ls_pcond_data-datab > <ls_cond_tab>-datab AND ls_pcond_data-datbi < <ls_cond_tab>-datbi.
                  ls_periods-from_date = ls_pcond_data-datab.
                  ls_periods-to_date = ls_pcond_data-datbi.
                  APPEND ls_periods TO lt_periods.
                  CLEAR ls_periods.
                  me->get_intermediate_dates(
                    EXPORTING
                      im_periods   = lt_periods                  " Table Type for Periods
                    IMPORTING
                      ex_prev_date = lv_prv_date                 " Valid-From Date
                      ex_next_date = lv_nxt_date                 " Date
                  ).

                  READ TABLE lt_pcond_upd ASSIGNING <ls_konp> WITH KEY matnr = <ls_cond_tab>-matnr
                                                                       lifnr = <ls_cond_tab>-lifnr
                                                                       ekorg = <ls_cond_tab>-ekorg
                                                                       werks = <ls_cond_tab>-werks
                                                                       datab = <ls_cond_tab>-datab
                                                                       datbi = <ls_cond_tab>-datbi
                                                                       esokz = <ls_cond_tab>-esokz.
                  IF sy-subrc  IS INITIAL.
                    <ls_konp>-datbi = lv_prv_date.
                    <ls_cond_tab>-datab = lv_nxt_date.
                    IF <ls_konp>-knumh IS INITIAL.
                      <ls_konp>-knumh = <ls_cond_tab>-knumh.
                    ENDIF.
                  ELSE.
                    MOVE-CORRESPONDING <ls_cond_tab> TO ls_new_pcond.
*                  READ TABLE lt_konp INTO DATA(ls_konp) WITH KEY knumh = ls_new_pcond-knumh.
                    DATA(ls_konp) = lt_konp[ knumh = ls_new_pcond-knumh ].

                    IF sy-subrc IS INITIAL.
                      MOVE-CORRESPONDING ls_konp TO ls_new_pcond.
                      IF lt_pcond_upd IS NOT INITIAL.
                        READ TABLE lt_pcond_upd ASSIGNING <ls_konp> WITH KEY matnr = <ls_cond_tab>-matnr
                                                                             lifnr = <ls_cond_tab>-lifnr
                                                                             ekorg = <ls_cond_tab>-ekorg
                                                                             werks = <ls_cond_tab>-werks
                                                                             esokz = <ls_cond_tab>-esokz.
                        IF sy-subrc IS INITIAL.
                          ls_new_pcond-kbetr_c = <ls_konp>-kbetr_c.
                        ENDIF.
                      ELSE.
                        ls_new_pcond-kbetr_c = ls_konp-kbetr.
                      ENDIF.
                      ls_new_pcond-kmein_c = ls_konp-kmein.
                      ls_new_pcond-kpein_c = ls_konp-kpein.
                      IF ls_new_pcond-lifnr IS INITIAL.
                        ls_new_pcond-lifnr = ls_pcond_data-lifnr.
                      ENDIF.
                    ENDIF.
                    ls_new_pcond-datbi = lv_prv_date.
                    APPEND ls_new_pcond TO lt_pcond_upd1.
                    <ls_cond_tab>-datab = lv_nxt_date.
                  ENDIF.
                ENDIF.
              ENDIF.
              CLEAR : ls_pcond_data,ls_new_pcond, lt_periods.
            ENDLOOP.

            IF <ls_cond_tab> IS ASSIGNED AND <ls_cond_tab> IS NOT INITIAL.
              MOVE-CORRESPONDING <ls_cond_tab> TO ls_new_pcond.
*            READ TABLE lt_konp INTO ls_konp WITH KEY knumh = ls_new_pcond-knumh.
              ls_konp = lt_konp[ knumh = ls_new_pcond-knumh ].
              IF sy-subrc IS INITIAL.
                MOVE-CORRESPONDING ls_konp TO ls_new_pcond.
                IF lt_pcond_upd IS NOT INITIAL.
                  READ TABLE lt_pcond_upd ASSIGNING <ls_konp> WITH KEY matnr = <ls_cond_tab>-matnr
                                                                       lifnr = <ls_cond_tab>-lifnr
                                                                       ekorg = <ls_cond_tab>-ekorg
                                                                       werks = <ls_cond_tab>-werks
                                                                       esokz = <ls_cond_tab>-esokz.
                  IF sy-subrc IS INITIAL.
                    ls_new_pcond-kbetr_c = <ls_konp>-kbetr_c.
                  ENDIF.
                ELSE.
                  ls_new_pcond-kbetr_c = ls_konp-kbetr.
                ENDIF.
                IF ls_new_pcond-lifnr IS INITIAL.
                  ls_new_pcond-lifnr = <ls_cond_tab>-lifnr.
                ENDIF.
                ls_new_pcond-kmein_c = ls_konp-kmein.
                ls_new_pcond-kpein_c = ls_konp-kpein.
                ls_new_pcond-datab = lv_nxt_date.
                APPEND ls_new_pcond TO lt_pcond_upd1.
                CLEAR : ls_new_pcond.
              ENDIF.
            ENDIF.

            IF lt_pcond_ins1 IS NOT INITIAL.
              SORT lt_pcond_ins1 BY lifnr ekorg werks datab.
              LOOP AT lt_pcond_ins1 INTO ls_pcond_data WHERE werks IS INITIAL.
                CLEAR : lv_prv_date, lv_nxt_date.
                READ TABLE lt_cond_tab_tmp ASSIGNING <ls_cond_tab> WITH KEY   matnr = ls_pcond_data-matnr
                                                                              lifnr = ls_pcond_data-lifnr
                                                                              ekorg = ls_pcond_data-ekorg
                                                                              werks = ls_pcond_data-werks
                                                                              esokz = ls_pcond_data-esokz.
                IF sy-subrc IS INITIAL.
                  IF ls_pcond_data-datab > <ls_cond_tab>-datab AND ls_pcond_data-datbi < <ls_cond_tab>-datbi.
                    ls_periods-from_date = ls_pcond_data-datab.
                    ls_periods-to_date = ls_pcond_data-datbi.
                    APPEND ls_periods TO lt_periods.
                    CLEAR ls_periods.
                    me->get_intermediate_dates(
                      EXPORTING
                        im_periods   = lt_periods                  " Table Type for Periods
                      IMPORTING
                        ex_prev_date = lv_prv_date                 " Valid-From Date
                        ex_next_date = lv_nxt_date                 " Date
                    ).

                    READ TABLE lt_pcond_upd ASSIGNING <ls_konp> WITH KEY  matnr = <ls_cond_tab>-matnr
                                                                          lifnr = <ls_cond_tab>-lifnr
                                                                          ekorg = <ls_cond_tab>-ekorg
                                                                          werks = <ls_cond_tab>-werks
                                                                          datab = <ls_cond_tab>-datab
                                                                          datbi = <ls_cond_tab>-datbi
                                                                          esokz = <ls_cond_tab>-esokz.
                    IF sy-subrc  IS INITIAL.
                      <ls_konp>-datbi = lv_prv_date.
                      <ls_cond_tab>-datab = lv_nxt_date.
                    ELSE.
                      MOVE-CORRESPONDING <ls_cond_tab> TO ls_new_pcond.
*                    READ TABLE lt_konp INTO ls_konp WITH KEY knumh = ls_new_pcond-knumh.
                      ls_konp = lt_konp[ knumh = ls_new_pcond-knumh ].
                      IF sy-subrc IS INITIAL.
                        MOVE-CORRESPONDING ls_konp TO ls_new_pcond.
                        IF lt_pcond_upd IS NOT INITIAL.
                          READ TABLE lt_pcond_upd ASSIGNING <ls_konp> WITH KEY matnr = <ls_cond_tab>-matnr
                                                                               lifnr = <ls_cond_tab>-lifnr
                                                                               ekorg = <ls_cond_tab>-ekorg
                                                                               werks = <ls_cond_tab>-werks
                                                                               esokz = <ls_cond_tab>-esokz.
                          IF sy-subrc IS INITIAL.
                            ls_new_pcond-kbetr_c = <ls_konp>-kbetr_c.
                          ELSE.
                            ls_new_pcond-kbetr_c = ls_konp-kbetr.
                          ENDIF.
                        ENDIF.
                        ls_new_pcond-kmein_c = ls_konp-kmein.
                        ls_new_pcond-kpein_c = ls_konp-kpein.
                        IF ls_new_pcond-lifnr IS INITIAL.
                          ls_new_pcond-lifnr = ls_pcond_data-lifnr.
                        ENDIF.
                      ENDIF.
                      ls_new_pcond-datbi = lv_prv_date.
                      APPEND ls_new_pcond TO lt_pcond_upd1.
                      <ls_cond_tab>-datab = lv_nxt_date.
                    ENDIF.
                  ENDIF.
                ENDIF.
                CLEAR : ls_pcond_data,ls_new_pcond, lt_periods.
              ENDLOOP.
              IF <ls_cond_tab> IS ASSIGNED.
                MOVE-CORRESPONDING <ls_cond_tab> TO ls_new_pcond.
*              READ TABLE lt_konp INTO ls_konp WITH KEY knumh = ls_new_pcond-knumh.
                ls_konp = lt_konp[ knumh = ls_new_pcond-knumh ].
                IF sy-subrc IS INITIAL.
                  MOVE-CORRESPONDING ls_konp TO ls_new_pcond.
                  IF lt_pcond_upd IS NOT INITIAL.
                    READ TABLE lt_pcond_upd ASSIGNING <ls_konp> WITH KEY matnr = <ls_cond_tab>-matnr
                                                                         lifnr = <ls_cond_tab>-lifnr
                                                                         ekorg = <ls_cond_tab>-ekorg
                                                                         werks = <ls_cond_tab>-werks
                                                                         esokz = <ls_cond_tab>-esokz.
                    IF sy-subrc IS INITIAL.
                      ls_new_pcond-kbetr_c = <ls_konp>-kbetr_c.
                    ELSE.
                      ls_new_pcond-kbetr_c = ls_konp-kbetr.
                    ENDIF.
                  ENDIF.
                  IF ls_new_pcond-lifnr IS INITIAL.
                    ls_new_pcond-lifnr = <ls_cond_tab>-lifnr.
                  ENDIF.
                  ls_new_pcond-kmein_c = ls_konp-kmein.
                  ls_new_pcond-kpein_c = ls_konp-kpein.
                  ls_new_pcond-datab = lv_nxt_date.
                  APPEND ls_new_pcond TO lt_pcond_upd1.
                  CLEAR : ls_new_pcond.
                ENDIF.
              ENDIF.
            ENDIF.

            CLEAR : lt_bapicondct, lt_bapicondhd, lt_bapicondit,lv_nxt_date,lv_prv_date.

            IF lt_pcond_ins IS NOT INITIAL.
              LOOP AT lt_pcond_ins INTO ls_pcond_data.
                ls_bapicondct-operation = '009'.
                ls_bapicondct-cond_usage = 'A'.
                IF ls_pcond_data-werks IS NOT INITIAL.
                  ls_bapicondct-table_no = '017'.
                ELSE.
                  ls_bapicondct-table_no = '018'.
                ENDIF.
                ls_bapicondct-applicatio = 'M'.
                ls_bapicondct-cond_type = 'PB00'.

                lv_count = lv_count + 1.
                CONDENSE lv_count.
                CONCATENATE '$' lv_count INTO lv_cond_no.
                CONCATENATE ls_pcond_data-lifnr ls_pcond_data-matnr ls_pcond_data-ekorg ls_pcond_data-werks ls_pcond_data-esokz INTO lv_varkey.
                ls_bapicondct-varkey = lv_varkey.
                ls_bapicondct-valid_from = ls_pcond_data-datab.
                ls_bapicondct-valid_to = ls_pcond_data-datbi.
                ls_bapicondct-cond_no = lv_cond_no.
                APPEND ls_bapicondct TO lt_bapicondct.
                CLEAR ls_bapicondct.

                ls_bapicondhd-operation = '009'.
                ls_bapicondhd-cond_no = lv_cond_no.
                ls_bapicondhd-created_by = sy-uname.
                ls_bapicondhd-creat_date = sy-datum.
                ls_bapicondhd-cond_usage = 'A'.
                IF ls_pcond_data-werks IS NOT INITIAL.
                  ls_bapicondhd-table_no = '017'.
                ELSE.
                  ls_bapicondhd-table_no = '018'.
                ENDIF.
                ls_bapicondhd-applicatio = 'M'.
                ls_bapicondhd-cond_type = 'PB00'.
                ls_bapicondhd-varkey = lv_varkey.
                ls_bapicondhd-valid_from = ls_pcond_data-datab.
                ls_bapicondhd-valid_to = ls_pcond_data-datbi.
                APPEND ls_bapicondhd TO lt_bapicondhd.
                CLEAR ls_bapicondhd.

                ls_bapicondit-operation = '009'.
                ls_bapicondit-cond_no = lv_cond_no.
                ls_bapicondit-cond_count = 01.
                ls_bapicondit-applicatio = 'M'.
                ls_bapicondit-cond_type = 'PB00'.
                ls_bapicondit-scaletype = 'A'.
                ls_bapicondit-currenckey = ls_pcond_data-konwa.
                ls_bapicondit-calctypcon = ls_pcond_data-krech.
                ls_bapicondit-cond_value = ls_pcond_data-kbetr_c.
                ls_bapicondit-condcurr = ls_pcond_data-konwa.
                ls_bapicondit-cond_p_unt = ls_pcond_data-kpein_c.
                ls_bapicondit-cond_unit = ls_pcond_data-kmein_c.
                ls_bapicondit-exclusion = ls_pcond_data-kznep_c.
                ls_bapicondit-indidelete = ls_pcond_data-loevm_ko.
                ls_bapicondit-add_val_dy = ls_pcond_data-valtg.
                ls_bapicondit-vendor_no = ls_pcond_data-lifnr.
                ls_bapicondit-fix_val_dy = ls_pcond_data-valdt.
                ls_bapicondit-pmnttrms = ls_pcond_data-zterm.
                APPEND ls_bapicondit TO lt_bapicondit.
                CLEAR : ls_bapicondit, lv_cond_no.
              ENDLOOP.
            ENDIF.

            CALL FUNCTION 'BAPI_PRICES_CONDITIONS'
              TABLES
                ti_bapicondct  = lt_bapicondct
                ti_bapicondhd  = lt_bapicondhd
                ti_bapicondit  = lt_bapicondit
                ti_bapicondqs  = lt_bapicondqs
                ti_bapicondvs  = lt_bapicondvs
                to_bapiret2    = lt_return
                to_bapiknumhs  = lt_bapiknumhs
                to_mem_initial = lt_to_mem_initial.

*         Application logging:
            REFRESH lt_balmi.
            LOOP AT lt_return INTO ls_return.
              CLEAR ls_balmi.
              ls_balmi-msgid = ls_return-id.
              ls_balmi-msgty = ls_return-type.
              ls_balmi-msgno = ls_return-number.
              ls_balmi-msgv1 = ls_return-message_v1.
              ls_balmi-msgv2 = ls_return-message_v2.
              ls_balmi-msgv3 = ls_return-message_v3.
              ls_balmi-msgv4 = ls_return-message_v4.
              APPEND ls_balmi TO lt_balmi.
            ENDLOOP.

            IF lt_balmi IS NOT INITIAL AND iv_test_mode = abap_false.
              CALL FUNCTION 'ZZMDG_FM_APPL_LOG_CREATE'
                EXPORTING
                  balhdri  = ls_balhdri
                TABLES
                  messages = lt_balmi.
            ENDIF.

            IF lt_pcond_upd1 IS NOT INITIAL.
              CLEAR : lt_bapicondct, lt_bapicondhd, lt_bapicondit.
              LOOP AT lt_pcond_upd1 INTO ls_pcond_data.
*              READ TABLE lt_cond_tab INTO ls_cond_tab WITH KEY matnr = ls_pcond_data-matnr
*                                                               lifnr = ls_pcond_data-lifnr
*                                                               ekorg = ls_pcond_data-ekorg
*                                                               esokz = ls_pcond_data-esokz. "
                ls_cond_tab =  lt_cond_tab[ matnr = ls_pcond_data-matnr lifnr = ls_pcond_data-lifnr ekorg = ls_pcond_data-ekorg esokz = ls_pcond_data-esokz ].
                IF sy-subrc IS INITIAL.
*                READ TABLE lt_konh INTO DATA(ls_konh) WITH KEY knumh = ls_cond_tab-knumh.
                  DATA(ls_konh) = lt_konh[ knumh = ls_cond_tab-knumh ].
                  IF sy-subrc IS INITIAL.
*                  READ TABLE lt_konp INTO ls_konp WITH KEY knumh = ls_cond_tab-knumh.
                    ls_konp = lt_konp[ knumh = ls_cond_tab-knumh ].
                  ENDIF.
                ENDIF.


                ls_bapicondct-operation = '004'.
                ls_bapicondct-cond_usage = ls_konh-kvewe.
                ls_bapicondct-table_no = ls_konh-kotabnr.
                ls_bapicondct-applicatio = ls_konh-kappl.
                ls_bapicondct-cond_type = ls_konh-kschl.
                CONCATENATE ls_pcond_data-lifnr ls_pcond_data-matnr ls_pcond_data-ekorg ls_pcond_data-werks ls_pcond_data-esokz INTO lv_varkey.
                ls_bapicondct-varkey = lv_varkey.
                ls_bapicondct-valid_from = ls_pcond_data-datab.
                ls_bapicondct-valid_to = ls_pcond_data-datbi.
                ls_bapicondct-cond_no = ls_konh-knumh.
                APPEND ls_bapicondct TO lt_bapicondct.
                CLEAR ls_bapicondct.

                ls_bapicondhd-operation = '004'.
                ls_bapicondhd-cond_no = ls_konh-knumh.
                ls_bapicondhd-varkey = lv_varkey.
                ls_bapicondhd-created_by = sy-uname.
                ls_bapicondhd-creat_date = sy-datum.
                ls_bapicondhd-cond_usage = ls_konh-kvewe.
                ls_bapicondhd-table_no = ls_konh-kotabnr.
                ls_bapicondhd-applicatio = ls_konh-kappl.
                ls_bapicondhd-cond_type = ls_konh-kschl.
                ls_bapicondhd-valid_from = ls_pcond_data-datab.
                ls_bapicondhd-valid_to = ls_pcond_data-datbi.
                APPEND ls_bapicondhd TO lt_bapicondhd.
                CLEAR ls_bapicondhd.

                ls_bapicondit-operation = '004'.
                ls_bapicondit-cond_no = ls_konp-knumh.
                ls_bapicondit-cond_count = ls_konp-kopos.
                ls_bapicondit-applicatio = ls_konp-kappl.
                ls_bapicondit-cond_type = ls_konp-kschl.
                ls_bapicondit-scaletype = ls_konp-stfkz.
                ls_bapicondit-scalebasin = ls_pcond_data-kzbzg.
                ls_bapicondit-scale_qty = ls_konp-kstbm.
                ls_bapicondit-currenckey = ls_pcond_data-konwa..
                ls_bapicondit-calctypcon = ls_pcond_data-krech.
                lv_amount = ls_pcond_data-kbetr_c.
                ls_bapicondit-cond_value = lv_amount.
                ls_bapicondit-condcurr = ls_pcond_data-konwa.
                ls_bapicondit-cond_p_unt = ls_pcond_data-kpein_c.
                ls_bapicondit-cond_unit = ls_pcond_data-kmein_c.
                ls_bapicondit-exclusion = ls_pcond_data-kznep_c.
                ls_bapicondit-vendor_no = ls_pcond_data-lifnr.
                ls_bapicondit-indidelete = ls_pcond_data-loevm_ko.
                ls_bapicondit-add_val_dy = ls_pcond_data-valtg.
                ls_bapicondit-fix_val_dy = ls_pcond_data-valdt.
                ls_bapicondit-pmnttrms = ls_pcond_data-zterm.
                APPEND ls_bapicondit TO lt_bapicondit.
                CLEAR ls_bapicondit.
              ENDLOOP.

              CALL FUNCTION 'BAPI_PRICES_CONDITIONS'
                TABLES
                  ti_bapicondct  = lt_bapicondct
                  ti_bapicondhd  = lt_bapicondhd
                  ti_bapicondit  = lt_bapicondit
                  ti_bapicondqs  = lt_bapicondqs
                  ti_bapicondvs  = lt_bapicondvs
                  to_bapiret2    = lt_return
                  to_bapiknumhs  = lt_bapiknumhs
                  to_mem_initial = lt_to_mem_initial
                EXCEPTIONS
                  update_error   = 1
                  OTHERS         = 2.

*           Application logging:
              REFRESH lt_balmi.
              LOOP AT lt_return INTO ls_return.
                CLEAR ls_balmi.
                ls_balmi-msgid = ls_return-id.
                ls_balmi-msgty = ls_return-type.
                ls_balmi-msgno = ls_return-number.
                ls_balmi-msgv1 = ls_return-message_v1.
                ls_balmi-msgv2 = ls_return-message_v2.
                ls_balmi-msgv3 = ls_return-message_v3.
                ls_balmi-msgv4 = ls_return-message_v4.
                APPEND ls_balmi TO lt_balmi.
              ENDLOOP.

              IF lt_balmi IS NOT INITIAL AND iv_test_mode = abap_false..
                CALL FUNCTION 'ZZMDG_FM_APPL_LOG_CREATE'
                  EXPORTING
                    balhdri  = ls_balhdri
                  TABLES
                    messages = lt_balmi.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

***Update PIR Condition
      IF iv_segment EQ 'ZZMDG_BS_MAT_S_COND' AND lt_pcond_upd IS NOT INITIAL AND iv_test_mode EQ abap_false.

        LOOP AT lt_pcond_upd INTO ls_pcond_data.
          CLEAR : lt_bapicondct, lt_bapicondhd, lt_bapicondit.

*        READ TABLE lt_cond_tab INTO ls_cond_tab WITH KEY matnr = ls_pcond_data-matnr
*                                                         lifnr = ls_pcond_data-lifnr
*                                                         ekorg = ls_pcond_data-ekorg
*                                                         esokz = ls_pcond_data-esokz.

          ls_cond_tab = lt_cond_tab[ matnr = ls_pcond_data-matnr lifnr = ls_pcond_data-lifnr ekorg = ls_pcond_data-ekorg esokz = ls_pcond_data-esokz ].
          IF sy-subrc IS INITIAL.
*          READ TABLE lt_konh INTO ls_konh WITH KEY knumh = ls_cond_tab-knumh.
            ls_konh = lt_konh[  knumh = ls_cond_tab-knumh ].
            IF sy-subrc IS INITIAL.
*            READ TABLE lt_konp INTO ls_konp WITH KEY knumh = ls_cond_tab-knumh.
              ls_konp = lt_konp[ knumh = ls_cond_tab-knumh ].
            ENDIF.
          ENDIF.

          ls_bapicondct-operation = '004'.
          ls_bapicondct-cond_usage = ls_konh-kvewe.
          ls_bapicondct-table_no = ls_konh-kotabnr.
          ls_bapicondct-applicatio = ls_konh-kappl.
          ls_bapicondct-cond_type = ls_konh-kschl.
          CONCATENATE ls_pcond_data-lifnr ls_pcond_data-matnr ls_pcond_data-ekorg ls_pcond_data-werks ls_pcond_data-esokz INTO lv_varkey.
          ls_bapicondct-varkey = lv_varkey.
          ls_bapicondct-valid_from = ls_pcond_data-datab.
          ls_bapicondct-valid_to = ls_pcond_data-datbi.
          ls_bapicondct-cond_no = ls_konh-knumh.
          APPEND ls_bapicondct TO lt_bapicondct.
          CLEAR ls_bapicondct.

          ls_bapicondhd-operation = '004'.
          ls_bapicondhd-cond_no = ls_konh-knumh.
          ls_bapicondhd-varkey = lv_varkey.
          ls_bapicondhd-created_by = sy-uname.
          ls_bapicondhd-creat_date = sy-datum.
          ls_bapicondhd-cond_usage = ls_konh-kvewe.
          ls_bapicondhd-table_no = ls_konh-kotabnr.
          ls_bapicondhd-applicatio = ls_konh-kappl.
          ls_bapicondhd-cond_type = ls_konh-kschl.
          ls_bapicondhd-valid_from = ls_pcond_data-datab.
          ls_bapicondhd-valid_to = ls_pcond_data-datbi.
          APPEND ls_bapicondhd TO lt_bapicondhd.
          CLEAR ls_bapicondhd.

          ls_bapicondit-operation = '004'.
          ls_bapicondit-cond_no = ls_konp-knumh.
          ls_bapicondit-cond_count = ls_konp-kopos.
          ls_bapicondit-applicatio = ls_konp-kappl.
          ls_bapicondit-cond_type = ls_konp-kschl.
          ls_bapicondit-scaletype = ls_konp-stfkz.
          ls_bapicondit-scalebasin = ls_pcond_data-kzbzg.
          ls_bapicondit-scale_qty = ls_konp-kstbm.
          ls_bapicondit-currenckey = ls_pcond_data-konwa..
          ls_bapicondit-calctypcon = ls_pcond_data-krech.
          lv_amount = ls_pcond_data-kbetr_c.
          ls_bapicondit-cond_value = lv_amount.
          ls_bapicondit-condcurr = ls_pcond_data-konwa.
          ls_bapicondit-cond_p_unt = ls_pcond_data-kpein_c.
          ls_bapicondit-cond_unit = ls_pcond_data-kmein_c.
          ls_bapicondit-exclusion = ls_pcond_data-kznep_c.
          ls_bapicondit-vendor_no = ls_pcond_data-lifnr.
          ls_bapicondit-indidelete = ls_pcond_data-loevm_ko.
          ls_bapicondit-add_val_dy = ls_pcond_data-valtg.
          ls_bapicondit-fix_val_dy = ls_pcond_data-valdt.
          ls_bapicondit-pmnttrms = ls_pcond_data-zterm.
          APPEND ls_bapicondit TO lt_bapicondit.
          CLEAR ls_bapicondit.

          CALL FUNCTION 'BAPI_PRICES_CONDITIONS'
            TABLES
              ti_bapicondct  = lt_bapicondct
              ti_bapicondhd  = lt_bapicondhd
              ti_bapicondit  = lt_bapicondit
              ti_bapicondqs  = lt_bapicondqs
              ti_bapicondvs  = lt_bapicondvs
              to_bapiret2    = lt_return
              to_bapiknumhs  = lt_bapiknumhs
              to_mem_initial = lt_to_mem_initial
            EXCEPTIONS
              update_error   = 1
              OTHERS         = 2.

*       Application logging:
          REFRESH lt_balmi.
          LOOP AT lt_return INTO ls_return.
            CLEAR ls_balmi.
            ls_balmi-msgid = ls_return-id.
            ls_balmi-msgty = ls_return-type.
            ls_balmi-msgno = ls_return-number.
            ls_balmi-msgv1 = ls_return-message_v1.
            ls_balmi-msgv2 = ls_return-message_v2.
            ls_balmi-msgv3 = ls_return-message_v3.
            ls_balmi-msgv4 = ls_return-message_v4.
            APPEND ls_balmi TO lt_balmi.
          ENDLOOP.

          IF lt_balmi IS NOT INITIAL AND iv_test_mode = abap_false.
            CALL FUNCTION 'ZZMDG_FM_APPL_LOG_CREATE'
              EXPORTING
                balhdri  = ls_balhdri
              TABLES
                messages = lt_balmi.
          ENDIF.
        ENDLOOP.

      ENDIF.

      """""Purorg create case
      IF is_data-zpurchgen_tab IS INITIAL AND is_data-zpurchinf_tab IS NOT INITIAL AND iv_segment = 'ZZMDG_BS_MAT_S_EINE' AND iv_test_mode = abap_false.
        lt_pog_data = is_data-zpurchinf_tab.
        lt_pog_data_x = is_data-zpurchinf_x_tab.
        CLEAR : lt_eine_ins.

        IF lt_pog_data IS NOT INITIAL.
          SELECT *                            "#EC CI_ALL_FIELDS_NEEDED
            FROM eine
            INTO TABLE lt_eine_o
            FOR ALL ENTRIES IN lt_pog_data
            WHERE infnr = lt_pog_data-infnr
              AND esokz = lt_pog_data-esokz.

          SELECT *                            "#EC CI_ALL_FIELDS_NEEDED
            FROM eina
            INTO TABLE lt_eina
            FOR ALL ENTRIES IN lt_pog_data
            WHERE matnr = lt_pog_data-matnr
            AND lifnr = lt_pog_data-lifnr.
        ENDIF.

        LOOP AT lt_pog_data INTO ls_pog_data.
          AT NEW matnr.
            ls_matnr_eine = ls_pog_data-matnr.
            APPEND ls_matnr_eine TO lt_matnr_eine.
          ENDAT.
        ENDLOOP.

        IF lt_eina IS NOT INITIAL.
          SORT lt_eina BY infnr matnr.
        ENDIF.
        IF lt_eine_o IS NOT INITIAL.
          SORT lt_eine_o BY infnr esokz.
        ENDIF.

        SORT lt_matnr_eine.
        DELETE ADJACENT DUPLICATES FROM lt_matnr_eine.
        DESCRIBE TABLE lt_matnr_eine LINES DATA(lv_lines_eine).

        LOOP AT lt_pog_data INTO ls_pog_data.
          READ TABLE lt_eine_o TRANSPORTING NO FIELDS WITH KEY infnr = ls_pog_data-infnr esokz = ls_pog_data-esokz.
*        IF line_exists( lt_eine_o[ infnr = ls_pog_data-infnr esokz = ls_pog_data-esokz ] ) IS NOT INITIAL.
          IF sy-subrc IS NOT INITIAL.
*          READ TABLE lt_eina INTO DATA(ls_eina) WITH KEY matnr = ls_pog_data-matnr lifnr = ls_pog_data-lifnr.
            DATA(ls_eina) = lt_eina[ matnr = ls_pog_data-matnr lifnr = ls_pog_data-lifnr ].
            IF sy-subrc IS INITIAL.
              ls_pog_data-infnr = ls_eina-infnr.
              APPEND ls_pog_data TO lt_eine_ins.
              MOVE-CORRESPONDING ls_eina TO ls_eina_upd.
              APPEND ls_eina_upd TO lt_eina_ins.
            ENDIF.
          ENDIF.
          CLEAR : ls_eina, ls_pog_data, ls_eina_upd.
        ENDLOOP.


        IF lt_eine_ins IS NOT INITIAL.

          CALL FUNCTION 'ZZMDG_PURCHASE_INFO_REC_SAVE' IN UPDATE TASK
            EXPORTING
*             IS_EINA  =
*             IS_EINE  =
*             IV_MATNR =
              iv_count = lv_lines_eine
            TABLES
              t_eina   = lt_eina_ins
              t_eine   = lt_eine_ins.

        ENDIF.
        CLEAR : lt_eine_ins, lt_eina_ins.


        IF lt_eina_upd IS NOT INITIAL OR lt_eine_upd IS NOT INITIAL.
          IF lt_pog_data IS NOT INITIAL.
            SELECT *
              FROM eina
              INTO TABLE lt_eina_temp
              FOR ALL ENTRIES IN lt_pog_data
              WHERE infnr = lt_pog_data-infnr.
          ENDIF.

          IF lt_pir_data IS NOT INITIAL.
            SELECT *
              FROM eine
              INTO TABLE lt_eine_temp
              FOR ALL ENTRIES IN lt_pir_data
              WHERE infnr = lt_pir_data-infnr.
          ENDIF.

          IF lt_eina_temp IS NOT INITIAL.
            INSERT LINES OF lt_eina_temp INTO TABLE lt_eina.
            SORT lt_eina BY matnr infnr.
            DELETE ADJACENT DUPLICATES FROM lt_eina COMPARING matnr infnr.

            INSERT LINES OF lt_eina_temp INTO TABLE lt_eina_upd.
            SORT lt_eina_upd BY matnr infnr.
            DELETE ADJACENT DUPLICATES FROM lt_eina_upd COMPARING matnr infnr.
          ENDIF.

          IF lt_eine_temp IS NOT INITIAL.
            INSERT LINES OF lt_eine_temp INTO TABLE lt_eine_o.
            SORT lt_eine_o BY infnr esokz.
            DELETE ADJACENT DUPLICATES FROM lt_eine_o COMPARING infnr esokz.
          ENDIF.

          LOOP AT lt_eina_upd INTO ls_eina_upd.
            MOVE-CORRESPONDING ls_eina_upd TO ls_eina_s.


            LOOP AT lt_eine_upd INTO ls_pog_data WHERE infnr = ls_eina_upd-infnr.

              MOVE-CORRESPONDING ls_pog_data TO ls_eine_s.


              READ TABLE lt_eina INTO ls_eina_o WITH KEY infnr = ls_eina_s-infnr.
              READ TABLE lt_eine_o INTO ls_eine_o WITH KEY infnr = ls_eine_s-infnr
                                                           esokz = ls_eine_s-esokz.

              ls_eina_s-lmein = ls_eina_o-lmein.
              ls_eine_s-esokz = ls_eine_o-esokz.
              ls_eina_s-erdat = ls_eina_o-erdat.
              ls_eina_s-ernam = ls_eina_o-ernam.
              ls_eine_s-erdat = ls_eine_o-erdat.
              ls_eine_s-ernam = ls_eine_o-ernam.

              CALL FUNCTION 'ME_UPDATE_INFORECORD' IN UPDATE TASK
                EXPORTING
                  xeina    = ls_eina_s
                  xeine    = ls_eine_s
                  yeina    = ls_eina_o
                  yeine    = ls_eine_o
                  reg_eina = ls_eina_o.

            ENDLOOP.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  method IF_MDG_BS_MAT_API_SEGMENTS_EXT~GET_ES_NODEINFO.

  endmethod.


  method IF_MDG_BS_MAT_API_SEGMENTS_EXT~READ.

 CHECK 1 = 0.

  TYPES : BEGIN OF lty_pcond_record,
            lifnr TYPE  elifn,
            matnr	TYPE matnr,
            ekorg	TYPE ekorg,
            werks	TYPE werks_d,
            esokz	TYPE esokz,
            knumh	TYPE knumh,
            datab TYPE kodatab,
            datbi	TYPE kodatbi,
          END OF lty_pcond_record,

          BEGIN OF lty_pcond_record1,
            lifnr TYPE  elifn,
            matnr	TYPE matnr,
            ekorg	TYPE ekorg,
            esokz	TYPE esokz,
            knumh	TYPE knumh,
            datab TYPE kodatab,
            datbi	TYPE kodatbi,
          END OF lty_pcond_record1.

  DATA : lt_eina      TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eina,
         lt_eine      TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eine,
         lt_eine_c    TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eine,
         lt_eine_u    TYPE STANDARD TABLE OF zzmdg_bs_mat_s_eine,
         lt_a017      TYPE TABLE OF lty_pcond_record,
         lt_a018      TYPE TABLE OF lty_pcond_record1,
         lt_konh      TYPE STANDARD TABLE OF konh,
         lt_konp      TYPE STANDARD TABLE OF konp,
         lt_pcond     TYPE STANDARD TABLE OF zzmdg_bs_mat_s_cond,
         lt_pcond_rec TYPE STANDARD TABLE OF lty_pcond_record,
         ls_pcond     TYPE zzmdg_bs_mat_s_cond,
         ls_pcond_rec TYPE lty_pcond_record,
         ls_a018      TYPE lty_pcond_record1,
         lv_usrname   TYPE usr02-bname,
         lv_plant     TYPE ust12-von,
         lv_auth_object    TYPE ust12-objct.


  CONSTANTS : lc_msg_cls TYPE string VALUE 'ZZMDG_PIR_MSG',
              lc_buffer  TYPE xuflag VALUE 3,
              lc_object  TYPE ust12-objct VALUE 'M_MATE_WRK',
              lc_field1  TYPE ust12-field VALUE 'WERKS',
              lc_field2  TYPE ust12-field VALUE 'ACTVT',
              lc_value2  TYPE ust12-von VALUE '02'.


    DATA(lv_crtype) = get_cr_type( ).



IF lv_crtype EQ 'ZMAT01' OR lv_crtype EQ 'ZMAT02'.

  IF lv_auth_object IS INITIAL.
*   Use default if not maintained:
    lv_auth_object = lc_object.
  ENDIF.

    IF iv_segment = 'ZZMDG_BS_MAT_S_EINA'.
      CHECK is_selection-matnr_range IS NOT INITIAL.
      SELECT * FROM eina INTO TABLE lt_eina WHERE matnr IN is_selection-matnr_range.
      IF sy-subrc = 0.
        INSERT LINES OF lt_eina INTO TABLE et_data.
      ENDIF.
    ENDIF.

    IF iv_segment = 'ZZMDG_BS_MAT_S_EINE' AND is_selection-matnr_range IS NOT INITIAL.
      CHECK is_selection-matnr_range IS NOT INITIAL.
      SELECT * FROM eina INTO TABLE lt_eina WHERE matnr IN is_selection-matnr_range.
      IF sy-subrc = 0.
        SELECT * FROM eine INTO TABLE lt_eine FOR ALL ENTRIES IN lt_eina WHERE infnr = lt_eina-infnr. "#EC CI_NO_TRANSFORM
        LOOP AT lt_eina INTO DATA(ls_eina).
          IF ls_eina-infnr IS NOT INITIAL.
            CLEAR : lt_eine_u.
            LOOP AT lt_eine INTO DATA(ls_eine) WHERE infnr = ls_eina-infnr.
              IF ls_eine-werks IS NOT INITIAL.
                lv_plant = ls_eine-werks.
                lv_usrname = sy-uname.
                CALL FUNCTION 'AUTHORITY_CHECK'
                  EXPORTING
                    new_buffering       = lc_buffer
                    user                = lv_usrname
                    object              = lv_auth_object
                    field1              = lc_field1
                    value1              = lv_plant
                    field2              = lc_field2
                    value2              = lc_value2
                  EXCEPTIONS
                    user_dont_exist     = 1
                    user_is_authorized  = 2
                    user_not_authorized = 3
                    user_is_locked      = 4
                    OTHERS              = 5.
                IF sy-subrc NE 2.
                  CONTINUE.
                ENDIF.
              ENDIF.
              ls_eine-matnr = ls_eina-matnr.
              ls_eine-infnr = ls_eina-infnr.
              ls_eine-lifnr = ls_eina-lifnr.
*              ls_eine-mein3 = ls_eine-bprme.
*              ls_eine-mein4 = ls_eine-bprme.
              INSERT ls_eine INTO TABLE lt_eine_u.
              CLEAR : ls_eine.
            ENDLOOP.
            IF lt_eine_u IS NOT INITIAL.
              INSERT LINES OF lt_eine_u INTO TABLE et_data.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

    IF iv_segment EQ 'ZZMDG_BS_MAT_S_COND'.
      CHECK is_selection-matnr_range IS NOT INITIAL.
      SELECT * FROM eina INTO TABLE lt_eina WHERE matnr IN is_selection-matnr_range.
      IF sy-subrc = 0.
        SELECT * FROM eine INTO TABLE lt_eine FOR ALL ENTRIES IN lt_eina WHERE infnr = lt_eina-infnr. "#EC CI_NO_TRANSFORM
        IF lt_eine IS NOT INITIAL.
          SORT lt_eine BY infnr.
        ENDIF.

        LOOP AT lt_eine ASSIGNING FIELD-SYMBOL(<ls_data>).
          READ TABLE lt_eina INTO ls_eina WITH KEY infnr = <ls_data>-infnr.
          IF sy-subrc IS INITIAL.
            <ls_data>-lifnr = ls_eina-lifnr.
          ENDIF.
        ENDLOOP.

        LOOP AT lt_eine INTO DATA(ls_eine_c).
          IF ls_eine_c-werks IS NOT INITIAL.
            lv_plant = ls_eine_c-werks.
            lv_usrname = sy-uname.
            CALL FUNCTION 'AUTHORITY_CHECK'
              EXPORTING
                new_buffering       = lc_buffer
                user                = lv_usrname
                object              = lv_auth_object
                field1              = lc_field1
                value1              = lv_plant
                field2              = lc_field2
                value2              = lc_value2
              EXCEPTIONS
                user_dont_exist     = 1
                user_is_authorized  = 2
                user_not_authorized = 3
                user_is_locked      = 4
                OTHERS              = 5.
            IF sy-subrc NE 2.
              CONTINUE.
            ELSE.
              APPEND ls_eine_c TO lt_eine_c.
              CLEAR ls_eine_c.
            ENDIF.
          ELSE.
            APPEND ls_eine_c TO lt_eine_c.
            CLEAR ls_eine_c.
          ENDIF.
        ENDLOOP.

        IF lt_eine_c IS NOT INITIAL.
          SELECT lifnr matnr ekorg werks esokz knumh datab datbi
            FROM a017
            INTO TABLE lt_a017
            FOR ALL ENTRIES IN lt_eine_c
            WHERE ekorg = lt_eine_c-ekorg
            AND werks = lt_eine_c-werks
            AND lifnr = lt_eine_c-lifnr
            AND matnr IN is_selection-matnr_range.
          IF sy-subrc IS INITIAL.
            SORT lt_a017 BY knumh.
          ENDIF.

          SELECT lifnr matnr ekorg esokz knumh datab datbi
             FROM a018
             INTO TABLE lt_a018
             FOR ALL ENTRIES IN lt_eine_c
             WHERE lifnr = lt_eine_c-lifnr
             AND ekorg = lt_eine_c-ekorg
             AND matnr IN is_selection-matnr_range.
          IF sy-subrc IS INITIAL.
            SORT lt_a018 BY knumh.
          ENDIF.
        ENDIF.

        IF lt_a017 IS NOT INITIAL.
          MOVE-CORRESPONDING lt_a017 TO lt_pcond_rec.
        ENDIF.

        IF lt_a018 IS NOT INITIAL.
          LOOP AT lt_a018 INTO ls_a018.
            MOVE-CORRESPONDING ls_a018 TO ls_pcond_rec.
            APPEND ls_pcond_rec TO lt_pcond_rec.
            CLEAR : ls_pcond_rec, ls_a018.
          ENDLOOP.
        ENDIF.

        SORT lt_pcond_rec BY knumh.

        IF lt_pcond_rec IS NOT INITIAL.
          SELECT *
              FROM konh
              INTO TABLE lt_konh
              FOR ALL ENTRIES IN lt_pcond_rec
              WHERE knumh = lt_pcond_rec-knumh. "#EC CI_ALL_FIELDS_NEEDED
          IF sy-subrc IS INITIAL.
            SELECT *
              FROM konp
              INTO TABLE lt_konp
              FOR ALL ENTRIES IN lt_pcond_rec
              WHERE knumh = lt_pcond_rec-knumh.
            IF sy-subrc IS INITIAL.
              SORT lt_konh BY knumh.
              SORT lt_konp BY knumh.
              LOOP AT lt_pcond_rec INTO DATA(ls_pcon_rec).
                ls_pcond-matnr = ls_pcon_rec-matnr.
                ls_pcond-lifnr = ls_pcon_rec-lifnr.
                ls_pcond-ekorg = ls_pcon_rec-ekorg.
                ls_pcond-werks = ls_pcon_rec-werks.
                ls_pcond-esokz = ls_pcon_rec-esokz.
                ls_pcond-datab = ls_pcon_rec-datab.
                ls_pcond-datbi = ls_pcon_rec-datbi.
                READ TABLE lt_konp INTO DATA(ls_konp) WITH KEY knumh = ls_pcon_rec-knumh.
                IF sy-subrc IS INITIAL.
                  ls_pcond-kmein_c = ls_konp-kmein.
                  ls_pcond-konwa = ls_konp-konwa.
                  IF ls_pcond-konwa = 'CLP'.
                    ls_pcond-kbetr_c = ls_konp-kbetr * 100.
                  ELSE.
                    ls_pcond-kbetr_c = ls_konp-kbetr.
                  ENDIF.
                  ls_pcond-kpein_c = ls_konp-kpein.
                  ls_pcond-krech = ls_konp-krech.
                  ls_pcond-kzbzg = ls_konp-kzbzg.
                  ls_pcond-kznep_c = ls_konp-kznep.
                  ls_pcond-loevm_ko = ls_konp-loevm_ko.
                  ls_pcond-mwsk1_c = ls_konp-mwsk1.
                  ls_pcond-valdt = ls_konp-valdt.
                  ls_pcond-valtg = ls_konp-valtg.
                  ls_pcond-zterm = ls_konp-zterm.
                ENDIF.
                APPEND ls_pcond TO lt_pcond.
                CLEAR : ls_pcond,  ls_konp.
              ENDLOOP.
              IF lt_pcond IS NOT INITIAL.
                SORT lt_pcond BY datab datbi lifnr ekorg.
                INSERT LINES OF lt_pcond INTO TABLE et_data.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
   ENDIF.

  endmethod.
ENDCLASS.
