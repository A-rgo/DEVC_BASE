FUNCTION YZ_FUNC_TEMP_UPDATE.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_RULE_TMP_DATA) TYPE  YZR_TT_RULE_TMP
*"     VALUE(IT_RULE_IMP_DATA) TYPE  YZR_TT_RULE_IMP
*"----------------------------------------------------------------------

  CHECK it_rule_tmp_data IS NOT INITIAL.

  IF it_rule_tmp_data IS NOT INITIAL.
    MODIFY yztabl_rule_tmp FROM TABLE it_rule_tmp_data.
    IF sy-subrc NE 0.
      RETURN.
    ENDIF.
  ENDIF.

  IF it_rule_imp_data IS NOT INITIAL.
    MODIFY yztabl_temp_itm FROM TABLE it_rule_imp_data.
  ENDIF.

ENDFUNCTION.
