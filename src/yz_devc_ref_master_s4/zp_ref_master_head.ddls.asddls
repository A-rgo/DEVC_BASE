@EndUserText.label: 'Projection View for ZI_REF_MASTER_HEAD'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI:{ headerInfo: {
    typeName: 'Change Request',
    typeNamePlural: 'Change Requests',
    title: {
        type: #STANDARD,
        value: 'Req_Id'
    }
} }
@Search.searchable: true
define root view entity ZP_REF_MASTER_HEAD
  as projection on ZI_REF_MASTER_HEAD
{
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Request GUID'
  key     Req_Guid,
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Object ID'
          Object_Id,
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Request ID'
          Req_Id,
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Change Request Type'
          @ObjectModel.text.element: ['Change_Req_Type_Desc']
          Change_Req_Type,
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Change Request Type'
          Change_Req_Type_Desc,
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Business Domain'
          @ObjectModel.text.element: ['Obj_Class_Descr']
          Object_Class,
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Business Domain'
          Obj_Class_Descr,
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Object Description'
          Object_Descr,
          @Search.defaultSearchElement: true
          @EndUserText.label: 'Parent Object'
          Parent_Object_Id,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_REF_MASTER_TAB_DISPLAY'
  virtual UICT_REQITEM_IS  : abap_boolean,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_REF_MASTER_TAB_DISPLAY'
  virtual UICT_APPROVER_IS : abap_boolean,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_REF_MASTER_TAB_DISPLAY'
  virtual UICT_WFLOG_IS    : abap_boolean,

          @UI.hidden: true
          /* Associations */
          @Search.defaultSearchElement: true
          _item : redirected to composition child ZP_REF_MASTER_ITM,
          _approver : redirected to composition child ZP_REF_MASTER_REQ_APPR,
      _wfLog : redirected to composition child ZP_REF_MASTER_WF_LOG
          
}
