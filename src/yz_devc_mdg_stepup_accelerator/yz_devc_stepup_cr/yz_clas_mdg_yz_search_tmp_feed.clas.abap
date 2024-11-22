class YZ_CLAS_MDG_YZ_SEARCH_TMP_FEED definition
  public
  inheriting from CL_USMD_SEARCH_GUIBB_RESULT
  final
  create public .

public section.

  methods IF_FPM_GUIBB~INITIALIZE
    redefinition .
protected section.

  methods NAVIGATE_TO_OVP
    redefinition .
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_YZ_SEARCH_TMP_FEED IMPLEMENTATION.


  method IF_FPM_GUIBB~INITIALIZE.

CALL METHOD super->if_fpm_guibb~initialize
  EXPORTING
    it_parameter      = it_parameter
    io_app_parameter  = io_app_parameter
    iv_component_name = iv_component_name
    is_config_key     = is_config_key
    iv_instance_id    = iv_instance_id.

    me->mv_link_column = 'TMP_ID'.
  endmethod.


  method NAVIGATE_TO_OVP.
    DATA:
      lo_communicator TYPE REF TO cl_mdg_bs_communicator_assist,
      lt_parameters   TYPE tihttpnvp.

    FIELD-SYMBOLS:
      <ls_parameter> LIKE LINE OF lt_parameters.

* get params and communicator
    lt_parameters = it_additional_url_parameters.
    lo_communicator = cl_mdg_bs_communicator_assist=>get_instance( ).

* check if there is a CRTYPE set
    IF lo_communicator IS BOUND
      AND lo_communicator->mv_cba_crequest_type IS NOT INITIAL.
*   If yes, ensure that this will become a navi parameter for OVP based CBAs
      APPEND INITIAL LINE TO lt_parameters ASSIGNING <ls_parameter>.
      <ls_parameter>-name  = lo_communicator->gc_parameter-dim_crequest_type.
      <ls_parameter>-value = lo_communicator->mv_cba_crequest_type.
    ENDIF.

* forward to parent
super->navigate_to_ovp( EXPORTING it_additional_url_parameters = it_additional_url_parameters ).


  endmethod.
ENDCLASS.
