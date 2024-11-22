class ZZMDG_CL_FEEDER_PIR_ORG_POPUP definition
  public
  final
  create public .

public section.

  interfaces IF_FPM_GUIBB .
  interfaces IF_FPM_GUIBB_LIST .

  TYPES: BEGIN OF ty_pog,
                  lifnr TYPE elifn,
                  ekorg TYPE ekorg,
                  werks TYPE werks_d,
                  esokz TYPE esokz,
                  esokz_txt TYPE val_text,
         END OF ty_pog.

   DATA : gt_pog TYPE TABLE OF ty_pog,
          gt_pog_upd TYPE TABLE OF ty_pog.
protected section.
private section.
ENDCLASS.



CLASS ZZMDG_CL_FEEDER_PIR_ORG_POPUP IMPLEMENTATION.


  method IF_FPM_GUIBB_LIST~CHECK_CONFIG.

  endmethod.


  method IF_FPM_GUIBB_LIST~FLUSH.
  endmethod.


  method IF_FPM_GUIBB_LIST~GET_DATA.

    TYPES : BEGIN OF ty_pog_new,
              lifnr     TYPE elifn,
              ekorg     TYPE ekorg,
              werks     TYPE werks_d,
              esokz     TYPE esokz,
              esokz_txt TYPE val_text,
            END OF ty_pog_new.
    DATA : lt_pog_new TYPE TABLE OF ty_pog_new,
           ls_pog_new TYPE ty_pog_new.
    DATA: lt_dd07_a TYPE TABLE OF dd07v,
          ls_dd07_a TYPE dd07v,
          lt_dd07_n TYPE TABLE OF dd07v.
    DATA: ls_tcurm  TYPE tcurm.
    DATA : lv_dialog_box_id TYPE string.
    DATA : ls_row   TYPE zzmdg_bs_mat_s_eina.
    DATA : ls_selected_lines TYPE rstabix.
    DATA : ls_pog    TYPE ty_pog,
           lt_pog_ex TYPE TABLE OF ty_pog.


    IF iv_eventid->mv_event_id = 'FPM_OPEN_DIALOG'.
      iv_eventid->mo_event_data->get_value( EXPORTING iv_key = if_fpm_constants=>gc_dialog_box-id IMPORTING ev_value = lv_dialog_box_id ).
      iv_eventid->mo_event_data->get_value( EXPORTING iv_key = 'TAB' IMPORTING ev_value = lt_pog_ex ).
      REFRESH gt_pog.
      IF lv_dialog_box_id = 'POG_INS'.
        CLEAR : gt_pog_upd.
        CLEAR : ct_selected_lines.
        cv_lead_index = if_wd_context_node=>no_selection.
        ev_selected_lines_changed = abap_true.
        ls_row = zzmdg_cl_feeder_zpurchgen=>gs_row.
        IF ls_row-lifnr IS NOT INITIAL.
          REFRESH lt_pog_new.
          SELECT ez~lifnr ez~ekorg ia~werks FROM lfm1 AS ez
                                   INNER JOIN t024w AS ia ON ez~ekorg = ia~ekorg
                                   INTO CORRESPONDING FIELDS OF TABLE lt_pog_new
                                   WHERE ez~lifnr = ls_row-lifnr.
          IF sy-subrc IS INITIAL.
*           Get the domain values for Info Category:
            REFRESH: lt_dd07_a, lt_dd07_n.
            CALL FUNCTION 'DD_DOMA_GET'
              EXPORTING
                domain_name   = 'ESOKZ'
              TABLES
                dd07v_tab_a   = lt_dd07_a
                dd07v_tab_n   = lt_dd07_n
              EXCEPTIONS
                illegal_value = 1
                op_failure    = 2
                OTHERS        = 3.
            IF sy-subrc IS INITIAL.
              CLEAR ls_tcurm.
              SELECT SINGLE * FROM tcurm INTO ls_tcurm.
              LOOP AT lt_dd07_a INTO ls_dd07_a.
                LOOP AT lt_pog_new INTO ls_pog_new.
                  IF NOT ( ls_dd07_a-domvalue_l = '1' AND ls_tcurm-charg IS INITIAL ). " For '1', CHARG must be active
                    CLEAR ls_pog.
                    ls_pog-lifnr      = ls_pog_new-lifnr.
                    ls_pog-ekorg      = ls_pog_new-ekorg.
                    ls_pog-werks      = ls_pog_new-werks.
                    ls_pog-esokz      = ls_dd07_a-domvalue_l.
                    ls_pog-esokz_txt  = ls_dd07_a-ddtext.
                    APPEND ls_pog TO gt_pog.
                  ENDIF.
                ENDLOOP.
              ENDLOOP.
              SORT gt_pog.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
      CHECK gt_pog IS NOT INITIAL.
      LOOP AT lt_pog_ex INTO ls_pog.
        READ TABLE gt_pog WITH KEY lifnr = ls_pog-lifnr ekorg = ls_pog-ekorg werks = ls_pog-werks TRANSPORTING NO FIELDS.
        IF sy-subrc IS INITIAL.
          DELETE gt_pog INDEX sy-tabix.
        ENDIF.
      ENDLOOP.
      ct_data = gt_pog.
      ev_data_changed = abap_true.

    ELSEIF iv_eventid->mv_event_id = 'FPM_GUIBB_LIST_ON_LEAD_SELECTI'.
      IF ct_selected_lines IS NOT INITIAL.
        CLEAR : gt_pog_upd.
        LOOP AT ct_selected_lines INTO ls_selected_lines.
          READ TABLE gt_pog INTO ls_pog INDEX ls_selected_lines-tabix.
          IF sy-subrc IS INITIAL.
            READ TABLE gt_pog_upd WITH KEY lifnr = ls_pog-lifnr ekorg = ls_pog-ekorg werks = ls_pog-werks esokz = ls_pog-esokz TRANSPORTING NO FIELDS.
            IF sy-subrc IS NOT INITIAL.
