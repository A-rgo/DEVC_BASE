@AbapCatalog.sqlViewName: 'ZCRMPARENTCHILD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reference Master Hierarchy'
@VDM.viewType: #BASIC
@Analytics.dataCategory: #DIMENSION
define view ZC_RM_PARENT_CHILD as select from zref_master_head
    association[1..1] to ZC_RM_PARENT_CHILD as _parent on $projection.Parent_Object_Id = _parent.Object_Id {
    key zref_master_head.object_id as Object_Id,
    parent_object_id as Parent_Object_Id,
    _parent
}
