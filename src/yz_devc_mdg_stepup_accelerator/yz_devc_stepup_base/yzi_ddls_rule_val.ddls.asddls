@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rule Value CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity yzi_ddls_rule_val
  as select from yztabl_rule_val as _value
  association     to parent yzi_ddls_rule_exe as _execution  on  $projection.model     = _execution.model
                                                             and $projection.otc       = _execution.otc
                                                             and $projection.rule_type = _execution.rule_type
                                                             and $projection.def_id    = _execution.def_id
                                                             and $projection.exe_id    = _execution.exe_id
                                                             and $projection.rule_sec  = _execution.rule_sec
  association [1] to YZI_DDLS_rule_def        as _definition on  $projection.model     = _definition.model
                                                             and $projection.otc       = _definition.otc
                                                             and $projection.rule_type = _definition.rule_type
                                                             and $projection.def_id    = _definition.def_id

{
  key model                 as model,
  key otc                   as otc,
  key rule_type             as rule_type,
  key def_id                as def_id,
  key exe_id                as exe_id,
  key rule_sec              as rule_sec,
  key val_id                as val_id,
      sign                  as sign,
      opt                   as opt,
      val_type              as val_type,
      low                   as low,
      high                  as high,
      val_ref1              as val_ref1,
      val_ref2              as val_ref2,
      val_ref3              as val_ref3,
      structure             as structure,
      valuepart1            as valuepart1,
      valuepart2            as valuepart2,
      valuepart3            as valuepart3,
      valuepart4            as valuepart4,
      active                as active,
      local_last_changed_at as local_last_changed_at,
      _execution,
      _definition
}
