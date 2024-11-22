@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Model CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZ_DDLS_DATA_MODEL
  as select from YZ_DDLS_ATTRIBUTE as att

  association to YZ_DDLS_ENTITY as ent on  ent.Model  = att.model
                                       and ent.Entity = att.entity

  association to YZ_DDLS_MODEL  as mod on  mod.model = att.model
{
  key att.model,
  key mod.otc,
  key att.entity,
  key att.attribute,
      mod.DataModelDescription,
      mod.ObjectTypeDescription,
      ent.mainentity,
      ent.EntityDescription,
      AttributeDescription,
      reusetable,
      reusefield
}
