class YCL_MAT_BOM_DYN_AGENT definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_USMD_SSW_DYNAMIC_AGT_SELECT .
protected section.
private section.
ENDCLASS.



CLASS YCL_MAT_BOM_DYN_AGENT IMPLEMENTATION.


  METHOD if_usmd_ssw_dynamic_agt_select~get_dynamic_agents.
    DATA: lv_mtart TYPE mtart.
    DATA: lt_user_agents      TYPE usmd_t_user_agent.
    DATA: ls_user_agent_group TYPE usmd_s_user_agent_group,
          ls_user_agent       TYPE usmd_s_user_agent.
    FIELD-SYMBOLS: <fs_material_data> TYPE ANY TABLE.

    IF  iv_service_name = 'YMAT_BOM_DYN_AGENT'." AND sy-uname = 'HARKUMARI'.
      TRY.
          cl_usmd_gov_api=>get_instance(
            EXPORTING
              iv_model_name = 'MM'                  " Data Model
*           iv_classname  = 'CL_USMD_GOV_API' " Object Type Name
            RECEIVING
              ro_gov_api    =   DATA(lo_gov_api)              " Governance API
          ).
        CATCH cx_usmd_gov_api. " General Processing Error GOV_API
      ENDTRY.
      lo_gov_api->get_crequest_data(
        EXPORTING
          iv_crequest_id          = iv_cr_number                 " Change Request
        IMPORTING
          et_entity_data_inactive = DATA(lt_entity_data_inactive)                 " Data for Entity Types
      ).
      LOOP AT lt_entity_data_inactive ASSIGNING FIELD-SYMBOL(<fs_entity_data_inactive>) WHERE usmd_entity = 'MATERIAL'
                                                                                        AND struct        = 'KATTR'
                                                                                        AND usmd_entity_cont IS INITIAL.
        ASSIGN <fs_entity_data_inactive>-r_data->* TO <fs_material_data>.
        IF <fs_material_data> IS ASSIGNED AND <fs_material_data> IS NOT INITIAL.
          LOOP AT <fs_material_data> ASSIGNING FIELD-SYMBOL(<ls_material_data>).
            ASSIGN COMPONENT 'MTART' OF STRUCTURE <ls_material_data> TO FIELD-SYMBOL(<lv_mtart>).
            IF <lv_mtart> IS ASSIGNED AND <lv_mtart> IS NOT INITIAL.
              lv_mtart = <lv_mtart>.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDLOOP.

      "Update user agent decesion table based on material type
      ls_user_agent_group-agent_group = '001'.
      ls_user_agent_group-step_type   = '2'.

      "Update user agents
      IF lv_mtart <> 'HALB'.
        CLEAR ct_user_agent_group.
        cv_new_step = '25'.
        cv_new_cr_status = 'ZD'.
        ls_user_agent-user_type = 'SU'.
        ls_user_agent-user_value = 'INIT'.
        APPEND ls_user_agent TO ls_user_agent_group-user_agent.
*        APPEND ls_user_agent TO lt_user_agents.
*        CLEAR ls_user_agent.
*        ls_user_agent_group-user_agent = lt_user_agents.
        APPEND ls_user_agent_group TO ct_user_agent_group.
        CLEAR ls_user_agent_group.
      ENDIF.

    ENDIF.
  ENDMETHOD.
ENDCLASS.
