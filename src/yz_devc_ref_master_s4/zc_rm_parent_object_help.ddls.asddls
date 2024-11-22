@AbapCatalog.sqlViewName: 'ZCRMPARENTHELP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View for RM Parent Object F4 Help'
define view ZC_RM_PARENT_OBJECT_HELP as select from zref_master_hry {
    key object_id as Object_Id
} union select from zref_master_subh {
    key object_id as Object_Id
}
