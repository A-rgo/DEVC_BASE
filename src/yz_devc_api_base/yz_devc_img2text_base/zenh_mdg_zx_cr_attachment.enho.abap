class lcl_zenh_mdg_zx_cr_attachment definition deferred.
class cl_usmd_cr_guibb_attachments definition local friends lcl_zenh_mdg_zx_cr_attachment.
class lcl_zenh_mdg_zx_cr_attachment definition.
  public section.
    class-data obj type ref to lcl_zenh_mdg_zx_cr_attachment. "#EC NEEDED
    data core_object type ref to cl_usmd_cr_guibb_attachments . "#EC NEEDED
 INTERFACES  IPO_ZENH_MDG_ZX_CR_ATTACHMENT.
    methods:
      constructor importing core_object
                              type ref to cl_usmd_cr_guibb_attachments optional.
endclass.
class lcl_zenh_mdg_zx_cr_attachment implementation.
  method constructor.
    me->core_object = core_object.
  endmethod.

  method ipo_zenh_mdg_zx_cr_attachment~get_data.
*"------------------------------------------------------------------------*
*" Declaration of POST-method, do not insert any comments here please!
*"
*"methods GET_DATA
*"  importing
*"    !IV_EVENTID type ref to CL_FPM_EVENT
*"    !IT_SELECTED_FIELDS type FPMGB_T_SELECTED_FIELDS optional
*"    !IV_RAISED_BY_OWN_UI type BOOLE_D optional
*"    !IV_VISIBLE_ROWS type I optional
*"    !IV_EDIT_MODE type FPM_EDIT_MODE optional
*"    !IO_EXTENDED_CTRL type ref to IF_FPM_LIST_ATS_EXT_CTRL optional
*"  changing
*"    !ET_MESSAGES type FPMGB_T_MESSAGES
*"    !EV_DATA_CHANGED type BOOLE_D
*"    !EV_FIELD_USAGE_CHANGED type BOOLE_D
*"    !EV_ACTION_USAGE_CHANGED type BOOLE_D
*"    !EV_SELECTED_LINES_CHANGED type BOOLE_D
*"    !EV_DND_ATTR_CHANGED type BOOLE_D
*"    !EO_ITAB_CHANGE_LOG type ref to IF_SALV_ITAB_CHANGE_LOG
*"    !CT_DATA type DATA
*"    !CT_FIELD_USAGE type FPMGB_T_FIELDUSAGE
*"    !CT_ACTION_USAGE type FPMGB_T_ACTIONUSAGE
*"    !CT_SELECTED_LINES type RSTABIXTAB
*"    !CV_LEAD_INDEX type SYTABIX
*"    !CV_FIRST_VISIBLE_ROW type I
*"    !CS_ADDITIONAL_INFO type FPMGB_S_ADDITIONAL_INFO optional
*"    !CT_DND_ATTRIBUTES type FPMGB_T_DND_DEFINITION optional.
*"------------------------------------------------------------------------*
    CHECK 1 = 2.
    data: lv_file_name     type eps2filnam,
          lv_directory   type epsf-epsdirnam value '/hana/log/Python_MDG_Files',
          lv_filename    type string,
          lv_long_directory type EPS2PATH,
          lo_exc         type ref to cx_root,
          lv_arch_path   type string,
          lv_filelength  type i,
          lv_error       type string,
          lt_data        type ref to data,
          lv_filecontent type c,
          lt_filecontent type string,
          lv_count       type i value 0,
          ls_solix       type solix-line,
          lt_solix_tab   type table of solix-line..
    field-symbols : <ls_file> type c.
* Read the CR number if exists.
    data(lo_context) = cl_usmd_app_context=>get_context( ).
    check lo_context is bound.
    call method lo_context->get_attributes
      importing
        ev_crequest_type = data(lv_request_type)
        ev_crequest_id   = data(lv_request_id).     " Change Request type


    if ct_data is not initial and lv_request_type eq 'ZXCREATE'.

      loop at ct_data assigning field-symbol(<fs_row>).
        assign component 'TITLE' of structure <fs_row> to field-symbol(<fs_file_name>).
        assign component 'CONTENT' of structure <fs_row> to field-symbol(<fs_file_content>).
        if <fs_file_content> is assigned and <fs_file_content> is not initial.
          call function 'SCMS_XSTRING_TO_BINARY'
            exporting
              buffer        = <fs_file_content>
*             APPEND_TO_TABLE       = ' '
            importing
              output_length = lv_filelength
            tables
              binary_tab    = lt_solix_tab.
        endif.
** CR id lv_request_id not included to avoid multiple creations during testing
*        concatenate lv_directory '/' lv_request_id '_' <fs_file_name> '.png' into lv_filename.
        concatenate lv_directory '/' lv_request_id '_' <fs_file_name> 'Test_Adhaar.png' into lv_filename.
        lv_long_directory = lv_directory. "For Deletion of File
        CONCATENATE lv_request_id '_' <fs_file_name> 'Test_Adhaar.png' into lv_file_name. "For Deletion of File
        try.
            open dataset lv_filename for output in binary mode.
            if sy-subrc = 0.
              loop at lt_solix_tab into ls_solix.

                transfer ls_solix to lv_filename.
              endloop.
            endif.
          catch cx_sy_conversion_codepage into lo_exc.
        endtry.
        close dataset lv_filename.

        call function 'EPS_DELETE_FILE'
          exporting
            iv_long_file_name      = lv_file_name
            dir_name               = lv_directory
            iv_long_dir_name       = lv_long_directory
          exceptions
            invalid_eps_subdir     = 1
            sapgparam_failed       = 2
            build_directory_failed = 3
            no_authorization       = 4
            build_path_failed      = 5
            delete_failed          = 6
            others                 = 7.
        if sy-subrc <> 0.
          lv_error = abap_true.
          return.
        endif.

      endloop.

    endif.
  endmethod.
ENDCLASS.
