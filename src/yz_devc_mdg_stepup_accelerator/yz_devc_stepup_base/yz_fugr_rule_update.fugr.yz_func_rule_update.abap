FUNCTION yz_func_rule_update.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_RULE_DEF_DATA) TYPE  YZR_TT_RULE_DEF
*"     VALUE(IT_RULE_EXE_DATA) TYPE  YZR_TT_RULE_EXE
*"     VALUE(IT_RULE_VAL_DATA) TYPE  YZR_TT_RULE_VAL
*"     VALUE(IT_RULE_EXE_DEL_DATA) TYPE  YZR_TT_RULE_EXE
*"     VALUE(IT_RULE_VAL_DEL_DATA) TYPE  YZR_TT_RULE_VAL
*"----------------------------------------------------------------------


  IF it_rule_def_data IS NOT INITIAL.
    MODIFY yztabl_rule_def FROM TABLE it_rule_def_data.
    IF sy-subrc NE 0.
      RETURN.
    ENDIF.
  ENDIF.

  IF it_rule_exe_data IS NOT INITIAL.
    MODIFY yztabl_rule_exe FROM TABLE it_rule_exe_data.
  ENDIF.

  IF it_rule_val_data IS NOT INITIAL.
    MODIFY yztabl_rule_val FROM TABLE it_rule_val_data.
  ENDIF.

  IF it_rule_exe_del_data IS NOT INITIAL.
    DELETE yztabl_rule_exe FROM TABLE it_rule_exe_del_data.
  ENDIF.

  IF it_rule_val_del_data IS NOT INITIAL.
    DELETE yztabl_rule_val FROM TABLE it_rule_val_del_data.
  ENDIF.


ENDFUNCTION.
