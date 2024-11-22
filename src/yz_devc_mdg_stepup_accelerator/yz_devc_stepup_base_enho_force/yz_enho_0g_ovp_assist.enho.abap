CLASS lcl_yz_enho_0g_ovp_assist DEFINITION DEFERRED.
CLASS cl_mdg_bs_communicator_assist DEFINITION LOCAL FRIENDS lcl_yz_enho_0g_ovp_assist.
CLASS lcl_yz_enho_0g_ovp_assist DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA obj TYPE REF TO lcl_yz_enho_0g_ovp_assist.   "#EC NEEDED
    DATA core_object TYPE REF TO cl_mdg_bs_communicator_assist . "#EC NEEDED
 INTERFACES  IPO_YZ_ENHO_0G_OVP_ASSIST.
    METHODS:
      constructor IMPORTING core_object
                              TYPE REF TO cl_mdg_bs_communicator_assist OPTIONAL.
ENDCLASS.
CLASS lcl_yz_enho_0g_ovp_assist IMPLEMENTATION.
  METHOD constructor.
    me->core_object = core_object.
  ENDMETHOD.

  METHOD ipo_yz_enho_0g_ovp_assist~override_event_ovp.
*"------------------------------------------------------------------------*
*" Declaration of POST-method, do not insert any comments here please!
*"
*"methods OVERRIDE_EVENT_OVP
*"  importing
*"    !IO_OVP type ref to IF_FPM_OVP.
*"------------------------------------------------------------------------*

    DATA(lv_model)    = yz_clas_mdg_utility=>get_data_model( ).
    DATA(lv_crequest) = yz_clas_mdg_utility=>get_cr_number( ).

    IF lv_model IS NOT INITIAL AND lv_crequest IS NOT INITIAL.
     yz_clas_mdg_event_process=>execute_hide_uibb_rules(
     EXPORTING
       iv_model    = lv_model               " Data Model
       iv_crequest = lv_crequest            " Change Request
       io_ovp      = io_ovp                 " Interface for Communication FPM App CC
       ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
