@EndUserText.label: 'Projection View for ZI_REF_MASTER_ITM'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZP_REF_MASTER_ITM
  as projection on ZI_REF_MASTER_ITM
{
      @UI.facet: [{ purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, label: 'Field Details', position: 10 }]
      @UI:{ lineItem: [{position: 10 }],identification: [{position: 10 }]}
      @EndUserText.label: 'Request GUID'
      @UI.hidden: true
  key Req_Guid,
      @EndUserText.label: 'Record ID'
      @UI.hidden: true
  key Record_Id,
     
      //@ObjectModel.text.element: ['Field_Descr']
      Field_Name,
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Field Descr'
       @UI:{ lineItem: [{position: 20 }], identification: [{position: 10 }] }
      Field_Descr,

      @Search.defaultSearchElement: true
      @EndUserText.label: 'Field Value'
      @UI:{lineItem: [{position: 30 }],identification: [{position: 30 }]}
      Field_Value,
      /* Associations */
      @EndUserText.label: 'Back'
      _header : redirected to parent ZP_REF_MASTER_HEAD
}
