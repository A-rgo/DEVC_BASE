class YCL_MDG_MM_BOMHDR_FEEDER_LIST definition
  public
  inheriting from CL_MDG_BS_MAT_FEEDER_LIST
  create public .

public section.

  constants GC_EVENT_BOM_ADD type FPM_EVENT_ID value 'MDGM_BOM_ADD' ##NO_TEXT.
  constants GC_EVENT_BOM_DISCARD type FPM_EVENT_ID value 'MDGM_BOM_DISCARD' ##NO_TEXT.

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
  methods /PLMU/IF_FRW_G_GLOBAL_EVENTS~PROCESS_GLOBAL_EVENT
    redefinition .
protected section.
private section.

  methods DEFINE_LOCAL_FIELDS
    changing
      !CO_CATALOGUE type ref to CL_ABAP_STRUCTDESCR
      !CT_DEFINITION type /PLMU/T_FRW_G_FIELD_DESCR_APPL .
  methods SET_ACTIONS_TXT .
ENDCLASS.



CLASS YCL_MDG_MM_BOMHDR_FEEDER_LIST IMPLEMENTATION.


  method /PLMU/IF_FRW_G_ACTIONS~GET_ACTION_DEFINITION.
*
**CALL METHOD SUPER->/PLMU/IF_FRW_G_ACTIONS~GET_ACTION_DEFINITION
**  CHANGING
**    CT_ACTION_DEFINITION     = CT_ACTION_DEFINITION
**    ct_row_action_definition = CT_ROW_ACTION_DEFINITION
**    .
*

   INSERT VALUE #( id = cl_mdg_bs_mat_c=>gc_event_roundtrip text = 'Roundtrip' ) INTO TABLE CT_ACTION_DEFINITION.
   INSERT VALUE #( id = cl_fpm_event=>gc_event_call_default_det_page text = 'Details' enabled = abap_true visible = '02' ) INTO TABLE CT_ACTION_DEFINITION.
   INSERT VALUE #( id = cl_fpm_event=>gc_event_call_default_ed_page text = 'Edit' enabled = abap_true visible = '02' ) INTO TABLE CT_ACTION_DEFINITION.
   INSERT VALUE #( id = ycl_mdg_mm_bomhdr_feeder_list=>gc_event_bom_add text = 'Add' enabled = abap_true visible = '02' ) INTO TABLE CT_ACTION_DEFINITION.
   INSERT VALUE #( id = ycl_mdg_mm_bomhdr_feeder_list=>gc_event_bom_discard text = 'Discard' enabled = abap_true visible = '02' ) INTO TABLE CT_ACTION_DEFINITION.

   "INSERT VALUE #(



  endmethod.


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


DATA: lt_data_plant TYPE TABLE OF mdg_bs_mat_s_mp_marcc_data.

 IF io_event->mv_event_id = 'FRW_INSERT'.

    mo_context->get_selection(
              IMPORTING
                et_selection = lt_data_plant ).

 ENDIF.


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

*    Added for enable Add button on UI
    ASSIGN ct_action_usage to FIELD-SYMBOL(<lt_action_usage>).
    IF <lt_action_usage> is ASSIGNED AND <lt_action_usage> is not INITIAL.
      LOOP AT <lt_action_usage> ASSIGNING FIELD-SYMBOL(<ls_action_usage>).
        IF <ls_action_usage>-id = 'FRW_INSERT' OR <ls_action_usage>-id = 'FRW_DELETE'.
          <ls_action_usage>-enabled = abap_true.
        ENDIF.
         IF <ls_action_usage>-id = 'FRW_DELETE'.
          <ls_action_usage>-visible = abap_false.
        ENDIF.
      ENDLOOP.

    ENDIF.




  IF cl_mdg_bs_mat_assist_ui=>is_last_event( abap_true ) = abap_true.

*   Set INFO_TXT: Used to display link for drill down in hiearchical UI
    set_actions_txt( ).

  ENDIF.

  IF io_event->mv_event_id = 'FPM_CALL_DEFAULT_DETAILS_PAGE'.

  DATA(lr_fpm) = cl_fpm_factory=>get_instance( ).

   CASE mo_context->get_info( )->get_node_name( ).

     WHEN 'YBOMHDR'.

 DATA(lv_fieldname) = cl_mdg_bs_mat_assist_ui=>if_mdg_bs_mat_gen_c~gc_attr_werks.
 READ TABLE cl_mdg_bs_mat_assist_ui=>gt_werks_derive INTO DATA(ls_werks_derive)
               WITH KEY werks = cl_mdg_bs_mat_assist_ui=>gv_current_werks.

   ENDCASE.


