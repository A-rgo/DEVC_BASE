class YZ_CLAS_CUST_TABL_UPLOAD definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IV_TABLENAME type CHAR30
    exceptions
      CONSTRUCTOR_ERROR
      DATABASE_DOES_NOT_EXIST
      DATABASE_NOT_PERMITTED .
  methods EXCEL_DOWNLOAD
    importing
      !IV_FILLED type ABAP_BOOL default ABAP_FALSE
    exceptions
      EXCEL_CREATE_ERROR .
  methods EXCEL_UPLOAD
    importing
      !IV_OVERWRITE_DB type ABAP_BOOL default ABAP_FALSE
      !IV_LONG_FIELDS type ABAP_BOOL default ABAP_FALSE
    exceptions
      EXCEL_LOAD_FROM_ERROR
      LOGGING_SAVE_ERROR
      DATABASE_ERROR
      WRONG_STRUCTURE
      EXCEL_UPLOAD_ERROR
      DATABASE_DOES_NOT_EXIST
      DATABASE_NOT_PERMITTED .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS gc_comment TYPE char7 VALUE 'COMMENT' ##NO_TEXT.
    CONSTANTS gc_file_filter_excel TYPE string VALUE 'Excel (*.XLS;*.XLSX;*.XLSM)|*.XLS;*.XLSX;*.XLSM' ##NO_TEXT.
    CONSTANTS gc_file_filter_xls TYPE string VALUE 'Microsoft Excel 97-2003 Worksheet (*.XLS)|*.XLS' ##NO_TEXT.
    DATA go_tabletype TYPE REF TO cl_abap_tabledescr .
    DATA gt_database TYPE REF TO data .
    DATA gt_entries TYPE REF TO data .
    DATA gt_entries_c TYPE REF TO data .
    DATA gt_entries_logging TYPE REF TO data .
    DATA gt_entries_string TYPE REF TO data .
    DATA gt_faulty_string TYPE REF TO data .
    DATA gt_fieldcat TYPE lvc_t_fcat .
    DATA gt_fieldcat_faulty TYPE lvc_t_fcat .
    DATA gt_fieldcat_logging TYPE lvc_t_fcat .
*    DATA gt_fieldname TYPE zmdg_t_fieldname .
    DATA gt_fieldname TYPE SORTED TABLE OF fieldname WITH NON-UNIQUE DEFAULT KEY.
    DATA gv_filename_excel TYPE rlgrap-filename .
    DATA gv_tablename TYPE char30 .
    DATA gs_usr01 TYPE usr01 .
    CONSTANTS gc_strg TYPE char4 VALUE 'STRG' ##NO_TEXT.
    CONSTANTS gc_char TYPE char4 VALUE 'CHAR' ##NO_TEXT.
    CONSTANTS gc_dats TYPE char4 VALUE 'DATS' ##NO_TEXT.
    CONSTANTS gc_dec TYPE char3 VALUE 'DEC' ##NO_TEXT.
    CONSTANTS gc_curr TYPE char4 VALUE 'CURR' ##NO_TEXT.
    CONSTANTS gc_quan TYPE char4 VALUE 'QUAN' ##NO_TEXT.
    CONSTANTS gc_tims TYPE char4 VALUE 'TIMS' ##NO_TEXT.
    CONSTANTS gc_clnt TYPE char4 VALUE 'CLNT' ##NO_TEXT.
    CONSTANTS gc_sstr TYPE char4 VALUE 'SSTR' ##NO_TEXT.
    CONSTANTS gc_colon TYPE char1 VALUE ':' ##NO_TEXT.
    CONSTANTS gc_comma TYPE char1 VALUE ',' ##NO_TEXT.
    CONSTANTS gc_point TYPE char1 VALUE '.' ##NO_TEXT.
    CONSTANTS gc_file_filter_xlsx TYPE string VALUE 'Microsoft Excel Worksheet (*.XLSX)|*.XLSX' ##NO_TEXT.
    DATA gv_docheck TYPE abap_bool VALUE 'X' ##NO_TEXT.

    METHODS convert_string_to_decimal
      CHANGING
        !cv_string TYPE string
      EXCEPTIONS
        invalid_input .
    METHODS copy_1_of_excel_load_from
      EXCEPTIONS
        excel_load_from_error .
    METHODS db_modify
      EXCEPTIONS
        db_modify_error .
    METHODS entries_check_duplicate
      EXCEPTIONS
        check_duplicate_error .
    METHODS entries_check_foreign_key
      EXCEPTIONS
        check_foreign_key_error .
    METHODS entries_move
      EXCEPTIONS
        entries_move_error .
    METHODS excel_load_from
      EXCEPTIONS
        excel_load_from_error .
    METHODS file_delete
      IMPORTING
        !iv_filename TYPE string
      EXPORTING
        !ev_rc       TYPE i
      EXCEPTIONS
        file_delete_error .
    METHODS file_open
      IMPORTING
        !iv_file_filter TYPE string
      EXPORTING
        !ev_filename    TYPE string
      EXCEPTIONS
        file_open_error .
    METHODS file_save
      IMPORTING
        !iv_file_filter TYPE string
      EXPORTING
        !ev_filename    TYPE string
      EXCEPTIONS
        file_save_error .
    METHODS log_table_create
      IMPORTING
        !is_entries_string TYPE any
        !iv_text           TYPE string
        !iv_fieldname      TYPE char30 OPTIONAL
      EXCEPTIONS
        log_table_create_error .
    METHODS log_table_fieldcat_create
      EXCEPTIONS
        log_table_fieldcat_create_err .
    METHODS log_table_save
      EXCEPTIONS
        log_table_save_error .
ENDCLASS.



CLASS YZ_CLAS_CUST_TABL_UPLOAD IMPLEMENTATION.


  METHOD constructor.

    DATA:
      lv_structure_name  TYPE dd02l-tabname,
      lt_entries_c       TYPE REF TO data,
      lt_fieldcat_string TYPE lvc_t_fcat,
      lt_fieldcat_c      TYPE lvc_t_fcat,
      lv_row_pos         TYPE i,
      lv_col_pos         TYPE i VALUE 1,
      ls_fieldcat        TYPE lvc_s_fcat,
      lv_tabname(30)     TYPE c,
      lv_intlen          TYPE i,
      ls_fieldname       type fieldname,
      lt_fieldname       TYPE SORTED TABLE OF fieldname with NON-UNIQUE DEFAULT KEY,
      lt_dd03l           TYPE TABLE OF dd03l,
      lo_linetype        TYPE REF TO cl_abap_structdescr,
      lt_key             TYPE abap_keydescr_tab,
      lo_exception       TYPE REF TO cx_root ##needed.

    FIELD-SYMBOLS:
      <ls_fieldcat> TYPE lvc_s_fcat,
      <ls_dd03l>    TYPE dd03l,
      <lt_entries>  TYPE STANDARD TABLE,
      <lt_database> TYPE STANDARD TABLE.

    gv_tablename      = iv_tablename.
    lv_structure_name = iv_tablename.

*   Get entries of DD03L to get check tables
    ##too_many_itab_fields    SELECT fieldname checktable FROM dd03l INTO CORRESPONDING FIELDS OF TABLE lt_dd03l WHERE tabname = gv_tablename.
    IF sy-subrc <> 0.
      MESSAGE e000(zmdg_upload_rep_msg) WITH iv_tablename RAISING database_does_not_exist.
    ENDIF.

    SORT lt_dd03l.

*--------------------------------------------------------------------*
*   Create GT_fieldcat, GT_entries
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = lv_structure_name
      CHANGING
        ct_fieldcat            = gt_fieldcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
    ENDIF.

    LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
      READ TABLE lt_dd03l WITH KEY fieldname = <ls_fieldcat>-fieldname ASSIGNING <ls_dd03l>.
      <ls_fieldcat>-checktable = <ls_dd03l>-checktable.
      CASE <ls_fieldcat>-datatype.
        WHEN
          'DF34_RAW' OR
          'DF34_SCL' OR
          'DF34_DEC' OR
          'DF16_RAW' OR
          'DF16_SCL' OR
          'DF16_DEC' OR
          'FLTP'     OR
          'LCHR'     OR
          'RAWSTRING'.
          MESSAGE e002(zmdg_upload_rep_msg) RAISING constructor_error.
      ENDCASE.
    ENDLOOP.

    CALL METHOD cl_alv_table_create=>create_dynamic_table
      EXPORTING
        it_fieldcatalog           = gt_fieldcat
      IMPORTING
        ep_table                  = gt_entries
      EXCEPTIONS
        generate_subpool_dir_full = 1
        OTHERS                    = 2.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
    ENDIF.

    ASSIGN gt_entries->* TO <lt_entries>.

