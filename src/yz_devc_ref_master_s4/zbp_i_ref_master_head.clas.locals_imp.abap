class lhc_Request definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for Request result result.

    methods create for modify
      importing entities for create Request.

    methods update for modify
      importing entities for update Request.

    methods delete for modify
      importing keys for delete Request.

    methods read for read
      importing keys for read Request result result.

    methods lock for lock
      importing keys for lock Request.

    methods rba_Item for read
      importing keys_rba for read Request\_Item full result_requested result result link association_links.

*    methods cba_Item for modify
*      importing entities_cba for create Request\_Item.
    methods rba_Approver for read
      importing keys_rba for read Request\_Approver full result_requested result result link association_links.

    methods rba_Wflog for read
      importing keys_rba for read Request\_Wflog full result_requested result result link association_links.

    methods cba_Approver for modify
      importing entities_cba for create Request\_Approver.

    methods cba_Wflog for modify
      importing entities_cba for create Request\_Wflog.

    methods show_approvers for modify
      importing keys for action Request~show_approvers result result.

    methods show_fields for modify
      importing keys for action Request~show_fields result result.

    methods show_wf_log for modify
      importing keys for action Request~show_wf_log result result.
    methods load_fields for modify
      importing keys for action Request~load_fields result result.

endclass.

