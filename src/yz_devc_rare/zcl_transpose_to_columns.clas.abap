CLASS zcl_transpose_to_columns DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES: zif_transposer.
    METHODS:
      constructor
        IMPORTING
          it_data   TYPE zif_transposer=>tt_rows
          it_fields TYPE zif_transposer=>tt_fields OPTIONAL.

  PRIVATE SECTION.
    ALIASES: t_data   FOR zif_transposer~t_data.
    ALIASES: t_fields FOR zif_transposer~t_fields.
    ALIASES: o_dyna_table FOR zif_transposer~o_dyna_table.
    ALIASES: o_dyna_wa    FOR zif_transposer~o_dyna_wa.


ENDCLASS.



CLASS ZCL_TRANSPOSE_TO_COLUMNS IMPLEMENTATION.


  METHOD constructor.
    t_data   = it_data.
    t_fields = it_fields.

  ENDMETHOD.                    "constructor


  METHOD zif_transposer~collect_fields.

    CHECK t_fields IS INITIAL.

    DATA: lv_first_field  TYPE char30.
    DATA: ls_data         LIKE LINE OF me->t_data.
    DATA: ls_field        LIKE LINE OF me->t_fields.
    LOOP AT me->t_data INTO ls_data.
      IF lv_first_field = ls_data-FIELD.
        EXIT.
      ENDIF.
      IF lv_first_field IS INITIAL.
        lv_first_field = ls_data-FIELD.
      ENDIF.
      MOVE-CORRESPONDING ls_data TO ls_field.
      APPEND ls_field TO me->t_fields.
    ENDLOOP.

  ENDMETHOD.                    "collect_Fields


  METHOD zif_transposer~create_dynamic_table.

    DATA: lo_struct   TYPE REF TO cl_abap_structdescr,
          lo_element  TYPE REF TO cl_abap_elemdescr,
          lo_new_type TYPE REF TO cl_abap_structdescr,
          lo_new_tab  TYPE REF TO cl_abap_tabledescr,
          lt_comp     TYPE cl_abap_structdescr=>component_table,
          lt_tot_comp TYPE cl_abap_structdescr=>component_table,
          la_comp     LIKE LINE OF lt_comp.

    DATA: ls_field    LIKE LINE OF me->t_fields.
    DATA: lv_name     TYPE STRING.

    LOOP AT me->t_fields INTO ls_field.
      IF ls_field-dename IS INITIAL.
        lv_name = ls_field-FIELD.
      ELSE.
        lv_name = ls_field-dename.
      ENDIF.

*   Element Description
      lo_element ?= cl_abap_elemdescr=>describe_by_name( lv_name ).

*   Components
      la_comp-NAME = ls_field-FIELD.
      la_comp-TYPE = lo_element.
      APPEND la_comp TO lt_tot_comp.
      CLEAR: la_comp.
    ENDLOOP.

*   Create a New Type
    lo_new_type = cl_abap_structdescr=>create( lt_tot_comp ).

*   New Table type
    lo_new_tab = cl_abap_tabledescr=>create(
                    p_line_type  = lo_new_type
                    p_table_kind = cl_abap_tabledescr=>tablekind_std
                    p_unique     = abap_false ).

*   data to handle the new table type
    CREATE DATA o_dyna_table TYPE HANDLE lo_new_tab.
    CREATE DATA o_dyna_wa    TYPE HANDLE lo_new_type.

  ENDMETHOD.                    "create_dynamic_table


  METHOD zif_transposer~transpose.

    FIELD-SYMBOLS:
      <f_tab> TYPE STANDARD TABLE,
      <f_wa>  TYPE ANY,
      <f_field> TYPE ANY.
    DATA: ls_data LIKE LINE OF me->t_data.

*   create dynamic table
    me->zif_transposer~collect_fields( ).
    me->zif_transposer~create_dynamic_table( ).

*   Move data to Dynamica table
    ASSIGN o_dyna_table->*  TO <f_tab>.
    ASSIGN o_dyna_wa->*     TO <f_wa>.

    LOOP AT me->t_data INTO ls_data.
      ASSIGN COMPONENT ls_data-FIELD OF STRUCTURE <f_wa> TO <f_field>.
      IF sy-subrc EQ 0.
        <f_field> = ls_data-VALUE.
      ENDIF.
      AT END OF row.
        APPEND <f_wa> TO <f_tab>.
        CLEAR  <f_wa>.
      ENDAT.
    ENDLOOP.

*   send data back
    ro_data = o_dyna_table.

  ENDMETHOD.                    "zif_transposer~transpose
ENDCLASS.
