@AbapCatalog.sqlViewName: 'ZVRMREQAPPROVER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Request Approvers'
define view ZV_REF_MASTER_REQ_APPROVERS
  as select from    zref_master_head as _header
    left outer join zref_mster_agent as _approver on  _header.object_class    = _approver.object_class
                                                  and _approver.active        = 'X'
                                                  and _header.change_req_type = _approver.change_req_type
    left outer join v_usr_name       as _usrNames

                                                  on _approver.approver = _usrNames.bname
{   
    key _header.req_guid    as ReqGuid,
    key _header.req_id          as ReqId, 
    key _approver.approver      as Approver,
     _header.object_class    as ObjectClass,
      _header.change_req_type as ChangeReqType,
      _usrNames.name_text
}
