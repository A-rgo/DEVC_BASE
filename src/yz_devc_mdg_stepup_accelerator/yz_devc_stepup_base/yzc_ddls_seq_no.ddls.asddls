@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Seq Number View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZC_DDLS_SEQ_NO
  as select from dd07t as domain
  association to yztabl_rule_sec as sec on sec.rule_sec is not initial
{
  key sec.rule_sec  as rule_sec,
  key sec.sec_desc  as sec_desc,
  key domvalue_l    as seq_no,
      domain.ddtext as seq_desc,
      case
         when ( sec.rule_sec = '1' and substring( domain.domvalue_l , 1 , 2 ) = '1U' )
           or ( sec.rule_sec = '2' and substring( domain.domvalue_l , 1 , 2 ) = '2S' )
           or ( sec.rule_sec = '3' and substring( domain.domvalue_l , 1 , 2 ) = '3C' )
         then 'X'
      else
         ' '
      end           as filter
}
where
      domain.domname    = 'YZ_DOMA_SEQ_NO'
  and domain.ddlanguage = 'E'
  and domain.as4local   = 'A'
  and domain.valpos     is not initial
  and domain.as4vers    is initial
  and domain.domvalue_l is not initial
