*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZREF_REQ_METDATA
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZREF_REQ_METDATA   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
