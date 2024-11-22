function yz_func_com2sap.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_MODE) TYPE  YZDTEL_MODE OPTIONAL
*"     VALUE(I_MODEL) TYPE  YZDTEL_MODEL OPTIONAL
*"     VALUE(I_SCOPE) TYPE  YZDTEL_SCOPE_ID OPTIONAL
*"     VALUE(I_TEMPID) TYPE  YZDTEL_TEMPLATE_ID OPTIONAL
*"     VALUE(I_ACTIONID) TYPE  YZDTEL_ACTION_ID OPTIONAL
*"     VALUE(I_JSON_REQUEST) TYPE  STRING OPTIONAL
*"  EXPORTING
*"     VALUE(ET_TEMPLATE) TYPE  YZM_T_TEMPLT_DET
*"     VALUE(ET_ERRORS) TYPE  YZM_T_ERROR_DETAILS
*"     VALUE(ET_CHARA_HELP) TYPE  YZM_T_CHARA_DETAILS
*"     VALUE(E_JSON_RESPONSE) TYPE  STRING
*"  CHANGING
*"     VALUE(I_INPUT_TAB) TYPE  YZM_S_INPUT_TAB OPTIONAL
*"----------------------------------------------------------------------
*R01 - Request for Data
*V01 - Validate Data
*P01 - Post Data
*U01 - Update Data
*D01 - Delete Data
************************************************************************
  types: begin of lty_input,
           i_mode      type yzdtel_mode,
           i_model     type yzdtel_model,
           i_scope     type yzdtel_scope_id,
           i_tempid    type yzdtel_template_id,
           i_actionid  type yzdtel_action_id,
           i_input_tab type yzm_s_input_tab,
         end of lty_input.
  data ls_input       type lty_input.

  /ui2/cl_json=>deserialize(
    exporting
      json = i_json_request   " JSON string
    changing
      data = ls_input         " Data to serialize
  ).

  if ls_input-i_mode is not initial.
    i_mode = ls_input-i_mode.
    i_model = ls_input-i_model.
    i_scope = ls_input-i_scope.
    i_tempid = ls_input-i_tempid.
    i_actionid = ls_input-i_actionid.
  endif.

  case i_mode.
    when 'R01'.
      if i_model = 'XX' and i_scope is initial and i_tempid is initial and i_actionid = '01'.
        call method yz_class_com2sap_utility=>get_selection_criteria
          importing
            e_json_response = e_json_response.
      elseif i_model is not initial and i_scope is not initial and i_tempid is not initial and i_actionid = '01'.
        perform get_template_from_template_id using i_model i_scope i_tempid
                                              changing  i_input_tab et_template.
      endif.
      if i_actionid = '06'.
        if i_input_tab-i_inputfield = 'CLASS' and i_input_tab-i_tablename = 'KLAH'.
          yz_class_com2sap_utility=>get_class_characterics(
            exporting
              i_model                = i_model                 " Data Model
              i_json_input           = i_json_request
            importing
              et_class_chara_details = et_chara_help  " Table Type Material Characteristic Details
            changing
              c_input                = i_input_tab                 " Input Tab
          ).
        else.
          yz_class_com2sap_utility=>get_search_help_value_from_dom(
            exporting
              i_mode   = i_mode                   " Character field of length 6
              i_model  = i_model                  " 3-Byte field
              i_scope  = i_scope                  " Component of the Version Number
              i_tempid = i_tempid                 " Template ID for mass process enrichment
            changing
              c_input  = i_input_tab                " Input Tab
          ).
        endif.
      elseif i_actionid = '08' and i_json_request is not initial." and ls_input-i_tempid is not initial.
        call method yz_class_com2sap_utility=>get_crequest_data
          exporting
            i_mode          = i_mode
            i_model         = i_model
            i_scope         = i_scope
            i_tempid        = i_tempid
            i_actionid      = i_actionid
            i_json_request  = i_json_request
          importing
            e_json_response = e_json_response.
      endif.
      if i_actionid = '07'.
        yz_class_com2sap_utility=>get_duplicate_check_criteria(
          exporting
            i_input_data  = i_json_request
          importing
            e_output_data = e_json_response                 " Output in Json
        ).
      endif.
      if i_actionid = '09'.
        yz_class_com2sap_utility=>get_derived_data(
          exporting
            i_json_input  = i_json_request
          importing
            e_json_output = e_json_response
        ).
      endif.
    when 'V01'.
      if i_model = 'MM' and i_scope = '01' and i_actionid = '02'.
        data lt_mara  type yzm_t_material_details.
