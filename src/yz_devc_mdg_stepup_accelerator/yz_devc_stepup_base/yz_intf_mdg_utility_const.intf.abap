interface YZ_INTF_MDG_UTILITY_CONST
  public .


  interfaces IF_DRF_CONST .
  interfaces IF_EHFND_UI_CONSTANTS_C .
  interfaces IF_FPM_CONSTANTS .
  interfaces IF_MDG_CONSTANTS .
  interfaces IF_MDG_IDSC_CONST .
  interfaces IF_MDG_OTC_CONST .
  interfaces IF_USMD_CR_CONSTANTS .
  interfaces IF_USMD_SEARCH_CONSTANTS .
  interfaces IF_XO_CONST_MESSAGE .
  interfaces YZ_INTF_MDG_CONST .
  interfaces YZ_INTF_MDG_CONST_EXT .

  constants GC_READMODE_ACT_INACT type USMD_READMODE value '2' ##NO_TEXT.
  constants GC_READMODE_ACT_ONLY type USMD_READMODE value '3' ##NO_TEXT.
  constants GC_READMODE_INACT_ONLY type USMD_READMODE value '4' ##NO_TEXT.
  constants GC_ERROR type YZ_DTEL_STATUS value 'E' ##NO_TEXT.
  constants GC_PASS type YZ_DTEL_STATUS value 'P' ##NO_TEXT.
  constants GC_FAIL type YZ_DTEL_STATUS value 'F' ##NO_TEXT.
  constants GC_EXECUTION_VD type YZ_DTEL_EXECUTE_TYPE value 'VD' ##NO_TEXT.
  constants GC_EXECUTION_DR type YZ_DTEL_EXECUTE_TYPE value 'DR' ##NO_TEXT.
  constants GC_EXECUTION_BR type YZ_DTEL_EXECUTE_TYPE value 'BR' ##NO_TEXT.
  constants GC_EXECUTION_CM type YZ_DTEL_EXECUTE_TYPE value 'CM' ##NO_TEXT.
  constants GC_EXECUTION_CD type YZ_DTEL_EXECUTE_TYPE value 'CD' ##NO_TEXT.
  constants GC_EXECUTION_HU type YZ_DTEL_EXECUTE_TYPE value 'HU' ##NO_TEXT.
  constants GC_EXECUTION_FP type YZ_DTEL_EXECUTE_TYPE value 'FP' ##NO_TEXT.
  constants GC_FRAME_DERIVE type CHAR15 value 'DERIVE' ##NO_TEXT.
  constants GC_FRAME_FLD_PROP type CHAR15 value 'FLD_PROP' ##NO_TEXT.
  constants GC_FRAME_HIDE_UIBB type CHAR15 value 'HIDE_UIBB' ##NO_TEXT.
  constants GC_FRAME_VALIDATE type CHAR15 value 'VALIDATE' ##NO_TEXT.
  constants GC_MASS type STRING value 'MASS' ##NO_TEXT.
  constants GC_MODEL type USMD_MODEL value 'BP' ##NO_TEXT.
  constants GC_PROCESS_TYPE_DERIVE type YZ_DTEL_PROCESS value 'DR' ##NO_TEXT.
  constants GC_PROCESS_TYPE_FIELD_PROPRTY type YZ_DTEL_PROCESS value 'FP' ##NO_TEXT.
  constants GC_PROCESS_TYPE_HIDE_UIBB type YZ_DTEL_PROCESS value 'HU' ##NO_TEXT.
  constants GC_PROCESS_TYPE_UNIQUE type YZ_DTEL_PROCESS value 'UC' ##NO_TEXT.
  constants GC_PROCESS_TYPE_CDB type YZ_DTEL_PROCESS value 'CD' ##NO_TEXT.
  constants GC_PROCESS_TYPE_VALIDATE type YZ_DTEL_PROCESS value 'VD' ##NO_TEXT.
  constants GC_RULE_CONTEXT_CR type YZ_DTEL_CONTEXT value 'CR' ##NO_TEXT.
  constants GC_RULE_STAT_TABNAME type STRING value 'YZTABL_CUSTOM_SLG1_STR' ##NO_TEXT.
  constants GC_MSG_CLAS_NAME type STRING value 'YZMSG_MDG_ACC' ##NO_TEXT.
  constants GC_MSG_TYPE_I type CHAR1 value 'I' ##NO_TEXT.
  constants GC_MSG_TYPE_E type CHAR1 value 'E' ##NO_TEXT.
  constants GC_MSG_TYPE_W type CHAR1 value 'W' ##NO_TEXT.
  constants GC_PASS_TEXT type STRING value 'Pass' ##NO_TEXT.
  constants GC_ERROR_TEXT type STRING value 'Error' ##NO_TEXT.
  constants GC_FAIL_TEXT type STRING value 'Fail' ##NO_TEXT.
  constants GC_NA_TEXT type STRING value 'NA' ##NO_TEXT.
  constants GC_NA type YZ_DTEL_STATUS value 'NA' ##NO_TEXT.
  constants GC_USAGE_MDF_CHECK type MDQ_RULE_USAGE value 'MDF_CHECK' ##NO_TEXT.
  constants GC_BOOL type IF_FDT_TYPES=>NAME value 'BOOLE' ##NO_TEXT.
  constants GC_LEFT_OUTER type CHAR20 value 'LEFT OUTER' ##NO_TEXT.
  constants GC_RIGHT_OUTER type CHAR20 value 'RIGHT OUTER' ##NO_TEXT.
  constants GC_MM_MODEL type USMD_MODEL value 'MM' ##NO_TEXT.
  constants GC_0G_MODEL type USMD_MODEL value '0G' ##NO_TEXT.
  constants GC_SPT_APPROVER type STRING value 'ST' ##NO_TEXT.
endinterface.
