class YZ_CLAS_MDG_YB_DATA_PROCESS definition
  public
  inheriting from YZ_CLAS_MDG_YB_DATA_PROCESS_EX
  create public .

public section.

  interfaces YZ_INTF_MDG_DATA_PROCESS .
  interfaces YZ_INTF_MDG_YB_DATA_TYPES .

  aliases GTY_T_Y_BANKL
    for YZ_INTF_MDG_YB_DATA_TYPES~GTY_T_Y_BANKL .

  class-data GT_Y_BANKL type GTY_T_Y_BANKL .

  methods CONSTRUCTOR .
  class-methods GET_DATA_PROCESS
    returning
      value(RO_DATA_PROCESS) type ref to YZ_INTF_MDG_DATA_PROCESS .
  class-methods SET_Y_BANKL
    importing
      !IT_DATA type ANY TABLE .
  class-methods GET_Y_BANKL
    importing
      !IV_CREQUEST type USMD_CREQUEST optional
      !IT_KEY_VALUE type GTY_T_KEY_VALUE optional
      !IV_READMODE type USMD_READMODE_EXT default GC_READMODE_ACT_INACT
    exporting
      !ER_DATA type ref to DATA
    returning
      value(RT_Y_BANKL) type GTY_T_Y_BANKL .
  class-methods DEL_Y_BANKL
    importing
      !IT_DATA type GTY_T_Y_BANKL .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA my_yb_data TYPE REF TO yz_clas_mdg_yb_data_process .
ENDCLASS.



CLASS YZ_CLAS_MDG_YB_DATA_PROCESS IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).
  ENDMETHOD.


  METHOD del_y_bankl.
    IF it_data IS NOT INITIAL.
      LOOP AT it_data INTO DATA(is_data).
        DELETE TABLE gt_y_bankl FROM is_data.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD get_data_process.
    IF my_yb_data IS INITIAL.
      CREATE OBJECT my_yb_data.
    ENDIF.

    IF my_yb_data IS BOUND.
      ro_data_process ?= my_yb_data.
    ELSE.
*      Raise Exception
    ENDIF.
  ENDMETHOD.


  METHOD get_y_bankl.
    IF gt_y_bankl IS INITIAL.
*#Fallback API
      CALL METHOD read_entity(
        EXPORTING
          iv_crequest = COND #( WHEN iv_crequest IS INITIAL THEN get_cr_number( ) ELSE iv_crequest )  " Change Request
          iv_entity   = 'Y_BANKL' " Entity Type
          iv_readmode = iv_readmode        " Read Mode
        IMPORTING
          eo_data_tab = er_data ).
      IF er_data IS BOUND.
        ASSIGN er_data->* TO FIELD-SYMBOL(<ft_data>).
        IF sy-subrc IS INITIAL AND <ft_data> IS ASSIGNED AND <ft_data> IS NOT INITIAL.
          gt_y_bankl = <ft_data>.
          CLEAR <ft_data>.
        ENDIF.
      ENDIF.
    ENDIF.

    IF it_key_value IS NOT INITIAL.
      DATA(lv_where) = get_where_condition( filter_current_context( iv_entity = 'Y_BANKL' it_key_value = it_key_value ) ).
      LOOP AT gt_y_bankl ASSIGNING FIELD-SYMBOL(<ls_data>) WHERE (lv_where).
        CHECK sy-subrc IS INITIAL AND <ls_data>  IS ASSIGNED AND <ls_data> IS NOT INITIAL.
        INSERT <ls_data> INTO TABLE rt_y_bankl."<ft_data>.
      ENDLOOP.
    ELSE.
      rt_y_bankl = gt_y_bankl.
    ENDIF.

    IF rt_y_bankl IS NOT INITIAL.
      CREATE DATA er_data LIKE rt_y_bankl.
      CHECK er_data IS BOUND.
      ASSIGN er_data->* TO FIELD-SYMBOL(<fgty_t_data>).
      CHECK sy-subrc IS INITIAL AND <fgty_t_data> IS ASSIGNED.
      <fgty_t_data> = CORRESPONDING #( rt_y_bankl ).
    ENDIF.
  ENDMETHOD.


  METHOD set_y_bankl.
    DATA lt_y_bankl TYPE gty_t_y_bankl.

    MOVE-CORRESPONDING it_data TO lt_y_bankl.
    LOOP AT lt_y_bankl ASSIGNING FIELD-SYMBOL(<ls_y_bankl>).
      READ TABLE gt_y_bankl FROM <ls_y_bankl> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        MODIFY TABLE gt_y_bankl FROM <ls_y_bankl>.
      ELSE.
        INSERT <ls_y_bankl> INTO TABLE gt_y_bankl.

        CALL METHOD create_dependent_entities
          EXPORTING
            iv_entity = 'Y_BANKL'
            is_record = <ls_y_bankl>.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD yz_intf_mdg_data_process~get_entity_data.
    FIELD-SYMBOLS : <ft_data> TYPE ANY TABLE.

    DATA(lv_method_name) = gc_get && iv_entity.

    TRY.

        CALL METHOD (lv_method_name)
          EXPORTING
            iv_crequest  = iv_crequest                                              " Change Request
            iv_readmode  = iv_readmode
            it_key_value = it_key_value                                               " Key Value Table Type
          IMPORTING
            er_data      = er_data.

        ASSIGN er_data->* TO <ft_data>.
        IF <ft_data> IS ASSIGNED.
          et_data = <ft_data>.
        ENDIF.

      CATCH cx_root INTO DATA(lr_error).
        DATA(lv_error) = lr_error->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD yz_intf_mdg_data_process~set_entity_data.
    IF io_changed_data IS BOUND.
      io_changed_data->get_entity_types( IMPORTING et_entity_del = DATA(lt_entity_del)
                                                   et_entity_mod = DATA(lt_entity_mod) ).                " List of Entity Types Containing New And/Or Changed Data

      IF lt_entity_mod IS NOT INITIAL.

        LOOP AT lt_entity_mod INTO DATA(ls_entity_mod) WHERE struct = gc_kattr.


          io_changed_data->read_data( EXPORTING i_entity      = ls_entity_mod-entity   " Entity Type
                                                i_struct      = ls_entity_mod-struct  " Type of Data Structure
                                      IMPORTING er_t_data_mod = DATA(lr_t_data_mod) ).    " "Modified" Data Records (INSERT+UPDATE ).


          ASSIGN lr_t_data_mod->* TO FIELD-SYMBOL(<lt_data_mod>).

          IF <lt_data_mod> IS ASSIGNED AND <lt_data_mod> IS NOT INITIAL.

