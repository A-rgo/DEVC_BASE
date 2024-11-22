class YZ_CL_MDG_BS_GUIBB_LIST_HRY definition
  public
  inheriting from CL_MDG_BS_GUIBB_LIST
  final
  create public .

public section.

  class-data GV_OBJ_CLASS type ZDE_REF_MASTER_OBJ_CLASS .
  class-data GV_ZMAIN type YZ_DTEL_OBJID .

  methods IF_FPM_GUIBB_LIST~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_LIST~GET_DEFINITION
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YZ_CL_MDG_BS_GUIBB_LIST_HRY IMPLEMENTATION.


  method if_fpm_guibb_list~get_data.

    data:lts_sel     type usmd_ts_sel,
         lif_model   type ref to if_usmd_model_ext,
         lts_objlist type   usmd_t_crequest_entity,
         lt_crequest type table of usmd_s_crequest,
         et_message  type usmd_t_message.
    constants: lc_incl            type ddsign   value 'I',
               lc_equal           type ddoption value 'EQ',
               lc_data_model_ZR   type usmd_model value 'ZR',
               lc_fieldname_ZMAIN type usmd_fieldname value 'ZMAIN',
               lc_hry             type char10 value 'ZIS_HRY'.

    data lo_data1  type ref to data.
    field-symbols : <lt_data>       type any table,
                    <ls_fieldusage> type fpmgb_s_fieldusage.

    super->if_fpm_guibb_list~get_data(
       exporting
         iv_eventid                = iv_eventid
         it_selected_fields        = it_selected_fields
         iv_raised_by_own_ui       = iv_raised_by_own_ui
         iv_visible_rows           = iv_visible_rows
         iv_edit_mode              = iv_edit_mode
         io_extended_ctrl          = io_extended_ctrl
       importing
         et_messages               = et_messages
         ev_data_changed           = ev_data_changed
         ev_field_usage_changed    = ev_field_usage_changed
         ev_action_usage_changed   = ev_action_usage_changed
         ev_selected_lines_changed = ev_selected_lines_changed
         ev_dnd_attr_changed       = ev_dnd_attr_changed
         eo_itab_change_log        = eo_itab_change_log
       changing
         ct_data                   = ct_data
         ct_field_usage            = ct_field_usage
         ct_action_usage           = ct_action_usage
         ct_selected_lines         = ct_selected_lines
         cv_lead_index             = cv_lead_index
         cv_first_visible_row      = cv_first_visible_row
         cs_additional_info        = cs_additional_info
         ct_dnd_attributes         = ct_dnd_attributes
     ).


***Read Change Request Data
    data(lif_context) = cl_usmd_app_context=>get_context( ).
    if lif_context is not bound.
      return.
    endif.
    data(iv_cr_number) = lif_context->mv_crequest_id.

** Get Read-only access to USMD Model data
    cl_usmd_model_ext=>get_instance(
    exporting
      i_usmd_model = lc_data_model_ZR
    importing
      eo_instance  = lif_model
      et_message   = et_message ).
** Get CR No.
    lts_sel = value usmd_ts_sel( ( fieldname = usmd0_cs_fld-crequest sign = lc_incl option = lc_equal low = iv_cr_number ) ).
** Create Data Reference
    lif_model->create_data_reference(
    exporting i_fieldname = lc_fieldname_ZMAIN
          i_struct    = if_usmd_model=>gc_struct_key_attr
          i_tabtype   = if_usmd_model=>gc_tabtype_standard
    importing er_data = lo_data1 ).

    assign lo_data1->* to <lt_data>.
    if <lt_data> is  not assigned.
      return.
    endif.
** Read Entity Data
    lif_model->read_char_value(
    exporting
      i_fieldname = lc_fieldname_ZMAIN
      it_sel      = lts_sel
    importing
    et_data     = <lt_data>
    et_message  = et_message ).

**Read Hierarchy Availability
    io_extended_ctrl->set_table_enabled( abap_false ).
    loop at <lt_data> assigning field-symbol(<ls_data>).
      assign component lc_hry of structure <ls_data> to field-symbol(<ls_is_hry>).


      if <ls_is_hry> is assigned and <ls_is_hry> = abap_true.
        io_extended_ctrl->set_table_enabled( abap_true ).
        exit.
      endif.
    endloop.

