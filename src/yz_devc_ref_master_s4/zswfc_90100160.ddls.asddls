@AbapCatalog.sqlViewName: 'ZSWF90100160'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@EndUserText.label: 'Generated: Flex Workflow CDS for scenario WS90100160'
@ObjectModel: {
  usageType.serviceQuality: #X,
  usageType.sizeCategory: #S,
  usageType.dataClass: #MASTER
}
@ClientHandling.algorithm: #SESSION_VARIABLE
define view ZSWFC_90100160
with parameters wf_id:sww_wiid
as select from ZSWFM_90100160(wf_id:$parameters.wf_id) as MetaData


{
  key MetaData.WorkflowId
  , MetaData._WF_INITIATOR AS S___WF_INITIATOR
  , MetaData._WF_PRIORITY AS S___WF_PRIORITY
  , MetaData._WF_VERSION AS S___WF_VERSION
  , MetaData.REQ_DATA AS REQ_DATA
  , MetaData.EV_USER AS EV_USER
  , MetaData.CUSTOMER AS CUSTOMER
  , MetaData.CUSTOMER001 AS CUSTOMER001
  , MetaData.SALES_COND AS SALES_COND
  , MetaData.SALES_COND001 AS SALES_COND001
  , MetaData.SALES_ORG AS SALES_ORG
  , MetaData.SALES_ORG001 AS SALES_ORG001
  , MetaData.DIST_CHA AS DIST_CHA
  , MetaData.DIST_CHA001 AS DIST_CHA001
  , MetaData.IV_OBJ_CLASS AS IV_OBJ_CLASS
  , MetaData.IV_CHANGE_REQ_TYPE AS IV_CHANGE_REQ_TYPE
}
where MetaData.WorkflowId = $parameters.wf_id;
