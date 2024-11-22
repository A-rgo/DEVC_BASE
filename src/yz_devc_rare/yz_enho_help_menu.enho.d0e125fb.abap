"Name: \FU:HELP_START\SE:END\EI
ENHANCEMENT 0 YZ_ENHO_HELP_MENU.


**--------------------------------------------------------------------*
*Isolation Technique Used :
*1) Do not call Directly any Z* and Y* Code
*2) Always Use Try Catch Block
*3) Catch the exception But ignore do not write Type E message
*--------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Enhancement for getting details from help menu
*&---------------------------------------------------------------------*

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

*if sy-uname = 'RABHAYANI' OR sy-uname = 'NIKHDESHPAND'.
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

*Help Menu Enhancement for Incident Management
      CASE help_infos-CALL.

      WHEN 'H'.
        CASE help_infos-menufunct.

        WHEN 'YZFC_INCRE'.
          TRY.
            CALL METHOD ('YZ_CLAS_RARE_BASE')=>('EXECUTE_RARE').

          CATCH cx_sy_dyn_call_error INTO exc_ref.
            TEXT = oref->get_text( ).
*           MESSAGE TEXT TYPE 'I'.
          ENDTRY.

          WHEN 'YZFC_SRCRE'.
          TRY.
            CALL METHOD ('YZ_CLAS_RARE_BASE')=>('CREATE_SERVICE_REQUEST').

          CATCH cx_sy_dyn_call_error INTO exc_ref.
            TEXT = oref->get_text( ).
*           MESSAGE TEXT TYPE 'I'.
          ENDTRY.
        ENDCASE.
      ENDCASE.


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

*endif.

ENDENHANCEMENT.
