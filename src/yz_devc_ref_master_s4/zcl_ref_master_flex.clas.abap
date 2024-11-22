class ZCL_REF_MASTER_FLEX definition
  public
  inheriting from CL_SWF_FLEX_IFS_RUN_APPL_BASE
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .
  interfaces IF_SWF_IFS_WORKITEM_EXIT .
  interfaces IF_SADL_EXIT .

  class-events START
    exporting
      value(IV_INITIATOR) type SWP_AGENT optional
      value(IV_OBJECT_ID) type SWC_ELEM optional
      value(HEADER) type ZREF_MASTER_HEAD optional
      value(ITEMS) type ZTT_REF_MASTER_ITM optional
      value(OUTPUT_TABLE) type HTML_TABLE optional .
  class-events APPROVE .

  class-methods START_WORKFLOW
    importing
      !I_REQ_ID type SYSUUID_X16 .
  class-methods ACTION
    importing
      !IO_CONTEXT type ref to IF_SWF_FLEX_RUN_CONTEXT
      !IO_RESULT type ref to IF_SWF_FLEX_RUN_RESULT .
  class-methods GET_1ST_APPROVER
    importing
      !IV_OBJ_CLASS type ZDE_REF_MASTER_OBJ_CLASS
      !IV_CHANGE_REQ_TYPE type ZDE_REF_MASTER_CHNG_REQ_TYPE
    exporting
      !ET_USER type USMD_T_USER .

  methods IF_SWF_FLEX_IFS_RUN_APPL~MITIGATE_AGENT_RULE_EVALUATION
    redefinition .
  methods IF_SWF_FLEX_IFS_RUN_APPL~RESULT_CALLBACK
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_REF_MASTER_FLEX IMPLEMENTATION.


method start_workflow.
  types: begin of lty_head,
           req_id          type zref_master_reqid,
           object_id       type cdobjectv,
           change_req_id   type usmd_crequest,
           status          type usmd_crequest_status,
           change_req_type type zde_ref_master_chng_req_type,
           object_class    type zde_ref_master_obj_class,
           created_by      type crmt_crusr,
           created_at      type crmt_created_at,
         end of lty_head,

         begin of lty_item,
           field_name  type fieldname,
           ddtext      type as4text,
           field_value type zref_master_field_val,
           old_value   type zref_master_old_val,
           update_ind  type updkz_d,
         end of lty_item,

         ltt_item type table of lty_item with default key,
         ltt_head type table of lty_head with default key.

  data lt_items     type ztt_ref_master_itm.
  data lt_head      type table of lty_head.
  data l_objtype               type sibftypeid value 'ZCL_REF_MASTER_FLEX'.
  data l_event                 type swo_event value 'START'.
  data l_event_container       type ref to if_swf_ifs_parameter_container.
  data lv_param_name       type swfdname.
  data lt_output type table of w3html.
  data lv_objkey        type sibfinstid.

  lv_objkey = i_req_id.
  try.
      call method cl_swf_evt_event=>get_event_container
        exporting
          im_objcateg  = cl_swf_evt_event=>mc_objcateg_cl
          im_objtype   = l_objtype
          im_event     = l_event
        receiving
          re_reference = data(lr_event_parameters).

      select single * from zref_master_head into @data(ls_header) where req_guid = @i_req_id.
      if sy-subrc = 0.
        update zref_master_head set status = '01' where req_id = i_req_id.
