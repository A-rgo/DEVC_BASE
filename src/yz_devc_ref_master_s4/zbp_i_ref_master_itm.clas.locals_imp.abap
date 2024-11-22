class lhc_Fields definition inheriting from cl_abap_behavior_handler.
  private section.

    methods update for modify
      importing entities for update Fields.

    methods delete for modify
      importing keys for delete Fields.

    methods read for read
      importing keys for read Fields result result.

    methods rba_Header for read
      importing keys_rba for read Fields\_Header full result_requested result result link association_links.

endclass.

class lhc_Fields implementation.

  method update.
    data ls_item type zref_master_itm.
    read table entities assigning field-symbol(<lfs_entity>) index 1.
    if <lfs_entity> is assigned.
      ls_item = corresponding #( <lfs_entity> mapping from entity ).
      select record_id, field_name, field_value, old_value from zref_master_itm
      into table @data(lt_items) where req_guid = @ls_item-req_guid.
      if sy-subrc = 0.
        sort lt_items by record_id.
      endif.
      select * from zref_master_head into @data(ls_header) up to 1 rows where req_guid = @ls_item-req_guid.
      endselect.
      if sy-subrc ne 0.
        clear ls_header.
      endif.
*
      loop at entities assigning <lfs_entity>.
        ls_item = corresponding #( <lfs_entity> mapping from entity ).
        read table lt_items into data(lw_item) with key record_id = ls_item-record_id binary search.
        if sy-subrc = 0.
          try.
              data(lo_validator) = ycl_addict_data_element=>get_instance( rollname = lw_item-field_name ).
              lo_validator->validate_value( value = ls_item-field_value ).
            catch ycx_addict_table_content into data(lo_tab_cont).
              data(lv_error) = 'X'.
              append value #( %cid = <lfs_entity>-%cid_ref
                            "change_req = <lfs_entity>-Change_Req
                            "req_id = <lfs_entity>-Req_Id
                            req_guid = <lfs_entity>-Req_Guid
                            record_id = <lfs_entity>-Record_Id )
                            to failed-fields.

              data(lv_msg) = lo_tab_cont->get_text( ).
              replace all occurrences of '&1' in lv_msg with lw_item-field_name.
              append value #( %msg = new_message( id       = 'ZREF_MASTER_MESSAGES'
                                                  number   = '000'
                                                  v1       = lv_msg
                                                  severity = if_abap_behv_message=>severity-error )
                              "%key-change_req = <lfs_entity>-Change_Req
                              "%key-Req_Id = <lfs_entity>-Req_Id
                              %key-Req_Guid = <lfs_entity>-Req_Guid
                              %cid =  <Lfs_entity>-%cid_ref
                              %key-record_id = <lfs_entity>-Record_Id
                              %update = 'X' )
                              to reported-fields.
            catch ycx_addict_domain into data(lo_exec_domain).
              lv_error = 'X'.
              append value #( %cid = <lfs_entity>-%cid_ref
                            "change_req = <lfs_entity>-Change_Req
                            "req_id = <lfs_entity>-Req_Id
                            req_guid = <lfs_entity>-Req_Guid
                            record_id = <lfs_entity>-Record_Id )
                            to failed-fields.

              lv_msg = lo_exec_domain->get_text( ).
              replace all occurrences of '&1' in lv_msg with lw_item-field_name.
              append value #( %msg = new_message( id       = 'ZREF_MASTER_MESSAGES'
                                                  number   = '000'
                                                  v1       = lv_msg
                                                  severity = if_abap_behv_message=>severity-error )
                              "%key-change_req = <lfs_entity>-Change_Req
                              "%key-Req_Id = <lfs_entity>-Req_Id
                              %key-Req_Guid = <lfs_entity>-Req_Guid
                              %cid =  <Lfs_entity>-%cid_ref
                              %key-record_id = <lfs_entity>-Record_Id
                              %update = 'X' )
                              to reported-fields.

          endtry.
        endif.
      endloop.
      if lv_error is not initial.
        return.
      endif.
      sort lt_items by record_id.
      loop at entities assigning <lfs_entity>.
        ls_item = corresponding #( <lfs_entity> mapping from entity ).
        lw_item = value #( lt_items[ record_id = <lfs_entity>-Record_Id ] optional ).
        if ls_header-change_req_type = '02'.
          data(lv_upd) = 'U'.
        else.
          lv_upd = 'I'.
        endif.
        update zref_master_itm set field_value = <lfs_entity>-Field_Value update_ind = lv_upd
        where req_guid = <lfs_entity>-Req_Guid and record_id = <lfs_entity>-Record_Id.
      endloop.

      call method zcl_ref_master_flex=>start_workflow( i_req_id = <lfs_entity>-Req_Guid ).
    endif.
  endmethod.

  method delete.
    loop at keys assigning field-symbol(<lfs_keys>).
      "DELETE FROM zref_master_itm WHERE req_id = <lfs_keys>-Req_Guid AND record_id = <lfs_keys>-Record_Id.
      delete from zref_master_itm where req_guid = <lfs_keys>-Req_Guid and record_id = <lfs_keys>-Record_Id.
    endloop.
  endmethod.

  method read.
  endmethod.

  method rba_Header.
  endmethod.

endclass.
