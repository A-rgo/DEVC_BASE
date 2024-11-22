FUNCTION ZZMDG_PURCHASE_INFO_REC_SAVE.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_MATNR) TYPE  MATNR OPTIONAL
*"     VALUE(IV_COUNT) TYPE  I OPTIONAL
*"  TABLES
*"      T_EINA STRUCTURE  ZZMDG_BS_MAT_S_EINA OPTIONAL
*"      T_EINE STRUCTURE  ZZMDG_BS_MAT_S_EINE OPTIONAL
*"      T_KONP STRUCTURE  ZZMDG_BS_MAT_S_COND OPTIONAL
*"----------------------------------------------------------------------
  TYPES :BEGIN OF ty_meins,
           matnr TYPE matnr,
           meins TYPE meins,
         END OF ty_meins,

         BEGIN OF lty_cond_tab,
           lifnr TYPE  elifn,
           matnr TYPE matnr,
           ekorg TYPE ekorg,
           werks TYPE werks_d,
           esokz TYPE esokz,
           knumh TYPE knumh,
           datab TYPE datab,
           datbi TYPE kodatbi,
         END OF lty_cond_tab.

  DATA : lo_api            TYPE REF TO zzmdg_cl_bs_mat_mm_api_ext,
         lt_txtlines       TYPE mewipirtext_tt,
         lt_condval        TYPE mewivalidity_tt,
         lt_pcond_list     TYPE TABLE OF zzmdg_bs_mat_s_cond,
         lt_pcond_recs     TYPE zzmdg_bs_mat_t_cond,
         lt_pcond_tmp      TYPE TABLE OF zzmdg_bs_mat_s_cond,
         lt_cond_tab       TYPE TABLE OF lty_cond_tab,
         lt_konh           TYPE TABLE OF konh,
         lt_konp           TYPE TABLE OF konp,
         lt_cscal_val      TYPE mewiscaleval_tt,
         lt_cscal_qua      TYPE mewiscalequan_tt,
         lt_cond           TYPE mewicondition_tt,
         lt_return         TYPE mewi_tt_return,
         lt_return_tmp     TYPE mewi_tt_return,
         lt_return_new     TYPE fs4mig_t_bapiret2,
         ls_return_new     TYPE fs4mig_s_bapiret2,
         lt_bapicondct     TYPE STANDARD TABLE OF bapicondct,
         lt_bapicondhd     TYPE STANDARD TABLE OF bapicondhd,
         lt_bapicondit     TYPE STANDARD TABLE OF bapicondit,
         lt_bapicondqs     TYPE STANDARD TABLE OF bapicondqs,
         lt_bapicondvs     TYPE STANDARD TABLE OF bapicondvs,
         lt_return_c       TYPE STANDARD TABLE OF bapiret2,
         lt_bapiknumhs     TYPE STANDARD TABLE OF bapiknumhs,
         lt_to_mem_initial TYPE STANDARD TABLE OF cnd_mem_initial,
         lt_meins          TYPE STANDARD TABLE OF ty_meins,
         lt_eina_s         TYPE mewieina_t, "mewieina_mig_t,
         it_eina           TYPE mewieina_mig_t,
         lt_eina_x         TYPE mewieinax_t,
         lt_eine_s         TYPE mewieine_t,
         it_eine           TYPE mewieine_t,
         lt_eine_x         TYPE mewieinex_t,
         lt_periods        TYPE zzmdg_t_period_dates,

         ls_meins          TYPE ty_meins,
         ls_eina_s         TYPE mewieina, "mewieina_mig,
         ls_pcond_list     TYPE zzmdg_bs_mat_s_cond,
         ls_pcond_new      TYPE zzmdg_bs_mat_s_cond,
         is_eina_s         TYPE zzmdg_bs_mat_s_eina,
         is_eine_s         TYPE zzmdg_bs_mat_s_eine,
         ls_eina_x         TYPE mewieinax_ty,
         ls_periods        TYPE zzmdg_s_period_dates,
         ls_eine_s         TYPE mewieine_ty,
         ls_eine_x         TYPE mewieinex_ty,
         ls_cond_val       TYPE mewivalidity_ty,
         ls_cond           TYPE mewicondition_ty,
         ls_cscal_val      TYPE mewiscaleval_ty,
         ls_cscal_qua      TYPE mewiscalequan_ty,
         ls_konp           TYPE zzmdg_bs_mat_s_cond,
         ls_bapicondct     TYPE bapicondct,
         ls_bapicondhd     TYPE bapicondhd,
         ls_bapicondit     TYPE bapicondit,
         ls_bapicondqs     TYPE bapicondqs,
         ls_bapicondvs     TYPE bapicondvs,
         ls_return         TYPE bapiret2,
         ls_bapiknumhs     TYPE bapiknumhs,

         lv_endloop        TYPE boolean,
         lv_count          TYPE i,
         lv_c_count        TYPE i,
         lv_cond_count     TYPE knumh,
         lv_condition      TYPE knumh,
         lv_lifnr          TYPE elifn,
         lv_matnr          TYPE matnr,
         lv_varkey         TYPE char100,
         lv_infnr          TYPE infnr,
         lv_bo_key         TYPE drf_object_id.


  DATA: lt_abap_component  TYPE abap_component_tab,
        lr_structdescr     TYPE REF TO cl_abap_structdescr,
        lr_fnl_structdescr TYPE REF TO cl_abap_structdescr.

  DATA: lo_new_type   TYPE REF TO cl_abap_structdescr,
        lo_table_type TYPE REF TO cl_abap_tabledescr,
        w_tref        TYPE REF TO data.

  DATA: lo_abap_typedescr TYPE REF TO cl_abap_typedescr,
        ls_dd02l          TYPE dd02l.

  DATA: ls_balhdri      TYPE balhdri,
        lt_balmi        TYPE TABLE OF balmi,
        ls_balmi        TYPE balmi,
        ls_return_pr    TYPE mewi_ty_return,
        lv_s4_1909_flag TYPE boolean.

  DATA: lv_log_handle   TYPE balloghndl.

  FIELD-SYMBOLS: <ft_eina>           TYPE STANDARD TABLE,
                 <ft_eina_s>         TYPE STANDARD TABLE,
                 <fs_abap_component> TYPE abap_componentdescr.

    DATA: lv_init_date      TYPE ltak-stdat,
        lv_init_time      TYPE ltak-stuzt,
        lv_diff_sec       TYPE ltak-istwm,
        lv_max_time_limit TYPE ltak_istwm.

  FIELD-SYMBOLS : <ls_pcond_tmp>  TYPE zzmdg_bs_mat_s_cond,
                  <ls_pcond_list> TYPE zzmdg_bs_mat_s_cond,
                  <ls_cond_tab>   TYPE lty_cond_tab.

  CONSTANTS : lc_prdat TYPE prdat VALUE '99991231'.

  CONSTANTS: lc_log_obj      TYPE balobj_d  VALUE 'ZZMDG_MM_LOG',
             lc_log_subobj   TYPE balsubobj VALUE 'ZZMDG_PIR_LOG',
             lc_tabname_1909 TYPE tabname   VALUE 'MEWIEINA_MIG',
             lc_tabname_old  TYPE tabname   VALUE 'MEWIEINA'.

  CONSTANTS: lc_matmsgs      TYPE symsgid   VALUE 'ZZMDG_PIR_MSG',
             lc_max_limit    TYPE i         VALUE 2000.

  CHECK t_eina[] IS NOT INITIAL.

  CLEAR: ls_balmi, ls_balhdri.
  ls_balhdri-object     = lc_log_obj.
  ls_balhdri-subobject  = lc_log_subobj.

  REFRESH lt_balmi.

  lv_max_time_limit = lc_max_limit.

  CLEAR: lv_init_time, lv_init_date.
  lv_init_date = sy-datum.
  lv_init_time = sy-uzeit.

  DO.
    SELECT matnr meins
      FROM mara
      INTO TABLE lt_meins
      FOR ALL ENTRIES IN t_eina
      WHERE matnr = t_eina-matnr.
    IF sy-subrc IS INITIAL.
      DESCRIBE TABLE lt_meins LINES lv_count.
      IF lv_count = iv_count.
        lv_endloop = abap_true.
      ENDIF.
    ENDIF.

    IF lv_endloop EQ abap_true.
      EXIT.
    ELSE.
      CLEAR lv_diff_sec.
      CALL FUNCTION 'L_TO_TIME_DIFF'
        EXPORTING
          i_start_date = lv_init_date
          i_start_time = lv_init_time
          i_end_date   = sy-datum
          i_end_time   = sy-uzeit
          i_time_uom   = 'S'
        IMPORTING
          e_time_diff  = lv_diff_sec.
      IF lv_diff_sec > lv_max_time_limit.
