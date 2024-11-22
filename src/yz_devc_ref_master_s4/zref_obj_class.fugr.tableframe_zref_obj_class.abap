*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZREF_OBJ_CLASS
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZREF_OBJ_CLASS     .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
