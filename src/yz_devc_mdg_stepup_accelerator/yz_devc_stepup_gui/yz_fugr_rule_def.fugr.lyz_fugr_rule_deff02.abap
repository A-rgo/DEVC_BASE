*----------------------------------------------------------------------*
***INCLUDE LYZ_FUGR_RULE_DEFF02.
*----------------------------------------------------------------------*

FORM on_new_entry.

 yz_clas_mdg_accelerator=>process_config_records(
 EXPORTING
   iv_event_id    = 'ON_NEW_ENTRY'
   iv_view_entity = 'YZ_VIEW_RULE_DEF'
   iv_action      = <action>
 CHANGING
   cs_data        = yz_view_rule_def
   ct_data        = total[]
 RECEIVING
   rt_messages    = DATA(lt_message)
   ).

ENDFORM.
