class YZ_CLAS_RARE_CUSTOM_BASE definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF cty_popup,
        tcode(12)    TYPE c,
        assgngrp(60) TYPE c,
        subcatg(60)  TYPE c,
        status(100)  TYPE c,
      END OF cty_popup .

  class-data:
    ct_upload_status TYPE STANDARD TABLE OF cty_popup .

  class-methods UPLOAD_FILE_CATEGORY
    importing
      !IV_PATH type STRING optional
      !IV_FILE_TYPE type STRING optional .
  class-methods PAI_UPLOAD_TMG .
  class-methods UPDATE_USER_AND_TIME_DETAILS
    changing
      !CT_RARE_CATG type YZTABL_RARE_CATG optional .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_RARE_CUSTOM_BASE IMPLEMENTATION.


  METHOD pai_upload_tmg.


    DATA:  mo_oref_root TYPE REF TO cx_root,
           mv_text      TYPE string.

    DATA: lv_title     TYPE string,
          lt_filetable TYPE filetable,
          lv_rc        TYPE i,
          lv_file(200) TYPE c,
          ls_filetable LIKE LINE OF lt_filetable,
          lv_error_msg TYPE string,
          gv_path      TYPE string,

          file_type    TYPE string.


    TRY.

        MESSAGE 'Kindly upload file of type .csv or .xls only' TYPE 'I'.

        CALL METHOD cl_gui_frontend_services=>file_open_dialog
          EXPORTING
            window_title            = lv_title
          CHANGING
            file_table              = lt_filetable
            rc                      = lv_rc
          EXCEPTIONS
            file_open_dialog_failed = 1
            cntl_error              = 2
            error_no_gui            = 3
            not_supported_by_gui    = 4
            OTHERS                  = 5.

        IF sy-subrc = 0.
          READ TABLE lt_filetable INTO ls_filetable INDEX 1.

          IF sy-subrc EQ 0.
            lv_file  = ls_filetable-filename.
            gv_path = lv_file.

            SPLIT gv_path AT '.' INTO lv_file file_type .

            IF  file_type = 'csv' OR file_type = 'CSV'.
              IF gv_path IS NOT INITIAL .
                CALL METHOD yz_clas_rare_custom_base=>upload_file_category
                  EXPORTING
                    iv_path      = gv_path
                    iv_file_type = 'CSV'.

                IF yz_clas_rare_base=>cs_rare_interface-exceptions IS NOT INITIAL.

                  CALL METHOD yz_clas_rare_base=>send_exceptions
                    EXPORTING
                      it_exceptions = yz_clas_rare_base=>cs_rare_interface-exceptions.
                ENDIF.

              ELSE.
                MESSAGE s043(yz_msag_rare) DISPLAY LIKE 'E'.
              ENDIF.

            ELSEIF file_type = 'xlsx' OR  file_type = 'xls' or file_type = 'XLSX' OR  file_type = 'XLS'.

              IF gv_path IS NOT INITIAL .
                CALL METHOD yz_clas_rare_custom_base=>upload_file_category
                  EXPORTING
                    iv_path      = gv_path
                    iv_file_type = 'XLS'.

                IF yz_clas_rare_base=>cs_rare_interface-exceptions IS NOT INITIAL.

                  CALL METHOD yz_clas_rare_base=>send_exceptions
                    EXPORTING
                      it_exceptions = yz_clas_rare_base=>cs_rare_interface-exceptions.
                ENDIF.

              ELSE.
                MESSAGE s043(yz_msag_rare) DISPLAY LIKE 'E'.
              ENDIF.

            ELSE.
              MESSAGE 'Please provide file oly of type .csv or .xls' TYPE 'S' DISPLAY LIKE 'E'.

            ENDIF.

          ELSE.
            MESSAGE s044(yz_msag_rare) DISPLAY LIKE 'E'.
          ENDIF.
        ELSE.
          CASE sy-subrc.
            WHEN 1.
              lv_error_msg = 'Exception file_open_dialog_failed caught while executing file_open_dialog in report YZ_PROG_RARE_UPLOAD'(001) .
              APPEND lv_error_msg TO yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR lv_error_msg.
            WHEN 2.
              lv_error_msg = 'Exception cntl_error caught while executing file_open_dialog in report YZ_PROG_RARE_UPLOAD'(002) .
              APPEND lv_error_msg TO yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR lv_error_msg.
            WHEN 3.
              lv_error_msg = 'Exception  error_no_gui caught while executing file_open_dialog in report YZ_PROG_RARE_UPLOAD'(003) .
              APPEND lv_error_msg TO yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR lv_error_msg.
            WHEN 4.
              lv_error_msg = 'Exception not_supported_by_gui caught while executing file_open_dialog in report YZ_PROG_RARE_UPLOAD'(004) .
              APPEND lv_error_msg TO yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR lv_error_msg.
            WHEN 5.
              lv_error_msg = 'Exception  OTHERS caught while executing file_open_dialog in report YZ_PROG_RARE_UPLOAD'(005) .
              APPEND lv_error_msg TO yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR lv_error_msg.
            WHEN OTHERS.
          ENDCASE.
        ENDIF.


      CATCH cx_root INTO  mo_oref_root .
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD update_user_and_time_details.

    DATA: mo_oref_root TYPE REF TO cx_root,
          mv_text      TYPE string.

    TRY.

        ct_rare_catg-file_flag = abap_false.
        ct_rare_catg-updated_by = sy-uname.
        GET TIME STAMP FIELD  ct_rare_catg-updated_on.

      CATCH cx_root INTO mo_oref_root.
        mv_text = mo_oref_root->get_text( ).
        APPEND mv_text TO yz_clas_rare_base=>cs_rare_interface-exceptions.
        yz_clas_rare_base=>collect_mesg( mv_text ).
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.


  METHOD upload_file_category.

    CONSTANTS : mc_sperator TYPE c VALUE ';'.

    TYPES: BEGIN OF mty_text,
             rec(4096) TYPE c,
           END OF mty_text.

    TYPES: BEGIN OF mty_data,
             tcode(12)    TYPE c,
             assgngrp(50) TYPE c,
             subcatg(50)  TYPE c,
           END OF mty_data.

