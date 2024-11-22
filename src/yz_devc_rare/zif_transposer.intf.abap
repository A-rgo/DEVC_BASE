interface ZIF_TRANSPOSER
  public .
  TYPES:
    BEGIN OF ty_rows,
      row     TYPE i,
      FIELD   TYPE char30,
      dename  TYPE char30,
      VALUE   TYPE STRING,
    END   OF ty_rows.
  TYPES: tt_rows TYPE STANDARD TABLE OF ty_rows.

  TYPES:
    BEGIN OF ty_fields,
      FIELD TYPE char30,
      dename TYPE char30,
    END   OF ty_fields.
  TYPES: tt_fields TYPE STANDARD TABLE OF ty_fields.

  METHODS:
    transpose
        RETURNING VALUE(ro_data) TYPE REF TO DATA.

  DATA: t_fields TYPE tt_fields.
  DATA: t_data   TYPE tt_rows.
  DATA: o_dyna_table TYPE REF TO DATA.
  DATA: o_dyna_wa    TYPE REF TO DATA.

  METHODS: create_dynamic_table.
  METHODS: collect_fields.
endinterface.
