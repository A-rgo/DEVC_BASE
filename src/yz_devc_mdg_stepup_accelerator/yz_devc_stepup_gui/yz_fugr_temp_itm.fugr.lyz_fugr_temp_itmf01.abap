*----------------------------------------------------------------------*
***INCLUDE LYZ_FUGR_TEMP_ITMF01.
*----------------------------------------------------------------------*
FORM on_new_entry.

  yz_clas_mdg_accelerator=>process_config_records(
  EXPORTING
    iv_event_id    = 'ON_NEW_ENTRY'
    iv_view_entity = 'YZ_VIEW_TEMP_ITM'
    iv_action      = <action>
  CHANGING
    cs_data        = yz_view_temp_itm
    ct_data        = total[]
    RECEIVING
    rt_messages    = DATA(lt_message)
    ).

ENDFORM.
