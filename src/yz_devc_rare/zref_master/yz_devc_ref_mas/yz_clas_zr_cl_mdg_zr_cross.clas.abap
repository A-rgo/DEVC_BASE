class YZ_CLAS_ZR_CL_MDG_ZR_CROSS definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE2 .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_ZR_CL_MDG_ZR_CROSS IMPLEMENTATION.


 METHOD if_ex_usmd_rule_service2~derive.
   FIELD-SYMBOLS : <lt_data>        TYPE ANY TABLE,
                   <ft_entity_data> TYPE ANY TABLE,
                   <fs_entity_data> TYPE any.
   DATA: lt_zmain_stg     TYPE TABLE OF zzr_s_zr_pp_zmain,
         lv_zobjcls       TYPE zzr_s_zr_pp_zmain-zobj_cls,
         lv_zmain         TYPE zzr_s_zr_pp_zmain-zmain,
         lt_zfield_stg    TYPE TABLE OF zzr_s_zr_pp_zvalue,
         ls_zfield        LIKE LINE OF lt_zfield_stg,
         lr_entity_data   TYPE REF TO data,
         lr_entity_data_s TYPE REF TO data,
         lr_data_mod      TYPE REF TO data.
   CONSTANTS: lc_entity_zmain TYPE fieldname VALUE 'ZMAIN'.

   yz_clas_mdg_utility=>read_entity_data(
                                          EXPORTING iv_cr_number = cl_usmd_app_context=>get_context( )->mv_crequest_id
                                                    iv_readmode = if_usmd_db_adapter=>gc_readmode_default
                                                    iv_entity_type = lc_entity_zmain
                                           IMPORTING et_message = et_message_info
                                                     eo_data = DATA(lr_data_zmain)       ).

   CALL METHOD io_changed_data->read_data
     EXPORTING
       i_entity      = 'ZMAIN'
       i_struct      = if_usmd_model_ext=>gc_struct_key_attr
     IMPORTING
       er_t_data_mod = lr_data_mod.

   IF lr_data_mod IS BOUND.
