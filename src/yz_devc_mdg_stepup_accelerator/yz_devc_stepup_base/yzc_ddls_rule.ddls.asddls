@EndUserText.label: 'Rule CDS View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity YZC_DDLS_RULE
  as select from yzi_ddls_rule_val as val
  association to yzi_ddls_rule_exe as exe on  exe.model     = val.model
                                          and exe.otc       = val.otc
                                          and exe.rule_type = val.rule_type
                                          and exe.def_id    = val.def_id
                                          and exe.exe_id    = val.exe_id
                                          and exe.rule_sec  = val.rule_sec

  association to YZI_DDLS_rule_def as def on  def.model     = val.model
                                          and def.otc       = val.otc
                                          and def.def_id    = val.def_id
                                          and def.rule_type = val.rule_type

  association to YZI_DDLS_rule_dom as dom on  dom.model     = val.model
                                          and dom.otc       = val.otc
{

  key val.model,
  key val.otc,
  key val.rule_type,
  key val.def_id,
  key val.exe_id,
  key val.val_id,
  key val.rule_sec,
      exe.seq_no,
      exe.temp_id,
      exe.task,
      exe.operation,
      exe.entity,
      exe.attribute,
      val.sign,
      val.opt,
      val.val_type,
      val.low,
      val.high,
      exe.exe_type,
      exe.operator,
      exe.class,
      exe.method,
      def.rule_def,
      def.reuse_scp,
      def.refruleid,
      def.rule_sta,
      def.rule_own,
      def.rule_exp,
      dom.active,
      def.active as def_active,
      exe.active as exe_active,
      val.active as val_active
      
}
