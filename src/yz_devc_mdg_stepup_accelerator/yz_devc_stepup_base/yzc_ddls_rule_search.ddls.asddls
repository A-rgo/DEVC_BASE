@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search View For Rule Application'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable : true
define view entity YZC_DDLS_RULE_SEARCH
  as select distinct from YZI_DDLS_rule_def
{
      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.9
  key model,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.9
  key otc,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.9
  key rule_type,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.9
  key def_id,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      rule_def,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      temp_id,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      reuse_scp,

      refruleid,

      //@Search.defaultSearchElement : true
      //@Search.ranking: #HIGH
      //@Search.fuzzinessThreshold : 0.9
      ///def_ref1,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      active                   as rule_active,
      local_last_changed_at,

      /* Associations */
      _execution.model         as model_e,
      _execution.otc           as otc_e,
      _execution.rule_type     as rule_type_e,
      _execution.def_id        as def_id_e,
      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.rule_sec,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.seq_no,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.temp_id       as exe_templ_id,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.task,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.operation,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.entity,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.attribute,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.exe_type,
      _execution.value_id,
      _execution.operator,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.class,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.7
      _execution.method,

      @Search.defaultSearchElement : true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold : 0.9
      _execution.active        as exe_active

//      _execution._value.val_id,
//
//      @Search.defaultSearchElement : true
//      @Search.ranking: #HIGH
//      @Search.fuzzinessThreshold : 0.9
//      _execution._value.sign,
//
//      @Search.defaultSearchElement : true
//      @Search.ranking: #HIGH
//      @Search.fuzzinessThreshold : 0.9
//      _execution._value.opt,
//
//      @Search.defaultSearchElement : true
//      @Search.ranking: #HIGH
//      @Search.fuzzinessThreshold : 0.9
//      _execution._value.val_type,
//
//      @Search.defaultSearchElement : true
//      @Search.ranking: #HIGH
//      @Search.fuzzinessThreshold : 0.7
//      _execution._value.low,
//
//      @Search.defaultSearchElement : true
//      @Search.ranking: #HIGH
//      @Search.fuzzinessThreshold : 0.7
//      _execution._value.high,
//      _execution._value.active as val_active
}
