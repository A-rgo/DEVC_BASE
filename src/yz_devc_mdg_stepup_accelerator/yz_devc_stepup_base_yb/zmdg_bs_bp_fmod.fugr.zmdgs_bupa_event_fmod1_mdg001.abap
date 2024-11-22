FUNCTION zmdgs_bupa_event_fmod1_mdg001 .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      T_FELDSTLST STRUCTURE  BUS0FLDLST_2
*"----------------------------------------------------------------------

  TYPES: BEGIN OF ty_appli,
           appli TYPE bu_appli,
           sicht TYPE bu_sicht,
         END OF ty_appli.

  TYPES: BEGIN OF ty_fldgr,
           appli TYPE bu_appli,
           sicht TYPE bu_sicht,
           fldgr TYPE bu_fldgr,
         END OF ty_fldgr.

  DATA: ls_but000    TYPE but000,
        lt_tbz3e     TYPE TABLE OF tbz3e,
        lt_tbz3s     TYPE TABLE OF tbz3s,
        ls_appli     TYPE ty_appli,
        lt_appli     TYPE TABLE OF ty_appli,
        ls_fldgr     TYPE ty_fldgr,
        lt_fldgr     TYPE TABLE OF ty_fldgr,

        lv_tab       TYPE i,
        lv_tab_n(2)  TYPE n,
        lv_offset    TYPE i,
        lv_fieldname TYPE string.


  FIELD-SYMBOLS: <ls_tbz3e>    TYPE tbz3e,
                 <ls_tbz3s>    TYPE tbz3s,
                 <ls_appli>    TYPE ty_appli,
                 <ls_fldgr>    TYPE ty_fldgr,
                 <lv_fieldlst> TYPE any.

  CALL FUNCTION 'BDT_TBZ3E_GET'
    EXPORTING
      iv_client = sy-mandt
      iv_objap  = 'BUPA'
    TABLES
      et_tbz3e  = lt_tbz3e
    EXCEPTIONS
      OTHERS    = 1.

  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT lt_tbz3e ASSIGNING <ls_tbz3e>.

    IF <ls_tbz3e>-appli = 'BUP' OR
       <ls_tbz3e>-appli = 'BUA' OR
       <ls_tbz3e>-appli = 'BUB' OR
       <ls_tbz3e>-appli = 'BUS' OR
       <ls_tbz3e>-appli = 'BNK' OR
       <ls_tbz3e>-appli = 'BUTC' OR
       <ls_tbz3e>-appli = 'BUTP' OR
       <ls_tbz3e>-appli = 'BUTX' OR
       <ls_tbz3e>-appli = 'CVIV'.

      IF <ls_tbz3e>-sicht = 'BUP520' OR <ls_tbz3e>-sicht = 'BUP810'. " Skip for Identification
        CONTINUE.
      ELSE.
        ls_appli-sicht = <ls_tbz3e>-sicht.
        ls_appli-appli = <ls_tbz3e>-appli.
        APPEND ls_appli TO lt_appli.
      ENDIF.

    ENDIF.
  ENDLOOP.

  LOOP AT lt_appli ASSIGNING <ls_appli>.

    CALL FUNCTION 'BDT_TBZ3S_GET_WITH_SICHT'
      EXPORTING
        iv_client = sy-mandt
        iv_objap  = 'BUPA'
        iv_sicht  = <ls_appli>-sicht
      TABLES
        et_tbz3s  = lt_tbz3s
      EXCEPTIONS
        OTHERS    = 1.

    IF sy-subrc <> 0.
    ENDIF.

    LOOP AT lt_tbz3s ASSIGNING <ls_tbz3s>.

      ls_fldgr-sicht = <ls_appli>-sicht.
      ls_fldgr-appli = <ls_appli>-appli.
      ls_fldgr-fldgr = <ls_tbz3s>-fldgr.
      APPEND ls_fldgr TO lt_fldgr.

    ENDLOOP.
  ENDLOOP.

  SORT lt_fldgr BY fldgr.

  LOOP AT lt_fldgr ASSIGNING <ls_fldgr>.

    lv_tab = trunc( ( <ls_fldgr>-fldgr + 250 ) / 250 ).
    lv_offset = <ls_fldgr>-fldgr MOD 250.

    IF lv_offset <> 0.
      lv_offset = lv_offset - 1.
    ENDIF.

    lv_tab_n = lv_tab.

    IF lv_tab < 10.
      CONCATENATE 'FELDSTLST' lv_tab_n+1 INTO lv_fieldname.
    ELSE.
      CONCATENATE 'FELDSTLST' lv_tab_n INTO lv_fieldname.
    ENDIF.

    ASSIGN COMPONENT lv_fieldname OF STRUCTURE t_feldstlst TO <lv_fieldlst>.

    <lv_fieldlst>+lv_offset = '*'.

  ENDLOOP.

  APPEND t_feldstlst.

ENDFUNCTION.
