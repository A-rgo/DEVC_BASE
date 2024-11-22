@AbapCatalog.sqlViewName: 'ZVREFMASTERWFLOG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Workflow Log Reference Master'
define view ZV_REF_MASTER_WF_LOG
  as select from    sww_wi2obj as _wi2obj
    left outer join swpsteplog as _steplog on _wi2obj.wi_id = _steplog.wf_id
    left outer join swwwihead  as _header  on _steplog.wi_id = _header.wi_id
    left outer join v_usr_name as _usrNames on _header.wi_aagent = _usrNames.bname
                                            or _steplog.wi_agent = _usrNames.bname
    left outer join zref_master_head as _reqHead on _reqHead.req_id =  _wi2obj.instid
{
  _reqHead.req_guid as Req_Guid,
  _wi2obj.instid               as Req_Id,
  _steplog.wi_id               as Workitem_Id,
  _steplog.log_date            as Log_Date,
  _steplog.log_time            as Log_Time,
  _header.wi_text              as Step,
  case _steplog.wi_agent
    when '' then _header.wi_aagent
    else _steplog.wi_agent end as Responsible_Person_Id,
  _usrNames.name_text as Responsible_Name,
  case _header.wi_stat
    when 'STARTED' then 'Workflow Started'
    when 'READY' then 'Pending'
    when 'COMPLETED' then 'Completed'
    else _header.wi_stat end   as Status,
  case _steplog.flex_return_value
    when 'APPROVE' then 'Approved' when 'REJECT' then 'Rejected' else _steplog.flex_return_value end as Action_Taken
    

} where _steplog.task_id is not initial