*       Time limit exceeded. Exit.
        CLEAR ls_balmi.
        ls_balmi-msgid = lc_matmsgs. "
        ls_balmi-msgty = 'E'.
        ls_balmi-msgno = 001.
        APPEND ls_balmi TO lt_balmi.
        EXIT.
      ENDIF.
    ENDIF.
  ENDDO.

  IF t_konp[] IS NOT INITIAL.

    LOOP AT t_konp[] INTO ls_pcond_list.
      APPEND ls_pcond_list TO lt_pcond_list.
      APPEND ls_pcond_list TO lt_pcond_recs.
      CLEAR ls_pcond_list.
    ENDLOOP.
    DESCRIBE TABLE lt_pcond_list LINES lv_c_count.
  ENDIF.
  REFRESH lt_return.
  CLEAR lv_log_handle.
  LOOP AT t_eina INTO is_eina_s.

    IF is_eina_s IS NOT INITIAL.
      ls_eina_s-material = is_eina_s-matnr.
      ls_eina_s-vendor = is_eina_s-lifnr.
      ls_eina_s-reminder1 = is_eina_s-mahn1.
      ls_eina_s-reminder2 = is_eina_s-mahn2.
      ls_eina_s-reminder3 = is_eina_s-mahn3.
      ls_eina_s-vend_mat = is_eina_s-idnlf.
      ls_eina_s-vend_matg = is_eina_s-wglif.
      ls_eina_s-sales_pers = is_eina_s-verkf.
      ls_eina_s-telephone = is_eina_s-telf1.
      ls_eina_s-back_agree = is_eina_s-rueck.
      ls_eina_s-po_unit = is_eina_s-meins.
      READ TABLE lt_meins INTO ls_meins WITH KEY matnr = is_eina_s-matnr.
      IF sy-subrc IS INITIAL.
        ls_eina_s-base_uom = ls_meins-meins.
      ENDIF.
      IF is_eina_s-infnr IS INITIAL.
        ls_eina_s-info_rec = lv_infnr.
      ELSE.
        ls_eina_s-info_rec = is_eina_s-infnr.
      ENDIF.
      ls_eina_s-cert_type = is_eina_s-urztp.
      ls_eina_s-cert_no = is_eina_s-urznr.
      ls_eina_s-cert_valid = is_eina_s-urzdt.
      ls_eina_s-cert_ctry = is_eina_s-urzla.
      ls_eina_s-cust_no = is_eina_s-urzzt.
      ls_eina_s-points = is_eina_s-anzpu.
      ls_eina_s-point_unit = is_eina_s-punei.
      ls_eina_s-conv_den1 = is_eina_s-umren.
      ls_eina_s-conv_num1 = is_eina_s-umrez.
      ls_eina_s-cust_no = is_eina_s-urzzt.
      ls_eina_s-pre_vendor = is_eina_s-kolif.
      ls_eina_s-region = is_eina_s-regio.
      ls_eina_s-suppl_from = is_eina_s-lifab.
      ls_eina_s-suppl_to = is_eina_s-lifbi.
      ls_eina_s-norm_vend = is_eina_s-relif.
      APPEND ls_eina_s TO lt_eina_s.
      CLEAR ls_eina_s.

      ls_eina_x-material = abap_true.
      IF is_eina_s-infnr IS INITIAL.
        ls_eina_x-info_recn = lv_infnr.
      ELSE.
        ls_eina_x-info_recn = is_eina_s-infnr.
      ENDIF.
      ls_eina_x-suppl_from = abap_true.
      ls_eina_x-suppl_to = abap_true.
      ls_eina_x-norm_vend = abap_true.
      ls_eina_x-region = abap_true.
      ls_eina_x-info_rec = abap_true.
      ls_eina_x-vendor = abap_true.
      ls_eina_x-reminder1 = abap_true.
      ls_eina_x-reminder2 = abap_true.
      ls_eina_x-reminder3 = abap_true.
      ls_eina_x-vend_mat = abap_true.
      ls_eina_x-vend_matg = abap_true.
      ls_eina_x-sales_pers = abap_true.
      ls_eina_x-telephone = abap_true.
      ls_eina_x-back_agree = abap_true.
      ls_eina_x-po_unit = abap_true.
      ls_eina_x-base_uom = abap_true.
      ls_eina_x-cert_type = abap_true.
      ls_eina_x-cert_no = abap_true.
      ls_eina_x-cert_valid = abap_true.
      ls_eina_x-cert_ctry = abap_true.
      ls_eina_x-cust_no  = abap_true.
      ls_eina_x-points = abap_true.
      ls_eina_x-point_unit = abap_true.
      ls_eina_x-conv_den1 = abap_true.
      ls_eina_x-conv_num1 = abap_true.
      ls_eina_x-cust_no = abap_true.
      ls_eina_x-pre_vendor = abap_true.
      APPEND ls_eina_x TO lt_eina_x.
      CLEAR ls_eina_x.
    ENDIF.

    LOOP AT t_eine INTO is_eine_s WHERE matnr = is_eina_s-matnr AND lifnr = is_eina_s-lifnr.
      IF is_eine_s IS NOT INITIAL.
        IF is_eina_s-infnr IS INITIAL.
          ls_eine_s-info_rec = lv_infnr.
        ELSE.
          ls_eine_s-info_rec = is_eina_s-infnr.
        ENDIF.
