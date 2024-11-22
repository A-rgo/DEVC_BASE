@AbapCatalog.sqlViewName: 'YBEMAILNOTIF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Email Notification'
define view YB_EMAIL_NOTIFICATION as select from usmd1213 as _crobjects
inner join usmd120c as _crdetails on _crobjects.usmd_crequest = _crdetails.usmd_crequest
{
  key  _crobjects.usmd_crequest as crnumber,
    _crobjects.usmd_value as value,
    _crdetails.usmd_creq_text as description,
    _crdetails.usmd_created_by as createdby
}
