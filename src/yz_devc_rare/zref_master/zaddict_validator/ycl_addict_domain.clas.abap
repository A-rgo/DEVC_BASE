class YCL_ADDICT_DOMAIN definition
  public
  final
  create private .

public section.

  types:
    BEGIN OF line_dict,
             value TYPE val_single,
             text  TYPE val_text,
           END OF line_dict .
  types:
    line_set TYPE HASHED TABLE OF line_dict
                    WITH UNIQUE KEY primary_key COMPONENTS value .

  data DEF type DD01L read-only .

  class-methods GET_INSTANCE
    importing
      !DOMNAME type DOMNAME
    returning
      value(OUTPUT) type ref to YCL_ADDICT_DOMAIN
    raising
      YCX_ADDICT_TABLE_CONTENT .
  class-methods GET_VALUE_TEXT_SAFE
    importing
      !DOMNAME type DOMNAME
      !VALUE type CHAR90
    returning
      value(OUTPUT) type VAL_TEXT .
  methods GET_TEXT
    returning
      value(OUTPUT) type DDTEXT .
  methods GET_VALUE_LINE
    importing
      !VALUE type CHAR90
    returning
      value(OUTPUT) type LINE_DICT
    raising
      YCX_ADDICT_DOMAIN .
  methods GET_VALUE_TAB
    returning
      value(OUTPUT) type LINE_SET .
  methods GET_VALUE_TEXT
    importing
      !VALUE type CHAR90
    returning
      value(OUTPUT) type VAL_TEXT
    raising
      YCX_ADDICT_DOMAIN .
  methods VALIDATE_VALUE
    importing
      !VALUE type CHAR90
    raising
      YCX_ADDICT_DOMAIN
      YCX_ADDICT_TABLE_CONTENT .
  PROTECTED SECTION.
private section.

  types:
    BEGIN OF lazy_flag_dict,
             text_read       TYPE abap_bool,
             value_text_read TYPE abap_bool,
           END OF lazy_flag_dict .
  types:
    BEGIN OF multiton_dict,
             domname TYPE domname,
             obj     TYPE REF TO ycl_addict_domain,
           END OF multiton_dict .
  types:
    multiton_set TYPE HASHED TABLE OF multiton_dict
                        WITH UNIQUE KEY primary_key COMPONENTS domname .

  constants:
    BEGIN OF table,
                 def TYPE tabname VALUE 'DD01L',
               END OF table .
  class-data MULTITONS type MULTITON_SET .
  data LAZY_FLAG type LAZY_FLAG_DICT .
  data LINES type LINE_SET .
  data TEXT type DDTEXT .

  methods ENSURE_TEXT_READ .
  methods ENSURE_VALUE_READ
    importing
      !VALUE type CHAR90 optional
    raising
      YCX_ADDICT_DOMAIN
      YCX_ADDICT_TABLE_CONTENT .
ENDCLASS.