*    TYPES: BEGIN OF mty_popup,
*             tcode(12)    TYPE c,
*             assgngrp(60) TYPE c,
*             subcatg(60)  TYPE c,
*             status(100)  TYPE c,
*           END OF mty_popup.


    DATA: mt_raw               TYPE STANDARD TABLE OF  mty_text,             "Raw data after uplaod
          ms_raw               TYPE                    mty_text,

          mt_data              TYPE STANDARD TABLE OF mty_data,              "Coverted into internal table data
          ms_final             TYPE                   yztabl_rare_catg,

          mt_popup             TYPE STANDARD TABLE OF cty_popup,             "Internal table as popup with status
          ms_popup             TYPE                   cty_popup,


          mt_domain_values_cat TYPE STANDARD TABLE OF  yztabl_rare_scat,
          ms_domain_values_cat TYPE                    yztabl_rare_scat,
          mt_domain_values_grp TYPE STANDARD TABLE OF  yztabl_rare_grp,
          ms_domain_values_grp TYPE                    yztabl_rare_grp,

          mv_text              TYPE string,
          mo_oref_root         TYPE REF TO cx_root,
          mv_filename          TYPE rlgrap-filename,
          mt_raw_data          TYPE truxs_t_text_data,
          ms_raw_data          TYPE truxs_t_text_data.

    FIELD-SYMBOLS : <fs_data>  TYPE mty_data.

    TRY .

        SELECT *
                    FROM yztabl_rare_scat
                    INTO TABLE mt_domain_values_cat
                    WHERE description IS NOT NULL .

        SELECT *
                   FROM yztabl_rare_grp
                   INTO TABLE mt_domain_values_grp
                   WHERE description IS NOT NULL .


        mv_filename   = iv_path.

        CALL FUNCTION 'GUI_UPLOAD'
          EXPORTING
            filename                = iv_path
            filetype                = 'BIN'
          TABLES
            data_tab                = mt_raw
          EXCEPTIONS
            file_open_error         = 1
            file_read_error         = 2
            no_batch                = 3
            gui_refuse_filetransfer = 4
            invalid_type            = 5
            no_authority            = 6
            unknown_error           = 7
            bad_data_format         = 8
            header_not_allowed      = 9
            separator_not_allowed   = 10
            header_too_long         = 11
            unknown_dp_error        = 12
            access_denied           = 13
            dp_out_of_memory        = 14
            disk_full               = 15
            dp_timeout              = 16
            OTHERS                  = 17.

        IF  sy-subrc = 0.
          mt_raw_data[] = mt_raw[].

          IF iv_file_type = 'CSV'.
            "CSV
            CALL FUNCTION 'TEXT_CONVERT_CSV_TO_SAP'
              EXPORTING
                i_field_seperator    = mc_sperator
                i_line_header        = abap_false
                i_tab_raw_data       = mt_raw_data
                i_filename           = mv_filename
              TABLES
                i_tab_converted_data = mt_data
              EXCEPTIONS
                conversion_failed    = 1
                OTHERS               = 2.

          ELSE .
            "XLS
            CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
              EXPORTING
