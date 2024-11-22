*&---------------------------------------------------------------------*
*&  Include           YZ_PROG_RARE_INCI_CL
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Rreport for RaRe incident management logs
*&---------------------------------------------------------------------*

DATA:
  gr_selections TYPE REF TO            cl_salv_selections, ##NEEDED
  gt_rows       TYPE                   salv_t_row,         ##NEEDED
  gr_alv        TYPE REF TO            cl_salv_table,      ##NEEDED
  gt_rare_inci  TYPE STANDARD TABLE OF yztabl_rare_inci.   ##NEEDED



CLASS lcl_handler_factory DEFINITION ABSTRACT.
  PUBLIC SECTION.
    CLASS-METHODS : factory
      IMPORTING iv_object_type   TYPE char30  ##NEEDED
      RETURNING VALUE(rv_object) TYPE REF TO lcl_handler_factory,
      init.
    METHODS : process ABSTRACT.
ENDCLASS.                    "lcl_handler_factory DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_execute DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_execute DEFINITION INHERITING FROM lcl_handler_factory FINAL.
  PUBLIC SECTION.

    CLASS-METHODS :  get_data,
      display_alv.

    METHODS : process REDEFINITION.
    " get_data,
    "display_alv.

ENDCLASS.                    "lcl_execute DEFINITION
CLASS lcl_handle_events DEFINITION FINAL.
  PUBLIC SECTION.

    METHODS:
      on_line_click   FOR EVENT added_function         OF cl_salv_events_table ,
      on_double_click FOR EVENT link_click             OF cl_salv_events_table .

    "event handler method, importing row and column of clicked value
ENDCLASS.                    "lcl_events DEFINITION

CLASS lcl_handle_events IMPLEMENTATION.

  METHOD on_line_click.
    DATA: ms_rows      LIKE LINE OF gt_rows,
          mv_row       TYPE string,
          ms_rare_inci TYPE yztabl_rare_inci,
          mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        IF sy-ucomm = 'YZ_REFRESH'.

          lcl_execute=>get_data( ).
          lcl_execute=>display_alv( ).

        ENDIF.

        gr_selections = gr_alv->get_selections( ).
        gt_rows = gr_selections->get_selected_rows( ).

        IF gt_rows IS INITIAL.
          MESSAGE 'Please select a valid line'(001) TYPE 'E' DISPLAY LIKE 'S'.
        ENDIF.

        LOOP AT gt_rows INTO ms_rows.

          mv_row = ms_rows.

          READ TABLE gt_rare_inci INTO ms_rare_inci INDEX mv_row.
          IF  sy-subrc <> 0.
            MESSAGE 'Please select a valid line'(001) TYPE 'I'.
          ELSE.

            IF ms_rare_inci-wi_id IS INITIAL.
              ms_rare_inci-wi_id = yz_clas_rare_base=>sync_workitem( ms_rare_inci ).
            ENDIF.

            IF ms_rare_inci-wi_id IS NOT INITIAL.

              CASE sy-ucomm.

                WHEN 'YZ_GEN_PDF'.
                  "Download PDF
                  CALL METHOD yz_clas_rare_base=>download_pdf
                    EXPORTING
                      is_rare_inci = ms_rare_inci.

                WHEN 'YZ_RESUB'.
                  "Re-submit
                  IF ms_rare_inci-inc_no IS INITIAL AND ms_rare_inci-wi_id IS NOT INITIAL.

                    ms_rare_inci-command = 'ENT'.
                    CALL METHOD yz_clas_rare_base=>popup_control
                      EXPORTING
                        is_rare_inci = ms_rare_inci.

                  ELSE.
                    mv_text =  text-004  && ' Incident No: '(002) &&  ms_rare_inci-inc_no .
                    MESSAGE mv_text TYPE 'I' DISPLAY LIKE 'I'.

                  ENDIF.

                WHEN 'YZ_VIEWPDF'.
                  "View PDF
                  ms_rare_inci-command = 'DIS'.
                  CALL METHOD yz_clas_rare_base=>get_pdf_form
                    EXPORTING
                      iv_view      = abap_true
                      is_rare_inci = ms_rare_inci.

                WHEN 'YZ_Mail'.

                WHEN OTHERS.
              ENDCASE.


            ELSE.
              mv_text = 'Workitem ID is intital hence session has not been saved in our RaRe Tool'(008).
              MESSAGE mv_text TYPE 'I' DISPLAY LIKE 'I'.
            ENDIF.
          ENDIF.

        ENDLOOP.

      CATCH cx_root INTO mo_oref_root.       ##CATCH_ALL
        mv_text = mo_oref_root->get_text( ). ##CATCH_ALL
        APPEND mv_text TO gt_exceptions.
    ENDTRY.

  ENDMETHOD.                    "on_link_click
  METHOD on_double_click.

    DATA: mo_oref_root TYPE REF TO cx_root,
          ms_rows      LIKE LINE OF gt_rows,
          mv_row       TYPE string,
          ms_rare_inci TYPE yztabl_rare_inci,
          mt_rsparams  TYPE TABLE OF rsparams,
          ms_rsparams  TYPE   rsparams,
          mv_text      TYPE string.

    TRY.

        gr_selections = gr_alv->get_selections( ).
        gt_rows = gr_selections->get_selected_rows( ).

        LOOP AT gt_rows INTO ms_rows.

          mv_row = ms_rows.

          READ TABLE gt_rare_inci INTO ms_rare_inci INDEX mv_row.
          IF sy-subrc = 0.

            CLEAR   :  ms_rsparams.
            REFRESH :  mt_rsparams[].

            ms_rsparams-selname = 'ID'.
            ms_rsparams-sign    = 'I'.
            ms_rsparams-option  = 'EQ'.
            ms_rsparams-low     = ms_rare_inci-wi_id.
            ms_rsparams-high    = ' '.

            APPEND ms_rsparams TO mt_rsparams.

            CALL FUNCTION 'SUBMIT_REPORT'
              EXPORTING
                report           = 'RSWIWILS'
                ret_via_leave    = abap_false
                skip_selscreen   = abap_true
              TABLES
                selection_table  = mt_rsparams
              EXCEPTIONS
                just_via_variant = 1
                no_submit_auth   = 2
                OTHERS           = 3.

            IF sy-subrc <> 0.
              CASE sy-subrc.
                WHEN 1.
                  mv_text =   'Exception just_via_variant caught while running report RSWIWILS'(009).
                  APPEND mv_text TO  gt_exceptions.
                  CLEAR mv_text.
                WHEN 2.
                  mv_text =   'Exception no_submit_auth caught while running report RSWIWILS'(010).
                  APPEND mv_text TO  gt_exceptions.
                  CLEAR mv_text.
                WHEN 3.
                  mv_text =   'Exception OTHERS caught while running report RSWIWILS'(011).
                  APPEND mv_text TO gt_exceptions.
                  CLEAR mv_text.
              ENDCASE.
            ENDIF.

          ELSE.
            MESSAGE 'No such workitem exist'(006) TYPE 'I'.
          ENDIF.

        ENDLOOP.

      CATCH cx_root INTO mo_oref_root.          ##CATCH_ALL
        mv_text = mo_oref_root->get_text( ).    ##CATCH_ALL
        APPEND mv_text TO gt_exceptions.
    ENDTRY.
  ENDMETHOD .

