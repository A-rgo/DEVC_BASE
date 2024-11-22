@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for Value types'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZC_DDLS_VAL_TYPE as select from YZC_USMD_MDL_ATTRIB as model_attr
{ 

concat(model_attr.Entity,concat('-',model_attr.Attribute))as selection, 

model_attr.AttributeText as SelectionText 


} union all select from YZC_USMD_MDL_ATTRIB as table_field 

{ 
 concat(table_field.TableName,concat('-',table_field.FieldName)) as Selection, 
 table_field.FieldDescription as SelectionText } where Status='A' 

union all select from dd07t as domain
{ 
  domvalue_l as selection, 
  ddtext as SelectionText } where ddlanguage=$session.system_language and domname='USMD_FLD_PROP_VALUE' 
