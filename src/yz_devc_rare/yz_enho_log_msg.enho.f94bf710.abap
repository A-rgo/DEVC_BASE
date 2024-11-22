"Name: \FU:BAL_LOG_MSG_ADD\SE:END\EI
ENHANCEMENT 0 YZ_ENHO_LOG_MSG.

*&------------------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Description       : Enhancement for getting error messages for Tool
*&------------------------------------------------------------------------------*


  DATA: oref    TYPE REF TO cx_root,
          exc_ref TYPE REF TO cx_sy_dyn_call_error,
          TEXT    TYPE string.

    DATA: oref_excp_not_found  TYPE REF TO cx_sy_dyn_call_excp_not_found,
          oref_illegal_class   TYPE REF TO cx_sy_dyn_call_illegal_class,
          oref_illegal_method  TYPE REF TO cx_sy_dyn_call_illegal_method,
          oref_illegal_type    TYPE REF TO cx_sy_dyn_call_illegal_type,
          oref_param_missing   TYPE REF TO cx_sy_dyn_call_param_missing,
          oref_param_not_found TYPE REF TO cx_sy_dyn_call_param_not_found,
          oref_ref_is_initial  TYPE REF TO cx_sy_ref_is_initial.

    DATA:
          ptab      TYPE abap_parmbind_tab,
          ptab_line TYPE abap_parmbind.

if sy-uname = 'RABHAYANI'.
    TRY.

      TRY.
*Collect Session Details using APIs
        CALL METHOD ('YZ_CLAS_RARE_BASE')=>('GET_STACK_DATA').

      CATCH cx_sy_dyn_call_error INTO exc_ref.
        TEXT = oref->get_text( ).
*           MESSAGE TEXT TYPE 'I'.
      ENDTRY.

      TRY.
*Collect Main screen / Subscreen / Child Screen using APIs
        CALL METHOD ('YZ_CLAS_RARE_BASE')=>('GET_ASSOCIATED_SCREEN_DATA').

      CATCH cx_sy_dyn_call_error INTO exc_ref.
        TEXT = oref->get_text( ).
*           MESSAGE TEXT TYPE 'I'.
      ENDTRY.

      TRY.
*Collect Logs
        ptab_line-name = 'IS_MSG'.
        ptab_line-kind = cl_abap_objectdescr=>exporting.
        GET REFERENCE OF l_s_msg INTO ptab_line-VALUE.
        INSERT ptab_line INTO TABLE ptab.

        CALL METHOD ('YZ_CLAS_RARE_BASE')=>('GET_MESSAGE_WHERE_USED_DATA')
        PARAMETER-TABLE ptab.

      CATCH cx_sy_dyn_call_error INTO exc_ref.
        TEXT = exc_ref->get_text( ).
*           MESSAGE TEXT TYPE 'I'.
      ENDTRY.

    CATCH cx_sy_dyn_call_excp_not_found INTO oref_excp_not_found.
      TEXT = oref_excp_not_found->get_text( ).

    CATCH cx_sy_dyn_call_illegal_class INTO oref_illegal_class.
      TEXT = oref_illegal_class->get_text( ).

    CATCH cx_sy_dyn_call_illegal_method INTO oref_illegal_method.
      TEXT = oref_illegal_method->get_text( ).

    CATCH cx_sy_dyn_call_illegal_type INTO oref_illegal_type.
      TEXT = oref_illegal_type->get_text( ).

    CATCH cx_sy_dyn_call_param_missing INTO oref_param_missing.
      TEXT = oref_param_missing->get_text( ).

    CATCH cx_sy_dyn_call_param_not_found INTO oref_param_not_found.
      TEXT = oref_param_not_found->get_text( ).

    CATCH cx_sy_ref_is_initial INTO oref_ref_is_initial.
      TEXT = oref_ref_is_initial->get_text( ).

    CATCH cx_root INTO oref.
      TEXT = oref->get_text( ).
*      MESSAGE TEXT TYPE 'I'.
    ENDTRY.
endif.
ENDENHANCEMENT.