CLASS YCL_ADDICT_DOMAIN IMPLEMENTATION.


  METHOD ensure_text_read.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Lazy reads texts
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    CHECK me->lazy_flag-text_read = abap_false.

    SELECT SINGLE ddtext FROM dd01t                     "#EC CI_NOORDER
           WHERE domname = @me->def-domname AND
                 ddlanguage = @sy-langu
           INTO @me->text ##WARN_OK.

    IF sy-subrc <> 0.
      SELECT SINGLE ddtext FROM dd01t                   "#EC CI_NOORDER
             WHERE domname = @me->def-domname
             INTO @me->text ##WARN_OK.
    ENDIF.

    me->lazy_flag-text_read = abap_true.
  ENDMETHOD.


  METHOD ensure_value_read.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Lazy read values
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    CHECK me->lazy_flag-value_text_read = abap_false.

    SELECT dd07l~domvalue_l AS value,                  "#EC CI_BUFFJOIN
           dd07t~ddtext AS text
           FROM dd07l
                LEFT JOIN dd07t ON
                     dd07t~domname    = dd07l~domname AND
                     dd07t~ddlanguage = @sy-langu AND
                     dd07t~as4local   = dd07l~as4local AND
                     dd07t~valpos     = dd07l~valpos AND
                     dd07t~as4vers    = dd07l~as4vers
           WHERE dd07l~domname = @me->def-domname
           INTO CORRESPONDING FIELDS OF TABLE @me->lines.

    me->lazy_flag-value_text_read = abap_true.

    SELECT datatype, leng FROM dd01l INTO TABLE @DATA(lt_dd01l) WHERE domname = @me->def-domname.
      IF sy-subrc = 0.
        READ TABLE lt_dd01l INTO DATA(lw_dd01l) INDEX 1.
        IF sy-subrc = 0.
          IF strlen( value ) > lw_dd01l-leng.
            RAISE EXCEPTION TYPE ycx_addict_domain
          EXPORTING
            textid     = ycx_addict_domain=>incorrect_length
            DOMNAME    = '&1'.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDMETHOD.


  METHOD get_instance.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Multiton factory
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ASSIGN ycl_addict_domain=>multitons[
        KEY primary_key
        COMPONENTS domname = domname
      ] TO FIELD-SYMBOL(<multiton>).

    IF sy-subrc <> 0.
      DATA(multiton) = VALUE multiton_dict( domname = domname ).

      multiton-obj = NEW #( ).

      SELECT SINGLE * FROM dd01l                        "#EC CI_NOORDER
             WHERE domname = @multiton-domname
             INTO @multiton-obj->def ##WARN_OK.

      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE ycx_addict_table_content
          EXPORTING
            textid   = ycx_addict_table_content=>no_entry_for_objectid
            objectid = CONV #( multiton-domname )
            tabname  = ycl_addict_domain=>table-def.
      ENDIF.

      INSERT multiton INTO TABLE ycl_addict_domain=>multitons
             ASSIGNING <multiton>.
    ENDIF.

    output = <multiton>-obj.
  ENDMETHOD.


  METHOD get_text.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Returns domain text
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ensure_text_read( ).
    output = me->text.
  ENDMETHOD.


  METHOD get_value_line.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Returns a value line
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    TRY .
      ensure_value_read( ).

      ASSIGN me->lines[ KEY primary_key
                      COMPONENTS value = value
                    ] TO FIELD-SYMBOL(<line>).

      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE ycx_addict_domain
        EXPORTING
          textid     = ycx_addict_domain=>invalid_value
          domname    = '&1'
          domvalue_l = value.
      ENDIF.

      output = <line>.
      CATCH YCX_ADDICT_TABLE_CONTENT INTO DATA(lo_ex_tab_content).

    ENDTRY.

  ENDMETHOD.


  METHOD get_value_tab.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Returns all domain values
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    TRY .

    ensure_value_read( ).
    output = me->lines.
    CATCH ycx_addict_table_content INTO DATA(lo_tab_content).
    CATCH ycx_addict_domain INTO DATA(lo_domain).

    ENDTRY.

  ENDMETHOD.


  METHOD get_value_text.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Returns the text of a given domain value
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    output = get_value_line( value )-text.
  ENDMETHOD.


  METHOD get_value_text_safe.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Returns the text of a value without generating an exception
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    TRY.
        output = get_instance( domname )->get_value_text( value ).
      CATCH cx_root.
        output = value.
    ENDTRY.
  ENDMETHOD.


  METHOD validate_value.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Ensures that the passed value is valid within the domain
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA dummy TYPE string.

    ensure_value_read( value ).

    IF me->lines IS NOT INITIAL.
      get_value_line( value ).
      RETURN.
    ENDIF.

    IF me->def-entitytab IS NOT INITIAL.
      DATA(table_keys) = ycl_addict_table=>get_instance( me->def-entitytab )->get_key_fields( with_mandt = abap_false ).
*      DATA(table_key) = table_keys[ 1 ]-fieldname.

*      DATA(where) = |{ table_key } = '{ value }'|.
      READ TABLE table_keys WITH key fieldname = ME->DEF-DOMNAME TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
      DATA(where) = |{ ME->DEF-DOMNAME } = '{ value }'|.
*SELECT SINGLE (table_key) INTO dummy
      SELECT SINGLE (ME->DEF-DOMNAME) INTO dummy
             FROM (me->def-entitytab)
             WHERE (where).

      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE ycx_addict_domain
          EXPORTING
            textid     = ycx_addict_domain=>invalid_value
            domname    = '&1'
            domvalue_l = value.
      ENDIF.
      ENDIF.
**      SELECT SINGLE (table_key) INTO dummy
**      SELECT SINGLE (ME->DEF-DOMNAME) INTO dummy
*             FROM (me->def-entitytab)
*             WHERE (where).
*
*      IF sy-subrc <> 0.
*        RAISE EXCEPTION TYPE ycx_addict_domain
*          EXPORTING
*            textid     = ycx_addict_domain=>invalid_value
*            domname    = me->def-domname
*            domvae_l = value.
*      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