ENDCLASS.

*----------------------------------------------------------------------*
*       CLASS lcl_execute IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_execute IMPLEMENTATION.
  METHOD process.

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        get_data( ).
        display_alv( ).

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO gt_exceptions.
    ENDTRY.

  ENDMETHOD.                    "process

  METHOD: get_data.

    DATA : mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.

    TRY.

        SELECT *
          FROM yztabl_rare_inci
    INTO TABLE gt_rare_inci
         UP TO lv_hits ROWS
         WHERE
          guid               IN s_guid    AND
          user_name          IN s_user    AND
          tcode              IN s_tcode   AND
          inc_no             IN s_incno   AND
          short_description  IN s_sdesc   AND
          impact             IN s_impact  AND
          state              IN s_state   AND
          urgency            IN s_urgen   AND
          wi_id              IN s_wi_id   AND
          req_timestamp      IN s_req_t   AND
          inc_timestamp      IN s_inc_t   AND
          last_d_timestamp   IN s_last_d  AND
          command            IN s_comand  AND
          download_count     IN s_dcount  AND
          status_mesg        IN s_status  AND
          data_file          IN s_data    AND
          sub_category       IN s_subcat AND
          assignment_grp     IN s_grp.

        IF sy-subrc <>  0.

          MESSAGE 'No Entries found for given selection criteria'(007) TYPE 'S'  DISPLAY LIKE 'E'.

        ENDIF.

      CATCH cx_root INTO mo_oref_root.          ##CATCH_ALL
        mv_text = mo_oref_root->get_text( ).    ##CATCH_ALL
        APPEND mv_text TO gt_exceptions.
    ENDTRY.
  ENDMETHOD.

  METHOD: display_alv.

    DATA:
      mo_oref_root                 TYPE REF TO cx_root,
      mv_text                      TYPE string,
      mo_oref_salv_msg             TYPE REF TO cx_salv_msg,
      mo_oref_method_not_supported TYPE REF TO cx_salv_method_not_supported,
      mr_columns                   TYPE REF TO cl_salv_columns_table,
      mr_col                       TYPE REF TO cl_salv_column_table, "column instance
      mr_events_handle             TYPE REF TO lcl_handle_events,
      mr_events                    TYPE REF TO cl_salv_events_table.

    TRY.

        IF gt_rare_inci[] IS NOT INITIAL.
