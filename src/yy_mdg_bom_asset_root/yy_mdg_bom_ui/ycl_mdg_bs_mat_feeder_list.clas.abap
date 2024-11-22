class YCL_MDG_BS_MAT_FEEDER_LIST definition
  public
  inheriting from /PLMU/CL_FRW_G_FEEDER_LIST
  create public .

public section.

  interfaces /PLMU/IF_FRW_G_DEFAULT_ROW .
  interfaces /PLMU/IF_FRW_G_GLOBAL_EVENTS .
  interfaces /PLMU/IF_FRW_G_AFTER_GET_DATA .
  interfaces /PLMU/IF_FRW_G_BEFORE_GET_DATA .
  interfaces /PLMU/IF_FRW_G_ACTIONS .
  interfaces /PLMU/IF_FRW_G_CONFIG_PARAM .
  interfaces /PLMU/IF_FRW_G_FIELD_DEF .
  interfaces /PLMU/IF_FRW_G_BEFORE_FLUSH .
  interfaces /PLMU/IF_FRW_G_OVS .
protected section.

  types:
    BEGIN OF ty_s_selection_key .
    TYPES sel TYPE int4.
    TYPES key TYPE REF TO data.
  TYPES END OF ty_s_selection_key .
  types:
    ty_t_selection_key TYPE STANDARD TABLE OF ty_s_selection_key .

  class-data SV_POPUP_OPENED type BOOLE_D .
  data MV_LEAD_SEL_INDEX_CORRECTED type BOOLE_D .
  data MV_NO_HIGHLIGHTING type BOOLE_D .
  data MV_ENTITY_CONFIG_SET type BOOLE_D .
  data MO_FIELD_CATALOGUE_ORG type ref to CL_ABAP_STRUCTDESCR .
  data MT_DEFINITION type /PLMU/T_FRW_G_FIELD_DESCR_APPL .
  data MV_IS_ENABL_IN_GOV_SCOPE type ABAP_BOOL .
  data MT_SELECTION type INT4_TABLE .
  data MV_LEAD_SEL_INDEX type INT4 .
  data MT_PARAMETER_VALUE type FPMGB_T_PARAM_VALUE .
  data MV_LOCK type /PLMB/SPI_LOCK_IND .
  data MT_SELECTION_KEY type TY_T_SELECTION_KEY .

  methods ENABLE_TOC_NAVIGATION
    importing
      !IO_EVENT type ref to CL_FPM_EVENT .
  methods GET_CONTEXT_DATA
    importing
      !IT_INDEX type INT4_TABLE optional
    returning
      value(RT_DATA) type ref to DATA .
  methods GET_NODE_NAME
    returning
      value(RV_NODE_NAME) type /PLMB/SPI_NODE_NAME .
  methods GET_SELECTION_KEYS
    importing
      !IT_SELECTION type INT4_TABLE
    exporting
      value(ET_SELECTION_KEY) type TY_T_SELECTION_KEY
    raising
      /PLMB/CX_SPI_METADATA .
  methods MARK_TRANSFERRED_ROW .
  methods UPDATE_STATIC_TOC .
  methods DELETE_MEAN
    exporting
      !EV_FAILED type /PLMB/SPI_FAILED_IND
    changing
      !CT_CHANGE_LOG type FPMGB_T_CHANGELOG .
  methods GET_NODE_ENTITY
    exporting
      !EV_NODE_NAME type /PLMB/SPI_NODE_NAME
      !EV_ENTITY_NAME type USMD_ENTITY
      !ETS_ENTITY_NAME type MDG_BS_MAT_TS_ENTITY .
  methods INSERT_INITIAL_ROW
    importing
      !IO_EVENT type ref to CL_FPM_EVENT
    exporting
      !EV_FAILED type BOOLE_D .
private section.

  data GO_GENERIC_OVS type ref to CL_MDG_BS_MAT_GENERIC_OVS .

  methods CHANGE_LOCAL_ACTION_INS_DEL
    importing
      !IV_INSERT_ID type FPM_EVENT_ID
      !IV_DELETE_ID type FPM_EVENT_ID
      !IV_LEAD_SEL_INDEX type I
      !IV_DATA_INITIAL type BOOLE_D
    changing
      !CV_ACTION_USAGE_CHANGED type BOOLE_D
      !CT_ACTION_USAGE type /PLMU/T_FRW_G_ACTION_USAGE .
  methods PICK_MESSAGES
    importing
      !IO_EVENT type ref to CL_FPM_EVENT   ##NEEDED
      !IT_FIELDS type FPMGB_T_SELECTED_FIELDS optional
    exporting
      !ET_MESSAGE type FPMGB_T_MESSAGES .
  methods CHANGE_LOCAL_ACTION_USAGE
    changing
      !CV_ACTION_USAGE_CHANGED type BOOLE_D
      !CT_ACTION_USAGE type /PLMU/T_FRW_G_ACTION_USAGE .
  methods SET_INDEX .
  methods SET_ENTITY
    importing
      !IT_SELECTED_FIELDS type FPMGB_T_SELECTED_FIELDS optional .
ENDCLASS.



CLASS YCL_MDG_BS_MAT_FEEDER_LIST IMPLEMENTATION.


METHOD /PLMU/IF_FRW_G_ACTIONS~GET_ACTION_DEFINITION.

  DATA ls_action_definition LIKE LINE OF ct_action_definition.

  FIELD-SYMBOLS <ls_action_definition> LIKE LINE OF ct_action_definition.

* Dummy action to trigger a roundtrip
  ls_action_definition-id   = cl_mdg_bs_mat_c=>gc_event_roundtrip.
  ls_action_definition-text = text-rnd.
  INSERT ls_action_definition INTO TABLE ct_action_definition.

* Navigate to default details page
  ls_action_definition-id   = cl_fpm_event=>gc_event_call_default_det_page.
  ls_action_definition-text = text-dts.
  INSERT ls_action_definition INTO TABLE ct_action_definition.

  READ TABLE ct_action_definition WITH KEY id = cl_mdg_bs_mat_c=>gc_action_update_mlan_entries ASSIGNING <ls_action_definition>.
  IF sy-subrc EQ 0.
    <ls_action_definition>-exposable = abap_true.
  ENDIF.

ENDMETHOD.


METHOD /PLMU/IF_FRW_G_ACTIONS~PROCESS_ACTION_EVENT.

  DATA lv_index                   TYPE int4.
  DATA lv_parent_node_name        TYPE /plmb/spi_node_name.
  DATA lo_parent_node_metadata    TYPE REF TO /plmb/if_spi_metadata_node.
  DATA lr_id_tab                  TYPE REF TO data.
  DATA lr_id_struc                TYPE REF TO data.
  DATA lr_data_tab                TYPE REF TO data.
  DATA lr_data_struc              TYPE REF TO data.

  FIELD-SYMBOLS <lt_node_data>    TYPE ANY TABLE.
  FIELD-SYMBOLS <ls_node_data>    TYPE any.
  FIELD-SYMBOLS <lt_node_id>      TYPE ANY TABLE.
  FIELD-SYMBOLS <ls_node_id>      TYPE any.


  CLEAR ev_skip_default.
  CLEAR et_messages.
  ev_result = if_fpm_constants=>gc_event_result-ok.


* get selected line (e.g. if inline action is triggered)
  io_event->mo_event_data->get_value(
    EXPORTING
      iv_key   = if_fpm_guibb_list=>gc_event_par_row
    IMPORTING
      ev_value = lv_index ).

* set lead selection index accordingly
  IF lv_index > 0.
    mo_context->set_lead_selection_index( iv_index = lv_index ).
  ENDIF.

  CASE io_event->mv_event_id.
    WHEN if_fpm_constants=>gc_event-call_default_details_page OR
         if_fpm_constants=>gc_event-call_default_edit_page OR
         if_fpm_constants=>gc_event-call_suboverview_page.

*     save current selection (table selection in hierarchical UI gets lost on detail page)
      TRY.
          mo_context->get_lead_selection_index( IMPORTING ev_index = mv_lead_sel_index ).
        CATCH cx_root.
          CLEAR mv_lead_sel_index.
      ENDTRY.
      TRY.
          mo_context->get_selection_index( IMPORTING et_index = mt_selection ).
          get_selection_keys(
            EXPORTING
              it_selection     = mt_selection
            IMPORTING
              et_selection_key = mt_selection_key ).
        CATCH /plmb/cx_spi_metadata.
          CLEAR mt_selection_key.
        CATCH cx_root.
          CLEAR mt_selection.
          CLEAR mt_selection_key.
      ENDTRY.
    WHEN cl_mdg_bs_mat_c=>gc_action_update_mlan_entries.
      IF me->get_node_name( ) EQ cl_mdg_bs_mat_c=>gc_node_name_mlansales or
         me->get_node_name( ) EQ cl_mdg_bs_mat_c=>gc_node_name_mlanpurch.
        ev_skip_default = abap_true.
        TRY .
            me->mo_application_model->mo_metadata->get_node_details(
               EXPORTING iv_node_name = me->get_node_name( )
                IMPORTING
                  ev_parent_node_name = lv_parent_node_name ).
            lo_parent_node_metadata = me->mo_application_model->mo_metadata->get_node_metadata( iv_node_name = lv_parent_node_name ).
            lo_parent_node_metadata->get_id_container(
              IMPORTING
                er_id_table          = lr_id_tab
                er_id_structure          = lr_id_struc
            ).
            lo_parent_node_metadata->get_data_container(
              IMPORTING
                er_data_structure      = lr_data_struc
                er_data_table          = lr_data_tab
            ).
            ASSIGN lr_id_tab->* TO <lt_node_id>.
            ASSIGN lr_id_struc->* TO <ls_node_id>.
            ASSIGN lr_data_tab->* TO <lt_node_data>.
            ASSIGN lr_data_struc->* TO <ls_node_data>.
*              CATCH /plmb/cx_spi_metadata.    " SPI Metadata Exception (static)
            me->get_wire_model( )->get_inport_data( IMPORTING et_data = <lt_node_data> ).
            LOOP AT <lt_node_data> ASSIGNING <ls_node_data>.
              MOVE-CORRESPONDING <ls_node_data> TO <ls_node_id>.
              INSERT <ls_node_id> INTO TABLE <lt_node_id>.
            ENDLOOP.

            CHECK <lt_node_id> IS NOT INITIAL.

            me->mo_application_model->action(
              EXPORTING
                iv_node_name    = lv_parent_node_name
                iv_action_name  = cl_mdg_bs_mat_c=>gc_action_update_mlan_entries
                it_node_id      = <lt_node_id>
            ).
          CATCH /plmb/cx_spi_metadata.    " SPI Metadata Exception (static)
          CATCH /plmu/cx_frw_wire.
        ENDTRY.

      ENDIF.
  ENDCASE.
ENDMETHOD.


METHOD /PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA.

  DATA lv_node                 TYPE        /plmb/spi_node_name.
  DATA lv_entity               TYPE        usmd_entity.
  DATA lt_message              TYPE        fpmgb_t_messages.
  DATA lo_exc                  TYPE REF TO /plmb/cx_spi_error.
  DATA lt_entity_field_changes TYPE        mdg_bs_mat_t_changed_entities.


  CLEAR ev_field_usage_changed.
  CLEAR ev_action_usage_changed.
  CLEAR et_message.

* improve performance
  IF io_event->mv_event_id = /plmu/if_frw_constants=>gc_fpm_event_id-activate_sidepanel OR
      me->mo_application_model->gv_update_error EQ abap_true.
    RETURN.
  ENDIF.

  get_node_entity(
    IMPORTING
      ev_node_name   = lv_node
      ev_entity_name = lv_entity ).

* add colors and adapt tooltips
  IF cl_mdg_bs_mat_switch_check=>mdg_bs_mat_switch_05( ) = abap_true AND
     mv_no_highlighting = abap_false.
*   highlight changes supported: set color/tooltip in last roundtrip
    IF io_event->mv_event_id = cl_mdg_bs_mat_c=>gc_event_xroundtrip.