*          IF gs_application_context-br_type EQ gc_execute_derivation.
            append_entity_keys_derivation( iv_entity = ls_entity_mod-entity it_data = <lt_data_mod> ).

            DATA(lv_method_name) = gc_set && ls_entity_mod-entity.

            TRY.
                CALL METHOD (lv_method_name) EXPORTING it_data = <lt_data_mod>.
              CATCH cx_root INTO DATA(lr_error).
                DATA(lv_error) = lr_error->get_text( ).

            ENDTRY.
*          ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.

      IF lt_entity_del IS NOT INITIAL.

        LOOP AT lt_entity_del INTO DATA(ls_entity_del) WHERE struct = gc_kattr.

          CALL METHOD io_changed_data->read_data
            EXPORTING
              i_entity               = ls_entity_del-entity
              i_struct               = ls_entity_del-struct
            IMPORTING
              er_t_data_del          = DATA(ir_t_data_del)
              ef_t_data_upd_complete = DATA(ir_t_data_upd_comp).

          ASSIGN ir_t_data_del->* TO FIELD-SYMBOL(<lt_data_del>).
          DATA(iv_method_name) = gc_del && ls_entity_del-entity.

          IF <lt_data_del> IS ASSIGNED AND <lt_data_del> IS NOT INITIAL.
            TRY.
                CALL METHOD (iv_method_name) EXPORTING it_data = <lt_data_del>.
              CATCH cx_root INTO DATA(ir_error).
                DATA(iv_error) = ir_error->get_text( ).

*          yz_clas_mdg_utility=>update_application_log( is_rule_status  = VALUE #( usmd_model = iv_data_model
*                                                               context = yz_intf_mdg_utility_const=>gc_rule_context_cr
*                                                               context_key = CONV  #( get_cr_number( ) )
*                                                               process = yz_clas_mdg_utility=>gc_process_type_derive
*                                                               rule_id = it_derivation-rule_id
*                                                               root_key = CONV #( ls_main_key-key_value )
*                                                               status  = lv_status
*                                                               usmd_entity =  ls_entity_mod-entity
*                                                               ersda = sy-datum
*                                                               time  = sy-uzeit
*                                                               usname = ls_cr_detail-usmd_created_by ) ).

            ENDTRY.
          ENDIF.

        ENDLOOP.
      ENDIF.

    ENDIF.

    IF it_data IS NOT INITIAL.
      lv_method_name = gc_set && iv_entity.

      TRY.
          CALL METHOD (lv_method_name) EXPORTING it_data = it_data.
        CATCH cx_root INTO lr_error.
          lv_error = lr_error->get_text( ).

      ENDTRY.

    ENDIF.
  ENDMETHOD.
ENDCLASS.