*        ls_eine_s-info_rec = lv_infnr.
        ls_eine_s-vendor = is_eina_s-lifnr.
        ls_eine_s-plant = is_eine_s-werks.
        ls_eine_s-gr_basediv = is_eine_s-webre.
        ls_eine_s-plnd_delry = is_eine_s-aplfz.
        ls_eine_s-purch_org = is_eine_s-ekorg.
        ls_eine_s-pur_group = is_eine_s-ekgrp.
        ls_eine_s-min_po_qty = is_eine_s-minbm.
        ls_eine_s-nrm_po_qty = is_eine_s-norbm.
        ls_eine_s-max_po_qty = is_eine_s-bstma.
        ls_eine_s-net_price = is_eine_s-netpr.
        ls_eine_s-eff_price = is_eine_s-netpr.
*        ls_eine_s-price_date = lc_prdat.
        ls_eine_s-incoterms1 = is_eine_s-inco1.
        ls_eine_s-incotermsv = is_eine_s-incov.
        ls_eine_s-orderpr_un = is_eine_s-bprme.
        ls_eine_s-price_unit = is_eine_s-peinh.
        ls_eine_s-currency = is_eine_s-waers.
        ls_eine_s-incoterms2l = is_eine_s-inco2_l.
        ls_eine_s-incoterms3l = is_eine_s-inco3_l.
        ls_eine_s-quotation = is_eine_s-angnr.
        ls_eine_s-minremlife = is_eine_s-mhdrz.
        ls_eine_s-tax_code = is_eine_s-mwskz.
        ls_eine_s-info_type = is_eine_s-esokz.
        ls_eine_s-conv_den1 = is_eine_s-bpumn.
        ls_eine_s-conv_num1 = is_eine_s-bpumz.
        ls_eine_s-round_prof = is_eine_s-rdprf.
        ls_eine_s-shipping = is_eine_s-evers.
        APPEND ls_eine_s TO lt_eine_s.
        CLEAR ls_eine_s.

        IF is_eina_s-infnr IS INITIAL.
          ls_eine_x-info_recn = lv_infnr.
        ELSE.
          ls_eine_x-info_recn = is_eina_s-infnr.
        ENDIF.
        ls_eine_x-round_prof = abap_true.
        ls_eine_x-conv_den1 = abap_true.
        ls_eine_x-conv_num1 = abap_true.
        ls_eine_x-gr_basediv = abap_true.