*     determine change indicator settings if multiple entities exist for same key
      cl_mdg_bs_mat_assist_ui=>define_change_indic_data4node(
        EXPORTING
          iv_node                 = lv_node
        IMPORTING
          et_entity_field_changes = lt_entity_field_changes ).
      cl_mdg_bs_mat_assist_ui=>get_color_tooltip_data4entity(
        EXPORTING
          iv_node                 = lv_node
          iv_entity               = lv_entity
          it_field_usage          = ct_field_usage
          it_selected_fields      = it_selected_fields
          it_entity_field_changes = lt_entity_field_changes
          it_definition           = mt_definition
          io_field_catalogue      = mo_field_catalogue_org
        CHANGING
          co_context              = mo_context ).
    ENDIF.
  ELSE.
*   highlight changes not supported: set initial tooltips
    cl_mdg_bs_mat_assist_ui=>set_initial_tooltips(
      EXPORTING
        iv_node             = lv_node
        iv_entity           = lv_entity
        it_field_usage      = ct_field_usage
        it_selected_fields  = it_selected_fields
        it_definition       = mt_definition
        io_field_catalogue  = mo_field_catalogue_org
      CHANGING
        co_context          = mo_context ).
  ENDIF.

  IF cl_mdg_bs_mat_assist_ui=>is_last_event( abap_true ) = abap_true.
*   set/restore selection/lead selection index
    set_index( ).
*   change operation properties that depend on selection
    change_local_action_usage(
      CHANGING
        cv_action_usage_changed = ev_action_usage_changed
        ct_action_usage         = ct_action_usage ).
  ENDIF.

* mark lead-selection if template org levels are copied (happens when switching to edit mode)
  IF io_event->mv_event_id = cl_fpm_event=>gc_event_edit OR
     io_event->mv_event_id = cl_fpm_event=>gc_event_local_edit.
    mark_transferred_row( ).
  ENDIF.

* define value set if field having value help is displayed as drop down box
  IF iv_first_time = abap_true.
    TRY.
        cl_mdg_bs_mat_assist_ui=>define_value_sets(
          EXPORTING
            it_selected_fields     = it_selected_fields
            io_app_model           = mo_application_model
            iv_node_name           = mo_context->get_info( )->get_node_name( )
          CHANGING
            cv_field_usage_changed = ev_field_usage_changed
            ct_field_usage         = ct_field_usage ).
      CATCH /plmb/cx_spi_error INTO lo_exc.
*        Check Metadata buffer - Invalidation needed, if metadata changed
        BREAK-POINT ID mdg_bs_mat_ui.
        IF me->mo_application_model->/plmu/if_frw_c_appl_model~mo_metadata->get_node_metadata( iv_node_name = get_node_name( ) )->is_transient( ) EQ abap_false."Catch exception for transient entities
          RAISE EXCEPTION lo_exc.
        ENDIF.
    ENDTRY.
  ENDIF.

* update a static table in the table of contents class
  IF cl_mdg_bs_mat_assist_ui=>gv_use_toc = abap_true AND
     io_event->mv_event_id <> cl_mdg_bs_mat_c=>gc_event_xroundtrip.
    update_static_toc( ).
*   enable navigation to the UIBB selected in the TOC
    IF io_event->mv_event_id = if_fpm_guibb_list=>gc_guibb_list_on_cell_action.
      enable_toc_navigation( io_event = io_event ).
    ENDIF.
  ENDIF.

* in case of message dispatch event, pick the relvant messages
**********************************************************************************************
* dump occurs in systems with SAP_BS_FND < 7.31 SP4                                          *
**********************************************************************************************
  IF io_event->mv_event_id EQ cl_mdg_bs_mat_c=>gc_event_xroundtrip.
    pick_messages(
      EXPORTING
        it_fields  = it_selected_fields
        io_event   = io_event
      IMPORTING
        et_message = lt_message ).
    APPEND LINES OF lt_message TO et_message.
  ENDIF.

ENDMETHOD.


METHOD /PLMU/IF_FRW_G_BEFORE_FLUSH~BEFORE_FLUSH.

  DATA lv_node_name TYPE /plmb/spi_node_name.


* get the current node
  lv_node_name = mo_context->get_info( )->get_node_name( ).

  CASE lv_node_name.
    WHEN cl_mdg_bs_mat_c=>gc_node_name_mean.
*     prepare the deletion. Generate the suitable structure only containing the keys
*     of the node MEAN
      delete_mean( CHANGING ct_change_log = ct_change_log ).

    WHEN cl_mdg_bs_mat_c=>gc_node_name_makt.
*     check if material text if changed
      IF ct_change_log IS NOT INITIAL.
        cl_mdg_bs_mat_assist_ui=>gv_matnr_txt_read = abap_false.
      ENDIF.

  ENDCASE.

  IF ct_change_log IS NOT INITIAL.
    cl_mdg_bs_mat_assist_ui=>gv_data_changed = abap_true.
  ENDIF.

ENDMETHOD.


METHOD /PLMU/IF_FRW_G_BEFORE_GET_DATA~BEFORE_GET_DATA.

  DATA lo_exc TYPE REF TO /plmb/cx_spi_error.

  CLEAR ev_skip_retrieve.

* Set entity value of feeder parameter into settings node
  IF iv_first_time EQ abap_true.
    TRY.
        set_entity( it_selected_fields = it_selected_fields ).
      CATCH /plmb/cx_spi_error INTO lo_exc.
*        Check Metadata buffer - Invalidation needed, if metadata changed
        BREAK-POINT ID mdg_bs_mat_ui.
        IF me->mo_application_model->/plmu/if_frw_c_appl_model~mo_metadata->get_node_metadata( iv_node_name = get_node_name( ) )->is_transient( ) EQ abap_false."Catch exception for transient entities
          RAISE EXCEPTION lo_exc.
        ENDIF.
    ENDTRY.
  ENDIF.

  CASE io_event->mv_event_id.
    WHEN cl_mdg_bs_mat_c=>gc_event_frw_insert.
      insert_initial_row(
        EXPORTING
          io_event   = io_event ).
      ev_skip_retrieve = abap_true.

    WHEN cl_mdg_bs_mat_c=>gc_event_button_aa_sta.
      ev_skip_retrieve = abap_true. "skip retrieve user just clicked on the switch button. switch will be handled in the read only event.
      RETURN.
  ENDCASE.

* trial to improve performance
  IF io_event->mv_event_id = /plmu/if_frw_constants=>gc_fpm_event_id-activate_sidepanel OR
      me->mo_application_model->gv_update_error EQ abap_true.
    ev_skip_retrieve = abap_true.
    RETURN.
  ENDIF.

  mv_lock = iv_lock.

* skip retrieving data when defined explicitely in FPM event
  io_event->mo_event_data->get_value(
    EXPORTING
      iv_key = cl_mdg_bs_mat_c=>gc_eventparam_skip_retrieve
    IMPORTING
      ev_value = ev_skip_retrieve ).

ENDMETHOD.


METHOD /PLMU/IF_FRW_G_CONFIG_PARAM~GET_PARAMETER_DESCRIPTION. "#EC NEEDED
****************************************************************************
* This method adds additional parameters 'ENTITY' and "ENTITY TABLE" to the UI
* configurations(as feeder parameters).
* These parameters are necessary to directly read the entities from the
* UIBBs to reduced the fields to be consumed in the UIBB and to save performance,
* when more than one entity is assigned to the same segment.
* Author KS.
*********************************************************************************

  CONSTANTS lc_no_highlighting TYPE c LENGTH 30 VALUE 'MDG_BS_MAT_NO_HIGHLIGHTING'.

  DATA lt_parameter LIKE         et_parameter_description.
  DATA ls_parameter LIKE LINE OF lt_parameter.


  CLEAR et_parameter_description.

  READ TABLE et_parameter_description TRANSPORTING NO FIELDS
       WITH KEY name = cl_mdg_bs_mat_c=>gc_param_entity.
  IF sy-subrc IS NOT INITIAL.
    ls_parameter-name = cl_mdg_bs_mat_c=>gc_param_entity.
    ls_parameter-type = cl_mdg_bs_mat_c=>gc_value_usmd_entity.
    INSERT ls_parameter INTO TABLE et_parameter_description.
    ls_parameter-name = cl_mdg_bs_mat_c=>gc_param_init_attr_read_only.
    ls_parameter-type = cl_mdg_bs_mat_c=>gc_value_init_attr_read_only.
    INSERT ls_parameter INTO TABLE et_parameter_description.
    ls_parameter-name = lc_no_highlighting.
    ls_parameter-type = lc_no_highlighting.
    INSERT ls_parameter INTO TABLE et_parameter_description.
    IF cl_mdg_bs_mat_assist_ui=>gv_use_toc EQ abap_true.
*     add the first field value in case TOC is active
      ls_parameter-name = cl_mdg_bs_mat_c=>gc_param_first_field.
      ls_parameter-type = cl_mdg_bs_mat_c=>gc_value_first_field.
      INSERT ls_parameter INTO TABLE et_parameter_description.
    ENDIF.
  ENDIF.
" Add parameter "Entity table" to UIBB-list
  READ TABLE et_parameter_description TRANSPORTING NO FIELDS
       WITH KEY name = cl_mdg_bs_mat_c=>gc_param_entity_table.
  IF sy-subrc IS NOT INITIAL.
    ls_parameter-name = cl_mdg_bs_mat_c=>gc_param_entity_table.
    ls_parameter-type = cl_mdg_bs_mat_c=>gc_value_usmd_entity_table. "'MDG_BS_MAT_TS_ENTITY'
    INSERT ls_parameter INTO TABLE et_parameter_description.
  ENDIF.

ENDMETHOD.


METHOD /PLMU/IF_FRW_G_CONFIG_PARAM~SET_PARAMETER_VALUES.
*--------------------------------------------------------------------*
* This method saves the parameter values maintained in the
* corresponding GUIBB into an attribute.
* Author: KS
*--------------------------------------------------------------------*
  CONSTANTS lc_no_highlighting TYPE c LENGTH 30 VALUE 'MDG_BS_MAT_NO_HIGHLIGHTING'.

  FIELD-SYMBOLS <ls_parameter_value> TYPE fpmgb_s_param_value.
  FIELD-SYMBOLS <lv_no_highlighting> TYPE boole_d.
  FIELD-SYMBOLS <lts_entity>         TYPE mdg_bs_mat_ts_entity.

* Store parameter information. It contains e.g. the node name.
  mt_parameter_value = it_parameter_value.

  READ TABLE mt_parameter_value ASSIGNING <ls_parameter_value>
       WITH KEY name = lc_no_highlighting.
  IF sy-subrc = 0.
    ASSIGN <ls_parameter_value>-value->* TO <lv_no_highlighting>.
    mv_no_highlighting = <lv_no_highlighting>.
  ENDIF.

  " Get ENTITY table (for the new list filtering...)
  READ TABLE mt_parameter_value ASSIGNING <ls_parameter_value>
   WITH KEY name = cl_mdg_bs_mat_c=>gc_param_entity_table.
  IF sy-subrc EQ 0.
    ASSIGN <ls_parameter_value>-value->* TO <lts_entity>.
    IF <lts_entity> IS ASSIGNED AND <lts_entity> IS NOT INITIAL.
      DELETE <lts_entity> WHERE entity IS INITIAL.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD /PLMU/IF_FRW_G_DEFAULT_ROW~GET_DEFAULT_ROW.          "#EC NEEDED
ENDMETHOD.


METHOD /PLMU/IF_FRW_G_FIELD_DEF~CHANGE_FIELD_DEFINITION.
**********************************************************************
* Method reads the corresponding entity and restricts the fields of
* the considered UIBB to those, which are mapped by the SMT-mapping
* Author: KS
**********************************************************************

  CONSTANTS:
    lc_tab_t001    TYPE reftable VALUE 'T001',
    lc_field_waers TYPE reffield VALUE 'WAERS',
    lc_is_nullable TYPE string   VALUE 'IS_NULLABLE'.

  DATA:
    ls_node_enty      TYPE mdg_bs_mat_s_node_enty_i,
    lts_entity_name   TYPE mdg_bs_mat_ts_entity,
    lv_failed         TYPE boole_d,
    lt_mst_field      TYPE mdg_bs_mat_t_smt_field,
    lv_is_segm_ent    TYPE boole_d,
    lt_messages       TYPE fpmgb_t_messages,
    lv_strucname      TYPE typename,
    lo_exc            TYPE REF TO /plmb/cx_spi_error,
    ls_ovs_assignment TYPE mdg_bs_mat_s_ovs_assignment.

  FIELD-SYMBOLS:
    <ls_parameter>   TYPE fpmgb_s_param_value,
    <lv_node_name>   TYPE /plmb/spi_node_name,
    <ls_definition>  TYPE /plmu/s_frw_g_field_descr_appl,
    <lv_is_nullable> TYPE boole_d,
    <ls_t001_ref>    TYPE mdg_bs_mat_s_a_get_t001_ref.


