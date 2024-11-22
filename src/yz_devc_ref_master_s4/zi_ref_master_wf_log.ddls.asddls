@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for RM Worfklow Log'
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity ZI_REF_MASTER_WF_LOG as select from ZV_REF_MASTER_WF_LOG as _wfLog
association to parent ZI_REF_MASTER_HEAD as _header on  $projection.Req_Guid = _header.Req_Guid
                {
    key  Req_Guid,
    key _wfLog.Workitem_Id,
   _wfLog.Req_Id,
    //key 
    _wfLog.Log_Date,
    _wfLog.Log_Time,
    _wfLog.Step,
    _wfLog.Responsible_Person_Id,
     _wfLog.Responsible_Name as Responsible_Person_Name,
    _wfLog.Status,
    _wfLog.Action_Taken,
    _header // Make association public
}
