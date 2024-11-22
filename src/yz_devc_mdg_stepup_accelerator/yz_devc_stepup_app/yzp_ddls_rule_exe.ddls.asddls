@EndUserText.label: 'Projection View for YZI_DDLS_RULE_EXE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity YZP_DDLS_RULE_EXE as projection on yzi_ddls_rule_exe {
    key model,
    key otc,
    key rule_type,
    key def_id,
    key exe_id,
    key rule_sec,
    seq_no,
    temp_id,
    task,
    operation,
    entity,
    attribute,
    exe_type,
    value_id,
    operator,
    class,
    method,
    exe_ref1,
    exe_ref2,
    exe_ref3,
    Structure,
    valuepart1,
    valuepart2,
    valuepart3,
    valuepart4,
    active,
    local_last_changed_at,
    /* Associations */
    _definition: redirected to parent YZP_DDLS_RULE_DEF,
    _value : redirected to composition child yzp_ddls_rule_val
}
