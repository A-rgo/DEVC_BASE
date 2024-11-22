*&---------------------------------------------------------------------*
*& Report YZ_REP_RULES_STATUS_LOG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT yz_rep_rules_status_log.
CALL FUNCTION 'RS_TOOL_ACCESS'
  EXPORTING
    operation   = 'TAB_CONT'
    object_name = 'YZTABL_RULE_STA'
    object_type = 'TABL'.