* save fieldcatalogue before adding local fields
  mo_field_catalogue_org = co_catalogue.

* Get node name and entity name
  get_node_entity(
    IMPORTING
      ev_node_name    = ls_node_enty-node_name
      ev_entity_name  = ls_node_enty-entity
      ets_entity_name = lts_entity_name ).

* relation between configuration and entity/node not saved yet
  IF mv_entity_config_set IS INITIAL.
    cl_mdg_bs_mat_assist_ui=>set_entity_config_4_uibb(
      EXPORTING
        iv_node              = ls_node_enty-node_name
        iv_entity            = ls_node_enty-entity
        its_entity           = lts_entity_name
        is_uibb_instance_key = get_uibb_instance_key( ) ).
    mv_entity_config_set = abap_true.
  ENDIF.

* Check whether node is segment node or a flex one and if yes then get the
* nodes which have to be considered.
* Notice: Method is developed in a such way, that the output parameter
* ev_exist indicates whether or not the node name is a segment node or a flex one....

  TRY.
      cl_mdg_bs_mat_assist_ui=>get_cons_segm_field_enty(
        EXPORTING
          iv_node_name         = ls_node_enty-node_name
          iv_entity            = ls_node_enty-entity
          its_entity           = lts_entity_name
          io_application_model = mo_application_model
        IMPORTING
          et_messages          = lt_messages
          et_mst_field         = lt_mst_field
          ev_exist             = lv_is_segm_ent ).
    CATCH /plmb/cx_spi_error INTO lo_exc.
*          Check Metadata buffer - Invalidation needed, if metadata changed
      BREAK-POINT ID mdg_bs_mat_ui.
      IF me->mo_application_model->/plmu/if_frw_c_appl_model~mo_metadata->get_node_metadata( iv_node_name = get_node_name( ) )->is_transient( ) EQ abap_false."Catch exception for transient entities
        RAISE EXCEPTION lo_exc.
      ENDIF.
  ENDTRY.

* If the node is a segment node or a flex one than restrict definition
  IF lv_is_segm_ent = abap_true.
    IF lt_messages IS NOT INITIAL.
      APPEND LINES OF lt_messages TO cl_mdg_bs_mat_assist_ui=>gt_init_messages.
    ENDIF.

*   restrict definition
    cl_mdg_bs_mat_assist_ui=>restrict_defin_field_catalog(
      EXPORTING
        iv_failed      = lv_failed
        iv_node_name   = ls_node_enty-node_name
        it_fields_cons = lt_mst_field
      CHANGING
        ct_definition  = ct_definition ).
  ENDIF.

* Get node name value
  READ TABLE mt_parameter_value ASSIGNING <ls_parameter>
       WITH KEY name = cl_mdg_bs_mat_c=>gc_param_frw_node_name.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  ASSIGN <ls_parameter>-value->* TO <lv_node_name>.
  ASSERT <lv_node_name> IS NOT INITIAL.

* display leading zeros as blanks
  cl_mdg_bs_mat_assist_ui=>remove_leading_zeros(
    EXPORTING
      it_node_name  = <lv_node_name>
    CHANGING
      ct_definition = ct_definition
      co_catalogue  = co_catalogue   ).

* add references for currency fields
  cl_mdg_bs_mat_smt=>get_segment_structure(
    EXPORTING
      iv_node_name = <lv_node_name>
    IMPORTING
      ev_strucname = lv_strucname ).

  IF lv_strucname IS NOT INITIAL.
    LOOP AT cl_mdg_bs_mat_assist_ui=>gt_t001_ref ASSIGNING <ls_t001_ref>
         WHERE structure = lv_strucname.
      READ TABLE ct_definition ASSIGNING <ls_definition>
           WITH KEY name = <ls_t001_ref>-field.
      <ls_definition>-cq     = cl_mdg_bs_mat_c=>gc_text_field_type_check_table.
      <ls_definition>-cq_ref = cl_mdg_bs_mat_c=>gc_field_waers.
    ENDLOOP.
  ENDIF.

* feature pack: add structure components to assign colors and tooltips
  IF cl_mdg_bs_mat_switch_check=>mdg_bs_mat_switch_05( ) = abap_true.
    cl_mdg_bs_mat_assist_ui=>add_color_tooltip(
      CHANGING
        co_catalogue  = co_catalogue
        ct_definition = ct_definition ).
  ENDIF.

  LOOP AT ct_definition ASSIGNING <ls_definition>.
    ASSIGN COMPONENT lc_is_nullable OF STRUCTURE <ls_definition> TO <lv_is_nullable>.
    IF sy-subrc EQ 0.
      <lv_is_nullable> = cl_mdg_bs_mat_assist_ui=>is_nullable( is_definition = <ls_definition> ).
    ELSE.
      EXIT. "if the field is not in structure implementation of note 1994353 is missing
    ENDIF.
  ENDLOOP.

* Get OVS assignments and add to definition
  IF cl_mdg_bs_mat_assist_ui=>gt_ovs_assignment IS INITIAL.
    mo_application_model->action(
      EXPORTING
        iv_node_name    = cl_mdg_bs_mat_c=>gc_node_name_settings
        iv_action_name  = cl_mdg_bs_mat_c=>gc_action_get_ovs_assignment
      IMPORTING
        eg_param        = cl_mdg_bs_mat_assist_ui=>gt_ovs_assignment ).
  ENDIF.

  LOOP AT cl_mdg_bs_mat_assist_ui=>gt_ovs_assignment INTO ls_ovs_assignment WHERE node_name = <lv_node_name>.
    READ TABLE ct_definition ASSIGNING <ls_definition> WITH KEY name = ls_ovs_assignment-fieldname_pp ddic_shlp_name = '' ovs_name =''.
    IF sy-subrc EQ 0 AND ls_ovs_assignment-ovs_name EQ cl_mdg_bs_mat_c=>gc_ovs_generic.
      <ls_definition>-ovs_name = cl_abap_typedescr=>describe_by_object_ref( me )->get_relative_name( ).
    ELSEIF sy-subrc EQ 0 AND ls_ovs_assignment-ovs_name IS NOT INITIAL.
      <ls_definition>-ovs_name = ls_ovs_assignment-ovs_name.
    ENDIF.
  ENDLOOP.

* store field description for later read accesses
  mt_definition = ct_definition.

ENDMETHOD.


METHOD /PLMU/IF_FRW_G_GLOBAL_EVENTS~PROCESS_GLOBAL_EVENT.
*--------------------------------------------------------------------*
* This method handles gloabl events.
*--------------------------------------------------------------------*

  DATA lv_node_name     TYPE /plmb/spi_node_name.
  DATA lv_entity        TYPE usmd_entity.
  DATA lo_exc           TYPE REF TO /plmb/cx_spi_error.
  DATA lt_key_value     TYPE mdg_bs_mat_t_key_value.
  DATA ls_key_value     TYPE mdg_bs_mat_key_value.
  DATA lv_index         TYPE int4.
  DATA lts_entity_name  TYPE mdg_bs_mat_ts_entity.



  CLEAR: ev_skip_default, lts_entity_name, et_messages.
  ev_result = if_fpm_constants=>gc_event_result-ok.

* get selected line (e.g. if inline action is triggered)
  io_event->mo_event_data->get_value(
    EXPORTING
      iv_key   = if_fpm_guibb_list=>gc_event_par_row
    IMPORTING
      ev_value = lv_index ).

* set lead selection index accordingly
  IF lv_index > 0 AND iv_raised_by_own_ui = abap_true.
    mo_context->set_lead_selection_index( iv_index = lv_index ).
  ENDIF.

  IF io_event             IS INITIAL OR
     mo_application_model IS INITIAL.
    RETURN.
  ENDIF.

  CASE io_event->mv_event_id.
    WHEN cl_fpm_event=>gc_event_cancel.
*     ROLLBACK
      TRY.
          mo_application_model->action(
            EXPORTING
              iv_node_name   = cl_mdg_bs_mat_c=>gc_node_name_mat
              iv_action_name = cl_mdg_bs_mat_c=>gc_action_rollback
              is_param       = abap_true ).
        CATCH /plmb/cx_spi_error INTO lo_exc.
*          Check Metadata buffer - Invalidation needed, if metadata changed
          BREAK-POINT ID mdg_bs_mat_ui.
          IF me->mo_application_model->/plmu/if_frw_c_appl_model~mo_metadata->get_node_metadata( iv_node_name = get_node_name( ) )->is_transient( ) EQ abap_false."Catch exception for transient entities
            RAISE EXCEPTION lo_exc.
          ENDIF.
      ENDTRY.

    WHEN if_fpm_guibb_list=>gc_fpm_event_on_lead_sel.
      TRY.
          mo_context->get_lead_selection_index( IMPORTING ev_index = mv_lead_sel_index ).
        CATCH cx_root.
          CLEAR mv_lead_sel_index.
      ENDTRY.
      TRY.
          mo_context->get_selection_index( IMPORTING et_index = mt_selection ).
          get_selection_keys(
            EXPORTING
              it_selection     = mt_selection
            IMPORTING
              et_selection_key = mt_selection_key ).
        CATCH /plmb/cx_spi_metadata.
          CLEAR mt_selection_key.
        CATCH cx_root.
          CLEAR mt_selection.
          CLEAR mt_selection_key.
      ENDTRY.

    WHEN if_fpm_constants=>gc_event-start OR
         if_fpm_constants=>gc_event-adapt_context OR
         if_fpm_constants=>gc_event-adapt_context_local OR
         cl_usmd_cr_guibb_general_data=>cv_action_cruibb_refresh OR
         cl_usmd_cr_guibb_general_data=>cv_action_refresh.
      get_node_entity(
        IMPORTING
          ev_node_name    = lv_node_name
          ev_entity_name  = lv_entity
          ets_entity_name = lts_entity_name ).
      cl_mdg_bs_mat_assist_ui=>set_entity_config_4_uibb(
        EXPORTING
          iv_node              = lv_node_name
          iv_entity            = lv_entity
          its_entity           = lts_entity_name
          is_uibb_instance_key = get_uibb_instance_key( ) ).
      mv_entity_config_set = abap_true.

  ENDCASE.
ENDMETHOD.


  method /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_0.

    IF me->go_generic_ovs IS INITIAL.
      CREATE OBJECT me->go_generic_ovs
        EXPORTING
          iv_node_name = me->get_node_name( ).
    ENDIF.

    me->go_generic_ovs->/plmu/if_frw_g_ovs~handle_phase_0(
      EXPORTING
        iv_field_name   = iv_field_name
        io_ovs_callback = io_ovs_callback
    ).

  endmethod.


  method /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_1.

    me->go_generic_ovs->/plmu/if_frw_g_ovs~handle_phase_1(
      EXPORTING
        iv_field_name   = iv_field_name
        io_ovs_callback = io_ovs_callback
    ).

  endmethod.


  METHOD /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_2.

    DATA lo_node_metadata         TYPE REF TO /plmb/if_spi_metadata_node.
    DATA lr_id_tab                TYPE REF TO data.
    DATA lr_id_struc              TYPE REF TO data.
    DATA lo_ovs_callback          TYPE REF TO /plmu/if_frw_g_ovs_callback.
    DATA lo_generic_ovs           TYPE REF TO cl_mdg_bs_mat_generic_ovs.
    DATA lo_struct_descr          TYPE REF TO cl_abap_structdescr.

    FIELD-SYMBOLS <lt_node_id>    TYPE ANY TABLE.
    FIELD-SYMBOLS <ls_node_id>    TYPE any.
    FIELD-SYMBOLS <ls_compdescr>  TYPE abap_compdescr.
    FIELD-SYMBOLS <lv_pid>        TYPE any.
    FIELD-SYMBOLS <lv_cid>        TYPE any.

    lo_ovs_callback = io_ovs_callback.

    TRY .
        lo_node_metadata = me->mo_application_model->mo_metadata->get_node_metadata( iv_node_name = me->get_node_name( ) ).
        lo_node_metadata->get_id_container(
          IMPORTING
            er_id_table               = lr_id_tab
            er_id_structure           = lr_id_struc
        ).
        ASSIGN lr_id_tab->* TO <lt_node_id>.
        ASSIGN lr_id_struc->* TO <ls_node_id>.
        me->get_wire_model( )->get_inport_data( IMPORTING et_data = <lt_node_id> ).
        LOOP AT <lt_node_id> ASSIGNING <ls_node_id>.
          EXIT.
        ENDLOOP.

        DATA lr_data TYPE REF TO data.
        FIELD-SYMBOLS <ls_data> TYPE any.

        lo_ovs_callback->get_row_data(
          IMPORTING
            er_data = lr_data ).
        ASSIGN lr_data->* TO <ls_data>.
        lo_struct_descr ?= cl_abap_structdescr=>describe_by_data( p_data = <ls_node_id> ).
        LOOP AT lo_struct_descr->components ASSIGNING <ls_compdescr>.
          ASSIGN COMPONENT <ls_compdescr>-name OF STRUCTURE <ls_node_id> TO <lv_pid>.
          ASSIGN COMPONENT <ls_compdescr>-name OF STRUCTURE <ls_data> TO <lv_cid>.
          IF <lv_pid> IS NOT INITIAL AND <lv_cid> IS INITIAL.
            <lv_cid> = <lv_pid>.
          ENDIF.
        ENDLOOP.

        lo_ovs_callback->set_row_data( is_data = <ls_data> ).

      CATCH /plmb/cx_spi_metadata.    " SPI Metadata Exception (static)
      CATCH /plmu/cx_frw_wire.
    ENDTRY.

    CREATE OBJECT lo_generic_ovs.

    me->go_generic_ovs->/plmu/if_frw_g_ovs~handle_phase_2(
      EXPORTING
        iv_field_name   = iv_field_name
        io_ovs_callback = io_ovs_callback
    ).

  ENDMETHOD.


  method /PLMU/IF_FRW_G_OVS~HANDLE_PHASE_3.

    me->go_generic_ovs->/plmu/if_frw_g_ovs~handle_phase_3(
      EXPORTING
        iv_field_name   = iv_field_name
        io_ovs_callback = io_ovs_callback
    ).

  endmethod.