*        ls_eine_x-price_date = abap_true.
        ls_eine_x-eff_price = abap_true.
        ls_eine_x-vendor = abap_true.
        ls_eine_x-plant = abap_true.
        ls_eine_x-plnd_delry = abap_true.
        ls_eine_x-purch_org = abap_true.
        ls_eine_x-pur_group = abap_true.
        ls_eine_x-min_po_qty = abap_true.
        ls_eine_x-max_po_qty = abap_true.
        ls_eine_x-net_price = abap_true.
        ls_eine_x-incoterms1 = abap_true.
        ls_eine_x-orderpr_un = abap_true.
        ls_eine_x-nrm_po_qty = abap_true.
        ls_eine_x-incotermsv = abap_true.
        ls_eine_x-price_unit = abap_true.
        ls_eine_x-currency = abap_true.
        ls_eine_x-incoterms2l = abap_true.
        ls_eine_x-incoterms3l = abap_true.
        ls_eine_x-quotation = abap_true.
        ls_eine_x-minremlife = abap_true.
        ls_eine_x-tax_code = abap_true.
        ls_eine_x-info_type = abap_true.
        ls_eine_x-shipping = abap_true.
        APPEND ls_eine_x TO lt_eine_x.
        CLEAR ls_eine_x.
      ENDIF.
    ENDLOOP.


    DO .
      CALL FUNCTION 'ENQUEUE_EMMARME'
        EXPORTING
          mode_marm      = 'E'
          mandt          = sy-mandt
          matnr          = is_eina_s-matnr
        EXCEPTIONS
          foreign_lock   = 1
          system_failure = 2
          OTHERS         = 3.
      IF sy-subrc = 0.
        EXIT.
