@ClientDependent: false
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@EndUserText.label: 'Generated: Flex Workflow CDS for scenario WS90100171'
define table function ZSWFM_90100171
with parameters wf_id:sww_wiid
returns {
  key WorkflowId : sww_wiid;
  _WF_INITIATOR : SWP_INITIA;
  _WF_PRIORITY : SWW_PRIO;
  _WF_VERSION : SWD_VERSIO;

}
implemented by method ZCL_SWF_90100171=>read_meta;
