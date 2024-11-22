@AbapCatalog.sqlViewName: 'ZCOBJCLASSTEXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Object Class Text'
//@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'Object_Class'
define view ZC_OBJCLASS_TEXT as select distinct from zref_obj_class {
    @UI: [{ lineItem: [{ position: 10 }], identification: [{ position:  10 }] }]
    key object_class as Object_Class,
    @Semantics.text: true
    @UI: [{ lineItem: [{ position: 20 }], identification: [{ position:  20 }] }]
    object_class_desc  as Text //ddtext as Text
} //where domname = 'ZDE_REF_MASTER_OBJ_CLASS'
