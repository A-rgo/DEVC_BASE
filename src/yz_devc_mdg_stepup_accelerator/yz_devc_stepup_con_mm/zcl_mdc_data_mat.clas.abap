class ZCL_MDC_DATA_MAT definition
  public
  inheriting from CL_MDC_DATA_MAT
  create public

  global friends IF_MDC_MODEL .

public section.

  methods IF_MDC_DATA~APPEND_ACTIVE_RECORDS
    redefinition .
  methods IF_MDC_DATA~CONTAINS_LOB_DATA
    redefinition .
  methods IF_MDC_DATA~TABLE_NAME_BY_TYPE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MDC_DATA_MAT IMPLEMENTATION.


  method if_mdc_data~append_active_records.
    try.
        call method super->if_mdc_data~append_active_records
          exporting
            it_source_keys = it_source_keys.
      catch cx_mdc_model ##NO_HANDLER.
    endtry.
  endmethod.


  method if_mdc_data~contains_lob_data.
    rv_contains_lob_data = super->if_mdc_data~contains_lob_data( ).
  endmethod.


  method if_mdc_data~table_name_by_type.
    call method super->if_mdc_data~table_name_by_type
      exporting
        iv_type           = iv_type
        iv_name_prefixing = 'MDC_'
      receiving
        rv_table_name     = rv_table_name.
  endmethod.
ENDCLASS.
