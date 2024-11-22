class YCL_MDG_MM_BOMITM_FEEDER_LIST definition
  public
  inheriting from CL_MDG_BS_MAT_FEEDER_LIST
  create public .

public section.

  methods /PLMU/IF_FRW_G_ACTIONS~GET_ACTION_DEFINITION
    redefinition .
  methods /PLMU/IF_FRW_G_ACTIONS~PROCESS_ACTION_EVENT
    redefinition .
  methods /PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA
    redefinition .
  methods /PLMU/IF_FRW_G_BEFORE_GET_DATA~BEFORE_GET_DATA
    redefinition .
  methods /PLMU/IF_FRW_G_FIELD_DEF~CHANGE_FIELD_DEFINITION
    redefinition .
protected section.
private section.

  methods DEFINE_LOCAL_FIELDS
    changing
      !CO_CATALOGUE type ref to CL_ABAP_STRUCTDESCR
      !CT_DEFINITION type /PLMU/T_FRW_G_FIELD_DESCR_APPL .
  methods SET_ACTIONS_TXT .
  methods DISCARD_SELECTION
    importing
      !IV_STRUC_NAME type STRING
      !IV_NODE type /PLMB/SPI_NODE_NAME
      !IV_ACTION type /PLMB/SPI_ACTION_NAME .
ENDCLASS.



CLASS YCL_MDG_MM_BOMITM_FEEDER_LIST IMPLEMENTATION.


  METHOD /plmu/if_frw_g_actions~get_action_definition.
CALL METHOD super->/plmu/if_frw_g_actions~get_action_definition
  CHANGING
    ct_action_definition     = ct_action_definition
*    ct_row_action_definition =
    .
   INSERT VALUE #( id = cl_mdg_bs_mat_c=>gc_event_roundtrip text = 'Roundtrip' ) INTO TABLE ct_action_definition.
   INSERT VALUE #( id = cl_fpm_event=>gc_event_call_default_det_page text = 'Details' enabled = abap_true visible = '02' ) INTO TABLE ct_action_definition.
   INSERT VALUE #( id = cl_fpm_event=>gc_event_call_default_ed_page text = 'Edit' enabled = abap_true visible = '02' ) INTO TABLE ct_action_definition.
  " INSERT VALUE #( id = 'DISCARD_ITEM' text = 'Discard' enabled = abap_true visible = '02' ) INTO TABLE CT_ACTION_DEFINITION.

*   LOOP AT CT_ACTION_DEFINITION ASSIGNING FIELD-SYMBOL(<LFS_ACTION_DEFINITION>) WHERE id = 'DISCARD_ITEM'.
*
*     <LFS_ACTION_DEFINITION>-enabled = abap_true.
*     <LFS_ACTION_DEFINITION>-visible = '02'.
*  <LFS_ACTION_DEFINITION>-text = 'Discard Item'.
*   ENDLOOP.


  ENDMETHOD.


  METHOD /plmu/if_frw_g_actions~process_action_event.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_ACTIONS~PROCESS_ACTION_EVENT
*  EXPORTING
*    IO_EVENT        =
**    iv_index        =
**  IMPORTING
**    ev_skip_default =
**    ev_result       =
**    et_messages     =
*    .
  CLEAR ev_result.
  CLEAR ev_skip_default.
  CLEAR et_messages.

  super->/plmu/if_frw_g_actions~process_action_event(
    EXPORTING
      io_event        = io_event
    IMPORTING
      ev_skip_default = ev_skip_default
      ev_result       = ev_result
      et_messages     = et_messages ).

*IF io_event->mv_event_id  = 'DISCARD_ITEM'.
* DATA(lw_node) = mo_context->get_info( )->get_node_name( ).
*  IF 'YMDGM_YBOMITM' = mo_context->get_info( )->get_node_name( ).
*      discard_selection(
*        EXPORTING
*          iv_struc_name = 'YMDGM_YBOMHDR_S'
*          iv_node       =  'YMDGM_YBOMITM'                " Node Name
*          iv_action     =  'DISCARD_ITEM'                " Action Name
*      ).
*  ENDIF.

* ENDIF.
  ENDMETHOD.


  method /PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA.
*CALL METHOD SUPER->/PLMU/IF_FRW_G_AFTER_GET_DATA~AFTER_GET_DATA
*  EXPORTING
*    IV_FIRST_TIME           =
*    IO_EVENT                =
**    it_selected_fields      =
**  IMPORTING
**    et_message              =
**    ev_field_usage_changed  =
**    ev_action_usage_changed =
*  CHANGING
*    CT_FIELD_USAGE          =
*    CT_ACTION_USAGE         =
*    .

     super->/plmu/if_frw_g_after_get_data~after_get_data(
    EXPORTING
      iv_first_time           = iv_first_time
      io_event                = io_event
      it_selected_fields      = it_selected_fields
    IMPORTING
      et_message              = et_message
      ev_field_usage_changed  = ev_field_usage_changed
      ev_action_usage_changed = ev_action_usage_changed
    CHANGING
      ct_field_usage          = ct_field_usage
      ct_action_usage         = ct_action_usage ).



  IF cl_mdg_bs_mat_assist_ui=>is_last_event( abap_true ) = abap_true.