*               i_field_seperator    = mc_sperator
                i_line_header        = abap_false
                i_tab_raw_data       = mt_raw_data
                i_filename           = mv_filename
              TABLES
                i_tab_converted_data = mt_data
              EXCEPTIONS
                conversion_failed    = 1
                OTHERS               = 2.
          ENDIF.

          IF sy-subrc = 0 AND mt_data IS NOT INITIAL.

            GET TIME STAMP FIELD  ms_final-updated_on.

            LOOP AT mt_data ASSIGNING <fs_data>.

              IF <fs_data> IS ASSIGNED.

                IF  <fs_data>-tcode IS  NOT INITIAL.
                  SELECT COUNT(*) FROM tstc WHERE tcode = <fs_data>-tcode.
                  IF sy-subrc <> 0  .
                    "internal table
                    ms_popup-tcode  = <fs_data>-tcode.
                    ms_popup-assgngrp = <fs_data>-assgngrp.
                    ms_popup-subcatg   = <fs_data>-subcatg.
                    ms_popup-status = 'No such Tcode exist '.
                    APPEND ms_popup TO ct_upload_status.
                    CLEAR ms_popup.
                    CONTINUE.
                  ENDIF..
                ELSE.
*   get the message in internal table
                  ms_popup-tcode  = <fs_data>-tcode.
                  ms_popup-assgngrp = <fs_data>-assgngrp.
                  ms_popup-subcatg   = <fs_data>-subcatg.
                  ms_popup-status = 'Tcode cant be empty'.
                  APPEND ms_popup TO ct_upload_status.
                  CLEAR ms_popup.

                  CONTINUE.
                ENDIF.

                TRANSLATE <fs_data>-subcatg TO  UPPER CASE.
                CONDENSE <fs_data>-subcatg.
                SORT mt_domain_values_cat BY subcategory.
                READ TABLE mt_domain_values_cat INTO ms_domain_values_cat WITH KEY
                                                                          subcategory = <fs_data>-subcatg
                                                                          BINARY SEARCH.

                IF sy-subrc = 0.

                  TRANSLATE <fs_data>-assgngrp TO  UPPER CASE.
                  CONDENSE <fs_data>-assgngrp.
                  SORT mt_domain_values_grp BY  assignment_group.
                  READ TABLE mt_domain_values_grp INTO ms_domain_values_grp WITH KEY
                                                                            assignment_group = <fs_data>-assgngrp
                                                                            BINARY SEARCH.

                  IF sy-subrc = 0.

                    ms_final-tcode           =  <fs_data>-tcode.
                    ms_final-sub_category    =  ms_domain_values_cat-description.
                    ms_final-assignment_grp  =  ms_domain_values_grp-description.
                    ms_final-file_flag       =  abap_true.
                    ms_final-updated_by      =  sy-uname.
                    ms_final-active          =  abap_true.

                    INSERT yztabl_rare_catg FROM  ms_final.

                    IF  sy-subrc = 0.
                      CALL FUNCTION 'DB_COMMIT'.
                      ms_popup-tcode  = <fs_data>-tcode.
                      ms_popup-assgngrp = <fs_data>-assgngrp.
                      ms_popup-subcatg   = <fs_data>-subcatg.
                      ms_popup-status = 'Record  inserted/updated successfully'.
                      APPEND ms_popup TO ct_upload_status.
                      CLEAR ms_popup.
                    ELSE.

                      MODIFY yztabl_rare_catg FROM ms_final.

                      IF  sy-subrc = 0.
                        CALL FUNCTION 'DB_COMMIT'.
                        ms_popup-tcode  = <fs_data>-tcode.
                        ms_popup-assgngrp = <fs_data>-assgngrp.
                        ms_popup-subcatg   = <fs_data>-subcatg.
                        ms_popup-status = 'Record  inserted/updated successfully'.
                        APPEND ms_popup TO ct_upload_status.
                        CLEAR ms_popup.
                      ELSE.       "Error while inserting data into table