class lhc_Request implementation.

  method get_instance_authorizations.
  endmethod.

  method create.
    data : ls_header type zref_master_head,
           lt_header type table of zref_master_head.
    data lv_nr     type i.
    loop at entities assigning field-symbol(<lfs_entity>).
      ls_header = corresponding #( <lfs_entity> mapping from entity using control ).
      if ls_header-object_class = '01'.
        select single werks from t001w into @data(lv_plant) where werks = @ls_header-object_id.
        if sy-subrc = 0.
          data(lv_exist) = 'X'.
        endif.
        if <lfs_entity>-Change_Req_Type = '02' and lv_exist is initial.
          append value #( %cid = <lfs_entity>-%cid
                          "Req_Id = 'XXX' )
                          Req_Guid = 'XXX' )
                          to failed-request.

          append value #( %msg = new_message( id       = 'ZREF_MASTER_MESSAGES'
                                              number   = '003'
                                              v1       = ls_header-object_id
                                              severity = if_abap_behv_message=>severity-error )
                          "%key-Req_Id = 'XXX'
                          %key-Req_Guid = 'XXX'
                          %cid =  <lfs_entity>-%cid
                          %create = 'X' )
                          to reported-request.
          return.
        elseif <lfs_entity>-Change_Req_Type = '01' and lv_exist is not initial.
          append value #( %cid = <lfs_entity>-%cid
                          "Req_Id = 'XXX' )
                          Req_Guid = 'XXX' )
                          to failed-request.

          append value #( %msg = new_message( id       = 'ZREF_MASTER_MESSAGES'
                                              number   = '001'
                                              v1       = ls_header-object_id
                                              severity = if_abap_behv_message=>severity-error )
                          "%key-Req_Id = 'XXX'
                          %key-Req_Guid = 'XXX'
                          %cid =  <lfs_entity>-%cid
                          %create = 'X' )
                          to reported-request.
          return.
        endif.
      elseif ls_header-object_class = '02'.
        select single bukrs from t001 into @data(lv_comp_code) where bukrs = @ls_header-object_id.
        if sy-subrc = 0.
          lv_exist = 'X'.
        endif.
        if <lfs_entity>-Change_Req_Type = '02' and lv_exist is initial.
          append value #( %cid = <lfs_entity>-%cid
                          "Req_Id = 'XXX' )
                          Req_Guid = 'XXX' )
                          to failed-request.

          append value #( %msg = new_message( id       = 'ZREF_MASTER_MESSAGES'
                                              number   = '004'
                                              v1       = ls_header-object_id
                                              severity = if_abap_behv_message=>severity-error )
                          "%key-Req_Id = 'XXX'
                          %key-Req_Guid = 'XXX'
                          %cid =  <lfs_entity>-%cid
                          %create = 'X' )
                          to reported-request.
          return.
        elseif <lfs_entity>-Change_Req_Type = '01' and lv_exist is not initial.
          append value #( %cid = <lfs_entity>-%cid
                          "Req_Id = 'XXX' )
                          Req_Guid = 'XXX' )
                          to failed-request.

          append value #( %msg = new_message( id       = 'ZREF_MASTER_MESSAGES'
                                              number   = '005'
                                              v1       = ls_header-object_id
                                              severity = if_abap_behv_message=>severity-error )
                          "%key-Req_Id = 'XXX'
                          %key-Req_Guid = 'XXX'
                          %cid =  <lfs_entity>-%cid
                          %create = 'X' )
                          to reported-request.
          return.
        endif.
      endif.
      if ls_header-change_req_type is initial or ls_header-object_class is initial
          or ls_header-object_id is initial.
        append value #( %cid = <lfs_entity>-%cid
                    "Req_Id = 'XXX' )
                    Req_Guid = 'XXX' )
                    to failed-request.

        append value #( %msg = new_message( id       = 'ZREF_MASTER_MESSAGES'
                                            number   = '000'
                                            v1       = 'All fields are mandatory'
                                            severity = if_abap_behv_message=>severity-error )
                        "%key-Req_Id = 'XXX'
                        %key-Req_Guid = 'XXX'
                        %cid =  <lfs_entity>-%cid
                        %create = 'X' )
                        to reported-request.
      else.
        if ls_header-parent_object_id is not initial.
          select single * from zref_obj_class into @data(ls_ref_obj_class) where object_class = @ls_header-object_class.
          if sy-subrc = 0 and ls_ref_obj_class-hierarchy is initial.
            append value #( %cid = <lfs_entity>-%cid
                "Req_Id = 'XXX' )
                Req_Guid = 'XXX' )
                to failed-request.

            append value #( %msg = new_message( id       = 'ZREF_MASTER_MESSAGES'
                                                number   = '000'
                                                v1       = 'Parent ID is not allowed for'
                                                v2       = ls_ref_obj_class-object_class_desc
                                                severity = if_abap_behv_message=>severity-error )
                            "%key-Req_Id = 'XXX'
                            %key-Req_Guid = 'XXX'
                            %cid =  <lfs_entity>-%cid
                            %create = 'X' )
                            to reported-request.
            return.
          endif.
        endif.
        call function 'NUMBER_GET_NEXT'
          exporting
            nr_range_nr             = '01'
            object                  = 'ZREF_MSTR'
          importing
            number                  = lv_nr
          exceptions
            interval_not_found      = 1
            number_range_not_intern = 2
            object_not_found        = 3
            quantity_is_0           = 4
            quantity_is_not_1       = 5
            interval_overflow       = 6
            buffer_overflow         = 7
            others                  = 8.
        if sy-subrc <> 0.
          append value #( %cid = <lfs_entity>-%cid
                    "Req_Id = 'XXX' )
                    Req_Guid = 'XXX' )
                    to failed-request.

          append value #( %msg = new_message( id       = 'ZREF_MASTER_MESSAGES'
                                              number   = '000'
                                              v1       = 'Request no. could not be generated'
                                              severity = if_abap_behv_message=>severity-error )
                          "%key-Req_Id = 'XXX'
                          %key-Req_Guid = 'XXX'
                          %cid =  <lfs_entity>-%cid
                          %create = 'X' )
                          to reported-request.
          return.
        endif.
        ls_header-Req_Id = '$' && lv_nr.
        ls_header-req_guid = cl_system_uuid=>if_system_uuid_static~create_uuid_x16(  ).

        mapped-request = value #( base mapped-request (
                                    %cid = <lfs_entity>-%cid
                                    "Req_Id = ls_header-Req_Id
                                    Req_Guid = ls_header-req_guid
                                ) ).