*    loop at ct_data assigning <ls_data>.
*      ASSIGN COMPONENT 'ZOBJ_CLS' OF STRUCTURE <ls_data> to field-symbol(<ls_is_obj>).
*      ASSIGN COMPONENT 'ZMAIN' OF STRUCTURE <ls_data> to field-symbol(<ls_is_zmain>).
*      if <ls_is_obj> is ASSIGNED and <ls_is_obj> is INITIAL.
*        <ls_is_obj> = GV_OBJ_CLASS.
*   read table ct_field_usage assigning <ls_fieldusage> with key name = 'ZOBJ_CLS'.
*            if sy-subrc eq 0.
*              <ls_fieldusage>-read_only = 'X'.
*              <ls_fieldusage>-fixed_values_changed = 'X'.
*              ev_field_usage_changed = abap_true.
*            endif.
*        ENDIF.
*      if <ls_is_zmain> is ASSIGNED and <ls_is_zmain> is INITIAL.
*
*        <ls_is_zmain> = GV_ZMAIN.
*           read table ct_field_usage assigning <ls_fieldusage> with key name = 'ZMAIN'.
*            if sy-subrc eq 0.
*              <ls_fieldusage>-read_only = 'X'.
*               <ls_fieldusage>-fixed_values_changed = 'X'.
*              ev_field_usage_changed = abap_true.
*            endif.
*
*        ENDIF.
*        ENDLOOP.
**Set Field property for Subnode based on Node Type
    loop at ct_data assigning <ls_data>.
      assign component 'ZIS_TOP' of structure <ls_data> to field-symbol(<ls_is_top>).

      if sy-subrc eq 0.
        case <ls_is_top>.
          when '1'. "Object is a Top Node
            read table ct_field_usage assigning <ls_fieldusage> with key name = 'ZHAS_SUB'.
            if sy-subrc eq 0.
              <ls_fieldusage>-visibility = 01.
              ev_field_usage_changed = abap_true.
            endif.
            read table ct_field_usage assigning <ls_fieldusage> with key name = 'ZHAS_TOP'.
            if sy-subrc eq 0.
              <ls_fieldusage>-visibility = 01.
              ev_field_usage_changed = abap_true.
            endif.
          when '2'."Object is a SubNode Node
            read table ct_field_usage assigning <ls_fieldusage> with key name = 'ZHAS_SUB'.
            if sy-subrc eq 0.
              <ls_fieldusage>-visibility = 01.
              ev_field_usage_changed = abap_true.
            endif.
            read table ct_field_usage assigning <ls_fieldusage> with key name = 'ZHAS_TOP'.
            if sy-subrc eq 0.
              <ls_fieldusage>-visibility = 02.
              ev_field_usage_changed = abap_true.
            endif.
          when others. "Object is a Leaf Node
            read table ct_field_usage assigning <ls_fieldusage> with key name = 'ZHAS_SUB'.
            if sy-subrc eq 0.
              <ls_fieldusage>-visibility = 02.
              ev_field_usage_changed = abap_true.
            endif.
            read table ct_field_usage assigning <ls_fieldusage> with key name = 'ZHAS_TOP'.
            if sy-subrc eq 0.
              <ls_fieldusage>-visibility = 02.
              ev_field_usage_changed = abap_true.
            endif.
        endcase.
      endif.
      exit.
    endloop.
  endmethod.


  method if_fpm_guibb_list~get_definition.

    call method super->if_fpm_guibb_list~get_definition
      importing
        eo_field_catalog         = eo_field_catalog
        et_field_description     = et_field_description
        et_action_definition     = et_action_definition
        et_special_groups        = et_special_groups
        es_message               = es_message
        ev_additional_error_info = ev_additional_error_info
        et_dnd_definition        = et_dnd_definition
        et_row_actions           = et_row_actions
        es_options               = es_options.
      endmethod.
ENDCLASS.
