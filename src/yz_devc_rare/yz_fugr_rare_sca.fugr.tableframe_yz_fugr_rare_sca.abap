*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_YZ_FUGR_RARE_SCA
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_YZ_FUGR_RARE_SCA   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