*---------------------------------------------------------
          TRY.
              cl_salv_table=>factory(
                IMPORTING
                  r_salv_table = gr_alv
                CHANGING
                  t_table      = gt_rare_inci ).

            CATCH cx_salv_msg INTO mo_oref_salv_msg.
              mv_text = mo_oref_salv_msg->get_text( ).
              APPEND mv_text TO gt_exceptions.
              CLEAR mv_text.
          ENDTRY.

*----------------------------------------------------------
          gr_selections = gr_alv->get_selections( ).
          CALL METHOD gr_selections->set_selection_mode
            EXPORTING
              value = if_salv_c_selection_mode=>multiple.
*-----------------------------------------------------------

          CALL METHOD gr_alv->get_columns  "get all columns
            RECEIVING
              value = mr_columns.
          IF mr_columns IS NOT INITIAL.

*Get guid column
            mr_col ?= mr_columns->get_column( 'WI_ID' ). "get WI-ID columns to insert hotspot

* Set the HotSpot for guid Column

            CALL METHOD mr_col->set_cell_type "set cell type hotspot
              EXPORTING
                value = if_salv_c_cell_type=>hotspot.

          ENDIF.

*Register events
*          TRY.
          mr_events = gr_alv->get_event( ). "get event
          CREATE OBJECT mr_events_handle.

          SET HANDLER   mr_events_handle->on_line_click   FOR mr_events. "register event handler method
          SET HANDLER   mr_events_handle->on_double_click FOR mr_events. "register event handler method


**set standard ALV functions visible
          TRY.

              gr_alv->set_screen_status(
                pfstatus      =  'YZ_RARE_INCI_STATUS'
                report        =  'YZ_PROG_RARE_INCI'
                set_functions = gr_alv->c_functions_all ).

            CATCH cx_salv_method_not_supported INTO mo_oref_method_not_supported.
              mv_text = mo_oref_method_not_supported->get_text( ).
              APPEND mv_text TO gt_exceptions.
              CLEAR mv_text.
          ENDTRY.
*-----------------------------------------------------------
*To optimize columns width.

          mr_columns = gr_alv->get_columns( ).
          mr_columns->set_optimize( ).

* To display final ALV
          gr_alv->display( ).
*-----------------------------------------------------------
        ENDIF.

      CATCH cx_root INTO mo_oref_root.               ##CATCH_ALL
        mv_text = mo_oref_root->get_text( ).         ##CATCH_ALL
        APPEND mv_text TO gt_exceptions.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.                    "lcl_execute IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_handler_factory IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_handler_factory IMPLEMENTATION.

  METHOD factory.

    DATA :  mo_oref_root TYPE REF TO cx_root,
            mv_text      TYPE string.

    TRY.

        CREATE OBJECT rv_object TYPE lcl_execute.

      CATCH cx_root INTO mo_oref_root.                ##CATCH_ALL
        mv_text = mo_oref_root->get_text( ).          ##CATCH_ALL
        APPEND mv_text TO gt_exceptions.

    ENDTRY.

  ENDMETHOD.                    "factory

  METHOD init.

    CLEAR gt_rows.
    CLEAR gr_alv.
    CLEAR gt_rare_inci.

  ENDMETHOD.                    "init
ENDCLASS.                    "lcl_handler_factory IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_main_app DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_main_app DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS : run.
ENDCLASS.                    "lcl_main_app DEFINITION


*----------------------------------------------------------------------*
*       CLASS lcl_main_app IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_main_app IMPLEMENTATION.
  METHOD run.

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string,
          mr_output    TYPE REF TO lcl_handler_factory.
    TRY.

        mr_output = lcl_handler_factory=>factory( 'EXECUTE' ) .
        mr_output->process( ).

      CATCH cx_root INTO mo_oref_root.                  ##CATCH_ALL
        mv_text = mo_oref_root->get_text( ).            ##CATCH_ALL
        APPEND mv_text TO gt_exceptions.
    ENDTRY.

  ENDMETHOD.                    "run
ENDCLASS.                    "lcl_main_app IMPLEMENTATION
