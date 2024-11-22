*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: YZ_V_TEMPL_VIEW.................................*
FORM GET_DATA_YZ_V_TEMPL_VIEW.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM YZTABL_TEMP_VIEW WHERE
(VIM_WHERETAB) .
    CLEAR YZ_V_TEMPL_VIEW .
YZ_V_TEMPL_VIEW-MANDT =
YZTABL_TEMP_VIEW-MANDT .
YZ_V_TEMPL_VIEW-USMD_MODEL =
YZTABL_TEMP_VIEW-USMD_MODEL .
YZ_V_TEMPL_VIEW-SCOPE_ID =
YZTABL_TEMP_VIEW-SCOPE_ID .
YZ_V_TEMPL_VIEW-TEMPLATE_ID =
YZTABL_TEMP_VIEW-TEMPLATE_ID .
YZ_V_TEMPL_VIEW-VIEW_ID =
YZTABL_TEMP_VIEW-VIEW_ID .
YZ_V_TEMPL_VIEW-DESCRIPTION =
YZTABL_TEMP_VIEW-DESCRIPTION .
YZ_V_TEMPL_VIEW-PRIMARY_TABLE =
YZTABL_TEMP_VIEW-PRIMARY_TABLE .
YZ_V_TEMPL_VIEW-USMD_ACTIVE =
YZTABL_TEMP_VIEW-USMD_ACTIVE .
<VIM_TOTAL_STRUC> = YZ_V_TEMPL_VIEW.
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
FORM DB_UPD_YZ_V_TEMPL_VIEW .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO YZ_V_TEMPL_VIEW.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_YZ_V_TEMPL_VIEW-ST_DELETE EQ GELOESCHT.
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
  SELECT SINGLE FOR UPDATE * FROM YZTABL_TEMP_VIEW WHERE
  USMD_MODEL = YZ_V_TEMPL_VIEW-USMD_MODEL AND
  SCOPE_ID = YZ_V_TEMPL_VIEW-SCOPE_ID AND
  TEMPLATE_ID = YZ_V_TEMPL_VIEW-TEMPLATE_ID AND
  VIEW_ID = YZ_V_TEMPL_VIEW-VIEW_ID .
    IF SY-SUBRC = 0.
    DELETE YZTABL_TEMP_VIEW .
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
  SELECT SINGLE FOR UPDATE * FROM YZTABL_TEMP_VIEW WHERE
  USMD_MODEL = YZ_V_TEMPL_VIEW-USMD_MODEL AND
  SCOPE_ID = YZ_V_TEMPL_VIEW-SCOPE_ID AND
  TEMPLATE_ID = YZ_V_TEMPL_VIEW-TEMPLATE_ID AND
  VIEW_ID = YZ_V_TEMPL_VIEW-VIEW_ID .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR YZTABL_TEMP_VIEW.
    ENDIF.
YZTABL_TEMP_VIEW-MANDT =
YZ_V_TEMPL_VIEW-MANDT .
YZTABL_TEMP_VIEW-USMD_MODEL =
YZ_V_TEMPL_VIEW-USMD_MODEL .
YZTABL_TEMP_VIEW-SCOPE_ID =
YZ_V_TEMPL_VIEW-SCOPE_ID .
YZTABL_TEMP_VIEW-TEMPLATE_ID =
YZ_V_TEMPL_VIEW-TEMPLATE_ID .
YZTABL_TEMP_VIEW-VIEW_ID =
YZ_V_TEMPL_VIEW-VIEW_ID .
YZTABL_TEMP_VIEW-DESCRIPTION =
YZ_V_TEMPL_VIEW-DESCRIPTION .
YZTABL_TEMP_VIEW-PRIMARY_TABLE =
YZ_V_TEMPL_VIEW-PRIMARY_TABLE .
YZTABL_TEMP_VIEW-USMD_ACTIVE =
YZ_V_TEMPL_VIEW-USMD_ACTIVE .
    IF SY-SUBRC = 0.
    UPDATE YZTABL_TEMP_VIEW ##WARN_OK.
    ELSE.
    INSERT YZTABL_TEMP_VIEW .
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
CLEAR: STATUS_YZ_V_TEMPL_VIEW-UPD_FLAG,
STATUS_YZ_V_TEMPL_VIEW-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_YZ_V_TEMPL_VIEW.
  SELECT SINGLE * FROM YZTABL_TEMP_VIEW WHERE
USMD_MODEL = YZ_V_TEMPL_VIEW-USMD_MODEL AND
SCOPE_ID = YZ_V_TEMPL_VIEW-SCOPE_ID AND
TEMPLATE_ID = YZ_V_TEMPL_VIEW-TEMPLATE_ID AND
VIEW_ID = YZ_V_TEMPL_VIEW-VIEW_ID .
YZ_V_TEMPL_VIEW-MANDT =
YZTABL_TEMP_VIEW-MANDT .
YZ_V_TEMPL_VIEW-USMD_MODEL =
YZTABL_TEMP_VIEW-USMD_MODEL .
YZ_V_TEMPL_VIEW-SCOPE_ID =
YZTABL_TEMP_VIEW-SCOPE_ID .
YZ_V_TEMPL_VIEW-TEMPLATE_ID =
YZTABL_TEMP_VIEW-TEMPLATE_ID .
YZ_V_TEMPL_VIEW-VIEW_ID =
YZTABL_TEMP_VIEW-VIEW_ID .
YZ_V_TEMPL_VIEW-DESCRIPTION =
YZTABL_TEMP_VIEW-DESCRIPTION .
YZ_V_TEMPL_VIEW-PRIMARY_TABLE =
YZTABL_TEMP_VIEW-PRIMARY_TABLE .
YZ_V_TEMPL_VIEW-USMD_ACTIVE =
YZTABL_TEMP_VIEW-USMD_ACTIVE .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_YZ_V_TEMPL_VIEW USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE YZ_V_TEMPL_VIEW-USMD_MODEL TO
YZTABL_TEMP_VIEW-USMD_MODEL .
MOVE YZ_V_TEMPL_VIEW-SCOPE_ID TO
YZTABL_TEMP_VIEW-SCOPE_ID .
MOVE YZ_V_TEMPL_VIEW-TEMPLATE_ID TO
YZTABL_TEMP_VIEW-TEMPLATE_ID .
MOVE YZ_V_TEMPL_VIEW-VIEW_ID TO
YZTABL_TEMP_VIEW-VIEW_ID .
MOVE YZ_V_TEMPL_VIEW-MANDT TO
YZTABL_TEMP_VIEW-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'YZTABL_TEMP_VIEW'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN YZTABL_TEMP_VIEW TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'YZTABL_TEMP_VIEW'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*