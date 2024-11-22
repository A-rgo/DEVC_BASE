@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for ZREF_MASTER_ITM'
define view entity ZI_REF_MASTER_ITM
  as select from zref_master_itm as item
  association        to parent ZI_REF_MASTER_HEAD as _header      on  $projection.Req_Guid = _header.Req_Guid
  association [0..1] to ZC_DD04T                  as _Description on  $projection.Field_Name = _Description.Field_Name
                                                                  and _Description.Language  = $session.system_language
{
  key req_guid                                        as Req_Guid,
  key record_id                                       as Record_Id,
      //@ObjectModel.text.element: ['Field_Descr']
      field_name                                      as Field_Name,
      _Description.Field_Descr                        as Field_Descr,
      case field_value
          when '' then old_value else field_value end as Field_Value,
      active                                          as Active,
      item.last_changed_at,
      item.local_last_changed_at,
      _header // Make association public
}