*      ASSIGN lr_data_zmain->* TO <lt_data>.
     ASSIGN lr_data_mod->* TO <lt_data>.
     IF sy-subrc EQ 0.
       LOOP AT <lt_data> ASSIGNING FIELD-SYMBOL(<ls_data>).
         ASSIGN COMPONENT 'ZOBJ_CLS' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<ls_objcls>).
         IF <ls_objcls> IS ASSIGNED.
           lv_zobjcls = <ls_objcls>.
           yz_cl_mdg_bs_guibb_list_hry=>gv_obj_class = <ls_objcls>.
         ENDIF.
         ASSIGN COMPONENT 'ZMAIN' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<ls_zmain>).
         IF <ls_zmain> IS ASSIGNED.
           lv_zmain = <ls_zmain>.
           yz_cl_mdg_bs_guibb_list_hry=>gv_zmain = <ls_zmain>.
         ENDIF.
       ENDLOOP.
     ENDIF.
   ENDIF.

   IF <lt_data> IS ASSIGNED AND <lt_data> IS NOT INITIAL.
     TRY.
         io_write_data->write_data(
           EXPORTING
             i_entity     =  'ZMAIN'           " Entity Type
             it_data      = <lt_data>
          ).
       CATCH cx_usmd_write_error. " Error while writing to buffer
     ENDTRY.
   ENDIF.

   SELECT zref_req_metdata~fields, zref_req_metdata~field_sequance, zref_master_itm~field_value
     FROM zref_req_metdata LEFT OUTER JOIN zref_master_itm
     ON zref_req_metdata~fields = zref_master_itm~field_name
     AND zref_req_metdata~business_id = zref_master_itm~business_id
     WHERE zref_req_metdata~active = @abap_true
     AND zref_req_metdata~object_class = @lv_zobjcls
     AND zref_req_metdata~tabname = @lv_zmain
     ORDER BY field_sequance ASCENDING
     INTO TABLE @DATA(lt_field_list).

   LOOP AT lt_field_list INTO DATA(ls_field).
     ls_zfield-zmain = lv_zmain.
     ls_zfield-zfield = ls_field-fields.
     ls_zfield-zobj_cls = lv_zobjcls.
     CALL FUNCTION 'TB_DATAELEMENT_GET_TEXTS'
       EXPORTING
         name        = ls_field-fields
       IMPORTING
         description = ls_zfield-zfld_desc.
     DATA(ls_zfield_stg) = VALUE #( lt_zfield_stg[ zfield = ls_field-fields ] OPTIONAL ).
     IF ls_zfield_stg IS INITIAL
       OR ls_zfield_stg-zfld_val IS INITIAL.
       ls_zfield-zfld_val = ls_field-field_value.
     ELSE.
       ls_zfield-zfld_val = ls_zfield_stg-zfld_val.
     ENDIF.
     APPEND ls_zfield TO lt_zfield_stg.
   ENDLOOP.
   TRY.
       io_write_data->create_data_reference(
     EXPORTING
       i_entity     =    'ZVALUE'                     " Entity Type
       i_struct     =  if_usmd_model_ext=>gc_struct_key_attr    " Type of Data Structure

     RECEIVING
       er_data      =  lr_entity_data
   ).

       ASSIGN lr_entity_data->* TO <ft_entity_data>.
       CREATE DATA lr_entity_data_s LIKE LINE OF <ft_entity_data>.
       ASSIGN lr_entity_data_s->* TO <fs_entity_data>.
     CATCH cx_usmd_write_error. " Error while writing to buffer
   ENDTRY.
   LOOP AT lt_zfield_stg INTO DATA(is_zfield).

     ASSIGN COMPONENT 'ZMAIN' OF STRUCTURE <fs_entity_data> TO FIELD-SYMBOL(<fs_main>).
     IF <fs_main> IS ASSIGNED.
       <fs_main> = is_zfield-zmain.

     ENDIF.
     ASSIGN COMPONENT 'ZFIELD' OF STRUCTURE <fs_entity_data> TO FIELD-SYMBOL(<fs_field>).
     IF <fs_field> IS ASSIGNED.
       <fs_field> = is_zfield-zfield.
     ENDIF.
     ASSIGN COMPONENT 'ZFLD_VAL' OF STRUCTURE <fs_entity_data> TO FIELD-SYMBOL(<fs_field_val>).
     IF <fs_field_val> IS ASSIGNED.
       <fs_field_val> = is_zfield-zfld_val.
     ENDIF.
     ASSIGN COMPONENT 'ZOBJ_CLS' OF STRUCTURE <fs_entity_data> TO FIELD-SYMBOL(<fs_zobj_cls>).
     IF <fs_zobj_cls> IS ASSIGNED.
       <fs_zobj_cls> = is_zfield-zobj_cls.
     ENDIF.
     ASSIGN COMPONENT 'ZFLD_DESC' OF STRUCTURE <fs_entity_data> TO FIELD-SYMBOL(<fs_zfld_desc>).
     IF <fs_zfld_desc> IS ASSIGNED.
       <fs_zfld_desc> = is_zfield-zfld_desc.
     ENDIF.

     INSERT <fs_entity_data> INTO TABLE <ft_entity_data>.

   ENDLOOP.
   IF <ft_entity_data> IS ASSIGNED AND <ft_entity_data> IS NOT INITIAL.
     TRY.

         io_write_data->write_data(
         EXPORTING
           i_entity = 'ZVALUE'
           it_data = <ft_entity_data> ).
       CATCH cx_usmd_write_error.
     ENDTRY.
   ENDIF.



*   CHECK sy-uname = 'RAJGOPAL'.
*   DATA: lt_sel     TYPE        usmd_ts_sel,
*         lt_objlist TYPE        usmd_t_crequest_entity.
*
*   DATA(iv_crequest) = cl_usmd_app_context=>get_context( )->mv_crequest_id.
*   lt_sel = VALUE #( ( fieldname = usmd0_cs_fld-crequest
*                    sign      = 'I'
*                    option    = 'EQ'
*                    low       = iv_crequest ) ).
*
*   io_model->read_char_value(
*     EXPORTING i_fieldname       = usmd0_cs_fld-crequest
*               it_sel            = lt_sel
*               if_use_edtn_slice = abap_false
*     IMPORTING et_data           = lt_objlist ).
*
*   CLEAR: lt_sel.
*   lt_sel = Value #( for ls_obj in lt_objlist ( fieldname = ls_obj-usmd_entity_obj sign = 'I' option = 'EQ' low = ls_obj-usmd_value ) ).
*
*   io_model->create_data_reference(
*     EXPORTING
*       i_fieldname          =  'BP_CPGEN'                 " Field Name
*       i_struct             = if_usmd_model_ext=>gc_struct_key_attr    " Structure
*     IMPORTING
*       er_data              = DATA(lr_data)
*       et_message           =  et_message_info   ).              " Messages
*
*   FIELD-SYMBOLS: <ft_bp_cpgen> TYPE ANY TABLE.
*   ASSIGN lr_data->* TO <ft_bp_cpgen>.
*
*   IF <ft_bp_cpgen> IS ASSIGNED.
*     io_model->read_char_value(
*       EXPORTING i_fieldname       = 'BP_CPGEN'
*                 it_sel            = lt_sel
*                 if_use_edtn_slice = abap_false
*       IMPORTING et_data           = <ft_bp_cpgen> ).
*   ENDIF.



 ENDMETHOD.
ENDCLASS.
