@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Model CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZ_DDLS_MODEL
 as select from usmd0050 as obj

  association to usmd001t      as dm  on  dm.langu        = $session.system_language
                                      and dm.usmd_model   = obj.usmd_model
                                      and dm.usmd_objstat = obj.usmd_objstat

  association to mdgi_otc_t_bs as typ on  typ.langu            = $session.system_language
                                      and typ.object_type_code = obj.usmd_otc

  association to usmd0020t     as txt on  txt.langu        = $session.system_language
                                      and txt.usmd_model   = obj.usmd_model
                                      and txt.usmd_entity  = obj.usmd_entity
                                      and txt.usmd_objstat = obj.usmd_objstat
{
  key usmd_model      as model,
  key usmd_otc        as otc,
  key usmd_entity     as RootEntity,
      dm.txtmi        as DataModelDescription,
      typ.description as ObjectTypeDescription,
      txt.txtlg       as EntityDescription


}
where
    usmd_objstat    = 'A'
and usmd_is_root_et = 'X'