*        /ui2/cl_json=>deserialize(
*          exporting
*            json             = i_json_request " JSON string
*          changing
*            data             = lt_mara                 " Data to serialize
*        ).

        yz_class_com2sap_utility=>validate_material(
          exporting
            i_model           = i_model                 " Data Model
            i_scope           = i_scope                 " Scope Id for Data model
            i_tempid          = i_tempid                " Template ID for mass process enrichment
            i_actionid        = i_actionid                 " Data element for action id
            it_material       = lt_mara                " Material Detail Table Type (Mass Enrichment)
            i_json_request    = i_json_request
          importing
            et_error_template = et_template                 " template details for excel
            et_errors         = et_errors                 " Template table for excel template
        ).
      elseif i_scope = '01' and i_actionid = '04'.
*        yz_class_com2sap_utility=>duplicate_check(
*          exporting
*            i_mode       = i_mode
*            i_model      = i_model
*            i_scope      = i_scope
*            i_tempid     = i_tempid
*            i_actionid   = i_actionid
*            i_input_data = i_json_request
*          importing
*            e_output     = e_json_response ).
*        if 1 = 2.
        yz_class_com2sap_utility=>duplicate_check_custom(
          exporting
            i_mode       = i_mode
            i_model      = i_model
            i_scope      = i_scope
            i_tempid     = i_tempid
            i_actionid   = i_actionid
            i_input_data = i_json_request
          importing
            e_output     = e_json_response
        ).
*        endif.
      elseif  i_actionid = '05'.
        yz_class_com2sap_utility=>business_rule_check(
          exporting
            i_mode       = i_mode                 " Model for Mass Process Enrichment
            i_model      = i_model                 " Data Model value for mass process enrichment
            i_scope      = i_scope                 " Scope Id for Data model
            i_tempid     = i_tempid                 " Template ID for mass process enrichment
            i_actionid   = i_actionid                 " Data element for action id
            i_input_data = i_json_request
          importing
            e_output     = e_json_response
        ).
      endif.
    when 'P01'.
    when 'U01'.
    when 'D01'.
    when others.
  endcase.
