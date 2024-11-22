@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Change Request Type CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZ_DDLS_CREQ_TYPE
  as select from usmd0080 as entcrtyp

  association to usmd110c as crtyp on crtyp.usmd_creq_type = entcrtyp.usmd_creq_type
{
  key entcrtyp.usmd_creq_type as cr_type,
  key entcrtyp.usmd_wfs       as cr_step,
  key entcrtyp.usmd_entity    as entity,
      crtyp.usmd_entity_main  as mainentity

}