*--------------------------------------------------------------------*
*   Create GT_entries_string
    lt_fieldcat_string = gt_fieldcat.

    LOOP AT lt_fieldcat_string ASSIGNING <ls_fieldcat>.
      IF sy-subrc <> 0.
        MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
      ENDIF.
      <ls_fieldcat>-convexit  = ''.
      <ls_fieldcat>-datatype  = gc_strg.
      <ls_fieldcat>-inttype   = 'g'.
      <ls_fieldcat>-intlen    = 0.
      <ls_fieldcat>-domname   = ''.
      <ls_fieldcat>-ref_table = ''.
      lv_col_pos = lv_col_pos + 1.
    ENDLOOP.

    lv_row_pos = <ls_fieldcat>-row_pos.
    lv_tabname = <ls_fieldcat>-tabname.

    CALL METHOD cl_alv_table_create=>create_dynamic_table
      EXPORTING
        it_fieldcatalog           = lt_fieldcat_string
      IMPORTING
        ep_table                  = gt_entries_string
      EXCEPTIONS
        generate_subpool_dir_full = 1
        OTHERS                    = 2.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
    ENDIF.

*--------------------------------------------------------------------*
*   Create GT_fieldcat_faulty, GT_faulty_string
    CLEAR ls_fieldcat.
    ls_fieldcat-fieldname = gc_comment.
    ls_fieldcat-convexit  = ''.
    ls_fieldcat-datatype  = gc_strg.
    ls_fieldcat-inttype   = 'g'.
    ls_fieldcat-intlen    = 0.
    ls_fieldcat-domname   = ''.
    ls_fieldcat-ref_table = ''.
    ls_fieldcat-row_pos   = lv_row_pos.
    ls_fieldcat-col_pos   = lv_col_pos.
    ls_fieldcat-tabname   = lv_tabname.
    APPEND ls_fieldcat TO lt_fieldcat_string.

    gt_fieldcat_faulty = lt_fieldcat_string.

    CALL METHOD cl_alv_table_create=>create_dynamic_table
      EXPORTING
        it_fieldcatalog           = gt_fieldcat_faulty
      IMPORTING
        ep_table                  = gt_faulty_string
      EXCEPTIONS
        generate_subpool_dir_full = 1
        OTHERS                    = 2.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
    ENDIF.

*--------------------------------------------------------------------*
*   Create GT_entries_c
    lt_fieldcat_c = gt_fieldcat.

    LOOP AT lt_fieldcat_c ASSIGNING <ls_fieldcat>.
      IF sy-subrc <> 0.
        MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
      ENDIF.
      IF <ls_fieldcat>-intlen > 30.
        lv_intlen = <ls_fieldcat>-intlen.
      ELSE.
        lv_intlen = 30.
      ENDIF.
      <ls_fieldcat>-convexit  = ''.
      <ls_fieldcat>-datatype  = gc_char.
      <ls_fieldcat>-inttype   = 'C'.
      <ls_fieldcat>-intlen    = lv_intlen.
      <ls_fieldcat>-domname   = ''.
      <ls_fieldcat>-ref_table = ''.
    ENDLOOP.

    CALL METHOD cl_alv_table_create=>create_dynamic_table
      EXPORTING
        it_fieldcatalog           = lt_fieldcat_c
      IMPORTING
        ep_table                  = lt_entries_c
      EXCEPTIONS
        generate_subpool_dir_full = 1
        OTHERS                    = 2.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
    ENDIF.

    gt_entries_c  = lt_entries_c.

*--------------------------------------------------------------------*
*   Create GT_fieldname
    LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
      IF sy-subrc <> 0.
        MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
      ENDIF.
      ls_fieldname = <ls_fieldcat>-fieldname.
      APPEND ls_fieldname TO lt_fieldname.
    ENDLOOP.
    gt_fieldname = lt_fieldname.

*--------------------------------------------------------------------*
*   Create GT_database
    lo_linetype ?= cl_abap_typedescr=>describe_by_name( gv_tablename ).
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
    ENDIF.

    LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
      IF sy-subrc <> 0.
        MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
      ENDIF.

      IF <ls_fieldcat>-key = abap_true.
        APPEND <ls_fieldcat>-fieldname TO lt_key.
      ENDIF.
    ENDLOOP.

    TRY.
        go_tabletype = cl_abap_tabledescr=>create(
          p_line_type   = lo_linetype
          p_table_kind  = cl_abap_tabledescr=>tablekind_sorted
          p_unique      = abap_true
          p_key         = lt_key ).
      CATCH cx_sy_table_creation INTO lo_exception.
        MESSAGE e001(zmdg_upload_rep_msg) RAISING constructor_error.
    ENDTRY.

    CREATE DATA:
      gt_database TYPE HANDLE go_tabletype.

    ASSIGN:
      gt_database->* TO <lt_database> CASTING TYPE HANDLE go_tabletype.

    SELECT * FROM (gv_tablename) INTO TABLE <lt_database>. "#EC CI_SUBRC

  ENDMETHOD.                    "constructor


  METHOD convert_string_to_decimal.

    CONSTANTS:
      lc_x(1)                         TYPE c VALUE 'X',
      lc_y(1)                         TYPE c VALUE 'Y',
      lc_blanc(1)                     TYPE c VALUE ' ',
      lc_comma(1)                     TYPE c VALUE ',',
      lc_point(1)                     TYPE c VALUE '.',
      lc_translate_point_to_blanc(2)  TYPE c VALUE '. ',
      lc_translate_comma_to_blanc(2)  TYPE c VALUE ', ',
      lc_translate_comma_to_point(2)  TYPE c VALUE ',.',
      lc_translate_dec_with_comma(13) TYPE c VALUE '-, 0123456789',
      lc_translate_dec_with_point(13) TYPE c VALUE '-. 0123456789'.

    DATA:
      lt_string TYPE TABLE OF string,
      lv_lines  TYPE i.

    SELECT SINGLE * FROM usr01 INTO gs_usr01 WHERE bname = sy-uname.

    IF sy-subrc = 0.
