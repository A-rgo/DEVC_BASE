*----------------------------------------------------------------------*
***INCLUDE YZ_PROG_BR_CONFIG_EVENTS_F01.
*----------------------------------------------------------------------*
INCLUDE lsvcmcod.

DATA eflag TYPE vcl_flag_type.

DATA: lt_data TYPE REF TO data.

 FIELD-SYMBOLS:  <table>     TYPE table.


FORM init.
* Assign <VCL_TOTAL> to desired data container.
  PERFORM vcl_set_table_access_for_obj USING vcl_struc_tab-vclname
                                      CHANGING eflag.

ENDFORM.


FORM before_navigation.

*  BREAK rabhayani.
  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
  CHANGING eflag.

  IF vcl_akt_view CS 'EXE' OR vcl_akt_view CS 'VAL' OR vcl_akt_view CS 'ITM'.
    IF vcl_last_view IS NOT INITIAL.
      PERFORM get_previous_view_data     USING vcl_last_view.
    ENDIF.

    PERFORM vcl_set_table_access_for_obj USING vcl_akt_view
    CHANGING eflag.
    IF <table> IS ASSIGNED.
      PERFORM process_record USING vcl_akt_view 'BEFORE_NAVIGATION' <table>.
    ENDIF.
  ENDIF.
ENDFORM.

FORM after_select.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*                                       CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'BEFORE_SAVE'.
ENDFORM.


FORM node_jump.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*                                       CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'BEFORE_SAVE'.
ENDFORM.

FORM determine_dependent.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*                                       CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'BEFORE_SAVE'.

ENDFORM.

FORM determine_superset.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*                                       CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'BEFORE_SAVE'.
ENDFORM.


FORM before_save.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*                                       CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'BEFORE_SAVE'.
ENDFORM.

FORM instead_selection.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*                                    CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'AFTER_SAVE'.
ENDFORM.

FORM after_save.
*  BREAK rabhayani.
  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
                                       CHANGING eflag.
*  PERFORM process_record USING vcl_akt_view 'AFTER_SAVE'.
ENDFORM.

FORM subset_popup.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*                                       CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'SUBSET_POPUP'.
ENDFORM.


FORM instead_of_std_validation.
**  BREAK rabhayani.
*  IF vcl_akt_view CS 'DEF' OR vcl_akt_view CS 'EXE' OR vcl_akt_view CS 'VAL'.
*    IF vcl_last_view IS NOT INITIAL.
*      PERFORM get_previous_view_data     USING vcl_last_view.
*    ELSE.
*      PERFORM get_previous_view_data     USING vcl_akt_view.
*    ENDIF.
*    PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*                                         CHANGING eflag.
*    IF <table> IS ASSIGNED.
*      PERFORM process_record USING vcl_akt_view 'INSTEAD_OF_STD_VALIDATION' <table>.
*    ENDIF.
*  ENDIF.
ENDFORM.

FORM instead_saving_db.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*  CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'INSTEAD_SAVING_DB'.
ENDFORM.

FORM instead_reading.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*  CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'AFTER_SAVE'.
ENDFORM.


FORM instead_of_lock_unlock.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*  CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'INSTEAD_OF_LOCK_UNLOCK'.
ENDFORM.


FORM end_of_process.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*  CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'END_OF_PROCESS'.
ENDFORM.

FORM after_lock_unlock.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*  CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'AFTER_LOCK_UNLOCK'.
ENDFORM.

FORM in_navigation.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*  CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'AFTER_LOCK_UNLOCK'.
ENDFORM.

FORM instead_of_selection.
**  BREAK rabhayani.
*  PERFORM vcl_set_table_access_for_obj USING    vcl_akt_view
*  CHANGING eflag.
**  PERFORM process_record USING vcl_akt_view 'AFTER_LOCK_UNLOCK'.
ENDFORM.


FORM get_previous_view_data USING VALUE(object) LIKE vclstruc-object.

  CREATE DATA lt_data TYPE STANDARD TABLE OF (object).
  ASSIGN lt_data->* TO <table>.

  IF <table> IS ASSIGNED.
    PERFORM vcl_set_table_access_for_obj USING object
                                         CHANGING eflag.
    IF <vcl_total> IS NOT INITIAL.
      READ TABLE <vcl_total> ASSIGNING FIELD-SYMBOL(<fs_total>) INDEX vcl_last_cursor_ix.
      IF sy-subrc = 0.
        INSERT INITIAL LINE INTO TABLE <table> ASSIGNING FIELD-SYMBOL(<fs_table>).
        <fs_table> = <fs_total> .
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.

FORM process_record USING VALUE(object) LIKE vclstruc-object
                               event_id TYPE char30
                          superset_data TYPE ANY TABLE .

    DATA: eflag        TYPE vcl_flag_type.

  FIELD-SYMBOLS:
    <header_wa>  TYPE vimdesc.

  CHECK <vcl_total> IS ASSIGNED.

  IF event_id <> 'BEFORE_NAVIGATION'.
    CHECK <vcl_total> IS NOT INITIAL.
  ENDIF.

  IF <vcl_header> IS ASSIGNED.
    READ TABLE <vcl_header> INDEX 1 ASSIGNING <header_wa>.
  ENDIF.

  CHECK <header_wa> IS ASSIGNED.

  yz_clas_mdg_accelerator=>process_config_records(
    EXPORTING
      iv_event_id         = event_id
      iv_view_entity      = CONV #( object )
      it_super_set_config = superset_data[]
    CHANGING
      ct_data             = <vcl_total>
*    RECEIVING
*      rt_messages         = DATA(lt_message)  "No reads perform on lt_message
      ).

ENDFORM.

*--------------------------------------------------------------------*
*Individual Table Event Code - Event 05 Create new entrty
*--------------------------------------------------------------------*
*FORM on_new_entry.
*
*  DATA lt_message   TYPE usmd_t_message..
*
*  DATA(lv_error) = yz_clas_mdg_accelerator=>process_config_records(
*  EXPORTING
*    iv_event_id    = 'ON_NEW_ENTRY'
*    iv_view_entity = 'YZ_VIEW_RULE_DEF'
*    iv_action      = <action>
*  IMPORTING
*    et_messages    = lt_message                 " Messages
*  CHANGING
*    cs_data        = yz_view_rule_def
*    ct_data        = total[]
*    ).
*
*ENDFORM.