*        ls_header- = sy-uname.
*        get time stamp field ls_header-created_at.
        modify zref_master_head from ls_header.
      endif.

      data ls_item type zref_master_itm.
      data lt_item type table of zref_master_itm.
      if ls_header-object_class = '01'.
        select * from zref_req_metdata into table @data(lt_fields) where Object_Class = @ls_header-object_class
        and Change_Req_Type = @ls_header-change_req_type.
        if sy-subrc = 0.
          sort lt_fields by field_sequance.
          select single * from t001w into @data(ls_existing) where werks = @ls_header-object_id.
          if sy-subrc ne 0.
            clear ls_existing.
          endif.
          loop at lt_fields into data(ls_field).
            ls_item-Req_Id = ls_header-Req_Id.
            ls_item-req_guid = ls_header-req_guid.
            ls_item-record_id = sy-tabix.
            ls_item-field_name = ls_field-fields.
            assign component ls_field-fields of structure ls_existing to field-symbol(<lfs_field>).
            if <lfs_field> is assigned.
              ls_item-old_value = <lfs_field>.
            endif.
            if ls_header-change_req_type = '01'.
              ls_item-update_ind = 'I'.
            endif.
            append ls_item to lt_item.
            clear ls_item.
          endloop.
          modify zref_master_itm from table lt_item.
        endif.
      elseif ls_header-object_class = '02'.
        select * from zref_req_metdata into table @lt_fields where Object_Class = @ls_header-object_class
        and Change_Req_Type = @ls_header-change_req_type.
        if sy-subrc = 0.
          select single * from t001 into @data(lw_t001) where bukrs = @ls_header-object_id.
          if sy-subrc ne 0.
            clear lw_t001.
          endif.
          loop at lt_fields into ls_field.
            ls_item-Req_Id = ls_header-Req_Id.
            ls_item-req_guid = ls_header-req_guid.
            ls_item-record_id = sy-tabix.
            ls_item-field_name = ls_field-fields.
            assign component ls_field-fields of structure lw_t001 to <lfs_field>.
            if <lfs_field> is assigned.
              ls_item-old_value = <lfs_field>.
            endif.
            if ls_header-change_req_type = '01'.
              ls_item-update_ind = 'I'.
            endif.
            append ls_item to lt_item.
            clear ls_item.
          endloop.
          modify zref_master_itm from table lt_item.
        endif.
      else.
      select * from zref_req_metdata into table @lt_fields where Object_Class = @ls_header-object_class
        and Change_Req_Type = @ls_header-change_req_type.
        if sy-subrc = 0.
          loop at lt_fields into ls_field.
            ls_item-Req_Id = ls_header-Req_Id.
            ls_item-req_guid = ls_header-req_guid.
            ls_item-record_id = sy-tabix.
            ls_item-field_name = ls_field-fields.
            if ls_header-change_req_type = '01'.
              ls_item-update_ind = 'I'.
            endif.
            append ls_item to lt_item.
            clear ls_item.
          endloop.
          modify zref_master_itm from table lt_item.
        endif.
      endif.
    endloop.
  endmethod.

  method update.
    if 1 = 2.
    endif.
    loop at entities assigning field-symbol(<lfs_entity>).
        update zref_master_head set parent_object_id = <lfs_entity>-Parent_Object_Id object_descr = <lfs_entity>-Object_Descr
        where req_guid = <lfs_entity>-Req_Guid.
    endloop.
  endmethod.

  method delete.
    loop at keys assigning field-symbol(<lfs_keys>).
      delete from zref_master_head where req_guid = <lfs_keys>-Req_Guid.
      delete from zref_master_itm where req_guid = <lfs_keys>-Req_Guid.
    endloop.
  endmethod.

  method read.
    select * from zi_ref_master_head for all entries in @keys
      where Req_Guid = @keys-Req_Guid into corresponding fields of table @result..

  endmethod.

  method lock.
  endmethod.

  method rba_Item.
  endmethod.

