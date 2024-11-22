"Name: \FU:GUI_UPLOAD\SE:END\EI
ENHANCEMENT 0 YZ_ENHO_GUI_UPLOAD.

*&-----------------------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Description       : Enhancement for getting uploaded file data for Tool
*&-----------------------------------------------------------------------------------*

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


    FIELD-SYMBOLS : <ft_data> TYPE ANY .

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


        ASSIGN ('data_tab[]') TO <ft_data>.
        IF <ft_data> IS ASSIGNED .
        ptab_line-name = 'DATA_TAB'.
        ptab_line-kind = cl_abap_objectdescr=>exporting.
        GET REFERENCE OF <ft_data>  INTO ptab_line-VALUE.
        INSERT ptab_line INTO TABLE ptab.
        ENDIF.


        ptab_line-name = 'FILENAME'.
        ptab_line-kind = cl_abap_objectdescr=>exporting.
        GET REFERENCE OF filename INTO ptab_line-VALUE.
        INSERT ptab_line INTO TABLE ptab.

        ptab_line-name = 'FILETYPE'.
        ptab_line-kind = cl_abap_objectdescr=>exporting.
        GET REFERENCE OF FILETYPE INTO ptab_line-VALUE.
        INSERT ptab_line INTO TABLE ptab.

        ptab_line-name = 'FILELENGTH'.
        ptab_line-kind = cl_abap_objectdescr=>exporting.
        GET REFERENCE OF filelength INTO ptab_line-VALUE.
        INSERT ptab_line INTO TABLE ptab.

*Collect Main screen / Subscreen / Child Screen using APIs
        CALL METHOD ('YZ_CLAS_RARE_BASE')=>('GET_UPLOADED_FILE_DATA')
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
