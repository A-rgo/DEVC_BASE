class YZ_CLAS_RULE_CHART definition
  public
  inheriting from CL_FPM_SADL_CHART
  final
  create public .

public section.

  methods IF_FPM_GUIBB_CHART~GET_DATA
    redefinition .
  methods IF_FPM_GUIBB_CHART~GET_DEFINITION
    redefinition .
protected section.

  methods SET_VIEW_PARAMETERS
    redefinition .
private section.
ENDCLASS.



CLASS YZ_CLAS_RULE_CHART IMPLEMENTATION.


  METHOD if_fpm_guibb_chart~get_data.

*    CALL METHOD super->if_fpm_guibb_chart~get_data
*      EXPORTING
*        io_event                = io_event
*        iv_raised_by_own_ui     = iv_raised_by_own_ui
*        io_chart_data           = io_chart_data
*        io_chart_selection      = io_chart_selection
*        io_chart_settings       = io_chart_settings
*        io_extended_ctrl        = io_extended_ctrl
*      IMPORTING
*        et_messages             = et_messages
*        ev_action_usage_changed = ev_action_usage_changed
*      CHANGING
*        ct_action_usage         = ct_action_usage.

    FIELD-SYMBOLS:
       <lt_data> TYPE STANDARD TABLE.


*----- start pbo
    init_pbo( io_event ).

*----- first time
    IF mr_data IS INITIAL.
      CREATE DATA mr_data TYPE HANDLE mo_field_cat.
      DATA(lo_table_model) = io_chart_data->get_table_model( ).
      mt_dimenison = lo_table_model->get_dimensions( ).
      mt_measure = lo_table_model->get_measures( ).
      prepare_chart_query( ).
    ENDIF.

*---- reset selection buffer for failed events
    CLEAR mo_selection_old.

*----- anything to do?
    IF has_new_input( ) = abap_false.
      RETURN.
    ENDIF.

*----- selection object
    CREATE OBJECT mo_selection.

*----- register selection condition
    register_condition(  ).

*----- retrieve data
    execute_query( ).

*----- transfer to chart
    ASSIGN mr_data->* TO <lt_data>.
    io_chart_data->get_table_model( )->set_data( <lt_data> ).


  ENDMETHOD.


  METHOD if_fpm_guibb_chart~get_definition.
    CALL METHOD super->if_fpm_guibb_chart~get_definition
      EXPORTING
        io_chart_model       = io_chart_model
      IMPORTING
        et_action_definition = et_action_definition
        es_message           = es_message.
  ENDMETHOD.


  METHOD set_view_parameters.
    CALL METHOD super->set_view_parameters
      EXPORTING
        it_parameter = it_parameter.
  ENDMETHOD.
ENDCLASS.
