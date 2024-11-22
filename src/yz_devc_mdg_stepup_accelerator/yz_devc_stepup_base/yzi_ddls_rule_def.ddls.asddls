@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rule Definition CDS VIew'
define root view entity YZI_DDLS_rule_def
  as select from yztabl_rule_def as _defination
  composition [1..*] of yzi_ddls_rule_exe as _execution
{
  key model                 as model,
  key otc                   as otc,
  key rule_type             as rule_type,
  key def_id                as def_id,
      rule_def              as rule_def,
      temp_id               as temp_id,
      reuse_scp             as reuse_scp,
      refruleid             as refruleid,
      rule_sta              as rule_sta,
      rule_own              as rule_own,
      rule_exp              as rule_exp,
     // def_ref1              as def_ref1,
      def_ref2              as def_ref2,
      def_ref3              as def_ref3,
      structure             as structure,
      valuepart1            as valuepart1,
      valuepart2            as valuepart2,
      valuepart3            as valuepart3,
      valuepart4            as valuepart4,
      active                as active,
      local_last_changed_at as local_last_changed_at,
      _execution
      
}
