@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Attribute CS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZ_DDLS_ATTRIBUTE
  as select from usmd0022 as att
  association to usmd0022t      as txt  on  txt.langu          = $session.system_language
                                        and txt.usmd_model     = att.usmd_model
                                        and txt.usmd_entity    = att.usmd_entity
                                        and txt.usmd_attribute = att.usmd_attribute
                                        and txt.usmd_objstat   = att.usmd_objstat
  association to dd04t          as _04t on  _04t.rollname   = att.rollname
                                        and _04t.ddlanguage = $session.system_language
                                        and _04t.as4local   = att.usmd_objstat
                                        and _04t.as4vers    is initial
  association to mdghdb_pp_fmap as _pp  on  _pp.model           = att.usmd_model
                                        and _pp.entity          = att.usmd_entity
                                        and _pp.model_fieldname = att.usmd_attribute
{
  key usmd_model          as model,
  key usmd_entity         as entity,
  key usmd_attribute      as attribute,
      case when txt.txtlg is not initial
           then txt.txtlg
           else _04t.ddtext
       end                as AttributeDescription,
      _pp.reuse_table     as reusetable,
      _pp.reuse_fieldname as reusefield
}
where
  usmd_objstat = 'A'
