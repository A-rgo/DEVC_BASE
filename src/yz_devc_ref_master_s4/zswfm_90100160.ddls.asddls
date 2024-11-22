@ClientDependent: false
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@EndUserText.label: 'Generated: Flex Workflow CDS for scenario WS90100160'
define table function ZSWFM_90100160
with parameters wf_id:sww_wiid
returns {
  key WorkflowId : sww_wiid;
  _WF_INITIATOR : SWP_INITIA;
  _WF_PRIORITY : SWW_PRIO;
  _WF_VERSION : SWD_VERSIO;
  REQ_DATA : ZREFMASTER_HTML_STRING;
  EV_USER : XUBNAME;
  CUSTOMER : KUNNR_V;
  CUSTOMER001 : KUNNR_V;
  SALES_COND : KSCHL;
  SALES_COND001 : KSCHL;
  SALES_ORG : VKORG;
  SALES_ORG001 : VKORG;
  DIST_CHA : VTWEG;
  DIST_CHA001 : VTWEG;
  IV_OBJ_CLASS : ZDE_REF_MASTER_OBJ_CLASS;
  IV_CHANGE_REQ_TYPE : ZDE_REF_MASTER_CHNG_REQ_TYPE;

}
implemented by method ZCL_SWF_90100160=>read_meta;