* Check User dependent formats for Decimals
      CASE gs_usr01-dcpfm.
        WHEN lc_blanc OR lc_y.
          TRANSLATE cv_string USING lc_translate_point_to_blanc.
          CONDENSE cv_string NO-GAPS.
          IF NOT cv_string CO lc_translate_dec_with_comma.
            MESSAGE e023(zmdg_upload_rep_msg) RAISING invalid_input.
          ENDIF.
          TRANSLATE cv_string USING lc_translate_comma_to_point.
        WHEN lc_x.
          TRANSLATE cv_string USING lc_translate_comma_to_blanc.
          CONDENSE cv_string NO-GAPS.
          IF NOT cv_string CO lc_translate_dec_with_point.
            MESSAGE e023(zmdg_upload_rep_msg) RAISING invalid_input.
          ENDIF.
        WHEN OTHERS.
          MESSAGE e023(zmdg_upload_rep_msg) RAISING invalid_input.
      ENDCASE.

      SPLIT cv_string AT lc_point INTO TABLE: lt_string.
      DESCRIBE TABLE lt_string LINES lv_lines.
      IF lv_lines > 2.
        MESSAGE e023(zmdg_upload_rep_msg) RAISING invalid_input.
      ENDIF.

      SPLIT cv_string AT lc_comma INTO TABLE: lt_string.
      DESCRIBE TABLE lt_string LINES lv_lines.
      IF lv_lines > 2.
        MESSAGE e023(zmdg_upload_rep_msg) RAISING invalid_input.
      ENDIF.
    ENDIF.

  ENDMETHOD.                    "convert_string_to_decimal


  METHOD copy_1_of_excel_load_from.

    DATA:
      lv_lines          TYPE i VALUE 25000,
      lt_intern         TYPE TABLE OF alsmex_tabline,
      lv_begin_row      TYPE i,
      lv_end_row        TYPE i,
      ls_entries_string TYPE REF TO data,
      lv_max_col        TYPE i,
      lv_previous_col   TYPE i.
    FIELD-SYMBOLS:
      <lt_entries_string>   TYPE STANDARD TABLE,
      <ls_entries_string>   TYPE any,
      <lv_entries_string_c> TYPE any,
      <ls_intern>           TYPE alsmex_tabline,
      <ls_fieldcat>         TYPE lvc_s_fcat.

    ASSIGN gt_entries_string->* TO <lt_entries_string>.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_load_from_error.
    ENDIF.

    CREATE DATA ls_entries_string LIKE LINE OF <lt_entries_string>.

    ASSIGN ls_entries_string->* TO <ls_entries_string>.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_load_from_error.
    ENDIF.

    lv_max_col    = lines( gt_fieldcat ).
    lv_begin_row  = 2.
    lv_end_row    = lv_lines.

    DO.
      CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
        EXPORTING
          filename                = gv_filename_excel
          i_begin_col             = 1
          i_begin_row             = lv_begin_row
          i_end_col               = lv_max_col
          i_end_row               = lv_end_row
        TABLES
          intern                  = lt_intern
        EXCEPTIONS
          inconsistent_parameters = 1
          upload_ole              = 2
          OTHERS                  = 3.
      IF sy-subrc <> 0.
        MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_load_from_error.
      ENDIF.

      IF lt_intern IS INITIAL.
        EXIT.
      ENDIF.

      LOOP AT lt_intern ASSIGNING <ls_intern>.
        IF sy-subrc <> 0.
          MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_load_from_error.
        ENDIF.

        READ TABLE gt_fieldcat INDEX <ls_intern>-col ASSIGNING <ls_fieldcat>.
        IF sy-subrc <> 0.
          MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_load_from_error.
        ENDIF.

        IF <ls_intern>-col < lv_previous_col.
          APPEND <ls_entries_string> TO <lt_entries_string>.
          CLEAR <ls_entries_string>.
        ENDIF.

        ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_string> TO <lv_entries_string_c>.
        IF sy-subrc <> 0.
          MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_load_from_error.
        ENDIF.

        <lv_entries_string_c> = <ls_intern>-value.
        lv_previous_col = <ls_intern>-col.
      ENDLOOP.

      APPEND <ls_entries_string> TO <lt_entries_string>.

      lv_begin_row  = lv_end_row    + 1.
      lv_end_row    = lv_begin_row  + lv_lines.
    ENDDO.

  ENDMETHOD.                    "excel_load_from


  METHOD db_modify.

    DATA:
      lt_database       TYPE REF TO data,
      lt_entries_insert TYPE REF TO data,
      lo_linetype       TYPE REF TO cl_abap_structdescr,
      lo_tabletype      TYPE REF TO cl_abap_tabledescr,
      lt_key            TYPE abap_keydescr_tab,
      lo_exception      TYPE REF TO cx_root ##needed.

    FIELD-SYMBOLS:
      <ls_database>       TYPE any,
      <ls_fieldcat>       TYPE lvc_s_fcat,
      <lt_database>       TYPE STANDARD TABLE,
      <lt_entries>        TYPE STANDARD TABLE,
      <lt_entries_insert> TYPE STANDARD TABLE.

    DATA:
      lt_ko200 TYPE TABLE OF ko200,
      ls_ko200 TYPE ko200,
      lt_e071k TYPE TABLE OF e071k,
      ls_e071k TYPE e071k.

    ASSIGN gt_entries->*  TO <lt_entries>.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING db_modify_error.
    ENDIF.

    lo_linetype ?= cl_abap_typedescr=>describe_by_name( gv_tablename ).
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING db_modify_error.
    ENDIF.

    LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
      IF sy-subrc <> 0.
        MESSAGE e001(zmdg_upload_rep_msg) RAISING db_modify_error.
      ENDIF.

      IF <ls_fieldcat>-key = abap_true.
        APPEND <ls_fieldcat>-fieldname TO lt_key.
      ENDIF.
    ENDLOOP.
    TRY.
        lo_tabletype = cl_abap_tabledescr=>create(
          p_line_type   = lo_linetype
          p_table_kind  = cl_abap_tabledescr=>tablekind_sorted
          p_unique      = abap_true
          p_key         = lt_key ).
      CATCH cx_sy_table_creation INTO lo_exception.
        MESSAGE e001(zmdg_upload_rep_msg) RAISING db_modify_error.
    ENDTRY.

    CREATE DATA:
      lt_database       TYPE HANDLE lo_tabletype,
      lt_entries_insert TYPE HANDLE lo_tabletype.

    ASSIGN:
      lt_database->*        TO <lt_database>        CASTING TYPE HANDLE lo_tabletype,
      lt_entries_insert->*  TO <lt_entries_insert>  CASTING TYPE HANDLE lo_tabletype.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING db_modify_error.
    ENDIF.

    SELECT * FROM (gv_tablename) INTO TABLE <lt_database>.

    IF sy-subrc = 4. "database is empty
      APPEND LINES OF <lt_entries> TO <lt_entries_insert>.
      INSERT (gv_tablename) FROM TABLE <lt_entries_insert>.
      IF sy-subrc <> 0.
*        ROLLBACK WORK.
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'
*         IMPORTING
*           RETURN        =
                  .
      ELSE.
        COMMIT WORK.
      ENDIF.
    ELSEIF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING db_modify_error.
    ELSE.

      APPEND LINES OF <lt_entries> TO <lt_entries_insert>.
      IF sy-subrc <> 0.
        MESSAGE e001(zmdg_upload_rep_msg) RAISING db_modify_error.
      ENDIF.

      LOOP AT <lt_database> ASSIGNING <ls_database>.
        IF sy-subrc <> 0.
          MESSAGE e001(zmdg_upload_rep_msg) RAISING db_modify_error.
        ENDIF.

        READ TABLE <lt_entries_insert> FROM <ls_database> TRANSPORTING NO FIELDS.
        IF sy-subrc <> 0.
          INSERT <ls_database> INTO TABLE <lt_entries_insert>.
          SORT <lt_entries_insert>.
        ENDIF.
      ENDLOOP.

      DELETE FROM (gv_tablename). "#EC CI_NOWHERE - no specific where condiction required
      IF sy-subrc <> 0.
*        ROLLBACK WORK.
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'
*         IMPORTING
*           RETURN        =
                  .
        MESSAGE e001(zmdg_upload_rep_msg) RAISING db_modify_error.
      ENDIF.

      INSERT (gv_tablename) FROM TABLE <lt_entries_insert>.
      IF sy-subrc <> 0.
