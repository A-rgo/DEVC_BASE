REPORT yz_prog_upload_custom_tab.

TABLES: dd02l.

CLASS lhc_file_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: upload_file
      IMPORTING
        iv_file_name    TYPE string
      EXPORTING
        et_file_content TYPE filetable
      EXCEPTIONS
        cx_sy_file_open
        cx_sy_file_read
        cx_sy_file_transfer.

    METHODS: upload_excel_file_binary
      IMPORTING
        iv_file_name  TYPE string
      EXPORTING
        et_excel_data TYPE ANY TABLE
      EXCEPTIONS
        cx_sy_file_open
        cx_sy_file_read.

    METHODS: download_file_to_al11
      IMPORTING
        iv_file_path  TYPE string
        it_table_data TYPE ANY TABLE
      EXCEPTIONS
        cx_sy_file_open
        cx_sy_file_write.

    METHODS: export_multi_tables_to_excel
      IMPORTING
                it_tables    TYPE ANY TABLE
                iv_file_path TYPE string
      EXPORTING ev_x_string  TYPE xstring .

    METHODS : modify_table
      IMPORTING iv_tab_name   TYPE string
                it_table_data TYPE ANY TABLE.
  PRIVATE SECTION.
ENDCLASS.

CLASS lhc_file_handler IMPLEMENTATION.
  METHOD upload_file.
    CALL METHOD cl_gui_frontend_services=>gui_upload
      EXPORTING
        filename = iv_file_name
        filetype = 'ASC'
      CHANGING
        data_tab = et_file_content
      EXCEPTIONS
        OTHERS   = 4.

    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN 1.
          RAISE cx_sy_file_open.
        WHEN 2.
          RAISE cx_sy_file_read.
        WHEN 4.
          RAISE cx_sy_file_transfer.
        WHEN OTHERS.
          RAISE cx_sy_file_transfer.
      ENDCASE.
    ENDIF.
  ENDMETHOD.

  METHOD upload_excel_file_binary.
    DATA: lt_records    TYPE solix_tab,
          lv_filelength TYPE i,
          lv_xstring    TYPE xstring,
          lo_excel_ref  TYPE REF TO cl_fdt_xl_spreadsheet,
          lt_worksheets TYPE TABLE OF string.

    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename   = iv_file_name
        filetype   = 'BIN'
      IMPORTING
        filelength = lv_filelength
      TABLES
        data_tab   = lt_records
      EXCEPTIONS
        OTHERS     = 1.

    IF sy-subrc <> 0.
      RAISE cx_sy_file_open.
    ENDIF.

    " Convert binary data to xstring
    CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
      EXPORTING
        input_length = lv_filelength
      IMPORTING
        buffer       = lv_xstring
      TABLES
        binary_tab   = lt_records
      EXCEPTIONS
        OTHERS       = 2.

    IF sy-subrc <> 0.
      RAISE cx_sy_file_read.
    ENDIF.

    " Load Excel from xstring

    DATA(o_reader) = CAST zif_excel_reader( NEW zcl_excel_reader_2007( ) ).
    DATA(o_excel) = o_reader->load_file( iv_file_name  ).
    DATA(lo_iter) = o_excel->get_worksheets_iterator( ).
    DO.
      IF  lo_iter IS BOUND.

        DATA(lo_worksheet) = CAST zcl_excel_worksheet( lo_iter->get_next( ) ).
        IF lo_worksheet IS BOUND.
          lo_worksheet->get_table( IMPORTING et_table = et_excel_data ).
          modify_table(  iv_tab_name   = lo_worksheet->get_title( ) it_table_data = et_excel_data ).
        ELSE.
          EXIT.
        ENDIF.
      ENDIF.
    ENDDO.

  ENDMETHOD.
  METHOD modify_table.
    " Declaration for dynamic table
    DATA: lt_split_tab TYPE REF TO data,   " Dynamic internal table reference
          lv_count     TYPE i,
          lv_chunk     TYPE i,
          lv_start     TYPE i,
          lv_end       TYPE i.

    FIELD-SYMBOLS: <lt_data>  TYPE STANDARD TABLE,  " Dynamic internal table field symbol
                   <lt_chunk> TYPE ANY TABLE.  " Field symbol for chunk table

    " Assign dynamic table
    ASSIGN it_table_data TO <lt_data>.

    " Get the number of records in the table
    lv_count = lines( <lt_data> ).

    " Set the chunk size to 5000
    lv_chunk = 5000.

    " Loop through the table in chunks based on the index
    lv_start = 1.

    WHILE lv_start <= lv_count.
      " Calculate the end index for the chunk
      lv_end = lv_start + lv_chunk - 1.
      IF lv_end > lv_count.
        lv_end = lv_count. " Adjust to the last index if beyond table size
      ENDIF.

      " Create a dynamic internal table for the current chunk
      CREATE DATA lt_split_tab LIKE <lt_data>.
      ASSIGN lt_split_tab->* TO <lt_chunk>.

      " Copy the specified range from the original table to the chunk
      INSERT LINES OF <lt_data> FROM lv_start TO lv_end INTO TABLE <lt_chunk>.

      " Perform MODIFY operation on the chunk
      MODIFY (iv_tab_name) FROM TABLE <lt_chunk>.

      COMMIT WORK AND WAIT.

      " Increment the starting index for the next chunk
      lv_start = lv_end + 1.

      REFRESH <lt_chunk>.
    ENDWHILE.
  ENDMETHOD.


  METHOD download_file_to_al11.
    OPEN DATASET iv_file_path FOR OUTPUT IN TEXT MODE ENCODING UTF-8.
    IF sy-subrc <> 0.
      RAISE cx_sy_file_open.
    ENDIF.

    LOOP AT it_table_data ASSIGNING FIELD-SYMBOL(<ls_table_data>).
      TRANSFER <ls_table_data> TO iv_file_path.
    ENDLOOP.

    CLOSE DATASET iv_file_path.
  ENDMETHOD.

  METHOD export_multi_tables_to_excel.
    DATA: lo_excel       TYPE REF TO zcl_excel,
          lt_worksheets  TYPE TABLE OF string,
          lv_xstring     TYPE xstring,
          lv_filename    TYPE string,
          lr_table_descr TYPE REF TO cl_abap_typedescr,
          lt_data        TYPE REF TO data,
          lv_tabname     TYPE string.

    DATA : lt_where    TYPE TABLE OF edpline,
           lt_sel_list TYPE TABLE OF edpline,
           l_wa_name   TYPE string,
           ls_where    TYPE edpline,
           l_having    TYPE string,
           dref        TYPE REF TO data,
           itab_type   TYPE REF TO cl_abap_tabledescr,
           struct_type TYPE REF TO cl_abap_structdescr,
           elem_type   TYPE REF TO cl_abap_elemdescr,
           comp_tab    TYPE cl_abap_structdescr=>component_table,
           comp_fld    TYPE cl_abap_structdescr=>component.

    " Create the Excel spreadsheet instance
    TRY.
        " Create a new Excel document
        DATA: o_xl TYPE REF TO zcl_excel.
