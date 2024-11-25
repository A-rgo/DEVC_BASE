*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: YZ_V_TEMPLATE...................................*
FORM GET_DATA_YZ_V_TEMPLATE.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM YZTABLE_TEMPLATE WHERE
(VIM_WHERETAB) .
    CLEAR YZ_V_TEMPLATE .
YZ_V_TEMPLATE-MANDT =
YZTABLE_TEMPLATE-MANDT .
YZ_V_TEMPLATE-USMD_MODEL =
YZTABLE_TEMPLATE-USMD_MODEL .
YZ_V_TEMPLATE-SCOPE_ID =
YZTABLE_TEMPLATE-SCOPE_ID .
YZ_V_TEMPLATE-TEMPLATE_ID =
YZTABLE_TEMPLATE-TEMPLATE_ID .
YZ_V_TEMPLATE-LANGU =
YZTABLE_TEMPLATE-LANGU .
YZ_V_TEMPLATE-DESCRIPTION =
YZTABLE_TEMPLATE-DESCRIPTION .
YZ_V_TEMPLATE-USMD_OBJSTAT =
YZTABLE_TEMPLATE-USMD_OBJSTAT .
YZ_V_TEMPLATE-USMD_ACTIVE =
YZTABLE_TEMPLATE-USMD_ACTIVE .
<VIM_TOTAL_STRUC> = YZ_V_TEMPLATE.
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
FORM DB_UPD_YZ_V_TEMPLATE .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO YZ_V_TEMPLATE.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_YZ_V_TEMPLATE-ST_DELETE EQ GELOESCHT.
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
  SELECT SINGLE FOR UPDATE * FROM YZTABLE_TEMPLATE WHERE
  USMD_MODEL = YZ_V_TEMPLATE-USMD_MODEL AND
  SCOPE_ID = YZ_V_TEMPLATE-SCOPE_ID AND
  TEMPLATE_ID = YZ_V_TEMPLATE-TEMPLATE_ID .
    IF SY-SUBRC = 0.
    DELETE YZTABLE_TEMPLATE .
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
  SELECT SINGLE FOR UPDATE * FROM YZTABLE_TEMPLATE WHERE
  USMD_MODEL = YZ_V_TEMPLATE-USMD_MODEL AND
  SCOPE_ID = YZ_V_TEMPLATE-SCOPE_ID AND
  TEMPLATE_ID = YZ_V_TEMPLATE-TEMPLATE_ID .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR YZTABLE_TEMPLATE.
    ENDIF.
YZTABLE_TEMPLATE-MANDT =
YZ_V_TEMPLATE-MANDT .
YZTABLE_TEMPLATE-USMD_MODEL =
YZ_V_TEMPLATE-USMD_MODEL .
YZTABLE_TEMPLATE-SCOPE_ID =
YZ_V_TEMPLATE-SCOPE_ID .
YZTABLE_TEMPLATE-TEMPLATE_ID =
YZ_V_TEMPLATE-TEMPLATE_ID .
YZTABLE_TEMPLATE-LANGU =
YZ_V_TEMPLATE-LANGU .
YZTABLE_TEMPLATE-DESCRIPTION =
YZ_V_TEMPLATE-DESCRIPTION .
YZTABLE_TEMPLATE-USMD_OBJSTAT =
YZ_V_TEMPLATE-USMD_OBJSTAT .
YZTABLE_TEMPLATE-USMD_ACTIVE =
YZ_V_TEMPLATE-USMD_ACTIVE .
    IF SY-SUBRC = 0.
    UPDATE YZTABLE_TEMPLATE ##WARN_OK.
    ELSE.
    INSERT YZTABLE_TEMPLATE .
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
CLEAR: STATUS_YZ_V_TEMPLATE-UPD_FLAG,
STATUS_YZ_V_TEMPLATE-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_YZ_V_TEMPLATE.
  SELECT SINGLE * FROM YZTABLE_TEMPLATE WHERE
USMD_MODEL = YZ_V_TEMPLATE-USMD_MODEL AND
SCOPE_ID = YZ_V_TEMPLATE-SCOPE_ID AND
TEMPLATE_ID = YZ_V_TEMPLATE-TEMPLATE_ID .
YZ_V_TEMPLATE-MANDT =
YZTABLE_TEMPLATE-MANDT .
YZ_V_TEMPLATE-USMD_MODEL =
YZTABLE_TEMPLATE-USMD_MODEL .
YZ_V_TEMPLATE-SCOPE_ID =
YZTABLE_TEMPLATE-SCOPE_ID .
YZ_V_TEMPLATE-TEMPLATE_ID =
YZTABLE_TEMPLATE-TEMPLATE_ID .
YZ_V_TEMPLATE-LANGU =
YZTABLE_TEMPLATE-LANGU .
YZ_V_TEMPLATE-DESCRIPTION =
YZTABLE_TEMPLATE-DESCRIPTION .
YZ_V_TEMPLATE-USMD_OBJSTAT =
YZTABLE_TEMPLATE-USMD_OBJSTAT .
YZ_V_TEMPLATE-USMD_ACTIVE =
YZTABLE_TEMPLATE-USMD_ACTIVE .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_YZ_V_TEMPLATE USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE YZ_V_TEMPLATE-USMD_MODEL TO
YZTABLE_TEMPLATE-USMD_MODEL .
MOVE YZ_V_TEMPLATE-SCOPE_ID TO
YZTABLE_TEMPLATE-SCOPE_ID .
MOVE YZ_V_TEMPLATE-TEMPLATE_ID TO
YZTABLE_TEMPLATE-TEMPLATE_ID .
MOVE YZ_V_TEMPLATE-MANDT TO
YZTABLE_TEMPLATE-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'YZTABLE_TEMPLATE'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN YZTABLE_TEMPLATE TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'YZTABLE_TEMPLATE'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*

* base table related FORM-routines.............
INCLUDE LSVIMFTX .