* Implement suitable error handling here
      ENDIF.
    ENDDO.

    CALL FUNCTION 'DEQUEUE_EMMARME'
      EXPORTING
        mode_marm = 'E'
        mandt     = sy-mandt
        matnr     = is_eina_s-matnr.

*    REFRESH lt_balmi.
    IF is_eina_s-matnr IS NOT INITIAL.
      CLEAR ls_balmi.
      ls_balmi-msgid = lc_matmsgs.
      ls_balmi-msgty = 'S'.
      ls_balmi-msgno = 000.
      ls_balmi-msgv1 = is_eina_s-matnr.
      ls_balmi-msgv2 = 'ZZMDG_PURCHASE_INFO_REC_SAVE'.
      APPEND ls_balmi TO lt_balmi.
    ENDIF.
    IF lt_balmi IS NOT INITIAL.
      CALL FUNCTION 'ZZMDG_FM_APPL_LOG_CREATE'
        EXPORTING
          balhdri       = ls_balhdri
        IMPORTING
          ev_log_handle = lv_log_handle
        TABLES
          messages      = lt_balmi.
      REFRESH lt_balmi.
    ENDIF.

  REFRESH lt_return_new.

  DATA lt_tabfields   TYPE mdg_cp_t_tabfields.
  DATA ls_tabfields   TYPE mdg_cp_s_tabfield.

        CALL FUNCTION 'ME_INFORECORD_MAINTAIN_MULTI'
          IMPORTING
            et_eina = it_eina
            et_eine = it_eine
          TABLES
            t_eina  = <ft_eina_s>   "lt_eina_s
            t_einax = lt_eina_x
            t_eine  = lt_eine_s
            t_einex = lt_eine_x
            return  = lt_return_new.
        IF sy-subrc = 0.
         COMMIT WORK.