*        ROLLBACK WORK.
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'
*         IMPORTING
*           RETURN        =
                  .
      ELSE.
        COMMIT WORK.
        ls_ko200-pgmid = 'R3TR'.
        ls_ko200-object = 'TABU'.
        ls_ko200-obj_name = gv_tablename.
        ls_ko200-objfunc  = 'K'.
        APPEND ls_ko200 TO lt_ko200.

        ls_e071k-pgmid = 'R3TR'.
        ls_e071k-object = 'TABU'.
        ls_e071k-objname = gv_tablename.
        ls_e071k-objfunc = 'K'.
        ls_e071k-mastername = gv_tablename.
        ls_e071k-mastertype = 'TABU'.
        ls_e071k-tabkey = '*'.
        APPEND ls_e071k TO lt_e071k.


        CALL FUNCTION 'IW_C_APPEND_OBJECTS_TO_REQUEST'
          TABLES
            objects = lt_ko200
            keys    = lt_e071k.
      ENDIF.
    ENDIF.

  ENDMETHOD.                    "database_MOdify


  METHOD entries_check_duplicate.

    DATA:
      lt_sort                  TYPE abap_sortorder_tab,
      ls_sort                  TYPE abap_sortorder,
      lv_key_length            TYPE i,
      lv_i                     TYPE i VALUE 1,
      lv_different             TYPE abap_bool,
      lv_s_entries_1_duplicate TYPE abap_bool,
      ls_entries_string        TYPE REF TO data,
      lv_duplicate_key         TYPE string.

    FIELD-SYMBOLS:
      <lt_entries>        TYPE STANDARD TABLE,
      <ls_fieldcat>       TYPE lvc_s_fcat,
      <ls_entries_1>      TYPE any,
      <lv_entries_1_comp> TYPE any,
      <ls_entries_2>      TYPE any,
      <lv_entries_2_comp> TYPE any,
      <lt_entries_string> TYPE STANDARD TABLE,
      <ls_entries_string> TYPE any.

    ASSIGN gt_entries_string->*  TO <lt_entries_string>.

    ASSIGN gt_entries->* TO <lt_entries>.
    IF sy-subrc <> 0.
      MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
    ENDIF.

    CREATE DATA ls_entries_string LIKE LINE OF <lt_entries_string>.

    ASSIGN ls_entries_string->* TO <ls_entries_string>.
    IF sy-subrc <> 0.
      MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
    ENDIF.

    lv_duplicate_key = TEXT-004.

    LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
      IF sy-subrc <> 0.
        MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
      ENDIF.
      IF <ls_fieldcat>-key = abap_true.
        ls_sort-name  = <ls_fieldcat>-fieldname.
        lv_key_length = lv_key_length + <ls_fieldcat>-intlen.
        APPEND ls_sort TO lt_sort.
      ENDIF.
    ENDLOOP.

    SORT <lt_entries> BY (lt_sort).

    WHILE lv_i < lines( <lt_entries> ).
      lv_different = abap_false.
      READ TABLE <lt_entries> INDEX lv_i ASSIGNING <ls_entries_1>.
      IF sy-subrc <> 0.
        MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
      ENDIF.

      READ TABLE <lt_entries> INDEX lv_i + 1 ASSIGNING <ls_entries_2>.
      IF sy-subrc <> 0.
        MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
      ENDIF.

      LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
        IF sy-subrc <> 0.
          MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
        ENDIF.

        IF <ls_fieldcat>-key = abap_true.
          ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_1> TO <lv_entries_1_comp>.
          IF sy-subrc <> 0.
            MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
          ENDIF.

          ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_2> TO <lv_entries_2_comp>.
          IF sy-subrc <> 0.
            MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
          ENDIF.

          IF <lv_entries_1_comp> <> <lv_entries_2_comp>.
            lv_different = abap_true.
          ENDIF.
        ENDIF.
      ENDLOOP.

      IF lv_different = abap_false.
        lv_s_entries_1_duplicate = abap_true.
        CLEAR <ls_entries_string>.
        MOVE-CORRESPONDING <ls_entries_2> TO <ls_entries_string>.

        CALL METHOD log_table_create
          EXPORTING
            is_entries_string      = <ls_entries_string>
            iv_text                = lv_duplicate_key
          EXCEPTIONS
            log_table_create_error = 1
            OTHERS                 = 2.
        IF sy-subrc <> 0.
          MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
        ENDIF.

        DELETE <lt_entries> INDEX lv_i + 1.
        IF sy-subrc <> 0.
          MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
        ENDIF.

      ELSE.
        IF lv_s_entries_1_duplicate = abap_true.
          CLEAR <ls_entries_string>.
          MOVE-CORRESPONDING <ls_entries_1> TO <ls_entries_string>.

          CALL METHOD log_table_create
            EXPORTING
              is_entries_string      = <ls_entries_string>
              iv_text                = lv_duplicate_key
            EXCEPTIONS
              log_table_create_error = 1
              OTHERS                 = 2.
          IF sy-subrc <> 0.
            MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
          ENDIF.

          DELETE <lt_entries> INDEX lv_i.
          IF sy-subrc <> 0.
            MESSAGE e004(zmdg_upload_rep_msg) RAISING check_duplicate_error.
          ENDIF.

          lv_s_entries_1_duplicate = abap_false.
        ELSE.
          lv_i = lv_i + 1.
        ENDIF.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.                    "check duplicate


  METHOD entries_check_foreign_key.

    DATA:
      lt_cond_tab            TYPE TABLE OF ddwherecnd,
      lt_failure_tab         TYPE TABLE OF ddfkeyrc,
      ls_entries_string      TYPE REF TO data,
      lv_invalid_foreign_key TYPE string.

    FIELD-SYMBOLS:
      <lt_entries_string> TYPE STANDARD TABLE,
      <ls_entries_string> TYPE any,
      <lt_entries>        TYPE STANDARD TABLE,
      <ls_entries>        TYPE any,
      <ls_failure_tab>    TYPE ddfkeyrc.

    ASSIGN:
      gt_entries->*         TO <lt_entries>,
      gt_entries_string->*  TO <lt_entries_string>.

    CREATE DATA ls_entries_string LIKE LINE OF <lt_entries_string>.

    ASSIGN ls_entries_string->* TO <ls_entries_string>.

    lv_invalid_foreign_key = TEXT-005.

    LOOP AT <lt_entries> ASSIGNING <ls_entries>.
      CLEAR lt_cond_tab.
      CALL FUNCTION 'DDUT_FORKEY_CHECK'
        EXPORTING
          tabname            = gv_tablename
          value_list         = <ls_entries>
          accept_initial     = abap_true
        TABLES
          cond_tab           = lt_cond_tab
          failure_tab        = lt_failure_tab
        EXCEPTIONS
          forkey_not_defined = 1
          table_not_active   = 2
          field_unknown      = 3.

      IF sy-subrc = 1.
        EXIT.
      ELSEIF sy-subrc <> 0.
        MESSAGE e003(zmdg_upload_rep_msg) RAISING check_foreign_key_error.
      ENDIF.

      IF lt_failure_tab IS NOT INITIAL.
        MOVE-CORRESPONDING <ls_entries> TO <ls_entries_string>.
        READ TABLE lt_failure_tab INDEX 1 ASSIGNING <ls_failure_tab>.

        CALL METHOD log_table_create
          EXPORTING
            is_entries_string      = <ls_entries_string>
            iv_text                = lv_invalid_foreign_key
            iv_fieldname           = <ls_failure_tab>-fieldname
          EXCEPTIONS
            log_table_create_error = 1
            OTHERS                 = 2.

        IF sy-subrc <> 0.
          MESSAGE e003(zmdg_upload_rep_msg) RAISING check_foreign_key_error.
        ENDIF.
        DELETE <lt_entries>.
        CLEAR lt_failure_tab.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.                    "entries_check_foreign_key


  METHOD entries_move.

    CONSTANTS:
      lc_conv_exit(16) TYPE c VALUE 'CONVERSION_EXIT_',
      lc_input(6)      TYPE c VALUE '_INPUT'.

    DATA:
      ls_entries         TYPE REF TO data,
      lo_exception       TYPE REF TO cx_root,
      lv_dec_upper_bound TYPE decfloat34,
      lv_faulty_line     TYPE abap_bool,
      lv_error_message   TYPE string,
      lv_conversion(30)  TYPE c,
      lv_time            TYPE string,
      lv_external_date   TYPE rvdat-extdatum,
      lv_internal_date   TYPE syst-datum.

    FIELD-SYMBOLS:
      <ls_fieldcat>            TYPE lvc_s_fcat,
      <lt_entries>             TYPE STANDARD TABLE,
      <ls_entries>             TYPE any,
      <lv_entries_comp>        TYPE any,
      <lt_entries_string>      TYPE STANDARD TABLE,
      <ls_entries_string>      TYPE any,
      <lv_entries_string_comp> TYPE any,
      <lt_faulty_string>       TYPE STANDARD TABLE,
      <lt_database>            TYPE STANDARD TABLE.

    ASSIGN gt_entries_string->*  TO <lt_entries_string>.
    IF sy-subrc <> 0.
      MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
    ENDIF.

    ASSIGN gt_entries->* TO <lt_entries>.
    IF sy-subrc <> 0.
      MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
    ENDIF.

    ASSIGN gt_faulty_string->* TO <lt_faulty_string>.
    IF sy-subrc <> 0.
      MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
    ENDIF.

    CREATE DATA ls_entries LIKE LINE OF <lt_entries>.

    ASSIGN ls_entries->* TO <ls_entries>.
    IF sy-subrc <> 0.
      MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
    ENDIF.

    ASSIGN gt_database->* TO <lt_database> CASTING TYPE HANDLE go_tabletype.

    LOOP AT <lt_entries_string> ASSIGNING <ls_entries_string>.
      IF sy-subrc <> 0.
        MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
      ENDIF.

      lv_faulty_line = abap_false.
      LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
        IF sy-subrc <> 0.
          MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
        ENDIF.

        IF <ls_fieldcat>-convexit IS NOT INITIAL.
          CONCATENATE lc_conv_exit <ls_fieldcat>-convexit lc_input INTO lv_conversion.
          ASSIGN COMPONENT:
            <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries> TO <lv_entries_comp>,
            <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_string> TO <lv_entries_string_comp>.
          CALL FUNCTION lv_conversion
            EXPORTING
              input  = <lv_entries_string_comp>
            IMPORTING
              output = <lv_entries_comp>
            EXCEPTIONS
              OTHERS = 1.

          IF sy-subrc <> 0.
            lv_error_message = TEXT-006.
            CALL METHOD log_table_create
              EXPORTING
                is_entries_string      = <ls_entries_string>
                iv_text                = lv_error_message
                iv_fieldname           = <ls_fieldcat>-fieldname
              EXCEPTIONS
                log_table_create_error = 1
                OTHERS                 = 2.
            IF sy-subrc <> 0.
              MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
            ENDIF.
            lv_faulty_line = abap_true.
            EXIT.
          ENDIF.
          CLEAR lv_conversion.
          CONTINUE.
        ENDIF.

        CASE <ls_fieldcat>-datatype.
          WHEN gc_dats.
            ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_string> TO <lv_entries_string_comp>.
            IF sy-subrc <> 0.
              MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
            ENDIF.
            lv_external_date = <lv_entries_string_comp>.
            IF lv_external_date IS NOT INITIAL.
              CALL FUNCTION 'PERIOD_AND_DATE_CONVERT_INPUT'
                EXPORTING
                  dialog_date_is_in_the_past = ''
                  external_date              = lv_external_date
                IMPORTING
                  internal_date              = lv_internal_date
                EXCEPTIONS
                  date_invalid               = 1
                  no_data                    = 2
                  period_invalid             = 3
                  OTHERS                     = 4.
              IF sy-subrc <> 0.
                CONCATENATE <lv_entries_string_comp> TEXT-008 INTO lv_error_message RESPECTING BLANKS.
                CALL METHOD log_table_create
                  EXPORTING
                    is_entries_string      = <ls_entries_string>
                    iv_text                = lv_error_message
                    iv_fieldname           = <ls_fieldcat>-fieldname
                  EXCEPTIONS
                    log_table_create_error = 1
                    OTHERS                 = 2.
                IF sy-subrc <> 0.
                  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
                ENDIF.
              ENDIF.
            ENDIF.
            <lv_entries_string_comp> = lv_internal_date.

          WHEN gc_dec OR gc_curr OR gc_quan.
            lv_dec_upper_bound = ipow( base = 10 exp = ( <ls_fieldcat>-intlen - <ls_fieldcat>-decimals ) ).
            ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries> TO <lv_entries_comp>.
            IF sy-subrc <> 0.
              MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
            ENDIF.

            ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_string> TO <lv_entries_string_comp>.
            IF sy-subrc <> 0.
              MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
            ENDIF.

            CALL METHOD convert_string_to_decimal
              CHANGING
                cv_string     = <lv_entries_string_comp>
              EXCEPTIONS
                invalid_input = 1.

            IF sy-subrc <> 0.
              sy-subrc = 0.
              lv_error_message = TEXT-001.
              CALL METHOD log_table_create
                EXPORTING
                  is_entries_string      = <ls_entries_string>
                  iv_text                = lv_error_message
                  iv_fieldname           = <ls_fieldcat>-fieldname
                EXCEPTIONS
                  log_table_create_error = 1
                  OTHERS                 = 2.
              IF sy-subrc <> 0.
                MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
              ENDIF.
              lv_faulty_line = abap_true.
              EXIT.
            ENDIF.

            TRY.
                MOVE EXACT <lv_entries_string_comp> TO <lv_entries_comp>.
              CATCH cx_sy_conversion_error INTO lo_exception.
                CALL METHOD lo_exception->get_text
                  RECEIVING
                    result = lv_error_message.
                CALL METHOD log_table_create
                  EXPORTING
                    is_entries_string      = <ls_entries_string>
                    iv_text                = lv_error_message
                    iv_fieldname           = <ls_fieldcat>-fieldname
                  EXCEPTIONS
                    log_table_create_error = 1
                    OTHERS                 = 2.
                IF sy-subrc <> 0.
                  MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
                ENDIF.
                lv_faulty_line = abap_true.
                EXIT.
            ENDTRY.
            IF <lv_entries_comp> >= lv_dec_upper_bound.
              lv_error_message = TEXT-002.
              CALL METHOD log_table_create
                EXPORTING
                  is_entries_string      = <ls_entries_string>
                  iv_text                = lv_error_message
                  iv_fieldname           = <ls_fieldcat>-fieldname
                EXCEPTIONS
                  log_table_create_error = 1
                  OTHERS                 = 2.
              IF sy-subrc <> 0.
                MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
              ENDIF.
              lv_faulty_line = abap_true.
              EXIT.
            ENDIF.

          WHEN gc_clnt.
            ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries> TO <lv_entries_comp>.
            <lv_entries_comp> = sy-mandt.

          WHEN gc_sstr.
            ASSIGN COMPONENT:
              <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_string> TO <lv_entries_string_comp>,
              <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries> TO <lv_entries_comp>.
            IF strlen( <lv_entries_string_comp> ) <= <ls_fieldcat>-intlen.
              <lv_entries_comp> = <lv_entries_string_comp>.
            ELSE.
              lv_error_message = TEXT-002.
              CALL METHOD log_table_create
                EXPORTING
                  is_entries_string      = <ls_entries_string>
                  iv_text                = lv_error_message
                  iv_fieldname           = <ls_fieldcat>-fieldname
                EXCEPTIONS
                  log_table_create_error = 1
                  OTHERS                 = 2.
              IF sy-subrc <> 0.
                MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
              ENDIF.
              lv_faulty_line = abap_true.
              EXIT.
            ENDIF.

          WHEN gc_tims.
            ASSIGN COMPONENT:
              <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_string>  TO <lv_entries_string_comp>,
              <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries>         TO <lv_entries_comp>.
            IF <lv_entries_string_comp> IS NOT INITIAL.
              lv_time = <lv_entries_string_comp>.
              IF lv_time CA gc_colon.
                REPLACE ALL OCCURRENCES OF gc_colon IN lv_time WITH space.
              ENDIF.
              TRY.
                  MOVE EXACT lv_time TO <lv_entries_comp>.
                CATCH cx_sy_conversion_error INTO lo_exception.
                  CONCATENATE <lv_entries_string_comp> TEXT-007 INTO lv_error_message RESPECTING BLANKS.
                  CALL METHOD log_table_create
                    EXPORTING
                      is_entries_string      = <ls_entries_string>
                      iv_text                = lv_error_message
                      iv_fieldname           = <ls_fieldcat>-fieldname
                    EXCEPTIONS
                      log_table_create_error = 1
                      OTHERS                 = 2.
                  IF sy-subrc <> 0.
                    MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
                  ENDIF.
                  lv_faulty_line = abap_true.
                  EXIT.
              ENDTRY.
            ELSE.
              <lv_entries_comp> = space.
            ENDIF.

          WHEN OTHERS.
            ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries> TO <lv_entries_comp>.
            IF sy-subrc <> 0.
              MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
            ENDIF.

            ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_string> TO <lv_entries_string_comp>.
            IF sy-subrc <> 0.
              MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
            ENDIF.

            TRY.
                MOVE EXACT <lv_entries_string_comp> TO <lv_entries_comp>.
              CATCH cx_sy_conversion_error INTO lo_exception.
                CALL METHOD lo_exception->get_text
                  RECEIVING
                    result = lv_error_message.
                CALL METHOD log_table_create
                  EXPORTING
                    is_entries_string      = <ls_entries_string>
                    iv_text                = lv_error_message
                    iv_fieldname           = <ls_fieldcat>-fieldname
                  EXCEPTIONS
                    log_table_create_error = 1
                    OTHERS                 = 2.
                IF sy-subrc <> 0.
                  MESSAGE e005(zmdg_upload_rep_msg) RAISING entries_move_error.
                ENDIF.
                lv_faulty_line = abap_true.
                EXIT.
            ENDTRY.
        ENDCASE.
      ENDLOOP.

      IF lv_faulty_line = abap_false.
        APPEND <ls_entries> TO <lt_entries>.
        CLEAR <ls_entries>.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.                    "entries_MOve


  METHOD excel_download.

    CONSTANTS:
      lc_conversion_exit(16) TYPE c VALUE 'CONVERSION_EXIT_',
      lc_output(7)           TYPE c VALUE '_OUTPUT'.
    DATA:
      ls_entries_c       TYPE REF TO data,
      ls_entries         TYPE REF TO data,
      lv_string_filename TYPE string,
      lo_exception       TYPE REF TO cx_sy_dynamic_osql_semantics ##needed,
      lt_fieldname       TYPE TABLE of fieldname with DEFAULT KEY,
      lv_conversion(30)  TYPE c,
      lv_input           TYPE sydatum,
      lv_output          TYPE rvdat-extdatum.
    FIELD-SYMBOLS:
      <lt_entries_c> TYPE STANDARD TABLE,
      <lt_entries>   TYPE STANDARD TABLE,
      <ls_entries_c> TYPE any,
      <ls_entries>   TYPE any,
      <ls_fieldcat>  TYPE lvc_s_fcat,
      <lv_comp>      TYPE any,
      <lv_comp_c>    TYPE any.

    ASSIGN gt_entries->* TO <lt_entries>.
    IF sy-subrc <> 0.
      MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
    ENDIF.

    ASSIGN gt_entries_c->* TO <lt_entries_c>.
    IF sy-subrc <> 0.
      MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
    ENDIF.

    CREATE DATA:
      ls_entries_c LIKE LINE OF <lt_entries_c>,
      ls_entries   LIKE LINE OF <lt_entries>.

    ASSIGN ls_entries_c->* TO <ls_entries_c>.
    IF sy-subrc <> 0.
      MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
    ENDIF.

    ASSIGN ls_entries->* TO <ls_entries>.
    IF sy-subrc <> 0.
      MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
    ENDIF.

    lt_fieldname = gt_fieldname.

    CALL METHOD file_save
      EXPORTING
        iv_file_filter  = gc_file_filter_xls
      IMPORTING
        ev_filename     = lv_string_filename
      EXCEPTIONS
        file_save_error = 1
        OTHERS          = 2.
    IF sy-subrc     <> 0.
      MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
    ENDIF.
    IF lv_string_filename IS INITIAL.
      RETURN.
    ENDIF.

    IF iv_filled = abap_true.
      TRY.
          SELECT * FROM (gv_tablename) INTO TABLE <lt_entries>. "#EC CI_SUBRC
        CATCH cx_sy_dynamic_osql_semantics INTO lo_exception.
          MESSAGE e007(zmdg_upload_rep_msg) WITH gv_tablename RAISING excel_create_error.
      ENDTRY.
      LOOP AT <lt_entries> ASSIGNING <ls_entries>.
        IF sy-subrc <> 0.
          MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
        ENDIF.

        LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
          IF sy-subrc <> 0.
            MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
          ENDIF.

          ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries> TO <lv_comp>.
          IF sy-subrc <> 0.
            MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
          ENDIF.

          ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_c> TO <lv_comp_c>.
          IF sy-subrc <> 0.
            MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
          ENDIF.

          IF <ls_fieldcat>-convexit IS NOT INITIAL.
            CONCATENATE lc_conversion_exit <ls_fieldcat>-convexit lc_output INTO lv_conversion.
            CALL FUNCTION lv_conversion
              EXPORTING
                input  = <lv_comp>
              IMPORTING
                output = <lv_comp_c>
              EXCEPTIONS
                OTHERS = 1.
            IF sy-subrc <> 0.
              MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
            ENDIF.
          ELSE.
            <lv_comp_c> = <lv_comp>.
          ENDIF.

          CASE <ls_fieldcat>-datatype.
            WHEN gc_curr OR gc_dec OR gc_quan.
              IF gs_usr01-dcpfm <> abap_true.
                REPLACE ALL OCCURRENCES OF gc_point IN <lv_comp_c> WITH gc_comma.
              ENDIF.

            WHEN gc_dats.
              lv_input = <lv_comp_c>.
              CALL FUNCTION 'PERIOD_AND_DATE_CONVERT_OUTPUT'
                EXPORTING
                  internal_date   = lv_input
                  internal_period = '1'
                  language        = syst-langu
                IMPORTING
                  external_date   = lv_output
                EXCEPTIONS
                  date_invalid    = 1
                  periode_invalid = 2
                  OTHERS          = 3.
              IF sy-subrc <> 0.
                MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
              ENDIF.
              <lv_comp_c> = lv_output.

            WHEN gc_tims.
              CONCATENATE <lv_comp_c>(2) gc_colon <lv_comp_c>+2(2) gc_colon <lv_comp_c>+4(2) INTO <lv_comp_c>.
          ENDCASE.
        ENDLOOP.
        APPEND <ls_entries_c> TO <lt_entries_c>.
      ENDLOOP.
    ENDIF.

    SORT <lt_entries_c>.

    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        filename                = lv_string_filename
        filetype                = 'DBF'
      TABLES
        data_tab                = <lt_entries_c>
        fieldnames              = lt_fieldname
      EXCEPTIONS
        file_write_error        = 1
        no_batch                = 2
        gui_refuse_filetransfer = 3
        invalid_type            = 4
        no_authority            = 5
        unknown_error           = 6
        header_not_allowed      = 7
        separator_not_allowed   = 8
        filesize_not_allowed    = 9
        header_too_long         = 10
        dp_error_create         = 11
        dp_error_send           = 12
        dp_error_write          = 13
        unknown_dp_error        = 14
        access_denied           = 15
        dp_out_of_memory        = 16
        disk_full               = 17
        dp_timeout              = 18
        file_not_found          = 19
        dataprovider_exception  = 20
        control_flush_error     = 21
        OTHERS                  = 22.
    IF sy-subrc <> 0.
      MESSAGE e006(zmdg_upload_rep_msg) RAISING excel_create_error.
    ENDIF.
  ENDMETHOD.                    "excel download


  METHOD excel_load_from.

    DATA:
          lt_raw            TYPE truxs_t_text_data.

    FIELD-SYMBOLS:
      <lt_entries_string>   TYPE STANDARD TABLE.

    ASSIGN gt_entries_string->* TO <lt_entries_string>.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_load_from_error.
    ENDIF.

    CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
      EXPORTING
        i_line_header        = 'X'
        i_tab_raw_data       = lt_raw
        i_filename           = gv_filename_excel
      TABLES
        i_tab_converted_data = <lt_entries_string>
      EXCEPTIONS
        conversion_failed    = 1
        OTHERS               = 2.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_load_from_error.
    ENDIF.

  ENDMETHOD.                    "excel load from


  METHOD excel_upload.

    DATA:
      lv_answer(1)         TYPE c,
      lv_filename          TYPE string,
      lv_lines             TYPE i,
      lt_dd02l             TYPE TABLE OF dd02l, "#EC NEEDED - check is done with sy-subrc
