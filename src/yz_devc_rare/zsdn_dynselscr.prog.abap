*&---------------------------------------------------------------------*
*& REPORT ZSDN_DYNSELSCR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsdn_dynselscr.

*PARAMETERS : p_tcode TYPE tcode NO-DISPLAY.

*&———————————————————————*
* GLOBAL DATA
*&———————————————————————*
DATA gt_scrflds TYPE TABLE OF zscrflds.
DATA wa_scrflds TYPE zscrflds.
DATA gt_prog TYPE TABLE OF abaptext.
DATA wa_prog LIKE LINE OF gt_prog.

*&———————————————————————*
* START OF SELECTION
*&———————————————————————*
START-OF-SELECTION.
  DATA gt_tmpflds TYPE TABLE OF zscrflds.
  DATA wa_tmpflds TYPE zscrflds.
  DATA w_type(60) TYPE c.
  DATA w_ctbix(10) TYPE c.
  DATA w_desc(10) TYPE c.

* RETRIVE THE REQUIRED FIELDS FROM THE TABLE
  SELECT *
    FROM zscrflds
    INTO TABLE gt_scrflds
    WHERE ( tcode = sy-tcode ) "OR tcode = p_tcode )
      AND active = abap_true.

* BUILD DYNAMIC REPORT CODE
  wa_prog = 'REPORT ZDYNSELSCR.'.
  APPEND wa_prog TO gt_prog.

**CODE FOR BUILDING TABLES SECTION
* COPY TO A TEMPORARY INTERNAL TABLE
  gt_tmpflds[] = gt_scrflds[].

* DELETE SCREEN FIELDS FOR PARAMETERS IN THE TEMP TABLE
  DELETE gt_tmpflds WHERE basictyp NE 'S'.
  SORT gt_tmpflds BY reftable.

* REMOVE DUPLICATES
  DELETE ADJACENT DUPLICATES FROM gt_tmpflds COMPARING reftable.

* BUILD TABLES… CODE FOR TABLE WORKAREA
  LOOP AT gt_tmpflds INTO wa_tmpflds.
    CONCATENATE 'TABLES' wa_tmpflds-reftable '.'
      INTO wa_prog
      SEPARATED BY space.
    APPEND wa_prog TO gt_prog.
  ENDLOOP.

* BUILD SELECTION SCREEN FIELD DEFINITION
  LOOP AT gt_scrflds INTO wa_scrflds.
    w_ctbix = sy-tabix.
    CONDENSE w_ctbix.
    wa_prog = 'SELECTION-SCREEN BEGIN OF SCREEN 900 AS WINDOW.'.
*    wa_prog = 'SELECTION-SCREEN BEGIN OF LINE.'.
    APPEND wa_prog TO gt_prog.

    wa_prog = 'SELECTION-SCREEN BEGIN OF LINE.'.
    APPEND wa_prog TO gt_prog.

*   COMMENTS FIELD IN THE SELECTION FIELD
    CONCATENATE
      'SELECTION-SCREEN COMMENT 1(20) CMT' w_ctbix '.'
    INTO wa_prog.
    APPEND wa_prog TO gt_prog.

*   CONCATENATE REF. TABLENAME AND FIELDNAME
*   EG. : MARA / MATNR INTO MARA-MATNR
    CONCATENATE wa_scrflds-reftable wa_scrflds-reffield
      INTO w_type
      SEPARATED BY '-'.

*   CODE GENERATION FOR PARAMETERS TYPE
    IF wa_scrflds-basictyp EQ 'P'.
      CASE wa_scrflds-required.
        WHEN abap_true.
          IF wa_scrflds-default_value IS NOT INITIAL.
            CONCATENATE
              'PARAMETERS' wa_scrflds-fieldname 'LIKE' w_type  'OBLIGATORY' 'DEFAULT' `'` wa_scrflds-default_value `'` '.'
            INTO wa_prog
            SEPARATED BY space.
          ELSE.
            CONCATENATE
               'PARAMETERS' wa_scrflds-fieldname 'LIKE' w_type  'OBLIGATORY' '.'
             INTO wa_prog
             SEPARATED BY space.
          ENDIF.
        WHEN OTHERS..
          IF wa_scrflds-default_value IS NOT INITIAL.
            CONCATENATE
              'PARAMETERS' wa_scrflds-fieldname 'LIKE' w_type   'DEFAULT' `'` wa_scrflds-default_value `'` '.'
            INTO wa_prog
            SEPARATED BY space.
          ELSE.
            CONCATENATE
              'PARAMETERS' wa_scrflds-fieldname 'LIKE' w_type '.'
            INTO wa_prog
            SEPARATED BY space.
          ENDIF.
      ENDCASE.

    ENDIF.