*Updating MDG change pointer for PIR
*         LOOP AT it_eina INTO DATA(is_eina).
*          lv_bo_key = is_eina-INFO_REC.
*          ls_tabfields-change_type = 'I'.
*          ls_tabfields-tabname = 'EINA'.
*          ls_tabfields-fieldname = 'INFNR'.
*          ls_tabfields-tabkey = is_eina-INFO_REC.
*          APPEND ls_tabfields TO lt_tabfields.
*
*         TRY.
*          cl_mdg_change_pointer=>create_cp_by_bo_key(
*            iv_business_object = 'ZZMDG_PIR'
*            iv_bo_key          = lv_bo_key
*            it_tabfields       = lt_tabfields ).
*          CATCH cx_mdg_cp_exception.
*         ENDTRY.
*         ENDLOOP.
        ENDIF.

        LOOP AT lt_return_new INTO ls_return_new.
          CLEAR ls_return_pr.
          MOVE-CORRESPONDING ls_return_new TO ls_return_pr.
          CONCATENATE ls_return_new-id ls_return_new-number INTO ls_return_pr-code.
          APPEND ls_return_pr TO lt_return.
        ENDLOOP.



    LOOP AT lt_return INTO ls_return_pr.
      CLEAR ls_balmi.
      ls_balmi-msgid = ls_return_pr-code+0(2).
      ls_balmi-msgty = ls_return_pr-type.
      ls_balmi-msgno = ls_return_pr-code+2(3).
      ls_balmi-msgv1 = ls_return_pr-message_v1.
      ls_balmi-msgv2 = ls_return_pr-message_v2.
      ls_balmi-msgv3 = ls_return_pr-message_v3.
      ls_balmi-msgv4 = ls_return_pr-message_v4.
      APPEND ls_balmi TO lt_balmi.
    ENDLOOP.
    IF lt_balmi IS NOT INITIAL.
      CALL FUNCTION 'ZZMDG_FM_APPL_LOG_CREATE'
        EXPORTING
          balhdri       = ls_balhdri
          iv_log_handle = lv_log_handle
        TABLES
          messages      = lt_balmi.
      REFRESH lt_balmi.
    ENDIF.
    REFRESH : lt_eina_s, lt_eine_s, lt_eina_x, lt_eine_x, lt_abap_component.
  ENDLOOP.

  LOOP AT lt_pcond_list INTO ls_konp.
    lv_cond_count = lv_cond_count + 1.
    CONDENSE lv_cond_count.
    CONCATENATE '$' lv_cond_count INTO lv_condition.
    ls_bapicondct-operation = '009'.
    ls_bapicondct-cond_usage = 'A'.
    IF ls_konp-werks IS NOT INITIAL.
      ls_bapicondct-table_no = '017'.
    ELSE.
      ls_bapicondct-table_no = '018'.
    ENDIF.
    ls_bapicondct-applicatio = 'M'.
    ls_bapicondct-cond_type = 'PB00'.

    CONCATENATE ls_konp-lifnr ls_konp-matnr ls_konp-ekorg ls_konp-werks ls_konp-esokz INTO lv_varkey.
    ls_bapicondct-varkey = lv_varkey.
    ls_bapicondct-valid_from = ls_konp-datab.
    ls_bapicondct-valid_to = ls_konp-datbi.
    ls_bapicondct-cond_no = lv_condition.
    APPEND ls_bapicondct TO lt_bapicondct.
    CLEAR ls_bapicondct.

    ls_bapicondhd-operation = '009'.
    ls_bapicondhd-cond_no = lv_condition.
    ls_bapicondhd-created_by = sy-uname.
    ls_bapicondhd-creat_date = sy-datum.
    ls_bapicondhd-cond_usage = 'A'.
    IF ls_konp-werks IS NOT INITIAL.
      ls_bapicondhd-table_no = '017'.
    ELSE.
      ls_bapicondhd-table_no = '018'.
    ENDIF.
    ls_bapicondhd-applicatio = 'M'.
    ls_bapicondhd-cond_type = 'PB00'.
    ls_bapicondhd-varkey = lv_varkey.
    ls_bapicondhd-valid_from = ls_konp-datab.
    ls_bapicondhd-valid_to = ls_konp-datbi.
    APPEND ls_bapicondhd TO lt_bapicondhd.
    CLEAR ls_bapicondhd.

    ls_bapicondit-operation = '009'.
    ls_bapicondit-cond_no = lv_condition.
    ls_bapicondit-cond_count = 01.
    ls_bapicondit-applicatio = 'M'.
    ls_bapicondit-cond_type = 'PB00'.
    ls_bapicondit-scaletype = 'A'.
    ls_bapicondit-currenckey = ls_konp-konwa.
    ls_bapicondit-calctypcon = ls_konp-krech.
    ls_bapicondit-cond_value = ls_konp-kbetr_c.
    ls_bapicondit-condcurr = ls_konp-konwa.
    ls_bapicondit-cond_p_unt = ls_konp-kpein_c.
    ls_bapicondit-cond_unit = ls_konp-kmein_c.
    ls_bapicondit-exclusion = ls_konp-kznep_c.
    ls_bapicondit-indidelete = ls_konp-loevm_ko.
    ls_bapicondit-add_val_dy = ls_konp-valtg.
    ls_bapicondit-vendor_no = ls_konp-lifnr.
    ls_bapicondit-fix_val_dy = ls_konp-valdt.
    ls_bapicondit-pmnttrms = ls_konp-zterm.
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
      to_bapiret2    = lt_return_c
      to_bapiknumhs  = lt_bapiknumhs
      to_mem_initial = lt_to_mem_initial.

* Application logging:
  LOOP AT lt_return_c INTO ls_return.
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

  IF lt_balmi IS NOT INITIAL.
    CALL FUNCTION 'ZZMDG_FM_APPL_LOG_CREATE'
      EXPORTING
        balhdri       = ls_balhdri
        iv_log_handle = lv_log_handle
      TABLES
        messages      = lt_balmi.
    REFRESH lt_balmi.
  ENDIF.



ENDFUNCTION.