*      lt_custtabupl        TYPE TABLE OF zmdg_c_custtabup,
      lv_contflag          TYPE contflag,
      lv_write2tr_canceled TYPE iwparams-flag.

    FIELD-SYMBOLS:
      <lt_entries>       TYPE STANDARD TABLE,
      <lt_faulty_string> TYPE STANDARD TABLE.

    DATA:
      lt_ko200 TYPE TABLE OF ko200,
      ls_ko200 TYPE ko200,
      lt_e071k TYPE TABLE OF e071k,
      ls_e071k TYPE e071k.



    ASSIGN gt_entries->* TO <lt_entries>.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_upload_error.
    ENDIF.

    ASSIGN gt_faulty_string->* TO <lt_faulty_string>.
    IF sy-subrc <> 0.
      MESSAGE e001(zmdg_upload_rep_msg) RAISING excel_upload_error.
    ENDIF.

    IF gv_docheck = abap_true.
      " check that database table exists
      ##too_many_itab_fields
      SELECT SINGLE contflag FROM dd02l INTO lv_contflag WHERE tabname = gv_tablename.
      IF sy-subrc <> 0.
        MESSAGE e008(zmdg_upload_rep_msg) WITH gv_tablename RAISING database_does_not_exist.
      ENDIF.

* only allow application and customizing tables
      IF lv_contflag = 'A' OR lv_contflag = 'C'.
      ELSE.
        MESSAGE e020(zmdg_upload_rep_msg) WITH gv_tablename RAISING database_does_not_exist.
      ENDIF.

      " check that database table is listed in ZMDG_C_CUSTTABUP