METHOD CHANGE_LOCAL_ACTION_INS_DEL.

  DATA lv_node_name          TYPE        /plmb/spi_node_name.
  DATA lv_enabled            TYPE        boole_d.
  DATA lv_visible            TYPE        wdui_visibility.
  DATA lv_visible_req        TYPE        wdui_visibility.
  DATA lv_in_scope_relev     TYPE        boole_d.
  DATA lv_req_in_scope_relev TYPE        boole_d.
  DATA lv_no_parent          TYPE        boole_d.
  DATA lo_table_desc         TYPE REF TO cl_abap_tabledescr.
  DATA lr_table              TYPE REF TO data.

  FIELD-SYMBOLS <lt_table>        TYPE ANY TABLE.
  FIELD-SYMBOLS <ls_action_usage> TYPE /plmu/s_frw_g_action_usage.


  get_node_entity(
    IMPORTING
      ev_node_name   = lv_node_name ).

* Addition if application parameter FPM_IGNORE_WIRE_SOURCE is used
  TRY.
      mo_application_model->mo_metadata->get_node_metadata( lv_node_name )->get_parent( )->get_id_rtti(
        IMPORTING
          eo_table_description = lo_table_desc ).
      CREATE DATA lr_table TYPE HANDLE lo_table_desc.
      ASSIGN lr_table->* TO <lt_table>.

      get_wire_model( )->get_inport_data(
        IMPORTING
          et_data = <lt_table> ).
    CATCH /plmu/cx_frw_wire
          /plmb/cx_spi_metadata.
      lv_no_parent = abap_true.
  ENDTRY.

* check if at least one entity is in scope and relevant
  IF lv_node_name = cl_mdg_bs_mat_c=>gc_node_name_mkalcc.
    " For the MKAL copy pop up we have to show the delete-button
    lv_in_scope_relev = abap_true.
    lv_req_in_scope_relev = abap_true.
  ELSE.
    lv_in_scope_relev = cl_mdg_bs_mat_assist_ui=>is_entity_in_scope(
                          iv_node = lv_node_name ).
* check if all required entities are in scope and relevant
    lv_req_in_scope_relev = cl_mdg_bs_mat_assist_ui=>is_required_entities_in_scope(
                              iv_node = lv_node_name ).
  ENDIF.
* define scope/relevance-dependent visibility
  IF lv_in_scope_relev = abap_false.
    lv_visible = cl_wd_uielement=>e_visible-none.
  ELSE.
    lv_visible = cl_wd_uielement=>e_visible-visible.
  ENDIF.
  IF lv_req_in_scope_relev = abap_false.
    lv_visible_req = cl_wd_uielement=>e_visible-none.
  ELSE.
    lv_visible_req = cl_wd_uielement=>e_visible-visible.
  ENDIF.

* DELETE
  IF iv_data_initial = abap_true OR
     iv_lead_sel_index < 1 OR
     mv_lock = abap_false.
    lv_enabled = abap_false.
  ELSE.
    lv_enabled = abap_true.
  ENDIF.
  READ TABLE ct_action_usage ASSIGNING <ls_action_usage>
                             WITH KEY id = iv_delete_id.
  IF sy-subrc = 0.
    IF <ls_action_usage> IS ASSIGNED.
      <ls_action_usage>-enabled = lv_enabled.
      <ls_action_usage>-visible = lv_visible.
      cv_action_usage_changed   = abap_true.
    ENDIF.
  ENDIF.

* INSERT
  IF mv_lock = abap_false OR
     lv_no_parent = abap_true.
    lv_enabled = abap_false.
  ELSE.
    lv_enabled = abap_true.
  ENDIF.
  READ TABLE ct_action_usage ASSIGNING <ls_action_usage>
                             WITH KEY id = iv_insert_id.
  IF sy-subrc = 0.
    IF <ls_action_usage> IS ASSIGNED.
      <ls_action_usage>-enabled = lv_enabled.
      <ls_action_usage>-visible = lv_visible_req.
      cv_action_usage_changed   = abap_true.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD CHANGE_LOCAL_ACTION_USAGE.

  DATA lv_lead_sel_index TYPE        int4.
  DATA lv_initial        TYPE        boole_d.
  DATA lv_node_name      TYPE        /plmb/spi_node_name.
  DATA lr_struct         TYPE REF TO data.
  DATA lo_info           TYPE REF TO /plmu/if_frw_context_info.
  DATA lo_struct_descr   TYPE REF TO cl_abap_structdescr.

  FIELD-SYMBOLS <ls_action_usage> TYPE /plmu/s_frw_g_action_usage.
  FIELD-SYMBOLS <ls_data>         TYPE any.
  FIELD-SYMBOLS <lv_data>         TYPE any.


* get data
  lo_info      = mo_context->get_info( ).
  lv_node_name = lo_info->get_node_name( ).
  lo_info->get_rtti( IMPORTING eo_ui_data_structure = lo_struct_descr ).
  IF lo_struct_descr IS INITIAL.
    RETURN.
  ENDIF.

* get lead selection index and data
  CREATE DATA lr_struct TYPE HANDLE lo_struct_descr.
  ASSIGN lr_struct->* TO <ls_data>.

  mo_context->get_lead_selection_index( IMPORTING ev_index = lv_lead_sel_index ).
  IF lv_lead_sel_index > 0.
    mo_context->get_row( IMPORTING es_row = <ls_data> ).
    IF <ls_data> IS INITIAL.
      lv_initial = abap_true.
    ELSE.
      lv_initial = abap_false.
    ENDIF.
  ENDIF.

* change properties for all nodes
  change_local_action_ins_del(
    EXPORTING
      iv_insert_id            = cl_mdg_bs_mat_c=>gc_event_frw_insert
      iv_delete_id            = cl_mdg_bs_mat_c=>gc_event_frw_delete
      iv_lead_sel_index       = lv_lead_sel_index
      iv_data_initial         = lv_initial
    CHANGING
      cv_action_usage_changed = cv_action_usage_changed
      ct_action_usage         = ct_action_usage ).

* special handling for single nodes
  CASE lv_node_name.
    WHEN cl_mdg_bs_mat_c=>gc_node_name_marm.
      ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_meinh OF STRUCTURE <ls_data> TO <lv_data>.
      IF <lv_data> = cl_mdg_bs_mat_assist_ui=>gv_current_meins.
*       set enablement status
        READ TABLE ct_action_usage ASSIGNING <ls_action_usage>
             WITH KEY id = cl_mdg_bs_mat_c=>gc_event_frw_delete.
        IF <ls_action_usage> IS ASSIGNED.
          <ls_action_usage>-enabled = abap_false.
          cv_action_usage_changed   = abap_true.
        ENDIF.
      ENDIF.
  ENDCASE.

ENDMETHOD.


METHOD DELETE_MEAN.
*******************************************************************************
* Method handles updates of the EANs:
* The framework generates a new entry, if an EAN is updated. It is not correct.
* Method deletes the wrong entry
* KS/KC
********************************************************************************

  DATA ls_change_log     TYPE         fpmgb_s_changelog.
  DATA lo_struc          TYPE REF TO  cl_abap_datadescr.
  DATA lo_table          TYPE REF TO  cl_abap_tabledescr.
  DATA lr_table_node_id  TYPE REF TO  data.
  DATA lr_struc_node_id  TYPE REF TO  data.
  DATA lt_components     TYPE         cl_abap_structdescr=>component_table.
  DATA ls_components     LIKE LINE OF lt_components.

  FIELD-SYMBOLS <fv_old_value>  TYPE any.
  FIELD-SYMBOLS <fv_matnr>      TYPE any.
  FIELD-SYMBOLS <fv_meinh>      TYPE any.
  FIELD-SYMBOLS <fv_ean11>      TYPE any.
  FIELD-SYMBOLS <fv_matnr1>     TYPE any.
  FIELD-SYMBOLS <fv_meinh1>     TYPE any.
  FIELD-SYMBOLS <fs_table_row>  TYPE any.
  FIELD-SYMBOLS <ft_node_id>    TYPE INDEX TABLE.
  FIELD-SYMBOLS <fs_node_id>    TYPE any.


  CLEAR ev_failed.
  CLEAR lt_components.

  ls_components-name = cl_mdg_bs_mat_c=>gc_matnr.
  ls_components-type ?= cl_abap_typedescr=>describe_by_name( p_name = cl_mdg_bs_mat_c=>gc_matnr ).
  APPEND ls_components TO lt_components.

  ls_components-name = cl_mdg_bs_mat_c=>gc_meinh.
  ls_components-type ?= cl_abap_typedescr=>describe_by_name( p_name = cl_mdg_bs_mat_c=>gc_meinh ).
  APPEND ls_components TO lt_components.

  ls_components-name = cl_mdg_bs_mat_c=>gc_ean11.
  ls_components-type ?= cl_abap_typedescr=>describe_by_name( p_name = cl_mdg_bs_mat_c=>gc_ean11 ).
  APPEND ls_components TO lt_components.

  lo_struc = cl_abap_structdescr=>create( p_components = lt_components ).
  CREATE DATA lr_struc_node_id TYPE HANDLE lo_struc.
  ASSIGN lr_struc_node_id->* TO <fs_node_id>.

  lo_table = cl_abap_tabledescr=>create( p_line_type = lo_struc ).
  CREATE DATA lr_table_node_id TYPE HANDLE lo_table.
  ASSIGN lr_table_node_id->* TO <ft_node_id>.

