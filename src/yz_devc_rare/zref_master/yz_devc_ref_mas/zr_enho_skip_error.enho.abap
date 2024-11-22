class lcl_zr_enho_skip_error definition deferred.
class cl_usmd_data_check definition local friends lcl_zr_enho_skip_error.
class lcl_zr_enho_skip_error definition.
  public section.
    class-data obj type ref to lcl_zr_enho_skip_error.      "#EC NEEDED
    data core_object type ref to cl_usmd_data_check .       "#EC NEEDED
 INTERFACES  IPO_ZR_ENHO_SKIP_ERROR.
    methods:
      constructor importing core_object
                              type ref to cl_usmd_data_check optional.
endclass.
class lcl_zr_enho_skip_error implementation.
  method constructor.
    me->core_object = core_object.
  endmethod.

  method ipo_zr_enho_skip_error~check_per_field_1_p.
*"------------------------------------------------------------------------*
*" Declaration of POST-method, do not insert any comments here please!
*"
*"methods CHECK_PER_FIELD_1_P
*"  importing
*"    !IO_MODEL type ref to IF_USMD_MODEL
*"    !IT_FATTR_DETAIL type USMD_TS_FATTR_KEY
*"    !I_FIELDNAME type USMD_FIELDNAME
*"    !I_ATTRIBUTE type USMD_FIELDNAME
*"    !IT_VALUE type ANY TABLE
*"  changing
*"    !CS_EXIST type ANY
*"    !CT_EXIST type ANY TABLE
*"    !CT_MESSAGE type USMD_T_MESSAGE.
*"------------------------------------------------------------------------*
    if cl_usmd_app_context=>get_context( )->mv_crequest_type = 'ZR_CREH1'
      and ( i_attribute = 'ZHAS_SUB' or i_attribute = 'ZHAS_TOP' ).

      delete ct_message where msgid = 'USMD1B' and msgno = '302'.

    endif.
  endmethod.
ENDCLASS.
