class ZCL_MDC_TMPL_MODEL_YB_BNKA definition
  public
  inheriting from CL_MDC_TMPL_MODEL
  final
  create public .

public section.

  methods CONSTRUCTOR .

  methods IF_MDC_MODEL~SOURCE_ID_FIELDS
    redefinition .
protected section.

  data MR_ZZBNKA_PRC type ref to ZMDC_TT_ZZBNKA_PRC .

  methods SAVE_ACTIVE_DATA
    redefinition .
  methods SAVE_SOURCE_STATUS
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_MDC_TMPL_MODEL_YB_BNKA IMPLEMENTATION.


  METHOD constructor.

    CALL METHOD super->constructor(
        iv_bo_type            = bo_type
        iv_process_id         = process_id
        iv_process_goal       = process_goal
        iv_step_number        = step_number
        iv_step_type          = step_type
        iv_configuration_data = configuration_data
        iv_package_size       = package_size
      ).
    me->append_active_records_by_sql = abap_true.
*    me->source_id_field = 'BANKS$$BANKL'.
*      CATCH cx_mdc_model."CONSTRUCTOR".

  ENDMETHOD.


  method IF_MDC_MODEL~SOURCE_ID_FIELDS.

    rt_fields = VALUE #( ( |BANKS| ) ( |BANKL| ) ).

  endmethod.


  METHOD save_active_data.

    TYPES: tt_zzbnka_src_stat TYPE STANDARD TABLE OF zzbnka_src_stat.
    DATA ls_zbnka   TYPE zbnka.
    DATA lt_zbnka TYPE STANDARD TABLE OF zbnka.
    TRY.
        me->mr_zzbnka_prc =  CAST zmdc_tt_zzbnka_prc( me->object( 'ZBNKA' )->read( ) ).
        LOOP AT me->mr_zzbnka_prc->* ASSIGNING FIELD-SYMBOL(<ls_zzbnka_prc>).
          CLEAR: ls_zbnka, lt_zbnka.
          MOVE-CORRESPONDING <ls_zzbnka_prc> TO ls_zbnka.
          FIELD-SYMBOLS <source_status_table> TYPE tt_zzbnka_src_stat.
          ASSIGN me->source_status_table->* TO <source_status_table>.
          READ TABLE <source_status_table> ASSIGNING FIELD-SYMBOL(<source_status>) WITH KEY source_id = <ls_zzbnka_prc>-source_id.
          IF <ls_zzbnka_prc>-validation_status <> if_mdc_data=>gc_validation_status-error.
            TRY.
                MODIFY zbnka FROM @ls_zbnka.
                """We may require to add additional code to update the data into main database table BNKA
                APPEND <ls_zzbnka_prc>-source_key TO me->dropped_source_keys.
                CHECK <source_status> IS ASSIGNED.
                <source_status>-activation_target = if_mdc_adapter=>activation_target-direct.
                <source_status>-banks = <ls_zzbnka_prc>-banks.
                <source_status>-bankl = <ls_zzbnka_prc>-bankl.
              CATCH cx_root INTO DATA(exception_root).
                me->log->add_exception( exception_root ).
                CONTINUE.
            ENDTRY.
          ENDIF.
          UNASSIGN <source_status>.
        ENDLOOP.
      CATCH cx_mdc_model INTO DATA(exception_model).
        me->log->add_exception( exception_model ).
    ENDTRY.

  ENDMETHOD.


  METHOD save_source_status.

    TYPES: tt_zzbnka_src_stat TYPE STANDARD TABLE OF zzbnka_src_stat.
    super->save_source_status( ).
    FIELD-SYMBOLS <source_status_table> TYPE tt_zzbnka_src_stat.
    ASSIGN me->source_status_table->* TO <source_status_table>.
    DATA(lt_recordtargets) = CORRESPONDING mdc_tt_recordtarget( <source_status_table> MAPPING activation = activation_target ).
    MODIFY lt_recordtargets FROM VALUE #( bo_type = me->bo_type ) TRANSPORTING bo_type WHERE bo_type <> me->bo_type.
    MODIFY lt_recordtargets FROM VALUE #( process_id = me->process_id ) TRANSPORTING process_id WHERE process_id <> me->process_id.
    LOOP AT lt_recordtargets ASSIGNING FIELD-SYMBOL(<ls_recordtarget>) WHERE activation BETWEEN if_mdc_adapter=>activation_target-direct AND if_mdc_adapter=>activation_target-cleansing_case..
      IF <ls_recordtarget>-activation = if_mdc_adapter=>activation_target-change_request
       OR <ls_recordtarget>-activation = if_mdc_adapter=>activation_target-cleansing_case.
        DATA(ls_record_change_request) = VALUE #( me->record_change_requests[ source_key = <ls_recordtarget>-source_key ]-change_request_id OPTIONAL ).
      ENDIF.
      <ls_recordtarget>-active_id = |{ VALUE #( <source_status_table>[ source_key = <ls_recordtarget>-source_key ]-banks OPTIONAL ) }$${ VALUE #( <source_status_table>[ source_key = <ls_recordtarget>-source_key ]-bankl OPTIONAL ) }| .
    ENDLOOP.
    MODIFY mdc_recordtarget FROM TABLE @lt_recordtargets.

  ENDMETHOD.
ENDCLASS.
