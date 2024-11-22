*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: YZ_VIEW_RULE_SEC................................*
FORM GET_DATA_YZ_VIEW_RULE_SEC.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM YZTABL_RULE_SEC WHERE
(VIM_WHERETAB) .
    CLEAR YZ_VIEW_RULE_SEC .
YZ_VIEW_RULE_SEC-MANDT =
YZTABL_RULE_SEC-MANDT .
YZ_VIEW_RULE_SEC-RULE_SEC =
YZTABL_RULE_SEC-RULE_SEC .
YZ_VIEW_RULE_SEC-SEC_DESC =
YZTABL_RULE_SEC-SEC_DESC .
<VIM_TOTAL_STRUC> = YZ_VIEW_RULE_SEC.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_YZ_VIEW_RULE_SEC .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO YZ_VIEW_RULE_SEC.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_YZ_VIEW_RULE_SEC-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM YZTABL_RULE_SEC WHERE
  RULE_SEC = YZ_VIEW_RULE_SEC-RULE_SEC .
    IF SY-SUBRC = 0.
    DELETE YZTABL_RULE_SEC .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM YZTABL_RULE_SEC WHERE
  RULE_SEC = YZ_VIEW_RULE_SEC-RULE_SEC .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR YZTABL_RULE_SEC.
    ENDIF.
YZTABL_RULE_SEC-MANDT =
YZ_VIEW_RULE_SEC-MANDT .
YZTABL_RULE_SEC-RULE_SEC =
YZ_VIEW_RULE_SEC-RULE_SEC .
YZTABL_RULE_SEC-SEC_DESC =
YZ_VIEW_RULE_SEC-SEC_DESC .
    IF SY-SUBRC = 0.
    UPDATE YZTABL_RULE_SEC ##WARN_OK.
    ELSE.
    INSERT YZTABL_RULE_SEC .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_YZ_VIEW_RULE_SEC-UPD_FLAG,
STATUS_YZ_VIEW_RULE_SEC-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_YZ_VIEW_RULE_SEC.
  SELECT SINGLE * FROM YZTABL_RULE_SEC WHERE
RULE_SEC = YZ_VIEW_RULE_SEC-RULE_SEC .
YZ_VIEW_RULE_SEC-MANDT =
YZTABL_RULE_SEC-MANDT .
YZ_VIEW_RULE_SEC-RULE_SEC =
YZTABL_RULE_SEC-RULE_SEC .
YZ_VIEW_RULE_SEC-SEC_DESC =
YZTABL_RULE_SEC-SEC_DESC .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_YZ_VIEW_RULE_SEC USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE YZ_VIEW_RULE_SEC-RULE_SEC TO
YZTABL_RULE_SEC-RULE_SEC .
MOVE YZ_VIEW_RULE_SEC-MANDT TO
YZTABL_RULE_SEC-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'YZTABL_RULE_SEC'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN YZTABL_RULE_SEC TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'YZTABL_RULE_SEC'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*