CLASS zcl_transpose_to_rows DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES: zif_transposer.
    METHODS:
      constructor
        IMPORTING
          it_data   TYPE ANY TABLE
          it_fields TYPE zif_transposer=>tt_fields OPTIONAL.

  PRIVATE SECTION.
    ALIASES: t_data   FOR zif_transposer~t_data.
    ALIASES: t_fields FOR zif_transposer~t_fields.
    ALIASES: o_dyna_table FOR zif_transposer~o_dyna_table.
    ALIASES: o_dyna_wa    FOR zif_transposer~o_dyna_wa.
ENDCLASS.



CLASS ZCL_TRANSPOSE_TO_ROWS IMPLEMENTATION.


  METHOD constructor.
    GET REFERENCE OF it_data INTO o_dyna_table.
    t_fields = it_fields.
  ENDMETHOD.                    "constructor


  METHOD zif_transposer~collect_fields.

    DATA: lo_tab      TYPE REF TO cl_abap_tabledescr,
          lo_struc    TYPE REF TO cl_abap_structdescr,
          lt_comp     TYPE cl_abap_structdescr=>component_table,
          ls_comp     LIKE LINE OF lt_comp,
          ls_fields   LIKE LINE OF t_fields.

    IF t_fields IS INITIAL.
      lo_tab ?= cl_abap_tabledescr=>describe_by_data_ref( o_dyna_table ).
      lo_struc ?= lo_tab->get_table_line_type( ).
      lt_comp = lo_struc->get_components( ).
      LOOP AT lt_comp INTO ls_comp.
        ls_fields-FIELD = ls_comp-NAME.
        ls_fields-dename = ls_comp-type->get_relative_name( ).
        APPEND ls_fields TO t_fields.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.                    "zif_transposer~collect_fields


  METHOD zif_transposer~create_dynamic_table.

*   Setting up the o_dyna_wa is unnecessary, just sake of completeness
*   of this method
    FIELD-SYMBOLS:
      <f_tab> TYPE STANDARD TABLE,
      <f_wa>  TYPE ANY.

    ASSIGN o_dyna_table->* TO <f_tab>.
    READ TABLE <f_tab> ASSIGNING <f_wa> INDEX 1.
    IF sy-subrc EQ 0.
      GET REFERENCE OF <f_wa> INTO o_dyna_wa.
    ENDIF.

  ENDMETHOD.                    "zif_transposer~create_dynamic_table


  METHOD zif_transposer~transpose.
    FIELD-SYMBOLS:
      <f_tab> TYPE STANDARD TABLE,
      <f_wa>  TYPE ANY,
      <f_field> TYPE ANY.

    DATA: lt_rows TYPE zif_transposer=>tt_rows.
    DATA: ls_rows LIKE LINE OF lt_rows,
          lv_row  TYPE i.
    DATA: ls_fields LIKE LINE OF t_fields.

    me->zif_transposer~collect_fields( ).
    me->zif_transposer~create_dynamic_table( ).

    ASSIGN o_dyna_table->* TO <f_tab>.
    LOOP AT <f_tab> ASSIGNING <f_wa>.
      lv_row = sy-tabix.
      LOOP AT t_fields INTO ls_fields.
        ASSIGN COMPONENT ls_fields-FIELD OF STRUCTURE <f_wa> TO <f_field>.
        IF sy-subrc EQ 0.
          ls_rows-row   = lv_row.
          ls_rows-FIELD = ls_fields-FIELD.
          ls_rows-dename = ls_fields-dename.
          ls_rows-VALUE  = <f_field>.
          APPEND ls_rows TO lt_rows.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    me->t_data = lt_rows.
    GET REFERENCE OF me->t_data INTO ro_data.

  ENDMETHOD.                    "zif_transposer~transpose
ENDCLASS.
