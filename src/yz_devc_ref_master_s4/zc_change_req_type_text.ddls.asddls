@AbapCatalog.sqlViewName: 'ZCCHNGREQTYPETXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Domain Values & Text'
@ObjectModel.dataCategory: #TEXT
define view ZC_CHANGE_REQ_TYPE_TEXT as select from dd07t {
    //key domname as Domain_Name,
    key domvalue_l as Change_Req_Type,
    // ddlanguage as Language,
    ddtext as Text
} where domname = 'ZDE_REF_MASTER_CHNG_REQ_TYPE'
and ddlanguage = $session.system_language
