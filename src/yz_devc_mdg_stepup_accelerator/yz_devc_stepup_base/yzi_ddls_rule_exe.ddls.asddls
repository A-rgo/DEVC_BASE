@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rule Execution CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity yzi_ddls_rule_exe
  as select from yztabl_rule_exe as _execution
  composition [1..*] of yzi_ddls_rule_val as _value
  association to parent YZI_DDLS_rule_def as _definition on $projection.model = _definition.model and
                                                            $projection.otc = _definition.otc and
                                                            $projection.rule_type = _definition.rule_type and 
                                                            $projection.def_id = _definition.def_id
{
  key model                 as model,
  key otc                   as otc,
  key rule_type             as rule_type,
  key def_id                as def_id,
  key exe_id                as exe_id,
  key rule_sec              as rule_sec,
      seq_no                as seq_no,
      temp_id               as temp_id,
      task                  as task,
      operation             as operation,
      entity                as entity,
      attribute             as attribute,
      exe_type              as exe_type,
      value_id              as value_id,
      operator              as operator,
      class                 as class,
      method                as method,
      exe_ref1              as exe_ref1,
      exe_ref2              as exe_ref2,
      exe_ref3              as exe_ref3,
      structure             as Structure,
      valuepart1            as valuepart1,
      valuepart2            as valuepart2,
      valuepart3            as valuepart3,
      valuepart4            as valuepart4,
      active                as active,
      local_last_changed_at as local_last_changed_at,
      _value,
      _definition
}