* get only the changes concerning the EANs. If the material nr is not initial,
* the old entry has to be deleted
  LOOP AT ct_change_log INTO ls_change_log WHERE name EQ cl_mdg_bs_mat_c=>gc_ean11.
    ASSIGN ls_change_log-table_row->* TO <fs_table_row>.
    ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_matnr OF STRUCTURE <fs_table_row> TO <fv_matnr>.
    IF <fv_matnr> IS ASSIGNED AND <fv_matnr> IS NOT INITIAL.
      ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_matnr OF STRUCTURE <fs_node_id> TO <fv_matnr1>.
      <fv_matnr1> = <fv_matnr>.

      ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_meinh OF STRUCTURE <fs_table_row> TO <fv_meinh>.
      IF <fv_meinh> IS ASSIGNED AND  <fv_meinh> IS NOT INITIAL.
        ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_meinh OF STRUCTURE <fs_node_id> TO <fv_meinh1>.
        <fv_meinh1> = <fv_meinh>.
      ENDIF.

      ASSIGN ls_change_log-old_value->* TO <fv_old_value>.
      ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_ean11 OF STRUCTURE <fs_node_id> TO <fv_ean11>.
      <fv_ean11> = <fv_old_value>.

      INSERT <fs_node_id> INTO TABLE <ft_node_id>.
      mo_application_model->delete(
        EXPORTING
          iv_node_name = cl_mdg_bs_mat_c=>gc_node_name_mean
          it_node_id   = <ft_node_id>
        IMPORTING
          ev_failed    = ev_failed ).
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD ENABLE_TOC_NAVIGATION.

  CONSTANTS lc_if_list_cntrl  TYPE abap_abstypename
                              VALUE '/PLMU/IF_FRW_G_UI_LIST_CNTRL'.
  CONSTANTS lc_if_table_cntrl TYPE abap_abstypename
                              VALUE '/PLMU/IF_FRW_G_UI_TABLE_CNTRL'.
  CONSTANTS lc_meth_preferred TYPE abap_methname
                              VALUE 'GET_EXTENDED_CONTROL'.
  CONSTANTS lc_meth_alternat  TYPE abap_methname
                              VALUE 'GET_LIST_ATS_EXTENDED_CONTROL'.

  DATA ls_instance_key    TYPE        fpm_s_uibb_instance_key.
  DATA lo_event_data      TYPE REF TO if_fpm_parameter.
  DATA lr_value           TYPE REF TO data.
  DATA lo_element         TYPE REF TO if_wd_context_element.
  DATA lo_extended_ctrl   TYPE REF TO if_fpm_list_ats_ext_ctrl.
  DATA lv_root_comp       TYPE        wdy_component_name.
  DATA lv_root_conf       TYPE        wdy_config_id.
  DATA lv_component       TYPE        wdy_component_name.
  DATA lv_config_id       TYPE        wdy_config_id.
  DATA ls_par_value       TYPE        fpmgb_s_param_value.
  DATA lv_methodname      TYPE        string.
  DATA lo_class_descr     TYPE REF TO cl_abap_classdescr.
  DATA lo_intf_descr      TYPE REF TO cl_abap_intfdescr.

  FIELD-SYMBOLS <lt_wdparam>     TYPE wdr_event_parameter_list.
  FIELD-SYMBOLS <ls_wdparam>     TYPE wdr_event_parameter.
  FIELD-SYMBOLS <lo_object>      TYPE any.
  FIELD-SYMBOLS <lv_first_field> TYPE name_komp.


  lo_event_data = io_event->mo_event_data.
  lo_event_data->get_value(
    EXPORTING
      iv_key   = cl_mdg_bs_mat_c=>gc_param_wdevent_params
    IMPORTING
      er_value = lr_value ).
  ASSIGN lr_value->* TO <lt_wdparam>.

  READ TABLE <lt_wdparam> ASSIGNING <ls_wdparam>
       WITH KEY name = cl_mdg_bs_mat_c=>gc_param_context_element.
  IF sy-subrc = 0.
    ASSIGN <ls_wdparam>-value->* TO <lo_object>.
    lo_element ?= <lo_object>.
*   activate the corresponding UIBB
    IF lo_element IS BOUND.
      TRY.
          lo_element->get_attribute(
            EXPORTING
              name  = cl_mdg_bs_mat_c=>gc_attr_ablock_config_id
            IMPORTING
              value = lv_config_id ).
          lo_element->get_attribute(
            EXPORTING
              name  = cl_mdg_bs_mat_c=>gc_attr_ablock_component_id
            IMPORTING
              value = lv_component ).
        CATCH cx_wd_context.
      ENDTRY.
      cl_mdg_bs_mat_toc_feeder=>get_root_component(
        EXPORTING
          iv_component = ls_instance_key-component
          iv_config_id = ls_instance_key-config_id
        IMPORTING
          ev_component = lv_root_comp
          ev_config_id = lv_root_conf ).

      IF lv_config_id = lv_root_conf AND
         lv_component = lv_root_comp.
*         the new list control class is present starting from SAP_BS_FND 747,
*         but we are also working with SAP_BS_FND 731, so a check is required
        lo_class_descr ?= cl_abap_classdescr=>describe_by_object_ref( mo_ui_table ).
        READ TABLE lo_class_descr->interfaces TRANSPORTING NO FIELDS
             WITH KEY name = lc_if_list_cntrl.
*       SAP_BS_FND 747
        IF sy-subrc = 0.
          lv_methodname = lc_meth_preferred.
          lo_intf_descr = lo_class_descr->get_interface_type( p_name = lc_if_list_cntrl ).
          READ TABLE lo_intf_descr->methods TRANSPORTING NO FIELDS
               WITH KEY name = lv_methodname.
          IF sy-subrc <> 0.
            CLEAR lv_methodname.
          ENDIF.
*       SAP_BS_FND 731
        ELSE.
          lv_methodname = lc_meth_alternat.
          READ TABLE lo_class_descr->interfaces TRANSPORTING NO FIELDS
               WITH KEY name = lc_if_table_cntrl.
          IF sy-subrc = 0.
            lo_intf_descr = lo_class_descr->get_interface_type( p_name = lc_if_table_cntrl ).
            READ TABLE lo_intf_descr->methods TRANSPORTING NO FIELDS
                 WITH KEY name = lv_methodname.
            IF sy-subrc <> 0.
              CLEAR lv_methodname.
            ENDIF.
          ELSE.
            CLEAR lv_methodname.
          ENDIF.
        ENDIF.

        IF lv_methodname IS NOT INITIAL.
          CALL METHOD mo_ui_table->(lv_methodname)
            RECEIVING
              eo_list_ats_control = lo_extended_ctrl.
          READ TABLE mt_parameter_value INTO ls_par_value
               WITH KEY name = cl_mdg_bs_mat_c=>gc_param_first_field.
          ASSIGN ls_par_value-value->* TO <lv_first_field>.
          IF <lv_first_field> IS ASSIGNED AND
             NOT <lv_first_field> IS INITIAL AND
             lo_extended_ctrl IS BOUND.
            TRY.
                lo_extended_ctrl->request_focus_on_cell(
                  iv_name  = <lv_first_field>
                  iv_index = 1 ).
              CATCH cx_salv_api_contract_violation.
            ENDTRY.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.


ENDMETHOD.


METHOD GET_CONTEXT_DATA.

  DATA lv_node_name      TYPE        /plmb/spi_node_name.
  DATA lr_data           TYPE REF TO data.
  DATA lo_tabledescr     TYPE REF TO cl_abap_tabledescr.

  FIELD-SYMBOLS <lt_data> TYPE ANY TABLE.


  get_node_entity( IMPORTING ev_node_name = lv_node_name ).

  TRY.
      mo_application_model->mo_metadata->get_node_metadata( lv_node_name )->get_data_rtti(
        IMPORTING
          eo_table_description = lo_tabledescr ).

      CREATE DATA lr_data TYPE HANDLE lo_tabledescr.
      ASSIGN lr_data->* TO <lt_data>.

      mo_context->get_rows(
        EXPORTING
          it_index = it_index
        IMPORTING
          et_row   = <lt_data> ).
      GET REFERENCE OF <lt_data> INTO rt_data.

    CATCH /plmb/cx_spi_metadata. "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD GET_NODE_ENTITY.

  FIELD-SYMBOLS <ls_parameter1> TYPE fpmgb_s_param_value.
  FIELD-SYMBOLS <ls_parameter2> TYPE fpmgb_s_param_value.
  FIELD-SYMBOLS <lv_entity>     TYPE usmd_entity.
  FIELD-SYMBOLS <lts_entity>    TYPE mdg_bs_mat_ts_entity.
  FIELD-SYMBOLS <lv_node_name>  TYPE /plmb/spi_node_name.


  CLEAR ev_entity_name.
  CLEAR ev_node_name.
  CLEAR ets_entity_name.
* Node
  READ TABLE mt_parameter_value ASSIGNING <ls_parameter1>
       WITH KEY name = cl_mdg_bs_mat_c=>gc_param_frw_node_name.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  ASSIGN <ls_parameter1>-value->* TO <lv_node_name>.
  IF <lv_node_name> IS NOT ASSIGNED OR <lv_node_name> IS INITIAL.
    RETURN.
  ENDIF.
  ev_node_name = <lv_node_name>.

* Entity
  READ TABLE mt_parameter_value ASSIGNING <ls_parameter2>
       WITH KEY name = cl_mdg_bs_mat_c=>gc_param_entity.
  IF sy-subrc = 0.
    ASSIGN <ls_parameter2>-value->* TO <lv_entity>.
    IF <lv_entity> IS ASSIGNED AND <lv_entity> IS NOT INITIAL.
      ev_entity_name = <lv_entity>.
    ENDIF.
  ENDIF.

  " Parameter: "entity_table"
  READ TABLE mt_parameter_value ASSIGNING <ls_parameter2>
       WITH KEY name = cl_mdg_bs_mat_c=>gc_param_entity_table.
  IF sy-subrc = 0.
    ASSIGN <ls_parameter2>-value->* TO <lts_entity>.
    IF <lts_entity> IS ASSIGNED AND <lts_entity> IS NOT INITIAL.
      ets_entity_name = <lts_entity>.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD GET_NODE_NAME.
*--------------------------------------------------------------------*
* This method determines the node name by analysing the parameter
* values. Parameter values are the feeder parameters.
*--------------------------------------------------------------------*
* <- RV_NODE_NAME: name of current node
*--------------------------------------------------------------------*

  FIELD-SYMBOLS <lv_node_name> TYPE         /plmb/spi_node_name.
  FIELD-SYMBOLS <ls_parameter> LIKE LINE OF mt_parameter_value.


  CLEAR rv_node_name.

  READ TABLE mt_parameter_value ASSIGNING <ls_parameter>
       WITH KEY name = /plmu/if_frw_constants=>gc_g_feeder_parameter-node_name.
  IF sy-subrc IS INITIAL.
    IF <ls_parameter>-value IS NOT INITIAL.
      ASSIGN <ls_parameter>-value->* TO <lv_node_name>.
      rv_node_name = <lv_node_name>.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD GET_SELECTION_KEYS.

  DATA lr_table          TYPE REF TO data.
  DATA lo_info           TYPE REF TO /plmu/if_frw_context_info.
  DATA lo_table_descr    TYPE REF TO cl_abap_tabledescr.
  DATA lv_node_name      TYPE        /plmb/spi_node_name.
  DATA ls_selection_key  TYPE ty_s_selection_key.
  DATA lv_index          TYPE int4.
  DATA lo_structdescr    TYPE REF TO cl_abap_structdescr.
  DATA lo_key_struc TYPE REF TO data.

  FIELD-SYMBOLS <lt_data> TYPE INDEX TABLE.
  FIELD-SYMBOLS <ls_data> TYPE any.
  FIELD-SYMBOLS <ls_key>  TYPE any.
  FIELD-SYMBOLS <lv_value> TYPE any.

* get data ********************************************************************
  lo_info      = mo_context->get_info( ).
  lv_node_name = lo_info->get_node_name( ).
  lo_info->get_rtti( IMPORTING eo_ui_data_table = lo_table_descr ).
  IF lo_table_descr IS INITIAL.
    RETURN.
  ENDIF.

  CREATE DATA lr_table TYPE HANDLE lo_table_descr.
  ASSIGN lr_table->* TO <lt_data>.

  IF it_selection IS NOT INITIAL.
    mo_context->get_rows(
      EXPORTING
        it_index = it_selection
      IMPORTING
        et_row   = <lt_data> ).
  ENDIF.

  mo_application_model->mo_metadata->get_node_metadata( lv_node_name )->get_id_rtti(
    IMPORTING eo_structure_description = lo_structdescr ).

  LOOP AT <lt_data> ASSIGNING <ls_data>.
    CREATE DATA lo_key_struc TYPE HANDLE lo_structdescr.
    ASSIGN lo_key_struc->* TO <ls_key>.
    READ TABLE it_selection INTO lv_index INDEX sy-tabix.
    ls_selection_key-sel = lv_index.
    MOVE-CORRESPONDING <ls_data> TO <ls_key>.