*        SELECT req_id, record_id, field_name, field_value, old_value, update_ind
*          FROM zref_master_itm INTO TABLE @DATA(lt_item_desc) WHERE req_id = @i_req_id.
*        IF  sy-subrc = 0.
*          MOVE-CORRESPONDING lt_item_desc TO lt_item.
*        ENDIF.
*        APPEND ls_header TO lt_header.

        select req_id, record_id, business_id, field_name, field_value, active, old_value, update_ind, ddtext
          from zref_master_itm as _item inner join dd04T as _text on _item~field_name = _text~rollname
          into table @data(lt_item_full) where req_guid = @i_req_id and ddlanguage = @sy-langu.
        if sy-subrc = 0.
          move-corresponding lt_item_full to lt_items.

          data(lt_itm_desc) = value ltt_item( for lw_item in lt_item_full ( corresponding #( lw_item ) ) ).
        endif.

        lt_head = value #( base lt_head ( corresponding #( ls_header ) ) ).
      endif.


      lv_param_name = 'HEADER'.

      call method lr_event_parameters->set
        exporting
          name  = lv_param_name
          value = ls_header.

      lv_param_name = 'ITEMS'.

      call method lr_event_parameters->set
        exporting
          name  = lv_param_name
          value = lt_items.

      data(lo_converter) = new zcl_itab_to_html(
        "Setting up CSS for the entire table
        table_style = 'width: 80%; border: #999 1px solid; border-collapse: collapse;'
        "Setting up CSS for header and data lines
        th_style    = 'font-weight: bold; border: #999 1px solid; background: #eee;'
        td_style    = 'border: #999 1px solid;'
      ).

      call method lo_converter->convert
        exporting
          tbl          = lt_head
        importing
          w3html_table = lt_output.

      lt_output = value #( base lt_output ( conv w3html( |<br><br>| ) ) ).


      call method lo_converter->convert
        exporting
          tbl          = lt_itm_desc
        importing
          w3html_table = data(lt_output_itm).

      append lines of lt_output_itm to lt_output.

      lv_param_name = 'OUTPUT_TABLE'.

      call method lr_event_parameters->set
        exporting
          name  = lv_param_name
          value = lt_output.

      call method cl_swf_evt_event=>raise
        exporting
          im_objcateg        = cl_swf_evt_event=>mc_objcateg_cl
          im_objtype         = l_objtype
          im_event           = l_event
          im_objkey          = lv_objkey
          im_event_container = lr_event_parameters.

    catch cx_swf_evt_invalid_objtype into data(lo_invalid_obj).
    catch cx_swf_evt_invalid_event into data(lo_invalid_event).
    catch cx_swf_cnt_container into data(lo_cnt_cont).

  endtry.
endmethod.


  method ACTION.
  endmethod.


  method IF_SWF_IFS_WORKITEM_EXIT~EVENT_RAISED.
    if 1 = 2.
     endif.
  endmethod.


METHOD if_swf_flex_ifs_run_appl~result_callback.

  DATA ls_header  TYPE zref_master_head.
  DATA lw_t001W   TYPE t001W.
  DATA lw_yT001W  TYPE t001w.
  DATA lw_yT001k  TYPE t001k.
  DATA lw_T001k   TYPE t001k.
  DATA lw_ref_wkfil   TYPE wr02d-ref_wkfil.
  DATA lw_tcurm   TYPE tcurm.
  DATA lw_kunnr   TYPE t001w-kunnr.
  DATA lt_wr04d   TYPE TABLE OF wr04d.
  DATA lw_ref_kunnr TYPE t001w-kunnr.
  DATA lv_ind TYPE cdchngind.

  FIELD-SYMBOLS: <lfs_field> TYPE any.
  TRY.
      DATA(ls_result) = io_result->get_result( ).
      DATA(lo_cont) = io_context->get_workflow_container( ).

      DATA(ls_ref) = io_context->get_leading_object_reference( ).

      IF ls_result-nature = 'POSITIVE'.
        lo_cont->get( EXPORTING name = 'HEADER' IMPORTING value = ls_header ).
        SELECT * FROM zref_master_itm INTO TABLE @DATA(lt_items) WHERE req_guid = @ls_header-req_guid.
        IF sy-subrc = 0.
          IF ls_header-object_class = '01'.
            UNASSIGN <lfs_field>.
            ASSIGN COMPONENT 'WERKS' OF STRUCTURE lw_t001W TO <lfs_field>.
            IF <lfs_field> IS ASSIGNED.
              <lfs_field> = ls_header-object_id.
            ENDIF.
            IF ls_header-change_req_type = '02'.
              SELECT SINGLE * FROM t001w INTO lw_yt001w WHERE werks = ls_header-object_id.
              IF sy-subrc = 0.
                MOVE-CORRESPONDING lw_yt001w TO lw_t001w.
              ENDIF.
            ENDIF.
            LOOP AT lt_items INTO DATA(lw_item).
              UNASSIGN <lfs_field>.
              ASSIGN COMPONENT lw_item-field_name OF STRUCTURE lw_t001w TO <lfs_field>.
              IF <lfs_field> IS ASSIGNED.
                IF ( lw_yt001w-werks IS NOT INITIAL AND lw_item-field_value IS NOT INITIAL )
                  OR ls_header-change_req_type = '01'.
                  <lfs_field> = lw_item-field_value.
                ENDIF.
              ENDIF.
            ENDLOOP.
            CALL FUNCTION 'LOCATION_UPDATE_CUSTOMIZING_WB'
              IN UPDATE TASK
              EXPORTING
                i_t001w     = lw_t001w
                i_yt001w    = lw_yt001w
                i_yt001k    = lw_yt001k
                i_t001k     = lw_t001k
*               I_VKBUR     =
*               I_VKBUR_OLD =
                i_ref_wkfil = lw_ref_wkfil
*               I_SADR      =
*               I_YSADR     =
                i_tcurm     = lw_tcurm
                i_ref_kunnr = lw_ref_kunnr
              TABLES
                pi_t_ctab   = lt_wr04d.

          ELSE.
            UNASSIGN <lfs_field>.
            IF ls_header-change_req_type = '02'.
              SELECT SINGLE * FROM t001 INTO @DATA(lw_t001) WHERE bukrs = @ls_header-object_id.
              IF sy-subrc = 0.
                lv_ind = 'U'.
              ENDIF.
            ELSE.
              lv_ind = 'I'.
              lw_t001-bukrs = ls_header-object_id.
            ENDIF.

            LOOP AT lt_items INTO lw_item WHERE update_ind = 'U' OR update_ind = 'I'.
              UNASSIGN <lfs_field>.
              ASSIGN COMPONENT lw_item-field_name OF STRUCTURE lw_t001 TO <lfs_field>.
              IF <lfs_field> IS ASSIGNED.
                <lfs_field> = lw_item-field_value.
              ENDIF.
            ENDLOOP.
            CALL FUNCTION 'REDB_T001_UPDATE_S'
              IN UPDATE TASK
              EXPORTING
                is_t001              = lw_t001
                id_operation         = lv_ind
              exceptions
                db_failure           = 1
                db_operation_unknown = 2
                others               = 3.
            IF sy-subrc <> 0.
            ENDIF.

          ENDIF.
        ENDIF.
        UPDATE zref_master_head SET status = '05' WHERE req_guid = ls_header-req_guid.
        COMMIT WORK.
      ELSE.
        lo_cont->get( EXPORTING name = 'HEADER' IMPORTING value = ls_header ).
        UPDATE zref_master_head SET status = '06' WHERE req_guid = ls_header-req_guid.
        COMMIT WORK.
      ENDIF.
    CATCH cx_swf_cnt_container INTO DATA(lo_cnt_cont).
  ENDTRY.
ENDMETHOD.


  method GET_1ST_APPROVER.
*    IF 1 = 2.
*
*    ENDIF.
    SELECT FROM ZREF_MSTER_AGENT FIELDS approver WHERE object_class = @iv_obj_class
      and change_req_type = @iv_change_req_type AND active = 'X' INTO TABLE @et_user.
    IF sy-subrc = 0.
      SORT et_user.
    ENDIF.
  endmethod.


METHOD if_swf_flex_ifs_run_appl~mitigate_agent_rule_evaluation.

  DATA ls_header TYPE zref_master_head.
  TRY .
      io_workflow_container->get(
        EXPORTING
          name  = 'HEADER'                 " Name of the Component Whose Value Is to Be Read
        IMPORTING
          value = ls_header                 " Copy of the Current Value of the Component
      ).
    CATCH cx_swf_cnt_elem_not_found.     " Name Entered Is Unknown
    CATCH cx_swf_cnt_elem_type_conflict. " Value Not Type Compatible to Current Parameter
    CATCH cx_swf_cnt_unit_type_conflict. " Unit Not Type Compatible to the Current Parameter
    CATCH cx_swf_cnt_container.          " Exception in the Container Service
  ENDTRY.

  get_1st_approver(
    EXPORTING
      iv_obj_class       = ls_header-object_class                 " Flexible Workflow Context
      iv_change_req_type = ls_header-change_req_type                 " Change Request Type
    IMPORTING
      et_user            = DATA(lt_approver)                " User Name in User Master Record
  ).

  rt_result = VALUE #( FOR lw_approver IN lt_approver ( otype = 'US' objid = lw_approver ) ).
ENDMETHOD.
ENDCLASS.
