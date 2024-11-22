@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Model Attributes Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZC_USMD_MDL_ATTRIB
  as select distinct from yztabl_ref_data as metadata
    left outer join       usmd001t        as _modelText   on  metadata.model   = _modelText.usmd_model
                                                          and _modelText.langu = $session.system_language
    left outer join       usmd0050        as _BoType      on  metadata.model  = _BoType.usmd_model
                                                          and metadata.entity = _BoType.usmd_entity
    left outer join       usmd0020t       as _entityText  on  metadata.model    = _entityText.usmd_model
                                                          and metadata.entity   = _entityText.usmd_entity
                                                          and _entityText.langu = $session.system_language
    left outer join       usmd0022t       as _attribText  on  metadata.model     = _attribText.usmd_model
                                                          and metadata.entity    = _attribText.usmd_entity
                                                          and metadata.attribute = _attribText.usmd_attribute
                                                          and _attribText.langu  = $session.system_language
    left outer join       dd02t           as _tableNames  on  metadata.tabname       = _tableNames.tabname
                                                          and _tableNames.ddlanguage = $session.system_language
    left outer join       dd03l           as _tableFields on  metadata.tabname   = _tableFields.tabname
                                                          and metadata.fieldname = _tableFields.fieldname
    left outer join       dd04t           as _fieldDescr  on  _tableFields.rollname  = _fieldDescr.rollname
                                                          and _fieldDescr.ddlanguage = $session.system_language
{
  key metadata.model          as Model,
  key metadata.entity         as Entity,
  key metadata.attribute      as Attribute,
      metadata.tabname        as TableName,
      metadata.fieldname      as FieldName,
      metadata.cds_view       as CDSView,
      _BoType.usmd_otc        as BoType,
      _modelText.txtmi        as ModelText,
      _modelText.usmd_objstat as Status,
      _entityText.txtlg       as EntityText,
      case when _attribText.txtlg != ''
      then _attribText.txtlg
      else _fieldDescr.ddtext
      end                     as AttributeText,
      _tableNames.ddtext      as TableDescription,
      _fieldDescr.ddtext      as FieldDescription
}
