@EndUserText.label: 'Projection View for YZI_DDLS_RULE_DEF'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity YZP_DDLS_RULE_DEF
provider contract transactional_query
  as projection on YZI_DDLS_rule_def
{
@EndUserText.label: 'Model'
  key model,
  @EndUserText.label: 'OTC'
  key otc,
  @EndUserText.label: 'Rule Type'
  key rule_type,
  @EndUserText.label: 'Definition ID'
  key def_id,
  @EndUserText.label: 'Rule Definition'
      rule_def,
      @EndUserText.label: 'Template ID'
      temp_id,
      @EndUserText.label: 'Reuse SCP'
      reuse_scp,
      @EndUserText.label: 'Ref. Rule ID'
      refruleid,
      @EndUserText.label: 'Rule Sta'
      rule_sta,
      rule_own,
      rule_exp,
      //def_ref1,
      def_ref2,
      def_ref3,
      structure,
      valuepart1,
      valuepart2,
      valuepart3,
      valuepart4,
      active,
      local_last_changed_at,
      /* Associations */
      _execution : redirected to composition child YZP_DDLS_RULE_EXE
}
