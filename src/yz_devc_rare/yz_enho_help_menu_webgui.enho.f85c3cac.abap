"Name: \TY:CL_WDR_HELP_HANDLER\IN:IF_WDR_CONTEXT_MENU_HANDLER\ME:CONTEXT_MENU_CALLED\SE:END\EI
ENHANCEMENT 0 YZ_ENHO_HELP_MENU_WEBGUI.
*Data Declaration
    DATA: oref    TYPE REF TO cx_root,
          exc_ref TYPE REF TO cx_sy_dyn_call_error,
          text    TYPE string,
          class   TYPE string VALUE 'YZ_CLAS_RARE_NWBC',
          method  TYPE string VALUE 'CUSTOMIZE_HELP_MENU'.

    DATA: oref_excp_not_found  TYPE REF TO cx_sy_dyn_call_excp_not_found,
          oref_illegal_class   TYPE REF TO cx_sy_dyn_call_illegal_class,
          oref_illegal_method  TYPE REF TO cx_sy_dyn_call_illegal_method,
          oref_illegal_type    TYPE REF TO cx_sy_dyn_call_illegal_type,
          oref_param_missing   TYPE REF TO cx_sy_dyn_call_param_missing,
          oref_param_not_found TYPE REF TO cx_sy_dyn_call_param_not_found,
          oref_ref_is_initial  TYPE REF TO cx_sy_ref_is_initial.

      IF sy-uname = 'RABHAYANI'.
    TRY.
      TRY.
* Customize the help context menu options
        CALL METHOD (class)=>(method)
          EXPORTING
            i_view_element               = i_view_element
            i_view_element_adapter       = i_view_element_adapter
            i_representative             = i_representative
            i_representative_adapter     = i_representative_adapter
            i_view_element_adapter_first = i_view_element_adapter_first
            i_current_event_id           = if_wdr_context_menu_handler~current_event_id
          IMPORTING
            e_context_menu_tab           = e_context_menu_tab.
      CATCH cx_sy_dyn_call_error INTO exc_ref.
        text = oref->get_text( ).
      ENDTRY.
    CATCH cx_sy_dyn_call_excp_not_found INTO oref_excp_not_found.
      text = oref_excp_not_found->get_text( ).

    CATCH cx_sy_dyn_call_illegal_class INTO oref_illegal_class.
      text = oref_illegal_class->get_text( ).

    CATCH cx_sy_dyn_call_illegal_method INTO oref_illegal_method.
      text = oref_illegal_method->get_text( ).

    CATCH cx_sy_dyn_call_illegal_type INTO oref_illegal_type.
      text = oref_illegal_type->get_text( ).

    CATCH cx_sy_dyn_call_param_missing INTO oref_param_missing.
      text = oref_param_missing->get_text( ).

    CATCH cx_sy_dyn_call_param_not_found INTO oref_param_not_found.
      text = oref_param_not_found->get_text( ).

    CATCH cx_sy_ref_is_initial INTO oref_ref_is_initial.
      text = oref_ref_is_initial->get_text( ).

    CATCH cx_root INTO oref.
      text = oref->get_text( ).
    ENDTRY.
    ENDIF.
ENDENHANCEMENT.