*      SELECT * FROM zmdg_c_custtabup INTO TABLE lt_custtabupl. "#EC CI_SUBRC
*      READ TABLE lt_custtabupl WITH KEY tablename = gv_tablename TRANSPORTING NO FIELDS.
*      IF sy-subrc <> 0.
*        MESSAGE e009(zmdg_upload_rep_msg) WITH gv_tablename RAISING database_not_permitted.
*      ENDIF.

      " check that database table is maintainable in this system
*      READ TABLE lt_custtabupl WITH KEY tablename = gv_tablename sysysid = sy-sysid TRANSPORTING NO FIELDS.
*      IF sy-subrc <> 0.
*        MESSAGE e009(zmdg_upload_rep_msg) WITH gv_tablename RAISING database_not_permitted.
*      ENDIF.
    ENDIF.

    CALL METHOD file_open
      EXPORTING
        iv_file_filter  = gc_file_filter_excel
      IMPORTING
        ev_filename     = lv_filename
      EXCEPTIONS
        file_open_error = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING excel_load_from_error.
    ENDIF.
    IF lv_filename IS INITIAL.
      RETURN.
    ENDIF.

    gv_filename_excel = lv_filename.
    IF iv_long_fields = abap_false.
      CALL METHOD copy_1_of_excel_load_from
        EXCEPTIONS
          excel_load_from_error = 1
          OTHERS                = 2.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING excel_load_from_error.
      ENDIF.
    ELSE.
      CALL METHOD excel_load_from
        EXCEPTIONS
          excel_load_from_error = 1
          OTHERS                = 2.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING excel_load_from_error.
      ENDIF.
    ENDIF.

    CALL METHOD entries_move
      EXCEPTIONS
        entries_move_error = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      MESSAGE e010(zmdg_upload_rep_msg) RAISING excel_upload_error.
    ENDIF.

    CALL METHOD entries_check_duplicate
      EXCEPTIONS
        check_duplicate_error = 1
        OTHERS                = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING excel_load_from_error.
    ENDIF.

    CALL METHOD entries_check_foreign_key
      EXCEPTIONS
        check_foreign_key_error = 1
        OTHERS                  = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING excel_load_from_error.
    ENDIF.

    IF NOT <lt_faulty_string> IS INITIAL.
