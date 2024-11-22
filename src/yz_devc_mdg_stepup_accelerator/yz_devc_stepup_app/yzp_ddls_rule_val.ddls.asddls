@EndUserText.label: 'Projection View for YZI_DDLS_RULE_VAL'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity YZP_DDLS_RULE_VAL
  as projection on yzi_ddls_rule_val
{
  key model,
  key otc,
  key rule_type,
  key def_id,
  key exe_id,
  key rule_sec,
  key val_id,
      sign,
      opt,
      val_type,
      low,
      high,
      val_ref1,
      val_ref2,
      val_ref3,
      structure,
      valuepart1,
      valuepart2,
      valuepart3,
      valuepart4,
      active,
      local_last_changed_at,
      /* Associations */
      _definition : redirected to YZP_DDLS_RULE_DEF,
      _execution  : redirected to parent YZP_DDLS_RULE_EXE
}
