class YZ_CLAS_MDG_YB_CP_CLASS definition
  public
  final
  create public .

public section.

  interfaces IF_EX_BDCP_BEFORE_WRITE .
protected section.
private section.
ENDCLASS.



CLASS YZ_CLAS_MDG_YB_CP_CLASS IMPLEMENTATION.


  METHOD if_ex_bdcp_before_write~filter_bdcpv_before_write.
    DATA: lx_mdg_cp_exception TYPE REF TO cx_mdg_cp_exception,
          lv_msg_text         TYPE string .                 "#EC NEEDED

    FIELD-SYMBOLS: <ls_bdcpv>  TYPE  bdcpv.
    TRY .
        CALL METHOD cl_mdg_change_pointer=>create_ale_related_cp(
          EXPORTING
            iv_business_object  = if_mdg_otc_const=>bp_relship_process_ctrl
            it_change_pointers  = change_pointers
            it_change_documents = change_document_positions
        ).
        LOOP AT change_pointers ASSIGNING <ls_bdcpv>.
          <ls_bdcpv>-process = 'X' .
        ENDLOOP .
**    Medthod raises an excaption or fills the ls_msg_text
      CATCH  cx_mdg_cp_exception INTO lx_mdg_cp_exception.
        lv_msg_text = lx_mdg_cp_exception->get_text( ).     "#EC NEEDED
    ENDTRY .
  ENDMETHOD.
ENDCLASS.
