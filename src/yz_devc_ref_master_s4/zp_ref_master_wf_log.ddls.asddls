@EndUserText.label: 'Projection View for ZI_REF_MASTER_WF_LOG'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZP_REF_MASTER_WF_LOG
  as projection on ZI_REF_MASTER_WF_LOG
{
      @UI.facet: [{ purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, label:'Workflow Log', position:10}]
  key Req_Guid,

      @EndUserText.label: 'Workitem ID'
  key Workitem_Id,
      @EndUserText.label: 'Request Id'
      //    key
      Req_Id,
      //Req_Guid,
      @EndUserText.label: 'Log Date'
      Log_Date,
      @EndUserText.label: 'Log Time'
      Log_Time,
      @EndUserText.label: 'Step'
      Step,
      @EndUserText.label: 'Status'
      Status,
      @EndUserText.label: 'Responsible Person'
      @ObjectModel.text.element: ['Responsible_Person_Name']
      Responsible_Person_Id,
      Responsible_Person_Name,
      @EndUserText.label: 'Action Taken'
      Action_Taken,
      /* Associations */
      _header : redirected to parent ZP_REF_MASTER_HEAD

}