*  method cba_Item.
*  endmethod.

  method rba_Approver.
  endmethod.

  method rba_Wflog.
  endmethod.

  method cba_Approver.
  endmethod.

  method cba_Wflog.
  endmethod.

  method show_approvers.
    if 1 = 2.
    endif.
    read entities of zi_ref_master_head in local mode
      entity Request
      fields ( Req_Id ) with corresponding #( keys )
      result data(lt_requests)
      failed failed.



    zcl_ref_master_tab_display=>gv_tab_fields = 'X'.
    zcl_ref_master_tab_display=>gv_tab_approvers = ''.
    zcl_ref_master_tab_display=>gv_tab_wf_log = 'X'.


    result = value #( for ls_request in lt_requests (
                                         %key = ls_request-%key
                                         %param = corresponding #( ls_request-%data )
                                         ) ).

  endmethod.

  method show_fields.
    data ls_item type zrm_draft_itm.
    if 1 = 2.
    endif.
    read entities of zi_ref_master_head in local mode
        entity Request
        fields ( Req_Id ) with corresponding #( keys )
        result data(lt_requests)
        failed failed.

    read table lt_requests into data(ls_header) index 1.
    if sy-subrc = 0. "and ls_header-%is_draft = '01'.
      select * from zrm_draft_itm into table @data(lt_item) where req_guid = @ls_header-Req_Guid.
      if sy-subrc ne 0.
        select single * from zrm_draft_head into @data(ls_header_d)
        where req_guid = @ls_header-req_guid.
        if sy-subrc = 0.
          if ls_header_d-object_class = '01'.
            select * from zref_req_metdata into table @data(lt_fields) where Object_Class = @ls_header_d-object_class
            and Change_Req_Type = @ls_header_d-change_req_type.
            if sy-subrc = 0.
              sort lt_fields by field_sequance.
              select single * from t001w into @data(ls_existing) where werks = @ls_header_d-object_id.
              if sy-subrc ne 0.
                clear ls_existing.
              endif.
              loop at lt_fields into data(ls_field).
                ls_item = corresponding #( ls_header_d ).
                ls_item-req_guid = ls_header_d-req_guid.
                ls_item-record_id = sy-tabix.
                ls_item-field_name = ls_field-fields.
                assign component ls_field-fields of structure ls_existing to field-symbol(<lfs_field>).
                if <lfs_field> is assigned.
                  ls_item-field_value = <lfs_field>.
                endif.
                append ls_item to lt_item.
                clear ls_item.
              endloop.
            endif.
          elseif ls_header_d-object_class = '02'.
            select * from zref_req_metdata into table @lt_fields where Object_Class = @ls_header_d-object_class
            and Change_Req_Type = @ls_header_d-change_req_type.
            if sy-subrc = 0.
              select single * from t001 into @data(lw_t001) where bukrs = @ls_header_d-object_id.
              if sy-subrc ne 0.
                clear lw_t001.
              endif.
              loop at lt_fields into ls_field.
                ls_item = corresponding #( ls_header_d ).
                ls_item-req_guid = ls_header_d-req_guid.
                ls_item-record_id = sy-tabix.
                ls_item-field_name = ls_field-fields.
                assign component ls_field-fields of structure lw_t001 to <lfs_field>.
                append ls_item to lt_item.
                clear ls_item.
              endloop.
            endif.
          endif.
        endif.
        if lt_item is not initial.
          modify zrm_draft_itm from table lt_item.
        endif.
      endif.
      "result = value #( base result[] ( %is_draft = '01' %param = corresponding #( ls_header_d )  ) ).
      result = value #( base result[] ( %param = corresponding #( ls_header_d )  ) ).
    else.
      zcl_ref_master_tab_display=>gv_tab_fields = 'X'.
      zcl_ref_master_tab_display=>gv_tab_approvers = ''.
      zcl_ref_master_tab_display=>gv_tab_wf_log = 'X'.
      result = value #( for ls_request in lt_requests (
                                         %key = ls_request-%key
                                         %param = corresponding #( ls_request-%data )
                                         ) ).
    endif.



  endmethod.

  method show_wf_log.
    if 1 = 2.
    endif.
    read entities of zi_ref_master_head in local mode
        entity Request
        fields ( Req_Id ) with corresponding #( keys )
        result data(lt_requests)
        failed failed.



    zcl_ref_master_tab_display=>gv_tab_fields = 'X'.
    zcl_ref_master_tab_display=>gv_tab_approvers = 'X'.
    zcl_ref_master_tab_display=>gv_tab_wf_log = ''.

    result = value #( for ls_request in lt_requests (
                                         %key = ls_request-%key
                                         %param = corresponding #( ls_request-%data )
                                         ) ).


  endmethod.

  method load_fields.
    data ls_item type zrm_draft_itm.
    data lt_item type table of zrm_draft_itm.
    read table keys assigning field-symbol(<lfs_key>) index 1.
    if sy-subrc = 0.
      select single * from zrm_draft_head into @data(ls_header)
      where req_guid = @<lfs_key>-req_guid.
      if sy-subrc = 0.
        if ls_header-object_class = '01'.
          select * from zref_req_metdata into table @data(lt_fields) where Object_Class = @ls_header-object_class
          and Change_Req_Type = @ls_header-change_req_type.
          if sy-subrc = 0.
            sort lt_fields by field_sequance.
            select single * from t001w into @data(ls_existing) where werks = @ls_header-object_id.
            if sy-subrc ne 0.
              clear ls_existing.
            endif.
            loop at lt_fields into data(ls_field).
              ls_item = corresponding #( ls_header ).
              ls_item-req_guid = ls_header-req_guid.
              ls_item-record_id = sy-tabix.
              ls_item-field_name = ls_field-fields.
              assign component ls_field-fields of structure ls_existing to field-symbol(<lfs_field>).
              if <lfs_field> is assigned.
                ls_item-field_value = <lfs_field>.
              endif.
              append ls_item to lt_item.
              clear ls_item.
            endloop.
          endif.
        elseif ls_header-object_class = '02'.
          select * from zref_req_metdata into table @lt_fields where Object_Class = @ls_header-object_class
          and Change_Req_Type = @ls_header-change_req_type.
          if sy-subrc = 0.
            select single * from t001 into @data(lw_t001) where bukrs = @ls_header-object_id.
            if sy-subrc ne 0.
              clear lw_t001.
            endif.
            loop at lt_fields into ls_field.
              ls_item-req_guid = ls_header-req_guid.
              ls_item-record_id = sy-tabix.
              ls_item-field_name = ls_field-fields.
              assign component ls_field-fields of structure lw_t001 to <lfs_field>.
              append ls_item to lt_item.
              clear ls_item.
            endloop.
          endif.
        endif.
      endif.
      if lt_item is not initial.
        modify zrm_draft_itm from table lt_item.
      endif.
    endif.
    read entities of zi_ref_master_head in local mode
        entity Request
        fields ( Req_Id ) with corresponding #( keys )
        result data(lt_requests)
        failed failed.

    result = value #( for ls_request in lt_requests (
                                         %key = ls_request-%key
                                         %param = corresponding #( ls_request-%data )
                                         ) ).
  endmethod.

endclass.

class lsc_ZI_REF_MASTER_HEAD definition inheriting from cl_abap_behavior_saver.
  protected section.

    methods finalize redefinition.

    methods check_before_save redefinition.

    methods save redefinition.

    methods cleanup redefinition.

    methods cleanup_finalize redefinition.

endclass.

class lsc_ZI_REF_MASTER_HEAD implementation.

  method finalize.
  endmethod.

  method check_before_save.
  endmethod.

  method save.
  endmethod.

  method cleanup.
  endmethod.

  method cleanup_finalize.
  endmethod.

endclass.