**        Added by Raghu on 05.03.2018
**   Errors occured , so clear the entries
      IF <lt_entries> IS ASSIGNED AND <lt_entries> IS NOT INITIAL.
        CLEAR:<lt_entries>.
      ENDIF.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          text_question = TEXT-000
        IMPORTING
          answer        = lv_answer.
      IF lv_answer = '1'.
        CALL METHOD log_table_save
          EXCEPTIONS
            log_table_save_error = 1
            OTHERS               = 2.
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING logging_save_error.

        ENDIF.
      ENDIF.
    ENDIF.

    lv_lines = lines( <lt_entries> ).

    IF NOT <lt_entries> IS INITIAL.
* check if customizing table and ask for transport
      IF lv_contflag = 'C'.
        ls_ko200-pgmid = 'R3TR'.
        ls_ko200-object = 'TABU'.
        ls_ko200-obj_name = gv_tablename.
        ls_ko200-objfunc  = 'K'.
        APPEND ls_ko200 TO lt_ko200.

        ls_e071k-pgmid = 'R3TR'.
        ls_e071k-object = 'TABU'.
        ls_e071k-objname = gv_tablename.
        ls_e071k-objfunc = 'K'.
        ls_e071k-mastername = gv_tablename.
        ls_e071k-mastertype = 'TABU'.
        CONCATENATE sy-mandt '*' INTO ls_e071k-tabkey.
        APPEND ls_e071k TO lt_e071k.

        CALL FUNCTION 'IW_C_APPEND_OBJECTS_TO_REQUEST'
          IMPORTING
            is_cancelled = lv_write2tr_canceled
          TABLES
            objects      = lt_ko200
            keys         = lt_e071k.
* if no transport was selected -> cancel upload
        IF lv_write2tr_canceled = abap_true.
          MESSAGE e021(zmdg_upload_rep_msg).
          RETURN.
        ENDIF.

      ENDIF.

      IF iv_overwrite_db = abap_true.
        DELETE FROM (gv_tablename).                    "#EC CI_NOWHERE.
        INSERT (gv_tablename) FROM TABLE <lt_entries>.
        IF sy-subrc <> 0.
*          ROLLBACK WORK.
          CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'