*   CODE GENERATION FOR SELECT-OPTIONS TYPE
    IF wa_scrflds-basictyp EQ 'S'.
      CONCATENATE
        'SELECT-OPTIONS' wa_scrflds-fieldname 'FOR' w_type '.'
      INTO wa_prog
      SEPARATED BY space.
    ENDIF.
    APPEND wa_prog TO gt_prog.

    wa_prog = 'SELECTION-SCREEN END OF LINE.'.
    APPEND wa_prog TO gt_prog.

    wa_prog = 'SELECTION-SCREEN END OF SCREEN 900.'.
*    wa_prog = 'SELECTION-SCREEN END OF LINE.'.
    APPEND wa_prog TO gt_prog.
  ENDLOOP.

* END OF CODE GENERATION FOR SELECTION SCREEN
* GENERATE INITIALIZATION EVENT CODE
* INITIALIZE THE COMMENTS FIELDS DEFINED IN THE SELECTION SCREEN
  wa_prog = 'INITIALIZATION.'.
  APPEND wa_prog TO gt_prog.
  LOOP AT gt_scrflds INTO wa_scrflds.
    w_ctbix = sy-tabix.
    CONDENSE w_ctbix.
    CONCATENATE 'CMT' w_ctbix
      INTO w_ctbix.


    IF wa_scrflds-fieldtitle IS INITIAL.
*   GET THE DESCRIPTION FROM THE TABLE DDFTX
      SELECT SINGLE scrtext_s
        FROM ddftx
        INTO w_desc
        WHERE tabname EQ wa_scrflds-reftable
          AND fieldname EQ wa_scrflds-reffield
          AND ddlanguage EQ sy-langu.

      CONCATENATE w_ctbix ` = '` w_desc `'.`
        INTO wa_prog.

    ELSE.
      CONCATENATE w_ctbix ` = '` wa_scrflds-fieldtitle `'.`
              INTO wa_prog.

    ENDIF.
    APPEND wa_prog TO gt_prog.
  ENDLOOP.

* GENERATE START OF SELECTION EVENT CODE
  wa_prog = 'START-OF-SELECTION.'.
  APPEND wa_prog TO gt_prog.

  wa_prog = 'CALL SELECTION-SCREEN 900 STARTING AT 10 10.'.
  APPEND wa_prog TO gt_prog.

* DATA TYPES FOR SHARED OBJECTS
  wa_prog = 'DATA T_RANGES TYPE ACE_FIELD_RANGES_T.'.
  APPEND wa_prog TO gt_prog.
  wa_prog = 'DATA WA_RANGES LIKE LINE OF T_RANGES.'.
  APPEND wa_prog TO gt_prog.
  wa_prog = 'DATA T_FLDRANGE TYPE ACE_GENERIC_RANGE_T.'.
  APPEND wa_prog TO gt_prog.
  wa_prog = 'DATA WA_FLDRANGE TYPE ACE_GENERIC_RANGE.'.
  APPEND wa_prog TO gt_prog.

* READ THE INPUT FROM THE SELECTION SCREEN AND
*  STORE IT IN SHARED OBJECTS
  LOOP AT gt_scrflds INTO wa_scrflds.

*   ASSIGN THE FIELDNAME IN THE VARIABLE
    CONCATENATE `WA_RANGES-FIELDNAME = '`
                 wa_scrflds-fieldname `'.`
    INTO wa_prog SEPARATED BY space.
    APPEND wa_prog TO gt_prog.
    wa_prog = 'REFRESH T_FLDRANGE.'.
    APPEND wa_prog TO gt_prog.

*   PROCESSING FOR SELECT-OPTIONS
*   LOOP AND MOVE DATA TO THE SHARED MEMORY
    IF wa_scrflds-basictyp EQ 'S'.
      CONCATENATE 'LOOP AT ' wa_scrflds-fieldname '.'
        INTO wa_prog SEPARATED BY space.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'CLEAR WA_FLDRANGE.'.
      APPEND wa_prog TO gt_prog.
      CONCATENATE 'MOVE-CORRESPONDING ' wa_scrflds-fieldname 'TO' 'WA_FLDRANGE.'
         INTO wa_prog SEPARATED BY space.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'APPEND WA_FLDRANGE TO T_FLDRANGE.'.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'ENDLOOP.'.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'WA_RANGES-FIELDRANGE[] = T_FLDRANGE[].'.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'APPEND WA_RANGES TO T_RANGES.'.
      APPEND wa_prog TO gt_prog.
    ELSEIF wa_scrflds-basictyp EQ 'P'.

