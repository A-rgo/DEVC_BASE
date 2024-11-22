class YCL_MAT_BOM_UI_APPCC definition
  public
  final
  create public .

public section.

  interfaces /PLMU/IF_EX_FRW_APPCC_OVP .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS YCL_MAT_BOM_UI_APPCC IMPLEMENTATION.


  method /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_AFTER_FAILED_EVENT.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_CLEANUP.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_FAILED_EVENT.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_FLUSH.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_NEEDS_CONFIRMATION.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_PROCESS_BEFORE_OUTPUT.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_PROCESS_EVENT.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~AFTER_SAVE.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~FLUSH.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~INITIALIZATION.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~NEEDS_CONFIRMATION.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~OVERRIDE_CONFIG_TABBED.
  endmethod.


  METHOD /plmu/if_ex_frw_appcc_ovp~override_event_ovp.
*    IF sy-uname = 'ASWARUP'.
    "Reading the Change Request
     DATA:  lv_crequest   TYPE usmd_crequest. "change request
     DATA(lo_context) = cl_usmd_app_context=>get_context( ).
     CHECK lo_context IS BOUND.
     CHECK lo_context IS NOT INITIAL.
     lv_crequest = lo_context->mv_crequest_id.

     DATA: lo_crequest_api TYPE REF TO if_usmd_crequest_api.
     DATA: lt_message TYPE usmd_t_message.
     DATA: lv_crequest_type TYPE usmd_s_crequest.
     DATA: lt_uibb TYPE if_fpm_ovp=>ty_t_uibb.
     DATA: lo_ovp TYPE REF TO if_fpm_ovp.
     DATA: ls_uibb TYPE if_fpm_ovp=>ty_s_uibb.
     DATA: lt_toolbar_elements TYPE if_fpm_ovp=>ty_t_toolbar_element.
     DATA: ls_toolbar_elements TYPE if_fpm_ovp=>ty_s_toolbar_element.


*     Get instance of CR API
      CALL METHOD cl_usmd_crequest_api=>get_instance
        EXPORTING
          iv_crequest          = lv_crequest
          iv_model_name        = 'MM'                " Data Model
        IMPORTING
*          et_message           =                  " Messages
          re_inst_crequest_api =  lo_crequest_api                " Change Request API Interface
        .
      CHECK lo_crequest_api IS BOUND.
      "Reading the Change Request type
      CALL METHOD lo_crequest_api->read_crequest
        IMPORTING
          es_crequest   =     lv_crequest_type              " Change Request
*          et_note       =                  " Change Request Note
*          et_attachment =                  " Change request Attachment
*          et_message    =                  " Messages
        .

      IF lv_crequest_type-usmd_creq_type = 'YBMAT02'.
        CLEAR: lt_uibb.
        "Reading the UIBBs
        CHECK io_ovp IS BOUND.
        TRY .
          "Reading the current content area
          io_ovp->get_current_content_area(
            RECEIVING
              rs_current_content_area = DATA(ls_content_Area) ).
*          io_ovp->get_default_action(
*            EXPORTING
*              iv_content_area   =     ls_content_area-id             " FPM: Content Area ID
*            IMPORTING
*              es_default_action =      Data(ls_default_action)            " Default action
*          ).
*          CATCH cx_fpm_floorplan. " Floorplan exceptions
          "Reading the UIBBs
          io_ovp->get_uibbs(
            EXPORTING
              iv_content_area       =  ls_content_area-id                " FPM: Content Area ID
*              iv_section            =                  " FPM: Section ID
            IMPORTING
              et_uibb               =    lt_uibb              " List of UIBBs
*              es_maximized_uibb_key =                  " Key of maximized UIBB of content area
          ).
          CATCH cx_fpm_floorplan. " Floorplan exceptions
*        CATCH .
*
        ENDTRY.

       "Hiding the UIBBs which are not applicable for BOM Processing
      LOOP AT lt_uibb INTO ls_uibb.
       IF ls_uibb-config_id NE 'USMD_CR_OVERVIEW' AND ls_uibb-config_id NE 'MDG_BS_MAT_MAT_FORM_06'
         AND ls_uibb-config_id NE 'MDG_BS_MAT_PLANT_LIST_ATS_H_06' AND ls_uibb-config_id NE 'Y_MDG_BS_MAT_BOM_HDR'
         AND ls_uibb-config_id NE 'Y_MDG_BS_MAT_BOM_ITM_DET' AND ls_uibb-config_id NE 'Y_MDG_BS_MAT_BOM_HDR_DET'
         AND ls_uibb-config_id NE 'Y_MDG_BS_MAT_BOM_ITM'.
        ls_uibb-hidden = 'T'.
        TRY.
            io_ovp->change_uibb( ls_uibb ).
          CATCH cx_fpm_floorplan.
        ENDTRY.
       ENDIF.
**       if ls_uibb-config_id EQ 'MDG_BS_MAT_PLANT_LIST_ATS_H_06'.
**       io_ovp->get_toolbar_elements(
**        EXPORTING iv_uibb_primary_attribute = ls_uibb-fpm_primary_attribute
**        IMPORTING et_toolbar_element = lt_toolbar_elements ).
***       endif.
**    LOOP AT lt_toolbar_elements INTO ls_toolbar_elements.
**
**      io_ovp->get_toolbar_button(
**        EXPORTING
******          iv_content_area           =                  " FPM: Content Area ID
******          is_page_master_uibb_key   =                  " Page master UIBB key
**          iv_uibb_primary_attribute =   ls_uibb-fpm_primary_attribute             " FPM: Element ID
**          iv_toolbar_element_id     =   ls_toolbar_elements-element_id             " FPM: Element ID
**        IMPORTING
**          es_toolbar_button         =      DATA(ls_button)            " Toolbar button attributes
**      ).
******      CATCH cx_fpm_floorplan. " Floorplan exceptions
**    ENDLOOP.
      ENDLOOP.
*      -------------------------------
**      IF sy-uname = 'ASWARUP'.
**        io_ovp->get_toolbar_elements(
***          EXPORTING
***            iv_content_area           =                 " FPM: Content Area ID
***            is_page_master_uibb_key   =                 " Page master UIBB key
***            iv_uibb_primary_attribute =                 " FPM: Element ID**            iv_event_id               =                " ID of the FPM Event
**          IMPORTING
**            et_toolbar_element        =  lt_toolbar_elements              " List of toolbar elements
**        ).
******        CATCH cx_fpm_floorplan. " Floorplan exceptions
**    LOOP AT lt_toolbar_elements INTO ls_toolbar_elements.
**
**      io_ovp->get_toolbar_button(
**        EXPORTING
******          iv_content_area           =                  " FPM: Content Area ID
******          is_page_master_uibb_key   =                  " Page master UIBB key
******          iv_uibb_primary_attribute =   'MDGM_PLANT_ADD'              " FPM: Element ID
**          iv_toolbar_element_id     =   ls_toolbar_elements-element_id             " FPM: Element ID
**        IMPORTING
**          es_toolbar_button         =      DATA(ls_button)            " Toolbar button attributes
**      ).
******      CATCH cx_fpm_floorplan. " Floorplan exceptions
**    ENDLOOP.
**      ENDIF.
      ENDIF." End of YBMAT02

*    ENDIF.
  ENDMETHOD.


  method /PLMU/IF_EX_FRW_APPCC_OVP~PROCESS_BEFORE_OUTPUT.
  endmethod.


  method /PLMU/IF_EX_FRW_APPCC_OVP~PROCESS_EVENT.
  endmethod.
ENDCLASS.