*   Set INFO_TXT: Used to display link for drill down in hiearchical UI
    set_actions_txt( ).

  ENDIF.


  endmethod.


  method /PLMU/IF_FRW_G_BEFORE_GET_DATA~BEFORE_GET_DATA.
  super->/plmu/if_frw_g_before_get_data~before_get_data(
    EXPORTING
      io_event           = io_event
      iv_first_time      = iv_first_time
      iv_lock            = iv_lock
      it_selected_fields = it_selected_fields
    IMPORTING
      ev_skip_retrieve   = ev_skip_retrieve ).
  endmethod.


  method /PLMU/IF_FRW_G_FIELD_DEF~CHANGE_FIELD_DEFINITION.
CALL METHOD super->/plmu/if_frw_g_field_def~change_field_definition
  IMPORTING
    et_special_groups = et_special_groups
  CHANGING
    co_catalogue      = co_catalogue
    ct_definition     = ct_definition
    .


      define_local_fields(
    CHANGING
      co_catalogue  = co_catalogue
      ct_definition = ct_definition ).

* store field description for later read accesses
  mt_definition = ct_definition.
  endmethod.


  method DEFINE_LOCAL_FIELDS.
  DATA lt_component  TYPE abap_component_tab.
  DATA ls_component1  LIKE LINE OF lt_component.
  DATA ls_component  like LINE OF lt_component.
  DATA lv_node_name  TYPE /plmb/spi_node_name.

    lv_node_name = mo_context->get_info( )->get_node_name( ).
* catalogue
    lt_component = co_catalogue->get_components( ).


    IF NOT line_exists( lt_component[ name = cl_mdg_bs_mat_c=>gc_field_action_details ] ).

      APPEND VALUE #(  name = cl_mdg_bs_mat_c=>gc_field_action_details type = cl_abap_elemdescr=>get_string( ) )
                                TO lt_component.
    ENDIF.

    co_catalogue = cl_abap_structdescr=>create( p_components = lt_component ).

    IF NOT line_exists( ct_definition[ name = cl_mdg_bs_mat_c=>gc_field_action_details ] ).
     INSERT VALUE #( name = cl_mdg_bs_mat_c=>gc_field_action_details label_text = 'Details' ) INTO TABLE ct_definition.
    ENDIF.
  endmethod.


  method DISCARD_SELECTION.

*  DATA lo_struc        TYPE REF TO cl_abap_structdescr.
*  DATA lo_info         TYPE REF TO /plmu/if_frw_context_info.
*  DATA lr_row          TYPE REF TO  data.
*  DATA lv_index        TYPE        int4.
*  DATA lr_data         TYPE REF TO data.
*  DATA lt_component    TYPE        abap_compdescr_tab.
*  DATA ls_component    TYPE        abap_compdescr.
*
*  FIELD-SYMBOLS <ls_struc>   TYPE any.
*  FIELD-SYMBOLS <ls_row>     TYPE any.
*  FIELD-SYMBOLS <lv_comp_s>  TYPE any.
*  FIELD-SYMBOLS <lv_comp_t>  TYPE any.
*
*
** create data object for current context
*  lo_info = mo_context->get_info( ).
*  lo_info->get_rtti(
*    IMPORTING eo_ui_data_structure = lo_struc ).
*  CREATE DATA lr_row  TYPE HANDLE lo_struc.
*  ASSIGN lr_row->*  TO <ls_row>.
*
** get data for leed selection
*  mo_context->get_lead_selection_index(
*    IMPORTING ev_index = lv_index ).
*  IF lv_index > 0.
*    mo_context->get_row(
*      EXPORTING iv_index = mo_context->gc_use_lead_selection
*      IMPORTING es_row   = <ls_row> ).
*  ENDIF.
*
** set key info in created data object
*  CREATE DATA lr_data TYPE (iv_struc_name).
*  ASSIGN lr_data->* TO <ls_struc>.
*  lo_struc ?= cl_abap_structdescr=>describe_by_name( iv_struc_name ).
*  lt_component = lo_struc->components.
*  IF <ls_row> IS NOT INITIAL.
*    LOOP AT lt_component INTO ls_component.
*      ASSIGN COMPONENT ls_component-name OF STRUCTURE <ls_struc> TO <lv_comp_t>.
*      ASSIGN COMPONENT ls_component-name OF STRUCTURE <ls_row>   TO <lv_comp_s>.
*      IF sy-subrc = 0.
*        <lv_comp_t> = <lv_comp_s>.
*      ENDIF.
*    ENDLOOP.
*  ENDIF.
*
** proces action
*  mo_application_model->action(
*    iv_node_name    = iv_node
*    iv_action_name  = iv_action
*    is_param        = <ls_struc> ).

  endmethod.


  method SET_ACTIONS_TXT.
  DATA lv_txt       TYPE string VALUE 'Details'.
  DATA(lv_node_name) = mo_context->get_info( )->get_node_name( ).

    mo_context->get_number_of_rows( IMPORTING ev_number_of_rows = DATA(lv_count) ).


     DO lv_count TIMES.

          mo_context->set_attribute(
         EXPORTING
           iv_index = sy-index
           iv_name  = cl_mdg_bs_mat_c=>gc_field_action_details
           iv_value = lv_txt ).

    ENDDO.
  endmethod.
ENDCLASS.