*   PROCESSING FOR PARAMETERS
      wa_prog = 'CLEAR WA_FLDRANGE.'.
      APPEND wa_prog TO gt_prog.

*     PROCESS IF THE PARAMETER IS NOT INITIAL
      CONCATENATE 'IF ' wa_scrflds-fieldname 'IS NOT INITIAL.'
        INTO wa_prog SEPARATED BY space.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'WA_FLDRANGE-SIGN = "I".'.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'WA_FLDRANGE-OPTION = "EQ".'.
      APPEND wa_prog TO gt_prog.
      CONCATENATE 'WA_FLDRANGE-LOW = ' wa_scrflds-fieldname '.'
        INTO wa_prog SEPARATED BY space.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'APPEND WA_FLDRANGE TO T_FLDRANGE.'.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'ENDIF.'.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'WA_RANGES-FIELDRANGE[] = T_FLDRANGE[].'.
      APPEND wa_prog TO gt_prog.
      wa_prog = 'APPEND WA_RANGES TO T_RANGES.'.
      APPEND wa_prog TO gt_prog.
    ENDIF.
  ENDLOOP.
  wa_prog = 'DATA: AREA TYPE REF TO ZSELAREA.'.
  APPEND wa_prog TO gt_prog.
  wa_prog = 'DATA ROOT TYPE REF TO ZCL_SELSCR.'.
  APPEND wa_prog TO gt_prog.

* GET REF TO THE SHARED MEMORY
  wa_prog = 'AREA = ZSELAREA=>ATTACH_FOR_WRITE( ).'.
  APPEND wa_prog TO gt_prog.
  wa_prog = 'CREATE OBJECT ROOT AREA HANDLE AREA.'.
  APPEND wa_prog TO gt_prog.

* STORE THE VALUE IN THE MEMORY
  wa_prog = 'ROOT->SET_FIELDS( T_RANGES ).'.
  APPEND wa_prog TO gt_prog.
  wa_prog = 'AREA->SET_ROOT(  ROOT ).'.
  APPEND wa_prog TO gt_prog.

* COMMIT AND DETATCH
  wa_prog = 'AREA->DETACH_COMMIT( ).'.
  APPEND wa_prog TO gt_prog.

* QUIT THE PROGRAM: RETURN TO THE MAIN CODE
  wa_prog = 'LEAVE PROGRAM.'.
  APPEND wa_prog TO gt_prog.

* GENERATE THE REPORT PROGRAM
  INSERT REPORT 'ZDYNSELSCR' FROM gt_prog.
  COMMIT WORK.

* EXECUTE THE REPORT
  SUBMIT zdynselscr VIA SELECTION-SCREEN AND RETURN.

*  READ THE DATA FROM THE SHARED MEMORY
*  DATA area TYPE REF TO zselarea.
*  area = zselarea=>attach_for_read( ).
*  DATA t_ranges TYPE ace_field_ranges_t.
*  t_ranges = area->root->get_fields( ).
*  area->detach( ).
*  TYPES cond(72) TYPE c.
*  DATA it_vbak TYPE TABLE OF vbak.
*  DATA wa_vbak LIKE LINE OF it_vbak.
*  DATA t_cond TYPE TABLE OF cond WITH HEADER LINE.
*  DATA wa_ranges LIKE LINE OF t_ranges.
*  DATA wa_fieldrange LIKE LINE OF wa_ranges-fieldrange.
*  DATA dref TYPE REF TO data.
*  LOOP AT t_ranges INTO wa_ranges.
*    WRITE / wa_ranges-fieldname COLOR COL_HEADING.
*    ULINE AT /8(68).
*    LOOP AT wa_ranges-fieldrange INTO wa_fieldrange.
*      WRITE :/8 sy-vline, 10 wa_fieldrange-sign,
*              14 sy-vline, 15 wa_fieldrange-option,
*              19 sy-vline, 20 wa_fieldrange-low, 42 sy-vline, 75 sy-vline.
*      IF wa_fieldrange-high IS NOT INITIAL.
*        WRITE AT 43 wa_fieldrange-high.
*        WRITE AT 75 sy-vline.
*      ENDIF.
*    ENDLOOP.
*    ULINE AT /8(68).
*  ENDLOOP.