DATA : lv_key TYPE STRING.
FIELD-SYMBOLS : <lv_value> TYPE any.
DATA : er_value TYPE REF TO data.
  lr_fpm->mo_app_parameter->set_value(
    EXPORTING
      iv_key   =  'YBOMHDR'
*      iv_value =
*      ir_value =
  ).
*
*mo_context->get_info( ).


  ENDIF.



  endmethod.


  METHOD /plmu/if_frw_g_before_get_data~before_get_data.
  super->/plmu/if_frw_g_before_get_data~before_get_data(
    EXPORTING
      io_event           = io_event
      iv_first_time      = iv_first_time
      iv_lock            = iv_lock
      it_selected_fields = it_selected_fields
    IMPORTING
      ev_skip_retrieve   = ev_skip_retrieve ).



   DATA lv_node_name       TYPE        /plmb/spi_node_name.
   DATA lv_entity_name     TYPE        string.
   DATA lv_key   TYPE string.
   DATA er_event_data TYPE REF TO data.
   FIELD-SYMBOLS <lt_data>     TYPE INDEX TABLE.


  CASE io_event->mv_event_id.
    WHEN 'FPW_INSERT'.

    READ TABLE mt_parameter_value INTO DATA(ls_param) WITH KEY name = cl_mdg_bs_mat_c=>gc_param_entity.
    IF sy-subrc = 0.
      ASSIGN ls_param-value->* TO FIELD-SYMBOL(<lv_entity>).
      IF <lv_entity> IS ASSIGNED.
        lv_entity_name = <lv_entity>.
      ENDIF.
    ENDIF.

*   get node name
    lv_node_name = mo_context->/plmu/if_frw_context~get_info( )->get_node_name( ).

*    io_event->mo_event_data->set_value(
*      EXPORTING
*        iv_key   =
*        iv_value =
*        ir_value =
*    ).

      lv_key = lv_node_name.
    io_event->mo_event_data->get_value(
      EXPORTING
        iv_key   = lv_key
      IMPORTING
        er_value = er_event_data ).

  ASSIGN er_event_data->* TO <lt_data>.

    ENDCASE.





  ENDMETHOD.


  METHOD /plmu/if_frw_g_field_def~change_field_definition.
CALL METHOD super->/plmu/if_frw_g_field_def~change_field_definition
  IMPORTING
    et_special_groups = et_special_groups
  CHANGING
    co_catalogue      = co_catalogue
    ct_definition     = ct_definition
    .

DATA(lv_node_name) = mo_context->get_info( )->get_node_name( ).

      define_local_fields(
    CHANGING
      co_catalogue  = co_catalogue
      ct_definition = ct_definition ).

* store field description for later read accesses
  mt_definition = ct_definition.


  ENDMETHOD.


  method /PLMU/IF_FRW_G_GLOBAL_EVENTS~PROCESS_GLOBAL_EVENT.
CALL METHOD SUPER->/PLMU/IF_FRW_G_GLOBAL_EVENTS~PROCESS_GLOBAL_EVENT
  EXPORTING
    IO_EVENT            = IO_EVENT
    IV_RAISED_BY_OWN_UI = IV_RAISED_BY_OWN_UI
  IMPORTING
    ev_skip_default     = EV_SKIP_DEFAULT
    ev_result           = EV_RESULT
    et_messages         = ET_MESSAGES
    .

DATA: lt_data_plant TYPE TABLE OF mdg_bs_mat_s_mp_marcc_data.

 IF io_event->mv_event_id = 'FRW_INSERT'.

    mo_context->get_selection(
              IMPORTING
                et_selection = lt_data_plant ).

 ENDIF.

  endmethod.


  METHOD define_local_fields.

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


  ENDMETHOD.


  METHOD set_actions_txt.

    DATA lv_txt       TYPE string VALUE 'Details'.
    FIELD-SYMBOLS  <lt_selection>  TYPE ANY TABLE.
  DATA(lv_node_name) = mo_context->get_info( )->get_node_name( ).

    mo_context->get_number_of_rows( IMPORTING ev_number_of_rows = DATA(lv_count) ).


     DO lv_count TIMES.

          mo_context->set_attribute(
         EXPORTING
           iv_index = sy-index
           iv_name  = cl_mdg_bs_mat_c=>gc_field_action_details
           iv_value = lv_txt ).






    ENDDO.


  ENDMETHOD.
ENDCLASS.