*            clear material number as it may be changed
    ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_material OF STRUCTURE <ls_key> TO <lv_value>.
    IF sy-subrc EQ 0.
      CLEAR <lv_value>.
    ENDIF.
    ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_matnr OF STRUCTURE <ls_key> TO <lv_value>.
    IF sy-subrc EQ 0.
      CLEAR <lv_value>.
    ENDIF.
    GET REFERENCE OF <ls_key> INTO ls_selection_key-key.
    INSERT ls_selection_key INTO TABLE et_selection_key.
  ENDLOOP.

ENDMETHOD.                                               "#EC CI_VALPAR


METHOD INSERT_INITIAL_ROW.

  DATA:
        lo_context_info  TYPE REF TO /plmu/if_frw_context_info,
        lo_struc         TYPE REF TO cl_abap_structdescr,
        lr_row           TYPE REF TO data,
        ls_instance_key  TYPE        fpm_s_uibb_instance_key,
        lv_nrows         TYPE        int4,
        lv_node_name     TYPE /plmb/spi_node_name.

  DATA lv_parent_node_name      TYPE /plmb/spi_node_name.
  DATA lo_parent_node_metadata  TYPE REF TO /plmb/if_spi_metadata_node.
  DATA lr_id_tab                TYPE REF TO data.
  DATA lr_id_struc              TYPE REF TO data.
  DATA lr_data_tab              TYPE REF TO data.
  DATA lr_data_struc            TYPE REF TO data.

  FIELD-SYMBOLS <lt_node_data>  TYPE ANY TABLE.
  FIELD-SYMBOLS <ls_node_data>  TYPE any.
  FIELD-SYMBOLS <lt_node_id>    TYPE ANY TABLE.
  FIELD-SYMBOLS <ls_node_id>    TYPE any.

  FIELD-SYMBOLS <ls_row> TYPE data.


  CLEAR ev_failed.

* get the instance key
  ls_instance_key = get_uibb_instance_key( ).

* check whether the config_id of the UIBB is the one belogning to the UIBB whose insert-button is clicked
  IF io_event->ms_source_uibb-config_id = ls_instance_key-config_id.

    TRY.
*       find the structure of the row
        lo_context_info = mo_context->get_info( ).
        lo_context_info->get_rtti(
          IMPORTING
            eo_ui_data_structure = lo_struc ).
        CREATE DATA lr_row TYPE HANDLE lo_struc.
        ASSIGN lr_row->* TO <ls_row>.

*       get the number of rows
        mo_context->get_number_of_rows(
          IMPORTING
            ev_number_of_rows = lv_nrows ).
*       insert initial row
        mo_context->add_row(
          EXPORTING
            iv_index = lv_nrows + 1
            is_row   = <ls_row> ).
      CATCH cx_root.
        ev_failed = abap_true.
        RETURN.
    ENDTRY.

    CALL METHOD me->get_node_entity
      IMPORTING
        ev_node_name = lv_node_name.

    TRY .
        me->mo_application_model->mo_metadata->get_node_details(
           EXPORTING iv_node_name = me->get_node_name( )
            IMPORTING
              ev_parent_node_name = lv_parent_node_name ).
        lo_parent_node_metadata = me->mo_application_model->mo_metadata->get_node_metadata( iv_node_name = lv_parent_node_name ).
        lo_parent_node_metadata->get_id_container(
          IMPORTING
            er_id_table          = lr_id_tab
            er_id_structure          = lr_id_struc
        ).
        lo_parent_node_metadata->get_data_container(
          IMPORTING
            er_data_structure      = lr_data_struc
            er_data_table          = lr_data_tab
        ).
        ASSIGN lr_id_tab->* TO <lt_node_id>.
        ASSIGN lr_id_struc->* TO <ls_node_id>.
        ASSIGN lr_data_tab->* TO <lt_node_data>.
        ASSIGN lr_data_struc->* TO <ls_node_data>.
*              CATCH /plmb/cx_spi_metadata.    " SPI Metadata Exception (static)
        me->get_wire_model( )->get_inport_data( IMPORTING et_data = <lt_node_data> ).
        LOOP AT <lt_node_data> ASSIGNING <ls_node_data>.
          MOVE-CORRESPONDING <ls_node_data> TO <ls_node_id>.
          INSERT <ls_node_id> INTO TABLE <lt_node_id>.
        ENDLOOP.

        CHECK <lt_node_id> IS NOT INITIAL.

      CATCH /plmb/cx_spi_metadata.    " SPI Metadata Exception (static)
      CATCH /plmu/cx_frw_wire.
    ENDTRY.

    IF <lt_node_id> IS ASSIGNED.
      mo_application_model->mo_tools->pull_field_properties(
        EXPORTING
          iv_node_name        =     lv_node_name
          iv_reference_type   =     /plmb/if_spi_c=>gs_c_prpty_ref_type-insert
          ig_reference_data   =     <lt_node_id>
      ).
    ELSE.
*   call the SP-properties to set the fields to edit (otherwise the fields are read-only...)
    mo_application_model->mo_tools->pull_field_properties(
      EXPORTING
        iv_node_name        = lv_node_name
        iv_reference_type   = /plmb/if_spi_c=>gs_c_prpty_ref_type-insert ).
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD MARK_TRANSFERRED_ROW.

  CONSTANTS lc_op_eq  TYPE string VALUE 'EQ'.
  CONSTANTS lc_op_and TYPE string VALUE 'AND'.

  DATA lv_node_name  TYPE        /plmb/spi_node_name.
  DATA lv_clause     TYPE        string.
  DATA lr_tab_data   TYPE REF TO data.

  FIELD-SYMBOLS <ls_data> TYPE any.
  FIELD-SYMBOLS <lt_data> TYPE ANY TABLE.


  get_node_entity(
    IMPORTING
      ev_node_name   = lv_node_name ).
  lr_tab_data = get_context_data( ).
  ASSIGN lr_tab_data->* TO <lt_data>.


* when switching to edit mode the first time, template org levels
* (contained in cl_mdg_bs_mat_assist_ui=>gs_settings_data-<org_lev>_t)
* are copied to target org levels (cl_mdg_bs_mat_assist_ui=>gs_settings_data-<org_level>)
* in this case, lead selection index should be set to new org level and
  CASE lv_node_name.
    WHEN cl_mdg_bs_mat_c=>gc_node_name_marc.
      IF cl_mdg_bs_mat_assist_ui=>gs_settings_data-werks IS NOT INITIAL AND
         mv_lead_sel_index_corrected = abap_false.
        lv_clause = |{ cl_mdg_bs_mat_c=>gc_field_werks } { lc_op_eq } '{ cl_mdg_bs_mat_assist_ui=>gs_settings_data-werks }'|.
        LOOP AT <lt_data> ASSIGNING <ls_data> WHERE (lv_clause).
          mo_context->set_lead_selection_index( iv_index = sy-tabix ).
          mv_lead_sel_index = sy-tabix.
          cl_mdg_bs_mat_assist_ui=>gv_current_werks = cl_mdg_bs_mat_assist_ui=>gs_settings_data-werks.
          " For the F4 help of MRP Areas...Noteice that the API-package communicates with cl_mdg_bs_mat_smt...
          cl_mdg_bs_mat_smt=>gv_current_plant = cl_mdg_bs_mat_assist_ui=>gv_current_werks.

          mv_lead_sel_index_corrected = abap_true.
          EXIT.
        ENDLOOP.
      ENDIF.

    WHEN cl_mdg_bs_mat_c=>gc_node_name_mard.
      IF cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgort IS NOT INITIAL AND
         mv_lead_sel_index_corrected = abap_false.
        lv_clause = |{ cl_mdg_bs_mat_c=>gc_field_lgort } { lc_op_eq } '{ cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgort }'|.
        LOOP AT <lt_data> ASSIGNING <ls_data> WHERE (lv_clause).
          mo_context->set_lead_selection_index( iv_index = sy-tabix ).
          mv_lead_sel_index = sy-tabix.
          cl_mdg_bs_mat_assist_ui=>gv_current_lgort = cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgort.
          mv_lead_sel_index_corrected = abap_true.
          EXIT.
        ENDLOOP.
      ENDIF.

    WHEN cl_mdg_bs_mat_c=>gc_node_name_mvke.
      IF cl_mdg_bs_mat_assist_ui=>gs_settings_data-vkorg IS NOT INITIAL AND
         cl_mdg_bs_mat_assist_ui=>gs_settings_data-vtweg IS NOT INITIAL AND
         mv_lead_sel_index_corrected = abap_false.
        lv_clause = |{ cl_mdg_bs_mat_c=>gc_field_vkorg } { lc_op_eq } '{ cl_mdg_bs_mat_assist_ui=>gs_settings_data-vkorg }' {
                        lc_op_and } { cl_mdg_bs_mat_c=>gc_field_vtweg } { lc_op_eq } '{ cl_mdg_bs_mat_assist_ui=>gs_settings_data-vtweg }'|.
        LOOP AT <lt_data> ASSIGNING <ls_data> WHERE (lv_clause).
          mo_context->set_lead_selection_index( iv_index = sy-tabix ).
          mv_lead_sel_index = sy-tabix.
          cl_mdg_bs_mat_assist_ui=>gv_current_vkorg = cl_mdg_bs_mat_assist_ui=>gs_settings_data-vkorg.
          cl_mdg_bs_mat_assist_ui=>gv_current_vtweg = cl_mdg_bs_mat_assist_ui=>gs_settings_data-vtweg.
          mv_lead_sel_index_corrected = abap_true.
          EXIT.
        ENDLOOP.
      ENDIF.

    WHEN cl_mdg_bs_mat_c=>gc_node_name_mlgn.
      IF cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgnum IS NOT INITIAL AND
         mv_lead_sel_index_corrected = abap_false.
        lv_clause = |{ cl_mdg_bs_mat_c=>gc_field_lgnum } { lc_op_eq } '{ cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgnum }'|.
        LOOP AT <lt_data> ASSIGNING <ls_data> WHERE (lv_clause).
          mo_context->set_lead_selection_index( iv_index = sy-tabix ).
          mv_lead_sel_index = sy-tabix.
          cl_mdg_bs_mat_assist_ui=>gv_current_lgnum = cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgnum.
          mv_lead_sel_index_corrected = abap_true.
          EXIT.
        ENDLOOP.
      ENDIF.

    WHEN cl_mdg_bs_mat_c=>gc_node_name_mlgt.
      IF cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgnum IS NOT INITIAL AND
         cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgtyp IS NOT INITIAL AND
         mv_lead_sel_index_corrected = abap_false.
        lv_clause = |{ cl_mdg_bs_mat_c=>gc_field_lgnum } { lc_op_eq } '{ cl_mdg_bs_mat_assist_ui=>gv_current_lgnum }' {
                        lc_op_and } { cl_mdg_bs_mat_c=>gc_field_lgtyp } { lc_op_eq } '{ cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgtyp }'|.
        LOOP AT <lt_data> ASSIGNING <ls_data> WHERE (lv_clause).
          mo_context->set_lead_selection_index( iv_index = sy-tabix ).
          mv_lead_sel_index = sy-tabix.
          cl_mdg_bs_mat_assist_ui=>gv_current_lgnum = cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgnum.
          cl_mdg_bs_mat_assist_ui=>gv_current_lgtyp = cl_mdg_bs_mat_assist_ui=>gs_settings_data-lgtyp.
          mv_lead_sel_index_corrected = abap_true.
          EXIT.
        ENDLOOP.
      ENDIF.

    WHEN OTHERS.
      RETURN.
  ENDCASE.

ENDMETHOD.


METHOD PICK_MESSAGES.

  DATA ls_fpm_message       TYPE        fpmgb_s_t100_message.
  DATA ls_usmd_message      TYPE        usmd_s_message.
  DATA lv_nodename          TYPE        /plmb/spi_node_name.
  DATA lv_entity            TYPE        usmd_entity.
  DATA lv_fieldname         TYPE        fieldname.
  DATA lv_found             TYPE        boole_d.
  DATA lv_tabix             TYPE        sytabix.
  DATA lo_msg_nav           TYPE REF TO cl_mdg_bs_mat_msg_nav.
  DATA lo_fpm               TYPE REF TO if_fpm.
  DATA lo_fpm_cnr_ovp       TYPE REF TO if_fpm_cnr_ovp.
  DATA ls_uibb              TYPE        if_fpm_ovp=>ty_s_uibb.
  DATA lt_uibb              TYPE        if_fpm_ovp=>ty_t_uibb.
  DATA ls_instance_key      TYPE        fpm_s_uibb_instance_key.
  DATA ls_key_fields        TYPE        cl_mdg_bs_mat_assist_ui=>ty_s_key_fields.
  DATA lr_data              TYPE REF TO data.
  DATA lv_elem_index        TYPE        i.

  FIELD-SYMBOLS <lt_data>    TYPE ANY TABLE.
  FIELD-SYMBOLS <ls_message> TYPE cl_mdg_bs_mat_bol_transaction=>gty_s_message.


  CLEAR et_message.

