@AbapCatalog.sqlViewName: 'YBUSMD1213EMAIL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View for Email Notification'
define view YB_USMD1213_EMAIL
  as select from usmd1213
{
  key  usmd_crequest as crnumber,
  key  usmd_entity_obj as object,
       usmd_value as value
}
