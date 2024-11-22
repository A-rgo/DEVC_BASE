*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_YZFUGR_RARE_LCTN
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_YZFUGR_RARE_LCTN   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
