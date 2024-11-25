*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZMREF_OBJ_CLASS.................................*
FORM GET_DATA_ZMREF_OBJ_CLASS.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZREF_OBJ_CLASS WHERE
(VIM_WHERETAB) .
    CLEAR ZMREF_OBJ_CLASS .
ZMREF_OBJ_CLASS-MANDT =
ZREF_OBJ_CLASS-MANDT .
ZMREF_OBJ_CLASS-OBJECT_CLASS =
ZREF_OBJ_CLASS-OBJECT_CLASS .
ZMREF_OBJ_CLASS-OBJECT_CLASS_DESC =
ZREF_OBJ_CLASS-OBJECT_CLASS_DESC .
ZMREF_OBJ_CLASS-HIERARCHY =
ZREF_OBJ_CLASS-HIERARCHY .
<VIM_TOTAL_STRUC> = ZMREF_OBJ_CLASS.
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
FORM DB_UPD_ZMREF_OBJ_CLASS .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZMREF_OBJ_CLASS.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZMREF_OBJ_CLASS-ST_DELETE EQ GELOESCHT.
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
  SELECT SINGLE FOR UPDATE * FROM ZREF_OBJ_CLASS WHERE
  OBJECT_CLASS = ZMREF_OBJ_CLASS-OBJECT_CLASS .
    IF SY-SUBRC = 0.
    DELETE ZREF_OBJ_CLASS .
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
  SELECT SINGLE FOR UPDATE * FROM ZREF_OBJ_CLASS WHERE
  OBJECT_CLASS = ZMREF_OBJ_CLASS-OBJECT_CLASS .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZREF_OBJ_CLASS.
    ENDIF.
ZREF_OBJ_CLASS-MANDT =
ZMREF_OBJ_CLASS-MANDT .
ZREF_OBJ_CLASS-OBJECT_CLASS =
ZMREF_OBJ_CLASS-OBJECT_CLASS .
ZREF_OBJ_CLASS-OBJECT_CLASS_DESC =
ZMREF_OBJ_CLASS-OBJECT_CLASS_DESC .
ZREF_OBJ_CLASS-HIERARCHY =
ZMREF_OBJ_CLASS-HIERARCHY .
    IF SY-SUBRC = 0.
    UPDATE ZREF_OBJ_CLASS ##WARN_OK.
    ELSE.
    INSERT ZREF_OBJ_CLASS .
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
CLEAR: STATUS_ZMREF_OBJ_CLASS-UPD_FLAG,
STATUS_ZMREF_OBJ_CLASS-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ZMREF_OBJ_CLASS.
  SELECT SINGLE * FROM ZREF_OBJ_CLASS WHERE
OBJECT_CLASS = ZMREF_OBJ_CLASS-OBJECT_CLASS .
ZMREF_OBJ_CLASS-MANDT =
ZREF_OBJ_CLASS-MANDT .
ZMREF_OBJ_CLASS-OBJECT_CLASS =
ZREF_OBJ_CLASS-OBJECT_CLASS .
ZMREF_OBJ_CLASS-OBJECT_CLASS_DESC =
ZREF_OBJ_CLASS-OBJECT_CLASS_DESC .
ZMREF_OBJ_CLASS-HIERARCHY =
ZREF_OBJ_CLASS-HIERARCHY .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZMREF_OBJ_CLASS USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZMREF_OBJ_CLASS-OBJECT_CLASS TO
ZREF_OBJ_CLASS-OBJECT_CLASS .
MOVE ZMREF_OBJ_CLASS-MANDT TO
ZREF_OBJ_CLASS-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZREF_OBJ_CLASS'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZREF_OBJ_CLASS TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZREF_OBJ_CLASS'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
