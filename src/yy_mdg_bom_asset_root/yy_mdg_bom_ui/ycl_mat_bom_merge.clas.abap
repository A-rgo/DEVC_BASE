class YCL_MAT_BOM_MERGE definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_USMD_SSW_PARA_RSLT_HANDLER .
protected section.
private section.
ENDCLASS.



CLASS YCL_MAT_BOM_MERGE IMPLEMENTATION.


  METHOD if_usmd_ssw_para_rslt_handler~handle_parallel_result.
    CASE iv_service_name.
      WHEN 'YMAT_BOM_MERGE'.
        LOOP AT it_step_action INTO DATA(ls_step_action).
*          ev_merge_step = '20'.
          IF ls_step_action-action = '04'.
*            ev_merge_action = '04'.
            ev_merge_step = '01'.
            RETURN.
          ENDIF.
        ENDLOOP.
        ev_merge_action = '03'.
        ev_merge_step = '70'.
      WHEN 'YMAT_BOM_MERGE_SRV'.
        READ TABLE it_step_action INTO ls_step_action WITH KEY action = '04'.
        IF sy-subrc IS INITIAL.
*          ev_merge_action = '04'.
          ev_merge_step = '01'.
          RETURN.
        ENDIF.
        ev_merge_action = '03'.
        ev_merge_step = '80'.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