endfunction.
***function yz_func_com2sap.
****"----------------------------------------------------------------------
****"*"Local Interface:
****"  IMPORTING
****"     VALUE(I_MODE) TYPE  YZDTEL_MODE OPTIONAL
****"     VALUE(I_MODEL) TYPE  YZDTEL_MODEL OPTIONAL
****"     VALUE(I_SCOPE) TYPE  YZDTEL_SCOPE_ID OPTIONAL
****"     VALUE(I_TEMPID) TYPE  YZDTEL_TEMPLATE_ID OPTIONAL
****"     VALUE(I_ACTIONID) TYPE  YZDTEL_ACTION_ID OPTIONAL
****"     VALUE(I_JSON_REQUEST) TYPE  STRING OPTIONAL
****"  EXPORTING
****"     VALUE(ET_TEMPLATE) TYPE  YZM_T_TEMPLT_DET
****"     VALUE(ET_ERRORS) TYPE  YZM_T_ERROR_DETAILS
****"     VALUE(ET_CHARA_HELP) TYPE  YZM_T_CHARA_DETAILS
****"     VALUE(E_JSON_RESPONSE) TYPE  STRING
****"  CHANGING
****"     VALUE(I_INPUT_TAB) TYPE  YZM_S_INPUT_TAB OPTIONAL
****"----------------------------------------------------------------------
****R01 - Request for Data
****V01 - Validate Data
****P01 - Post Data
****U01 - Update Data
****D01 - Delete Data
***************************************************************************
***  data: lv_scope_required    type flag,
***        lv_tempid_required   type flag,
***        lv_template_required type flag.
***
***  types: begin of lty_input,
***          i_mode      type yzdtel_model,
***          i_model     type yzdtel_model,
***          i_scope     type yzdtel_scope_id,
***          i_tempid    type yzdtel_template_id,
***          i_actionid  type yzdtel_action_id,
***          i_input_tab type yzm_s_input_tab,
***        end of lty_input.
***  data ls_input       type lty_input.
***
***
***  "" VALIDATE MODE PARAMETER
***  case i_mode.
***    when 'R01'.
***      perform get_model_value using i_mode
***                                    i_actionid
***                                    i_model
***                           changing i_input_tab
***                                    lv_scope_required .
***      if lv_scope_required eq abap_true.
***        perform get_scope_model using     i_model
***                                          i_scope
***                                changing  i_input_tab
***                                          lv_tempid_required.
***      endif.
***
***      if lv_tempid_required eq abap_true.
***        perform get_template_from_scope using     i_model
***                                                  i_scope
***                                                  i_tempid
***                                        changing  i_input_tab
***                                                  lv_template_required.
***      endif.
***
***      if lv_template_required eq abap_true.
***        perform get_template_from_template_id using     i_model
***                                                        i_scope
***                                                        i_tempid
***                                              changing  i_input_tab
***                                                        et_template.
***      endif.
***
***      if i_actionid eq '06'. "" Request for F4 Help
***        if i_input_tab-i_inputfield = 'CLASS' and i_input_tab-i_tablename = 'KLAH'.
***          yz_class_com2sap_utility=>get_class_characterics(
***            exporting
***              i_model                = i_model                 " Data Model
***            importing
***              et_class_chara_details = et_chara_help  " Table Type Material Characteristic Details
***            changing
***              c_input                = i_input_tab                 " Input Tab
***          ).
***        else.
***          yz_class_com2sap_utility=>get_search_help_value_from_dom(
***            exporting
***              i_mode   = i_mode                   " Character field of length 6
***              i_model  = i_model                  " 3-Byte field
***              i_scope  = i_scope                  " Component of the Version Number
***              i_tempid = i_tempid                 " Template ID for mass process enrichment
***            changing
***              c_input  = i_input_tab                " Input Tab
***          ).
***        endif.
***      elseif i_actionid = '01' and i_json_request is not initial.
***        call method yz_class_com2sap_utility=>get_crequest_data
***          exporting
***            i_mode          = i_mode
***            i_model         = i_model
***            i_scope         = i_scope
***            i_tempid        = i_tempid
***            i_actionid      = i_actionid
***            i_json_request  = i_json_request
***          importing
***            e_json_response = e_json_response.
***
***      endif.
***    when 'V01'.
***      if i_model = 'MM' and i_scope = '01' and i_actionid = '02'.
***        yz_class_com2sap_utility=>deserialize_json_input(
***          exporting
***            i_mode       = i_mode                  " Model for Mass Process Enrichment
***            i_model      = i_model                 " Data Model value for mass process enrichment
***            i_scope      = i_scope                 " Scope Id for Data model
***            i_tempid     = i_tempid                " Template ID for mass process enrichment
***            i_actionid   = i_actionid                " Data element for action id
***            i_json_input = i_json_request
***          importing
***            et_data      = data(lt_data)
***        ).
***        data lt_mara  type yzm_t_material_details.
****        /ui2/cl_json=>deserialize(
****          exporting
****            json             = i_json_request " JSON string
****          changing
****            data             = lt_mara                 " Data to serialize
****        ).
***
***        yz_class_com2sap_utility=>validate_material(
***          exporting
***            i_model           = i_model                 " Data Model
***            i_tempid          = i_tempid
***            it_material       = lt_mara                 " Material Detail Table Type (Mass Enrichment)
***            it_data           = lt_data
***          importing
***            et_error_template = et_template                 " template details for excel
***            et_errors         = et_errors                 " Template table for excel template
***        ).
***      elseif i_model = 'MM' and i_scope = '01' and i_actionid = '04'.
***          yz_class_com2sap_utility=>duplicate_check(
***            exporting
***              i_mode       = i_mode
***              i_model      = i_model
***              i_scope      = i_scope
***              i_tempid     = i_tempid
***              i_actionid   = i_actionid
***              i_input_data = i_json_request
***            importing
***              e_output     = e_json_response ).
***      elseif i_model = 'MM' and i_actionid = '05'.
***        yz_class_com2sap_utility=>business_rule_check(
***          exporting
***            i_mode       = i_mode                 " Model for Mass Process Enrichment
***            i_model      = i_model                 " Data Model value for mass process enrichment
***            i_scope      = i_scope                 " Scope Id for Data model
***            i_tempid     = i_tempid                 " Template ID for mass process enrichment
***            i_actionid   = i_actionid                 " Data element for action id
***            i_input_data = i_json_request
***          importing
***            e_output     = e_json_response
***        ).
***      endif.
***    when 'P01'.
***    when 'U01'.
***    when 'D01'.
***    when others.
***  endcase.
***
***endfunction.
