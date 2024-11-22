@AbapCatalog.sqlViewName: 'ZCDD04T'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Text View for Data Elements'
@ObjectModel.dataCategory: #TEXT
define view ZC_DD04T as select from dd04t {
    @Semantics.language: true
    key ddlanguage as Language,
    key rollname as Field_Name,
    @Semantics.text: true
    ddtext as Field_Descr
    
}