* pick messages only makes sense if the UIBB is not hidden:
  lo_fpm = cl_fpm=>get_instance( ).
  lo_fpm_cnr_ovp ?= lo_fpm->get_service( cl_fpm_service_manager=>gc_key_cnr_ovp ).
  TRY.
      lo_fpm_cnr_ovp->get_uibbs( IMPORTING et_uibb = lt_uibb ).
    CATCH cx_fpm_floorplan.
      RETURN.
  ENDTRY.

  ls_instance_key = get_uibb_instance_key( ).

  READ TABLE lt_uibb INTO ls_uibb
    WITH KEY component = ls_instance_key-component
             config_id = ls_instance_key-config_id.
  IF NOT sy-subrc EQ 0 OR NOT ls_uibb-hidden IS INITIAL.
    RETURN.
  ENDIF.

* instantiate the msg navigation info class
  lo_msg_nav = cl_mdg_bs_mat_msg_nav=>get_instance( ).

  get_node_entity(
    IMPORTING ev_node_name   = lv_nodename
              ev_entity_name = lv_entity ).

  lr_data = get_context_data( ).
  ASSIGN lr_data->* TO <lt_data>.

  LOOP AT cl_mdg_bs_mat_bol_transaction=>gt_messages ASSIGNING <ls_message>.
    IF <ls_message> IS INITIAL.
      CONTINUE.
    ENDIF.
    lv_tabix        = sy-tabix.
    ls_usmd_message = cl_mdg_bs_mat_bol_transaction=>convert_message_to_usmd( <ls_message> ).

*   handle header messages
    IF cl_mdg_bs_mat_msg_nav=>is_header_message( iv_msgid = ls_usmd_message-msgid iv_msgno = ls_usmd_message-msgno ).
*     assigned header message contains key field information
      cl_mdg_bs_mat_assist_ui=>get_key_fields_from_hdr_msg(
         EXPORTING
           is_hdr_message = ls_usmd_message
         IMPORTING
           es_key_fields  = ls_key_fields ).
      CONTINUE.
    ENDIF.
    IF ls_key_fields IS INITIAL.
      CONTINUE.
    ENDIF.

*   handle content messages
    lo_msg_nav->read_navigation_data(
      EXPORTING is_message      = ls_usmd_message
                iv_nodename     = lv_nodename
                iv_entity       = lv_entity
                it_fields       = it_fields
      IMPORTING ef_found        = lv_found
                ev_fieldname    = lv_fieldname ).
    IF lv_found = abap_true.
*     find related context element
      cl_mdg_bs_mat_assist_ui=>get_elem_index_for_key_fields(
        EXPORTING
          it_data	      = <lt_data>
          is_key_fields	= ls_key_fields
        IMPORTING
          ev_index      = lv_elem_index ).
      IF lv_elem_index > 0.
        ls_fpm_message-message_index = <ls_message>-msg_index.
        ls_fpm_message-msgid         = <ls_message>-id.
        ls_fpm_message-msgno         = <ls_message>-number.
        ls_fpm_message-severity      = <ls_message>-type.
        ls_fpm_message-parameter_1   = <ls_message>-var1.
        ls_fpm_message-parameter_2   = <ls_message>-var2.
        ls_fpm_message-parameter_3   = <ls_message>-var3.
        ls_fpm_message-parameter_4   = <ls_message>-var4.
        ls_fpm_message-plaintext     = <ls_message>-message.
        ls_fpm_message-ref_name      = lv_fieldname.
        ls_fpm_message-ref_index     = lv_elem_index.
        APPEND ls_fpm_message TO et_message.
*       <ls_message>-reported = abap_true.
        DELETE cl_mdg_bs_mat_bol_transaction=>gt_messages.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD SET_ENTITY.
*--------------------------------------------------------------------*
* This method sets the entity in the settings buffer.
* E.g. for node NOTES there are two GUIBBs, one for basic texts and
* the other for internal comments. Each of these GUIBBs corresponds
* to a different entity.
*--------------------------------------------------------------------*

  DATA ls_uibb_instance_key TYPE fpm_s_uibb_instance_key.

  ls_uibb_instance_key = me->get_uibb_instance_key( ).

  me->mv_is_enabl_in_gov_scope =
    cl_mdg_bs_mat_assist_ui=>set_entity(
      io_application_model = mo_application_model
      it_parameter_value   = mt_parameter_value
      iv_config_id         = ls_uibb_instance_key-config_id
      it_selected_fields   = it_selected_fields ).

ENDMETHOD.


METHOD SET_INDEX.
**--------------------------------------------------------------------*
** This method sets / clears the selection / lead selection index
*
*  Selection / lead selection is cleared if
*  - context is empty or
*  - contains only initial lines
*  Selection / lead selection stays unchanged if
*  - context contains meaningful data and
*  - selection / lead selection is already set
*  - selection / lead selection is meaningful (only non initial lines)
*  (++) Last selection / lead selection is restored if
*  - context contains meaningful data
*  - current selection / lead selection is initial
*  - last selection / lead selection is meaningful (only non initial lines)
*    Exception is class assignment for lean classification: Lead selection can remain initial
*  Selection / lead selection is initialized
*  - for all other cases
*
*  (++) This situation occurs when
*  - navigating from main screen to detail screen and
*  - triggering any FPM event on detail screen !!
**--------------------------------------------------------------------*

  DATA lr_table          TYPE REF TO  data.
  DATA lr_data           TYPE REF TO  data.
  DATA lo_info           TYPE REF TO  /plmu/if_frw_context_info.
  DATA lo_table_descr    TYPE REF TO  cl_abap_tabledescr.
  DATA lo_structdescr    TYPE REF TO  cl_abap_structdescr.
  DATA lv_index          TYPE         int4.
  DATA lt_index          TYPE         int4_table.
  DATA lv_sel_index      TYPE         int4.
  DATA lv_selection      TYPE         int4.
  DATA lv_clear_select   TYPE         boole_d.
  DATA lv_non_init_rows  TYPE         i.
  DATA lv_node_name      TYPE         /plmb/spi_node_name.
  DATA ls_selection_key  TYPE         ty_s_selection_key.
  DATA lt_components     TYPE         abap_component_tab.
  DATA ls_component      LIKE LINE OF lt_components.
  DATA lv_clause         TYPE         string.

  FIELD-SYMBOLS <lt_data>  TYPE INDEX TABLE.
  FIELD-SYMBOLS <ls_data>  TYPE any.
  FIELD-SYMBOLS <ls_data_clean> TYPE any.
  FIELD-SYMBOLS <ls_key>        TYPE any.
  FIELD-SYMBOLS <lv_key>   TYPE any.
  FIELD-SYMBOLS <lv_data1> TYPE any.
  FIELD-SYMBOLS <lv_data2> TYPE any.
  FIELD-SYMBOLS <lv_berid> TYPE berid.


* get data ********************************************************************
  lo_info      = mo_context->get_info( ).
  lv_node_name = lo_info->get_node_name( ).
  lo_info->get_rtti( IMPORTING eo_ui_data_table = lo_table_descr ).
  IF lo_table_descr IS INITIAL.
    RETURN.
  ENDIF.

  CREATE DATA lr_table TYPE HANDLE lo_table_descr.
  ASSIGN lr_table->* TO <lt_data>.

  mo_context->get_rows( IMPORTING et_row = <lt_data> ).


* no data -> selection is not possible ****************************************
  CLEAR lt_index.
  CLEAR lv_non_init_rows.
  IF <lt_data> IS INITIAL.
    mo_context->set_lead_selection_index( iv_index = if_wd_context_node=>no_selection ).
    mo_context->set_selection_index( it_index = lt_index ).
    CLEAR mt_selection.
    CLEAR mt_selection_key.
    CLEAR mv_lead_sel_index.
    RETURN.
  ELSE.
    CREATE DATA lr_data TYPE HANDLE mo_field_catalogue_org.
    ASSIGN lr_data->* TO <ls_data_clean>.
    LOOP AT <lt_data> ASSIGNING <ls_data>.
      MOVE-CORRESPONDING <ls_data> TO <ls_data_clean>.
      IF <ls_data_clean> IS NOT INITIAL.
        lv_non_init_rows = lv_non_init_rows + 1.
      ENDIF.
    ENDLOOP.
*   only initial lines -> delete selections
    IF lv_non_init_rows = 0.
      mo_context->set_lead_selection_index( iv_index = if_wd_context_node=>no_selection ).
      mo_context->set_selection_index( it_index = lt_index ).
      CLEAR mt_selection.
      CLEAR mt_selection_key.
      CLEAR mv_lead_sel_index.
      RETURN.
    ENDIF.
  ENDIF.


* check current selection *****************************************************
  mo_context->get_lead_selection_index( IMPORTING ev_index = lv_index ).
  mo_context->get_selection_index( IMPORTING et_index = lt_index ).


* lead selection index / selection table NOT initial **************************
* selection table not initial -> check each selection
* remove selections on initial data rows
  CLEAR lv_clear_select.
  IF lt_index IS NOT INITIAL.
    LOOP AT lt_index INTO lv_sel_index.
      READ TABLE <lt_data> ASSIGNING <ls_data> INDEX lv_sel_index.
      IF <ls_data> IS NOT ASSIGNED OR <ls_data> IS INITIAL.
        lv_clear_select = abap_true.
        DELETE lt_index WHERE table_line = sy-tabix.
      ENDIF.
    ENDLOOP.
    IF lv_clear_select = abap_true.
      CLEAR mt_selection.
      CLEAR mt_selection_key.
    ENDIF.
  ENDIF.

* lead selection not initial -> check
* remove lead selection on inital data row
  IF lv_index > lv_non_init_rows.
    lv_index = if_wd_context_node=>no_selection.
    CLEAR mv_lead_sel_index.
  ENDIF.

* lead selection index / selection table initial, buffered index available ****
* restore last selection table - if meaningful
  CLEAR lv_clear_select.
  IF lt_index IS INITIAL AND mt_selection_key IS NOT INITIAL.
    TRY.
        mo_application_model->mo_metadata->get_node_metadata( lv_node_name )->get_id_rtti(
          IMPORTING eo_structure_description = lo_structdescr ).
        lt_components = lo_structdescr->get_components( ).

        LOOP AT mt_selection_key INTO ls_selection_key.
          ASSIGN ls_selection_key-key->* TO <ls_key>.
          CLEAR lv_clause.
          LOOP AT lt_components INTO ls_component WHERE
                                name NE cl_mdg_bs_mat_c=>gc_field_material AND
                                name NE cl_mdg_bs_mat_c=>gc_field_matnr.
            ASSIGN COMPONENT ls_component-name OF STRUCTURE <ls_key> TO <lv_key>.
            IF lv_clause IS INITIAL.
              lv_clause = |{ ls_component-name } = '{ <lv_key> }'|.
            ELSE.
              lv_clause = |{ lv_clause } AND { ls_component-name } = '{ <lv_key> }'|.
            ENDIF.
          ENDLOOP.
          LOOP AT <lt_data> ASSIGNING <ls_data> WHERE (lv_clause).
            lv_selection = sy-tabix. " SAP Note 2093224
            CONTINUE.
          ENDLOOP.
          IF sy-subrc <> 0 OR <ls_data> IS INITIAL.
*           data with stored key not found -> selection of key not valid
            DELETE mt_selection_key.
            DELETE mt_selection WHERE table_line = ls_selection_key-sel.