*                        MESSAGE i040(yz_msag_rare).
                        ms_popup-tcode  = <fs_data>-tcode.
                        ms_popup-assgngrp = <fs_data>-assgngrp.
                        ms_popup-subcatg   = <fs_data>-subcatg.
                        ms_popup-status = 'Record could not be inserted/updated'.
                        APPEND ms_popup TO ct_upload_status.
                        CLEAR ms_popup.

                      ENDIF.

                    ENDIF.

                  ELSE.           "Read table- No such assignment group exist
*                    MESSAGE i041(yz_msag_rare).
                    ms_popup-tcode    = <fs_data>-tcode.
                    ms_popup-assgngrp = <fs_data>-assgngrp.
                    ms_popup-subcatg     = <fs_data>-subcatg.
                    ms_popup-status   = 'No such group exist'.
                    APPEND ms_popup TO ct_upload_status.
                    CLEAR ms_popup.
                  ENDIF.

                ELSE.           "Read table- No such category exist
*                    MESSAGE i041(yz_msag_rare).
                  ms_popup-tcode  = <fs_data>-tcode.
                  ms_popup-assgngrp = <fs_data>-assgngrp.
                  ms_popup-subcatg   = <fs_data>-subcatg.
                  ms_popup-status = 'No such category exist'.
                  APPEND ms_popup TO ct_upload_status.
                  CLEAR ms_popup.
                ENDIF.

              ELSE.           "Field symbol assignment - Provide tcode data
*                  MESSAGE s042(yz_msag_rare) DISPLAY LIKE 'E'.
                ms_popup-tcode  = <fs_data>-tcode.
                ms_popup-assgngrp = <fs_data>-assgngrp.
                ms_popup-subcatg   = <fs_data>-subcatg.
                ms_popup-status = 'Provide tcode data'.
                APPEND ms_popup TO ct_upload_status.
                CLEAR ms_popup.
              ENDIF.

            ENDLOOP.





          ELSE.            "TEXT_CONVERT_CSV_TO_SAP failed
            CASE sy-subrc.
              WHEN 1.
                mv_text = 'Exception conversion_failed caught while converting data in method UPLOAD_FILE_CATEGORY'(037) .
                APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
                CLEAR mv_text.
              WHEN 2 .
                mv_text = 'Exception others caught while converting data in method UPLOAD_FILE_CATEGORY'(036) .
                APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
                CLEAR mv_text.
              WHEN OTHERS.
            ENDCASE.
          ENDIF.

        ELSE.          "GUI_UPLOAD
          CASE sy-subrc.
            WHEN 1.
              mv_text = 'Exception file_open_error caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(038) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 2 .
              mv_text = 'Exception file_read_error caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(039) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 3 .
              mv_text = 'Exception no_batch  caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(040) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 4 .
              mv_text = 'Exception gui_refuse_filetransfer caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(044) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 5 .
              mv_text = 'Exception invalid_type  caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(045) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 6 .
              mv_text = 'Exception  no_authority caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(046) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 7 .
              mv_text = 'Exception unknown_error caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(047) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 8 .
              mv_text = 'Exceptionbad_data_format  caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(048) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 9 .
              mv_text = 'Exception header_not_allowed caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(049) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 10 .
              mv_text = 'Exception separator_not_allowed caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(050) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 11 .
              mv_text = 'Exception header_too_long caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(051) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 12 .
              mv_text = 'Exception unknown_dp_error caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(052) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 13 .
              mv_text = 'Exception access_denied caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(053) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 14 .
              mv_text = 'Exception dp_out_of_memory caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(054) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 15 .
              mv_text = 'Exception disk_full caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(070) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 16 .
              mv_text = 'Exception dp_timeout  caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(071) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN 17 .
              mv_text = 'Exception OTHERS  caught while executing FM GUI_UPLOAD in method UPLOAD_FILE_CATEGORY'(072) .
              APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
              CLEAR mv_text.

            WHEN OTHERS.
          ENDCASE.
        ENDIF.

      CATCH cx_root INTO mo_oref_root.
        mv_text =  mo_oref_root->get_text( ).
        APPEND mv_text TO  yz_clas_rare_base=>cs_rare_interface-exceptions.
        CLEAR mv_text.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