*              APPEND ls_pog TO gt_pog_upd.
              APPEND ls_pog TO gt_pog_upd.
            ENDIF.
          ENDIF.
          CLEAR : ls_pog.
        ENDLOOP.
      ELSE.
        CLEAR : gt_pog_upd.
      ENDIF.
    ENDIF.

  endmethod.


  method IF_FPM_GUIBB_LIST~GET_DEFAULT_CONFIG.

  endmethod.


  method IF_FPM_GUIBB_LIST~GET_DEFINITION.

    TYPES : BEGIN OF ty_pog,
              lifnr     TYPE elifn,
              ekorg     TYPE ekorg,
              werks     TYPE werks_d,
              esokz     TYPE esokz,
              esokz_txt TYPE val_text,
            END OF ty_pog.

    DATA : lt_pog TYPE TABLE OF ty_pog.

    eo_field_catalog ?= cl_abap_tabledescr=>describe_by_data( lt_pog ).
  endmethod.


  method IF_FPM_GUIBB_LIST~PROCESS_EVENT.

   DATA : lv_dialog_box_id TYPE string,
           lv_action        TYPE string,
           lo_fpm           TYPE REF TO if_fpm,
           lo_fpm_event     TYPE REF TO cl_fpm_event.

    DATA : ls_row   TYPE zzmdg_bs_mat_s_eina.

    IF io_event->mv_event_id = 'FPM_OPEN_DIALOG'.
      io_event->mo_event_data->get_value( EXPORTING iv_key = if_fpm_constants=>gc_dialog_box-id IMPORTING ev_value = lv_dialog_box_id ).
      IF lv_dialog_box_id = 'POG_INS'.
        ls_row = zzmdg_cl_feeder_zpurchgen=>gs_row.
        IF ls_row-lifnr IS NOT INITIAL.
*          SELECT lifnr ekorg FROM lfm1 INTO TABLE gt_pog WHERE lifnr = ls_row-lifnr.
          SELECT ez~lifnr ez~ekorg ia~werks FROM lfm1 AS ez
                                   INNER JOIN t024w AS ia ON ez~ekorg = ia~ekorg
                                   INTO CORRESPONDING FIELDS OF TABLE gt_pog
                                   WHERE ez~lifnr = ls_row-lifnr.
        ENDIF.
      ENDIF.

    ELSEIF io_event->mv_event_id = 'FPM_CLOSE_DIALOG'.
      io_event->mo_event_data->get_value( EXPORTING iv_key = if_fpm_constants=>gc_dialog_box-id IMPORTING ev_value = lv_dialog_box_id ).
      IF lv_dialog_box_id = 'POG_INS'.
        io_event->mo_event_data->get_value( EXPORTING iv_key = 'DIALOG_BUTTON_ACTION' IMPORTING ev_value = lv_action ).
        IF lv_action = 'OK'.
          lo_fpm = cl_fpm_factory=>get_instance( ).
          lo_fpm_event = cl_fpm_event=>create_by_id( EXPORTING iv_event_id = 'SET_POG' ).
          lo_fpm_event->mo_event_data->set_value( EXPORTING iv_key = 'TAB' iv_value = gt_pog_upd ).
          IF lo_fpm_event IS BOUND.
            lo_fpm->raise_event( lo_fpm_event ).
          ENDIF.
        ENDIF.
      ENDIF.

    ENDIF.

  endmethod.


  method IF_FPM_GUIBB~GET_PARAMETER_LIST.

  endmethod.


  method IF_FPM_GUIBB~INITIALIZE.

  endmethod.
ENDCLASS.