* Converter itab->ABAP2XLSX
        DATA(o_xl_conv) = NEW zcl_excel_converter( ).

        " Loop through each table name
        LOOP AT it_tables INTO lv_tabname.
          DATA(lv_tabix) = sy-tabix.
          " Describe the table dynamically
          struct_type ?= cl_abap_typedescr=>describe_by_name( lv_tabname ).
*         elem_type   ?= cl_abap_elemdescr=>describe_by_name( 'MANDT' ).
          comp_tab = struct_type->get_components( ).

*         comp_fld-name = 'MANDT'.
*         comp_fld-type = mandt.
*         APPEND comp_fld TO comp_tab.
          struct_type = cl_abap_structdescr=>create( comp_tab ).
          itab_type   = cl_abap_tabledescr=>create( struct_type ).

          " Create a dynamic internal table
          CREATE DATA lt_data TYPE HANDLE itab_type.
          ASSIGN lt_data->* TO FIELD-SYMBOL(<lt_data>).

          " Select data into the internal table
          SELECT * FROM (lv_tabname) INTO TABLE @<lt_data>.

          IF sy-subrc = 0.
            IF o_xl IS INITIAL.
              o_xl_conv->convert( EXPORTING it_table = <lt_data>
                                  CHANGING  co_excel = o_xl ).
              o_xl->get_active_worksheet( )->set_title( ip_title = CONV #( lv_tabname ) ).
            ELSE.
              o_xl_conv->convert( EXPORTING it_table = <lt_data>
                                        io_worksheet = o_xl->add_new_worksheet( ip_title = CONV #( lv_tabname ) )
                                CHANGING  co_excel = o_xl ).
            ENDIF.
          ENDIF.
        ENDLOOP.

        DATA(o_writer) = CAST zif_excel_writer( NEW zcl_excel_writer_huge_file( ) ).

* Excel-Writer-Objekt->xstring
        ev_x_string = o_writer->write_file( o_xl ).


      CATCH cx_root INTO DATA(e_txt).
        WRITE: / e_txt->get_text( ).
    ENDTRY.
  ENDMETHOD.


ENDCLASS.

DATA: lt_file_content TYPE filetable,
      lv_file_name    TYPE string,
      lv_rc           TYPE i,
      lt_tables       TYPE TABLE OF dd02l-tabname,
      lo_file_handler TYPE REF TO lhc_file_handler.

SELECTION-SCREEN BEGIN OF BLOCK b90 WITH FRAME TITLE TEXT-090.
  PARAMETERS: rd_exp TYPE c RADIOBUTTON GROUP rb1 DEFAULT 'X' USER-COMMAND cmd_radio1 .
  PARAMETERS: rd_imp TYPE c RADIOBUTTON GROUP rb1 .
SELECTION-SCREEN END OF BLOCK b90.

SELECTION-SCREEN BEGIN OF BLOCK b92 WITH FRAME TITLE TEXT-092.
  PARAMETERS: rd_app TYPE c RADIOBUTTON GROUP rb2 DEFAULT 'X' USER-COMMAND cmd_radio2 .
  PARAMETERS: rd_pre TYPE c RADIOBUTTON GROUP rb2 .
SELECTION-SCREEN END OF BLOCK b92.

SELECTION-SCREEN BEGIN OF BLOCK b95 WITH FRAME TITLE TEXT-095.
  SELECT-OPTIONS: p_table FOR dd02l-tabname MODIF ID tab NO INTERVALS DEFAULT 'Enter Custom Table'.
  PARAMETERS: p_dele AS CHECKBOX MODIF ID del.
SELECTION-SCREEN END OF BLOCK b95.

SELECTION-SCREEN BEGIN OF BLOCK b98 WITH FRAME TITLE TEXT-098.
  PARAMETERS: p_app LIKE ibipparms-path MEMORY ID ad_al11_path MODIF ID app.
SELECTION-SCREEN END OF BLOCK b98.

SELECTION-SCREEN BEGIN OF BLOCK b99 WITH FRAME TITLE TEXT-099.
  PARAMETERS: p_file TYPE file_table-filename MEMORY ID ad_local_path MODIF ID usr.
*  PARAMETERS: p_colnum TYPE i OBLIGATORY DEFAULT 4 MODIF ID USR.
*  PARAMETERS: p_rownum TYPE i OBLIGATORY DEFAULT 5 MODIF ID USR.
SELECTION-SCREEN END OF BLOCK b99.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  DATA: lv_rc TYPE i.
  DATA: it_files TYPE filetable.
  DATA: lv_action TYPE i.

* File-Tabelle leeren, da hier noch alte Einträge von vorherigen Aufrufen drin stehen können
  CLEAR it_files.

* FileOpen-Dialog aufrufen
  TRY.
      cl_gui_frontend_services=>file_open_dialog( EXPORTING
                                                    file_filter    = |XLSX (*.XLSX)\|*.CSV\|{ cl_gui_frontend_services=>filetype_all }|
                                                    multiselection = abap_false
                                                  CHANGING
                                                    file_table  = it_files
                                                    rc          = lv_rc
                                                    user_action = lv_action ).

      IF lv_action = cl_gui_frontend_services=>action_ok.
* wenn Datei ausgewählt wurde
        IF lines( it_files ) > 0.
* ersten Tabelleneintrag lesen
          p_file = it_files[ 1 ]-filename.
        ENDIF.
      ENDIF.

    CATCH cx_root INTO DATA(e_text).
      MESSAGE e_text->get_text( ) TYPE 'I'.
  ENDTRY.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_app.
  DATA: lv_canceled TYPE boolean.
  DATA: lv_file_name TYPE string.

  TRY.
      cl_rsan_ut_files=>f4( EXPORTING
                              i_applserv         = abap_true " Dateiauswahl vom Appl.-Server holen, sonst GUI
                              i_title            = 'Dateiauswahl auf dem Applikationsserver'
                              i_gui_extension    = ''
                              i_gui_ext_filter   = ''
                              i_applserv_logical = abap_false
                              i_applserv_al11    = abap_true
                            IMPORTING
                              e_canceled         = lv_canceled
                            CHANGING
                              c_file_name        = lv_file_name ).

      IF lv_canceled NE abap_true.
        p_app = lv_file_name.
      ENDIF.
    CATCH cx_root INTO DATA(e_text).
      MESSAGE e_text->get_text( ) TYPE 'I'.
  ENDTRY.

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    " Hide table selection section when importing
    IF rd_imp = 'X' AND rd_app = 'X'.
      IF screen-group1 = 'APP' .
        screen-active = 1.
        MODIFY SCREEN.
        CONTINUE.
      ELSEIF screen-group1 = 'TAB' OR screen-group1 = 'USR' .
        screen-active = 0.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.
    ENDIF.

    IF rd_imp = 'X' AND rd_pre = 'X'.
      IF screen-group1 = 'USR' .
        screen-active = 1.
        MODIFY SCREEN.
        CONTINUE.
      ELSEIF screen-group1 = 'APP' OR screen-group1 = 'TAB' .
        screen-active = 0.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.
    ENDIF.

    IF rd_exp = 'X' AND rd_app = 'X'.
      IF screen-group1 = 'APP' OR screen-group1 = 'TAB'.
        screen-active = 1.
        MODIFY SCREEN.
        CONTINUE.
      ELSEIF screen-group1 = 'USR' OR screen-group1 = 'DEL' .
        screen-active = 0.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.
    ENDIF.

    IF rd_exp = 'X' AND rd_pre = 'X'.
      IF screen-group1 = 'USR' OR screen-group1 = 'TAB'.
        screen-active = 1.
        MODIFY SCREEN.
        CONTINUE.
      ELSEIF screen-group1 = 'APP' OR screen-group1 = 'DEL' .
        screen-active = 0.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.
    ENDIF.

  ENDLOOP.

START-OF-SELECTION.
  " Create an instance of the file handler class
  CREATE OBJECT lo_file_handler.

  IF rd_imp = 'X' AND rd_app = 'X'.
    " Import file from AL11
    lo_file_handler->upload_file(
      EXPORTING
        iv_file_name = CONV #( p_app )
      IMPORTING
        et_file_content = lt_file_content ).


  ELSEIF rd_imp = 'X' AND rd_pre = 'X'.
    " Import file from presentation server

    lo_file_handler->upload_file(
      EXPORTING
        iv_file_name = CONV #( p_file )
      IMPORTING
        et_file_content = lt_file_content ).

  ELSEIF rd_exp = 'X'.
    " Export multiple tables to Excel
    TRY.
        " Fill lt_tables with user selected tables from p_table range
        LOOP AT p_table INTO DATA(lv_range).
          APPEND lv_range-low TO lt_tables.
        ENDLOOP.

        lo_file_handler->export_multi_tables_to_excel(
          EXPORTING
            it_tables    = lt_tables[]
            iv_file_path = CONV #( p_file )
          IMPORTING
            ev_x_string  = DATA(lv_x_string)   ).

* xstring -> solix
        DATA(it_solix_data) = cl_bcs_convert=>xstring_to_solix( iv_xstring = lv_x_string ).
        IF rd_app = abap_true.

          OPEN DATASET p_app FOR OUTPUT IN BINARY MODE.
          IF sy-subrc <> 0.
            RAISE cx_sy_file_open.
          ENDIF.

          LOOP AT it_solix_data INTO DATA(lv_line).
            TRANSFER lv_line TO p_app.
          ENDLOOP.

          CLOSE DATASET p_app.

        ELSE.
* CSV Daten lokal speichern (binär übertragen)
          cl_gui_frontend_services=>gui_download( EXPORTING filename     = CONV #( p_file )
                                                            filetype     = 'BIN'
                                                            bin_filesize = xstrlen( lv_x_string )
                                                  CHANGING  data_tab     = it_solix_data ).

        ENDIF.

        MESSAGE 'Tables exported successfully to Excel file' TYPE 'S'.
      CATCH cx_fdt_excel_core.
        MESSAGE 'Error during Excel export' TYPE 'E'.
    ENDTRY.

  ELSE.
    MESSAGE 'Please select a valid operation (Import/Export)' TYPE 'E'.
  ENDIF.