*           SAP Note 2093224
*           data with stored key found, but with different index -> adjust selection index
          ELSEIF lv_selection <> ls_selection_key-sel.
            DELETE mt_selection WHERE table_line = ls_selection_key-sel.
            INSERT lv_selection INTO TABLE mt_selection.
            ls_selection_key-sel = lv_selection.
            MODIFY mt_selection_key FROM ls_selection_key.

          ENDIF.
        ENDLOOP.
      CATCH /plmb/cx_spi_metadata.
        CLEAR mt_selection_key.
        CLEAR mt_selection.
    ENDTRY.
    lt_index = mt_selection.
  ENDIF.

  CASE lv_node_name.
    WHEN cl_mdg_bs_mat_c=>gc_node_name_mkal.
      IF lv_index < 1 AND mv_lead_sel_index > 0.
        READ TABLE <lt_data> ASSIGNING <ls_data> INDEX mv_lead_sel_index.
        IF sy-subrc <> 0.
          " mark last row
          lv_index = lv_non_init_rows.
        ELSE.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_verid OF STRUCTURE <ls_data> TO <lv_data1>.
          IF <lv_data1> IS INITIAL.
            " mark last row
            lv_index = lv_non_init_rows.
          ELSE.
            " Otherwise mark related data set
            TRY.
                mo_application_model->mo_metadata->get_node_metadata( lv_node_name )->get_id_rtti(
                  IMPORTING eo_structure_description = lo_structdescr ).
                lt_components = lo_structdescr->get_components( ).

                READ TABLE mt_selection_key INTO ls_selection_key
                     WITH KEY sel = mv_lead_sel_index.
                IF sy-subrc = 0.
                  ASSIGN ls_selection_key-key->* TO <ls_key>.
                  CLEAR lv_clause.
                  LOOP AT lt_components INTO ls_component WHERE
                                        name NE cl_mdg_bs_mat_c=>gc_field_material AND
                                        name NE cl_mdg_bs_mat_c=>gc_field_matnr.
                    ASSIGN COMPONENT ls_component-name OF STRUCTURE <ls_key> TO <lv_key>.
                    IF lv_clause IS INITIAL.
                      lv_clause = |{ ls_component-name } = '{ <lv_key> }'|.
                    ELSE.
                      lv_clause = |{ lv_clause } AND { ls_component-name } = '{ <lv_key> }'|.
                    ENDIF.
                  ENDLOOP.
                  LOOP AT <lt_data> ASSIGNING <ls_data> WHERE (lv_clause).
                    mv_lead_sel_index = sy-tabix.
                    EXIT.
                  ENDLOOP.
                ENDIF.
              CATCH /plmb/cx_spi_metadata.              "#EC NO_HANDLER
*         do nothing
            ENDTRY.
            lv_index = mv_lead_sel_index.
          ENDIF.
        ENDIF.
      ENDIF.
    WHEN cl_mdg_bs_mat_c=>gc_node_name_class_assignment.
*     do nothing
    WHEN OTHERS.
* restore last lead selection - if meaningful
      IF lv_index < 1 AND mv_lead_sel_index > 0.
        READ TABLE <lt_data> ASSIGNING <ls_data> INDEX mv_lead_sel_index.
        IF sy-subrc <> 0 OR <ls_data> IS INITIAL.
*     mark last row
          lv_index = lv_non_init_rows.

        ELSE.
*     mark related data set
          TRY.
              mo_application_model->mo_metadata->get_node_metadata( lv_node_name )->get_id_rtti(
                IMPORTING eo_structure_description = lo_structdescr ).
              lt_components = lo_structdescr->get_components( ).

              READ TABLE mt_selection_key INTO ls_selection_key
                   WITH KEY sel = mv_lead_sel_index.
              IF sy-subrc = 0.
                ASSIGN ls_selection_key-key->* TO <ls_key>.
                CLEAR lv_clause.
                LOOP AT lt_components INTO ls_component WHERE
                                      name NE cl_mdg_bs_mat_c=>gc_field_material AND
                                      name NE cl_mdg_bs_mat_c=>gc_field_matnr.
                  ASSIGN COMPONENT ls_component-name OF STRUCTURE <ls_key> TO <lv_key>.
                  IF lv_clause IS INITIAL.
                    lv_clause = |{ ls_component-name } = '{ <lv_key> }'|.
                  ELSE.
                    lv_clause = |{ lv_clause } AND { ls_component-name } = '{ <lv_key> }'|.
                  ENDIF.
                ENDLOOP.
                LOOP AT <lt_data> ASSIGNING <ls_data> WHERE (lv_clause).
                  mv_lead_sel_index = sy-tabix.
                  EXIT.
                ENDLOOP.
              ENDIF.
            CATCH /plmb/cx_spi_metadata.                "#EC NO_HANDLER
*         do nothing
          ENDTRY.
          lv_index = mv_lead_sel_index.
        ENDIF.
      ENDIF.
  ENDCASE.

* lead selection index and buffered index initial *****************************
* check currently set org level data if lead selection index cannot be determined
* - at startup: if target org levels but no source provided
* - after startup: if lead selection index and MV_LEAD_SEL_INDEX are cleared explicitly
  IF mv_lead_sel_index IS INITIAL.
    CASE lv_node_name.
      WHEN cl_mdg_bs_mat_c=>gc_node_name_marc.
        LOOP AT <lt_data> ASSIGNING <ls_data>.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_werks OF STRUCTURE <ls_data> TO <lv_data1>.
          IF <lv_data1> IS ASSIGNED.
            IF <lv_data1> = cl_mdg_bs_mat_assist_ui=>gv_current_werks AND <lv_data1> IS NOT INITIAL.
              lv_index = sy-tabix.
              EXIT.
            ENDIF.
          ENDIF.
        ENDLOOP.
      WHEN cl_mdg_bs_mat_c=>gc_node_name_mvke.
        LOOP AT <lt_data> ASSIGNING <ls_data>.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_vkorg OF STRUCTURE <ls_data> TO <lv_data1>.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_vtweg OF STRUCTURE <ls_data> TO <lv_data2>.
          IF <lv_data1> IS ASSIGNED AND <lv_data2> IS ASSIGNED.
            IF <lv_data1> = cl_mdg_bs_mat_assist_ui=>gv_current_vkorg AND
               <lv_data2> = cl_mdg_bs_mat_assist_ui=>gv_current_vtweg AND
               <lv_data1> IS NOT INITIAL AND
               <lv_data2> IS NOT INITIAL.
              lv_index = sy-tabix.
              EXIT.
            ENDIF.
          ENDIF.
        ENDLOOP.
      WHEN cl_mdg_bs_mat_c=>gc_node_name_mard.
        LOOP AT <lt_data> ASSIGNING <ls_data>.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_lgort OF STRUCTURE <ls_data> TO <lv_data1>.
          IF <lv_data1> IS ASSIGNED.
            IF <lv_data1> = cl_mdg_bs_mat_assist_ui=>gv_current_lgort AND <lv_data1> IS NOT INITIAL.
              lv_index = sy-tabix.
              EXIT.
            ENDIF.
          ENDIF.
        ENDLOOP.
      WHEN cl_mdg_bs_mat_c=>gc_node_name_mlgn.
        LOOP AT <lt_data> ASSIGNING <ls_data>.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_lgnum OF STRUCTURE <ls_data> TO <lv_data1>.
          IF <lv_data1> IS ASSIGNED.
            IF <lv_data1> = cl_mdg_bs_mat_assist_ui=>gv_current_lgnum AND <lv_data1> IS NOT INITIAL.
              lv_index = sy-tabix.
              EXIT.
            ENDIF.
          ENDIF.
        ENDLOOP.
      WHEN cl_mdg_bs_mat_c=>gc_node_name_mlgt.
        LOOP AT <lt_data> ASSIGNING <ls_data>.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_lgnum OF STRUCTURE <ls_data> TO <lv_data1>.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_lgtyp OF STRUCTURE <ls_data> TO <lv_data2>.
          IF <lv_data1> IS ASSIGNED AND <lv_data2> IS ASSIGNED.
            IF <lv_data1> = cl_mdg_bs_mat_assist_ui=>gv_current_lgnum AND
               <lv_data2> = cl_mdg_bs_mat_assist_ui=>gv_current_lgtyp AND
               <lv_data1> IS NOT INITIAL AND
               <lv_data2> IS NOT INITIAL.
              lv_index = sy-tabix.
              EXIT.
            ENDIF.
          ENDIF.
        ENDLOOP.
      WHEN cl_mdg_bs_mat_c=>gc_node_name_mkal.
        LOOP AT <lt_data> ASSIGNING <ls_data>.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_verid OF STRUCTURE <ls_data> TO <lv_data1>.
          IF <lv_data1> IS ASSIGNED.
            IF <lv_data1> = cl_mdg_bs_mat_assist_ui=>gv_current_verid_popup AND <lv_data1> IS NOT INITIAL.
              lv_index = sy-tabix.
              EXIT.
            ENDIF.
          ENDIF.
        ENDLOOP.
      WHEN cl_mdg_bs_mat_c=>gc_node_name_mdma.
        LOOP AT <lt_data> ASSIGNING <ls_data>.
          ASSIGN COMPONENT cl_mdg_bs_mat_c=>gc_field_berid OF STRUCTURE <ls_data> TO <lv_data1>.
          IF <lv_data1> IS ASSIGNED.
            IF cl_mdg_bs_mat_assist_ui=>gv_current_berid_popup IS INITIAL.
              IF <lv_data1> = cl_mdg_bs_mat_assist_ui=>gv_current_berid AND <lv_data1> IS NOT INITIAL.
                lv_index = sy-tabix.
                EXIT.
              ENDIF.
            ELSE.
              IF <lv_data1> = cl_mdg_bs_mat_assist_ui=>gv_current_berid_popup AND <lv_data1> IS NOT INITIAL.
                lv_index = sy-tabix.
                EXIT.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDLOOP.
    ENDCASE.
  ENDIF.


* set consistent settings *****************************************************
  IF lv_index < 1 AND lt_index IS INITIAL.
    "Do not reset lead selection for Lean Classification Class Assignment
    IF lv_node_name = cl_mdg_bs_mat_c=>gc_node_name_class_assignment.
      RETURN.
    ENDIF.
*    lv_index = 1.  " default value = first line
*    APPEND lv_index TO lt_index.
  ELSEIF lv_index < 1 AND lt_index IS NOT INITIAL.
    READ TABLE lt_index INTO lv_index INDEX 1.
  ELSEIF lv_index > 0 AND lt_index IS INITIAL.
    APPEND lv_index TO lt_index.
  ELSE.
    APPEND lv_index TO lt_index.
  ENDIF.
  SORT lt_index.
  DELETE ADJACENT DUPLICATES FROM lt_index.

  mo_context->set_lead_selection_index( iv_index = lv_index ).
  mo_context->set_selection_index( it_index = lt_index ).

  mv_lead_sel_index = lv_index.
  mt_selection      = lt_index.
  TRY.
      get_selection_keys(
        EXPORTING
          it_selection     = mt_selection
        IMPORTING
          et_selection_key = mt_selection_key ).
    CATCH /plmb/cx_spi_metadata.
      CLEAR mt_selection_key.
  ENDTRY.
  " remove the value of berid after Add/Copy for MRP Areas
  IF lv_node_name = cl_mdg_bs_mat_c=>gc_node_name_mdma.
    CLEAR cl_mdg_bs_mat_assist_ui=>gv_current_berid_popup.
  ENDIF.
ENDMETHOD.


METHOD UPDATE_STATIC_TOC.

  DATA ls_instance_key    TYPE        fpm_s_uibb_instance_key.
  DATA lv_nrows           TYPE        int4.
  DATA lo_info            TYPE REF TO /plmu/if_frw_context_info.
  DATA lo_rtti            TYPE REF TO cl_abap_tabledescr.
  DATA lr_data            TYPE REF TO data.

  FIELD-SYMBOLS <ls_data> TYPE any.
  FIELD-SYMBOLS <lt_data> TYPE ANY TABLE.


  ls_instance_key = get_uibb_instance_key( ).

  lo_info = mo_context->get_info( ).
  lo_info->get_rtti(
    IMPORTING
      eo_ui_data_table = lo_rtti ).
  CREATE DATA lr_data TYPE HANDLE lo_rtti.
  ASSIGN lr_data->* TO <lt_data>.

  mo_context->get_rows(
    IMPORTING
      et_row = <lt_data> ).
  LOOP AT <lt_data> ASSIGNING <ls_data>.
    IF <ls_data> IS INITIAL.
      DELETE <lt_data> USING KEY loop_key.
    ENDIF.
  ENDLOOP.

  lv_nrows = lines( <lt_data> ).
  cl_mdg_bs_mat_toc_feeder=>set_count(
    iv_component = ls_instance_key-component
    iv_config_id = ls_instance_key-config_id
    iv_count     = lv_nrows ).

ENDMETHOD.
ENDCLASS.
