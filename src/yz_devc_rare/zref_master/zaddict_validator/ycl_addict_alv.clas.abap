CLASS ycl_addict_alv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF form_dict,
             html_end_of_list TYPE slis_formname,
             pf_status        TYPE slis_formname,
             user_command     TYPE slis_formname,
           END OF form_dict.

    TYPES field_list TYPE STANDARD TABLE OF fieldname WITH EMPTY KEY.

    TYPES: BEGIN OF build_fcat_input_dict,
             structure       TYPE tabname,
             itab_name       TYPE tabname,
             tech_fields     TYPE field_list,
             edit_fields     TYPE field_list,
             hotspot_fields  TYPE field_list,
             checkbox_fields TYPE field_list,
           END OF build_fcat_input_dict.

    CONSTANTS: BEGIN OF default_fields,
                 alvsl   TYPE fieldname     VALUE 'ALVSL',
                 celltab TYPE fieldname     VALUE 'CELLTAB',
               END OF default_fields.

    CONSTANTS: BEGIN OF default_forms,
                 html_end_of_list TYPE slis_formname VALUE 'HTML_END_OF_LIST',
                 pf_status        TYPE slis_formname VALUE 'PF_STATUS',
                 user_command     TYPE slis_formname VALUE 'USER_COMMAND',
               END OF default_forms.

    DATA cprog  TYPE sycprog.
    DATA itab   TYPE REF TO data.
    DATA forms  TYPE form_dict.
    DATA layout TYPE slis_layout_alv.
    DATA fcat   TYPE slis_t_fieldcat_alv.

    METHODS constructor
      IMPORTING !itab       TYPE REF TO data
                !cprog      TYPE sy-cprog OPTIONAL
                !forms      TYPE form_dict OPTIONAL
                !layout     TYPE slis_layout_alv OPTIONAL
                !fcat       TYPE slis_t_fieldcat_alv OPTIONAL
                !fcat_param TYPE build_fcat_input_dict OPTIONAL
      RAISING   ycx_addict_alv.

    METHODS build_fcat
      IMPORTING !input TYPE build_fcat_input_dict
      RAISING   ycx_addict_alv.

    METHODS show_grid RAISING ycx_addict_alv.
    METHODS show_list RAISING ycx_addict_alv.
    METHODS show RAISING ycx_addict_alv.

protected section.
private section.
ENDCLASS.



CLASS YCL_ADDICT_ALV IMPLEMENTATION.
ENDCLASS.
