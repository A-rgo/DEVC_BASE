@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for ZREF_MASTER_HEAD'
define root view entity ZI_REF_MASTER_HEAD as select distinct from zref_master_head as header
composition [1..*] of ZI_REF_MASTER_ITM as _item 
  composition [1..*] of ZI_REF_MASTER_REQ_APPR  as _approver
  composition [1..*] of ZI_REF_MASTER_WF_LOG    as _wfLog
  association [1..1] to ZC_OBJCLASS_TEXT        as _objclstext on $projection.Object_Class = _objclstext.Object_Class
  association [1..1] to ZC_CHANGE_REQ_TYPE_TEXT as _reqtext    on $projection.Change_Req_Type = _reqtext.Change_Req_Type
{
    key header.req_guid as Req_Guid,
    header.object_id as Object_Id,
    header.req_id as Req_Id,
    @ObjectModel.text.element: ['Change_Req_Type_Desc']
    header.change_req_type as Change_Req_Type,
    _reqtext.Text         as Change_Req_Type_Desc,
    @ObjectModel.text.element: ['Obj_Class_Descr']
    header.object_class as Object_Class,
    _objclstext.Text      as Obj_Class_Descr,
    header.object_descr as Object_Descr,
    header.parent_object_id as Parent_Object_Id,
    local_last_changed_at,
    last_changed_at,
    
    _item, // Make association public
    _objclstext,
      _reqtext,
      _approver,
      _wfLog
    
}