*           IMPORTING
*             RETURN        =
                    .
          MESSAGE e012(zmdg_upload_rep_msg) WITH gv_tablename RAISING database_error.
        ELSE.
          MESSAGE s011(zmdg_upload_rep_msg) WITH lv_lines gv_tablename.
        ENDIF.
      ELSE.
        CALL METHOD db_modify
          EXCEPTIONS
            db_modify_error = 1
            OTHERS          = 2.
        IF sy-subrc <> 0.
          MESSAGE e014(zmdg_upload_rep_msg) WITH gv_tablename RAISING database_error.
        ELSE.
          MESSAGE s011(zmdg_upload_rep_msg) WITH lv_lines gv_tablename.
        ENDIF.
      ENDIF.
    ELSE.
      MESSAGE s013(zmdg_upload_rep_msg) WITH gv_tablename.
    ENDIF.

  ENDMETHOD.                    "excel upload


  METHOD file_delete.

    DATA:
       lv_file TYPE draw-filep.

    lv_file = iv_filename.

    CALL FUNCTION 'CV120_DELETE_FILE'
      EXPORTING
        pf_file = lv_file
      EXCEPTIONS
        error   = 1
        OTHERS  = 2.
    IF sy-subrc <> 0.
      MESSAGE i015(zmdg_upload_rep_msg) WITH iv_filename.
      ev_rc = 1.
    ELSE.
      ev_rc = 0.
    ENDIF.
  ENDMETHOD.                    "file delete


  METHOD file_open.

    DATA:
      lv_filename  TYPE file_table-filename,
      lt_filetable TYPE filetable,
      lv_rc        TYPE i.

    CALL METHOD cl_gui_frontend_services=>file_open_dialog
      EXPORTING
        file_filter             = iv_file_filter
      CHANGING
        file_table              = lt_filetable
        rc                      = lv_rc
      EXCEPTIONS
        file_open_dialog_failed = 1
        cntl_error              = 2
        error_no_gui            = 3
        not_supported_by_gui    = 4
        OTHERS                  = 5.
    IF sy-subrc <> 0.
      MESSAGE e016(zmdg_upload_rep_msg) RAISING file_open_error.
    ENDIF.

    READ TABLE lt_filetable INTO lv_filename INDEX 1.

    ev_filename = lv_filename.

  ENDMETHOD.                    "file open


  METHOD file_save.

    DATA:
      lv_path       TYPE string,
      lv_fullpath   TYPE string,
      lv_file_exist TYPE abap_bool,
      lv_answer(1)  TYPE c,
      lv_rc         TYPE i.

    CLEAR ev_filename.

    CALL METHOD cl_gui_frontend_services=>file_save_dialog
      EXPORTING
        file_filter               = iv_file_filter
        prompt_on_overwrite       = ''
      CHANGING
        filename                  = ev_filename
        path                      = lv_path
        fullpath                  = lv_fullpath
      EXCEPTIONS
        cntl_error                = 1
        error_no_gui              = 2
        not_supported_by_gui      = 3
        invalid_default_file_name = 4
        OTHERS                    = 5.
    IF sy-subrc <> 0.
      MESSAGE e017(zmdg_upload_rep_msg) WITH ev_filename RAISING file_save_error.
    ENDIF.

    IF ev_filename IS INITIAL. "= the 'Cancel'-button of the file browser was pressed
      RETURN.
    ENDIF.

    CALL METHOD cl_gui_frontend_services=>file_exist
      EXPORTING
        file                 = ev_filename
      RECEIVING
        result               = lv_file_exist
      EXCEPTIONS
        cntl_error           = 1
        error_no_gui         = 2
        wrong_parameter      = 3
        not_supported_by_gui = 4
        OTHERS               = 5.
    IF sy-subrc <> 0.
      MESSAGE e017(zmdg_upload_rep_msg) WITH ev_filename RAISING file_save_error.
    ENDIF.

    IF lv_file_exist = abap_true.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          text_question  = TEXT-003
        IMPORTING
          answer         = lv_answer
        EXCEPTIONS
          text_not_found = 1
          OTHERS         = 2.
      IF sy-subrc <> 0.
        MESSAGE e017(zmdg_upload_rep_msg) WITH ev_filename RAISING file_save_error.
      ENDIF.

      IF lv_answer = '1'.
        CALL METHOD file_delete
          EXPORTING
            iv_filename       = ev_filename
          IMPORTING
            ev_rc             = lv_rc
          EXCEPTIONS
            file_delete_error = 1
            OTHERS            = 2.
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING file_save_error.
        ENDIF.

        IF lv_rc = 1.
          CALL METHOD file_save
            EXPORTING
              iv_file_filter  = iv_file_filter
            IMPORTING
              ev_filename     = ev_filename
            EXCEPTIONS
              file_save_error = 1
              OTHERS          = 2.
          IF sy-subrc <> 0.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                       WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING file_save_error.
          ENDIF.
        ENDIF.

      ELSEIF lv_answer = '2'.
        CALL METHOD file_save
          EXPORTING
            iv_file_filter  = iv_file_filter
          IMPORTING
            ev_filename     = ev_filename
          EXCEPTIONS
            file_save_error = 1
            OTHERS          = 2.
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING file_save_error.
        ENDIF.

      ELSEIF lv_answer = 'A'.
        CLEAR ev_filename.
        RETURN.
      ENDIF.
    ENDIF.

  ENDMETHOD.                    "file save


  METHOD log_table_create.

    DATA:
      ls_faulty_string TYPE REF TO data,
      lv_text          TYPE string.

    FIELD-SYMBOLS:
      <ls_entries_string>      TYPE any,
      <lv_entries_string_comp> TYPE any,
      <lt_faulty_string>       TYPE STANDARD TABLE,
      <ls_faulty_string>       TYPE any,
      <lv_faulty_string_comp>  TYPE any,
      <ls_fieldcat>            TYPE lvc_s_fcat.

    ASSIGN is_entries_string   TO <ls_entries_string>.

    ASSIGN gt_faulty_string->* TO  <lt_faulty_string>.
    IF sy-subrc <> 0.
      RAISE log_table_create_error.
    ENDIF.

    CREATE DATA ls_faulty_string LIKE LINE OF <lt_faulty_string>.

    ASSIGN ls_faulty_string->* TO <ls_faulty_string>.
    IF sy-subrc <> 0.
      RAISE log_table_create_error.
    ENDIF.

    LOOP AT gt_fieldcat_faulty ASSIGNING <ls_fieldcat>.
      IF sy-subrc <> 0.
        RAISE log_table_create_error.
      ENDIF.

      IF <ls_fieldcat>-fieldname = gc_comment.
        ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_faulty_string> TO <lv_faulty_string_comp>.
        IF sy-subrc <> 0.
          RAISE log_table_create_error.
        ENDIF.

        IF iv_fieldname IS NOT INITIAL.
          CONCATENATE: iv_fieldname gc_colon iv_text INTO lv_text.
        ELSE.
          lv_text = iv_text.
        ENDIF.
        <lv_faulty_string_comp> = lv_text.

      ELSE.
        ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_entries_string> TO <lv_entries_string_comp>.
        IF sy-subrc <> 0.
          RAISE log_table_create_error.
        ENDIF.

        ASSIGN COMPONENT <ls_fieldcat>-fieldname OF STRUCTURE <ls_faulty_string>  TO <lv_faulty_string_comp>.
        IF sy-subrc <> 0.
          RAISE log_table_create_error.
        ENDIF.

        <lv_faulty_string_comp> = <lv_entries_string_comp>.
      ENDIF.
    ENDLOOP.
    APPEND <ls_faulty_string> TO <lt_faulty_string>.

  ENDMETHOD.                    "log table create


  METHOD log_table_fieldcat_create.

    DATA:
          lv_max_length TYPE i.

    FIELD-SYMBOLS:
      <ls_fieldcat_logging>   TYPE lvc_s_fcat,
      <lt_faulty_string>      TYPE STANDARD TABLE,
      <ls_faulty_string>      TYPE any,
      <lv_faulty_string_comp> TYPE any.

    ASSIGN gt_faulty_string->*    TO <lt_faulty_string>.
    IF sy-subrc <> 0.
      RAISE log_table_fieldcat_create_err.
    ENDIF.

    gt_fieldcat_logging = gt_fieldcat_faulty.

    LOOP AT gt_fieldcat_logging ASSIGNING <ls_fieldcat_logging>.
      IF sy-subrc <> 0.
        RAISE log_table_fieldcat_create_err.
      ENDIF.

      lv_max_length = 30.

      LOOP AT <lt_faulty_string> ASSIGNING <ls_faulty_string>.
        IF sy-subrc <> 0.
          RAISE log_table_fieldcat_create_err.
        ENDIF.
        ASSIGN COMPONENT <ls_fieldcat_logging>-fieldname OF STRUCTURE <ls_faulty_string> TO <lv_faulty_string_comp>.
        IF lv_max_length < strlen( <lv_faulty_string_comp> ) AND <ls_fieldcat_logging>-intlen < strlen( <lv_faulty_string_comp> ).
          lv_max_length = strlen( <lv_faulty_string_comp> ).
        ENDIF.
      ENDLOOP.

      <ls_fieldcat_logging>-convexit  = ''.
      <ls_fieldcat_logging>-datatype  = gc_char.
      <ls_fieldcat_logging>-inttype   = 'C'.
      <ls_fieldcat_logging>-intlen    = lv_max_length.
      <ls_fieldcat_logging>-domname   = ''.
      <ls_fieldcat_logging>-ref_table = ''.
    ENDLOOP.

  ENDMETHOD.                    "log table fieldcat create


  METHOD log_table_save.

    DATA:
      lv_string_filename TYPE string,
      ls_entries_logging TYPE REF TO data,
      lv_filename        TYPE rlgrap-filename,
      ls_fieldname       TYPE fieldname,
      lt_fieldname       TYPE table of fieldname with non-UNIQUE DEFAULT KEY ##NEEDED.

    FIELD-SYMBOLS:
      <ls_faulty_string>        TYPE any,
      <lv_faulty_string_comp>   TYPE any,
      <lt_faulty_string>        TYPE STANDARD TABLE,
      <lt_entries_logging>      TYPE STANDARD TABLE,
      <ls_entries_logging>      TYPE any,
      <lt_fieldcat_faulty>      TYPE lvc_t_fcat,
      <ls_fieldcat_logging>     TYPE lvc_s_fcat,
      <lv_entries_logging_comp> TYPE any.

    ASSIGN gt_fieldcat_faulty  TO <lt_fieldcat_faulty>.

    ASSIGN gt_faulty_string->* TO <lt_faulty_string>.
    IF sy-subrc <> 0.
      MESSAGE e018(zmdg_upload_rep_msg) RAISING log_table_save_error.
    ENDIF.

    CALL METHOD file_save
      EXPORTING
        iv_file_filter  = gc_file_filter_xlsx
      IMPORTING
        ev_filename     = lv_string_filename
      EXCEPTIONS
        file_save_error = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 RAISING log_table_save_error.
    ENDIF.
    IF lv_string_filename IS INITIAL.
      RETURN.
    ENDIF.

    CALL METHOD log_table_fieldcat_create
      EXCEPTIONS
        log_table_fieldcat_create_err = 1
        OTHERS                        = 2.
    IF sy-subrc <> 0.
      MESSAGE e017(zmdg_upload_rep_msg) WITH lv_string_filename RAISING log_table_save_error.
    ENDIF.

    CALL METHOD cl_alv_table_create=>create_dynamic_table
      EXPORTING
        it_fieldcatalog           = gt_fieldcat_logging
      IMPORTING
        ep_table                  = gt_entries_logging
      EXCEPTIONS
        generate_subpool_dir_full = 1
        OTHERS                    = 2.
    IF sy-subrc <> 0.
      MESSAGE e017(zmdg_upload_rep_msg) WITH lv_string_filename RAISING log_table_save_error.
    ENDIF.

    ASSIGN gt_entries_logging->* TO <lt_entries_logging>.
    IF sy-subrc <> 0.
      MESSAGE e017(zmdg_upload_rep_msg) WITH lv_string_filename RAISING log_table_save_error.
    ENDIF.

    CREATE DATA ls_entries_logging LIKE LINE OF <lt_entries_logging>.

    ASSIGN ls_entries_logging->* TO <ls_entries_logging>.
    IF sy-subrc <> 0.
      MESSAGE e017(zmdg_upload_rep_msg) WITH lv_string_filename RAISING log_table_save_error.
    ENDIF.

    lt_fieldname = gt_fieldname.
    ls_fieldname = gc_comment.
    APPEND ls_fieldname TO lt_fieldname.

    LOOP AT <lt_faulty_string> ASSIGNING <ls_faulty_string>.
      IF sy-subrc <> 0.
        MESSAGE e017(zmdg_upload_rep_msg) WITH lv_string_filename RAISING log_table_save_error.
      ENDIF.

      LOOP AT gt_fieldcat_logging ASSIGNING <ls_fieldcat_logging>.
        IF sy-subrc <> 0.
          MESSAGE e017(zmdg_upload_rep_msg) WITH lv_string_filename RAISING log_table_save_error.
        ENDIF.

        ASSIGN COMPONENT <ls_fieldcat_logging>-fieldname OF STRUCTURE <ls_faulty_string> TO <lv_faulty_string_comp>.
        IF sy-subrc <> 0.
          MESSAGE e017(zmdg_upload_rep_msg) WITH lv_string_filename RAISING log_table_save_error.
        ENDIF.

        ASSIGN COMPONENT <ls_fieldcat_logging>-fieldname OF STRUCTURE <ls_entries_logging> TO <lv_entries_logging_comp>.
        IF sy-subrc <> 0.
          MESSAGE e017(zmdg_upload_rep_msg) WITH lv_string_filename RAISING log_table_save_error.
        ENDIF.

        <lv_entries_logging_comp> = <lv_faulty_string_comp>.

      ENDLOOP.
      APPEND <ls_entries_logging> TO <lt_entries_logging>.
    ENDLOOP.

    lv_filename = lv_string_filename.
    CALL FUNCTION 'SAP_CONVERT_TO_XLS_FORMAT'
      EXPORTING
        i_filename        = lv_filename
      TABLES
        i_tab_sap_data    = <lt_entries_logging>
      EXCEPTIONS
        conversion_failed = 1
        OTHERS            = 2.
    IF sy-subrc <> 0.
      MESSAGE e017(zmdg_upload_rep_msg) WITH lv_string_filename RAISING log_table_save_error.
    ELSE.
      MESSAGE s019(zmdg_upload_rep_msg) WITH lv_string_filename.
    ENDIF.

  ENDMETHOD.                    "log table save
ENDCLASS.
