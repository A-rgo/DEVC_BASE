@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rule Domain CDS view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZI_DDLS_rule_dom
  as select from yztabl_rule_dom
{
  key model                 as model,
  key otc                   as otc,
      app_log               as app_log,
      br_log                as br_log,
      active                as active,
      local_last_changed_at as local_last_changed_at
}
