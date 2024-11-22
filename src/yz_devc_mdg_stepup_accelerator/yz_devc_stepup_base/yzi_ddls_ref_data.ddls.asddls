@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reference Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZI_DDLS_REF_DATA
  as select from yztabl_ref_data
{
  key model     as model,
  key otc       as otc,
  key entity    as entity,
  key attribute as Attribute,
      ent_text  as ent_text,
      att_text  as att_text,
      tabname   as tabname,
      fieldname as fieldname,
      cds_view  as cds_view,
      cds_field as cds_field
}
