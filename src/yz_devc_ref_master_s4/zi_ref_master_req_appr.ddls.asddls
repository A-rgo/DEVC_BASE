@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Reference Master Request Approver'
define view entity ZI_REF_MASTER_REQ_APPR
  as select from ZV_REF_MASTER_REQ_APPROVERS as _approver
  association to parent ZI_REF_MASTER_HEAD as _header on $projection.Req_Guid = _header.Req_Guid
{

  key ReqGuid                      as Req_Guid,
  key Approver                     as Approver,
      ReqId                        as Req_Id,
      ObjectClass                  as Object_Class,
      _header.Change_Req_Type      as Change_Req_Type,
      _header.Change_Req_Type_Desc as Change_Req_Type_Descr,
      name_text                    as Name,
      _header
}
