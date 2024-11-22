@EndUserText.label: 'Projection View for ZI_REF_MASTER_ITM'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZP_REF_MASTER_REQ_APPR
  as projection on ZI_REF_MASTER_REQ_APPR
{
      @UI.facet: [{ purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, label:'Approvers', position:10}]

  key
      Req_Guid,
      @EndUserText.label: 'Approver'
      //@UI.hidden: true
      @Search.defaultSearchElement: true
      @UI:{ lineItem:[{ position: 20 }], identification: [{ position: 20 }]}
      @ObjectModel.text.element: ['Name']
  key Approver,

      @EndUserText.label: 'Change Request'
      @UI.hidden: true
      Req_Id,

      //Req_Id,
      @UI.hidden: true
      Name,
      @EndUserText.label: 'Back'
      _header : redirected to parent ZP_REF_MASTER_HEAD

}
