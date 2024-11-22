class ZZMDG_CL_PIR_IDOC_DRF_FLT definition
  public
  final
  create public .

public section.

  interfaces IF_DRF_FILTER .
protected section.
private section.

  constants GC_PIR_DRF_OUT type DRF_OUTB_IMPL value 'ZZMDG_PIR' ##NO_TEXT.

  methods GET_WHERE_CONDITION
    importing
      !IT_SELECTION_CRITERIA type RSDS_TRANGE
    exporting
      !ET_WHERE_CONDITION type RSDS_TWHERE .
  methods GET_SELECTED_PIR
    importing
      !IT_WHERE_CONDITION type RSDS_TWHERE
    returning
      value(ET_PIR) type ZZMDG_T_DRF_KF_PIR .
  methods PREPARE_SELECTION_CRITERIA
    importing
      !IT_EXTERNAL_CRITERIA type RSDS_TRANGE
      !IT_UNFILTERED_OBJECTS type SORTED TABLE
    exporting
      !ET_EXT_CRITERIA type RSDS_TRANGE .
  methods ADD_RANGE_WITH_PATTERN
    importing
      !IV_TABLENAME type CHAR30
      !IV_FIELDNAME type CHAR30
      !IV_PATTERN type RSDSSELOP_
    exporting
      !ES_RANGE type RSDS_RANGE .
  methods ADD_SELECT_OPTION
    importing
      !IV_SIGN type TVARV_SIGN
      !IV_OPTION type TVARV_OPTI
      !IV_LOW type RSDSSELOP_
      !IV_HIGH type RSDSSELOP_ optional
    exporting
      !ES_SELECT_OPTION type RSDSSELOPT .
ENDCLASS.



CLASS ZZMDG_CL_PIR_IDOC_DRF_FLT IMPLEMENTATION.


  METHOD ADD_RANGE_WITH_PATTERN.

    DATA: ls_ext_criteria TYPE rsds_range,
          ls_seloption    TYPE rsdsselopt,
          lt_seloption    TYPE rsds_selopt_t,
          lt_filter_range TYPE rsds_frange_t,
          ls_filter_range TYPE rsds_frange.

    ls_ext_criteria-tablename = iv_tablename.
    ls_filter_range-fieldname = iv_fieldname.
    ls_seloption-sign = 'I'.
    ls_seloption-option = 'CP'.
    ls_seloption-low = '*'.
    INSERT ls_seloption INTO TABLE lt_seloption.
    ls_filter_range-selopt_t = lt_seloption.
    APPEND ls_filter_range TO lt_filter_range.
    ls_ext_criteria-frange_t = lt_filter_range.
    es_range = ls_ext_criteria.
  ENDMETHOD.


  METHOD ADD_SELECT_OPTION.
    es_select_option-sign = iv_sign .
    es_select_option-option = iv_option.
    es_select_option-low = iv_low.
    es_select_option-high = iv_high.
  ENDMETHOD.


  METHOD GET_SELECTED_PIR.

    TYPES: BEGIN OF lty_pir_key,
             matnr TYPE matnr,
             lifnr TYPE lifnr,
           END OF lty_pir_key.
    DATA:
      lv_previous_selcrit_ext TYPE abap_bool VALUE abap_false,
      lv_bom_selcrit_ext      TYPE abap_bool VALUE abap_false,
      ls_where                TYPE rsds_where,
      ls_where_tab_line       TYPE rsdswhere,
      lv_pir_hits             TYPE i,
      lt_stzu                 TYPE STANDARD TABLE OF lty_pir_key,
      ls_stzu                 TYPE lty_pir_key,
      lt_eina                 TYPE STANDARD TABLE OF eina.

*    IF it_where_condition IS NOT INITIAL.
*      lv_bom_selcrit_ext = abap_true.
*    ENDIF.

    CHECK it_where_condition IS NOT INITIAL.

* Select data from STZU - Permanent BOM data (Read only data of STLTY type 'M')
*    READ TABLE it_where_condition INTO ls_where
*         WITH KEY tablename = 'STZU'.
*    IF sy-subrc EQ 0.
*      READ TABLE ls_where-where_tab INTO ls_where_tab_line INDEX 1.
*      IF sy-subrc EQ 0 AND
*         ls_where_tab_line IS NOT INITIAL.
*        IF lv_bom_hits > 0.
*          IF ( lt_stzu IS NOT INITIAL ).
*            SELECT stlty stlnr FROM stzu
*                     INTO CORRESPONDING FIELDS OF TABLE lt_stzu
*                     FOR ALL ENTRIES IN lt_stzu
*                     WHERE  stlnr = lt_stzu-stlnr AND stlty = 'M' AND (ls_where-where_tab). "#EC CI_DYNWHERE. "Note 2933728
*          ENDIF.
*        ELSE.
*          IF lv_previous_selcrit_ext EQ abap_false.
*            SELECT stlty stlnr FROM stzu
*                         INTO CORRESPONDING FIELDS OF TABLE lt_stzu
*                         WHERE (ls_where-where_tab) AND stlty = 'M'. "#EC CI_DYNWHERE. "Note 2933728
*            lv_previous_selcrit_ext = abap_true.
*          ENDIF.
*        ENDIF.
*      ENDIF.
*    ENDIF.
*    SORT lt_stzu.
*    lv_bom_hits = lines( lt_stzu ).

* Select data from MAST - Material to BOM Link
    READ TABLE it_where_condition INTO ls_where
         WITH KEY tablename = 'EINA'.
    IF sy-subrc = 0.
      READ TABLE ls_where-where_tab INTO ls_where_tab_line INDEX 1.
      IF sy-subrc EQ 0 AND
         NOT ls_where_tab_line IS INITIAL.
*        IF lv_bom_hits > 0.
*          IF ( lt_stzu IS NOT INITIAL ).
*            SELECT DISTINCT matnr werks stlan stlnr stlal FROM mast
*                                  INTO CORRESPONDING FIELDS OF TABLE lt_mast
*                                  FOR ALL ENTRIES IN lt_stzu
*                                  WHERE stlnr = lt_stzu-stlnr AND (ls_where-where_tab). "#EC CI_DYNWHERE. "Note 2933728
*          ENDIF.
*        ELSE.
*          IF lv_previous_selcrit_ext EQ abap_false.
        SELECT DISTINCT matnr lifnr FROM eina
                              INTO CORRESPONDING FIELDS OF TABLE lt_eina
                              WHERE (ls_where-where_tab). "#EC CI_DYNWHERE. "Note 2933728
        lv_previous_selcrit_ext = abap_true.
*          ENDIF.
*        ENDIF.
*        LOOP AT lt_mast INTO DATA(ls_mast).
*          ls_stzu-stlnr = ls_mast-stlnr.
*          ls_stzu-stlty = 'M'.
*          APPEND ls_stzu TO lt_stzu.
*        ENDLOOP.
*        lv_bom_hits = lines( lt_stzu ).
      ENDIF.
    ENDIF.
*    SORT lt_stzu BY stlty stlnr.
*    DELETE ADJACENT DUPLICATES FROM lt_stzu.
*
*    et_bom =  CORRESPONDING #( lt_stzu ) .
    et_pir = CORRESPONDING #( lt_eina ) .
  ENDMETHOD.


  METHOD GET_WHERE_CONDITION.
    CALL FUNCTION 'FREE_SELECTIONS_RANGE_2_WHERE'
      EXPORTING
        field_ranges  = it_selection_criteria
      IMPORTING
        where_clauses = et_where_condition.
  ENDMETHOD.


  METHOD IF_DRF_FILTER~APPLY_FILTER.

    DATA:
      lt_ext_criteria         TYPE rsds_trange,
      ls_ext_criteria         TYPE rsds_range,
      lt_filter_range_mara    TYPE rsds_frange_t,
      lt_filter_range         TYPE rsds_frange_t,
      ls_filter_range         TYPE rsds_frange,
      lv_ext_crit_exist       TYPE abap_bool VALUE abap_false,
      lt_seloption            TYPE rsds_selopt_t,
      ls_seloption            TYPE rsdsselopt,
      ls_unfiltered_object    TYPE zzmdg_s_drf_kf_pir,
      lt_unfiltered_seloption TYPE rsds_selopt_t,
      lt_where_condition      TYPE rsds_twhere,
      lt_message              TYPE bapiret2_t.

    FIELD-SYMBOLS:
      <ls_ext_criteria> TYPE rsds_range,
      <ls_filter_range> TYPE rsds_frange,
      <lt_filter_range> TYPE rsds_frange_t.

    CHECK iv_outb_impl = gc_pir_drf_out.
* prepare the incoming filter criteria and
* check, if selection criteria besides the selection mode were maintained (lv_ext_crit_exist)

    CALL METHOD me->prepare_selection_criteria
      EXPORTING
        it_external_criteria  = it_external_criteria
        it_unfiltered_objects = it_unfiltered_objects
      IMPORTING
        et_ext_criteria       = lt_ext_criteria.

    IF lt_ext_criteria IS NOT INITIAL.
      CALL METHOD me->get_where_condition
        EXPORTING
          it_selection_criteria = lt_ext_criteria
        IMPORTING
          et_where_condition    = lt_where_condition.
    ENDIF.

    IF lt_where_condition IS NOT INITIAL.
      CALL METHOD me->get_selected_pir
        EXPORTING
          it_where_condition = lt_where_condition
        RECEIVING
          et_pir             = DATA(lt_pir).
    ENDIF.

*    INSERT LINES OF lt_bom INTO et_filtered_objects.
    et_filtered_objects = lt_pir.

  ENDMETHOD.


  METHOD PREPARE_SELECTION_CRITERIA.

    TYPES: BEGIN OF lty_fieldname,
             fieldname TYPE fieldname,
           END OF lty_fieldname.

    DATA:
      lt_ext_criteria               TYPE rsds_trange,
      ls_temp_ext                   TYPE rsds_range,
      ls_ext_criteria               TYPE rsds_range,
      ls_temp_range                 TYPE rsds_frange,
      ls_final_unfilt               TYPE rsdsselopt,
      lt_filter_range_mara          TYPE rsds_frange_t,
      lt_filter_range               TYPE rsds_frange_t,
      ls_filter_range               TYPE rsds_frange,
      lv_ext_crit_exist             TYPE abap_bool VALUE abap_false,
      lt_seloption                  TYPE rsds_selopt_t,
      ls_seloption                  TYPE rsdsselopt,
      ls_unfiltered_object          TYPE zzmdg_s_drf_kf_pir,
      lt_unfiltered_seloption_matnr TYPE rsds_selopt_t,
      lt_unfiltered_seloption_lifnr TYPE rsds_selopt_t,
*      lt_unfiltered_seloption_stlan TYPE rsds_selopt_t,
*      lt_unfiltered_seloption_stlnr TYPE rsds_selopt_t,
*      lt_unfiltered_seloption_stlal TYPE rsds_selopt_t,
      lt_where_condition            TYPE rsds_twhere,
      lt_message                    TYPE bapiret2_t,
      lv_sign                       TYPE tvarv_sign,
      lv_low                        TYPE rsdsselop_,
      lt_unfiltered_objects         TYPE zzmdg_t_drf_kf_pir,
      lv_contained                  TYPE abap_boolean,
      ls_fieldname_found            TYPE lty_fieldname,
      lt_fieldname_found            TYPE TABLE OF lty_fieldname.

    DATA: lr_descr TYPE REF TO cl_abap_structdescr,
          ls_comp  TYPE abap_compdescr.

    FIELD-SYMBOLS:
      <ls_ext_criteria> TYPE rsds_range,
      <ls_filter_range> TYPE rsds_frange,
      <lt_filter_range> TYPE rsds_frange_t.

    lr_descr ?= cl_abap_typedescr=>describe_by_data( ls_unfiltered_object ).

    lt_unfiltered_objects = it_unfiltered_objects.
* in case external filter criteria is provided --> add the filters
    LOOP AT it_external_criteria ASSIGNING <ls_ext_criteria>.
      LOOP AT <ls_ext_criteria>-frange_t ASSIGNING <ls_filter_range>.
        CASE <ls_filter_range>-fieldname.
          WHEN 'MATNR'.
            ls_ext_criteria-tablename = 'EINA'.
            MOVE-CORRESPONDING <ls_filter_range> TO ls_filter_range.
            ls_filter_range-fieldname = 'MATNR'.
          WHEN 'LIFNR'.
            ls_ext_criteria-tablename = 'EINA'.
            MOVE-CORRESPONDING <ls_filter_range> TO ls_filter_range.
            ls_filter_range-fieldname = 'LIFNR'.
        ENDCASE.
        APPEND ls_filter_range TO lt_filter_range.
        ls_ext_criteria-frange_t = lt_filter_range.
        APPEND ls_ext_criteria TO lt_ext_criteria.
        lv_ext_crit_exist = abap_true.
        CLEAR: lt_filter_range, ls_filter_range.
      ENDLOOP.
    ENDLOOP.
* in case no external filter criteria are assigned --> all products shall be replicated
    IF lv_ext_crit_exist EQ abap_false AND lt_unfiltered_objects IS INITIAL.
      CALL METHOD me->add_range_with_pattern
        EXPORTING
          iv_tablename = 'EINA'
          iv_fieldname = 'MATNR'
          iv_pattern   = '*'
        IMPORTING
          es_range     = ls_ext_criteria.
      APPEND ls_ext_criteria TO lt_ext_criteria.
    ENDIF.
* in case the specific Material PIR are provided --> add them to selection criteria
* add only those PIR keys to ext_criteria which are satisfying filter criteria (if provided)
    IF lt_unfiltered_objects IS NOT INITIAL.
      LOOP AT lt_unfiltered_objects INTO ls_unfiltered_object.
        IF it_external_criteria IS INITIAL.
          IF ls_unfiltered_object-matnr IS NOT INITIAL.
            lv_low = ls_unfiltered_object-matnr.
            CALL METHOD me->add_select_option
              EXPORTING
                iv_sign          = 'I'
                iv_option        = 'EQ'
                iv_low           = lv_low
              IMPORTING
                es_select_option = ls_seloption.
            INSERT ls_seloption INTO TABLE lt_unfiltered_seloption_matnr.
          ENDIF.
          IF ls_unfiltered_object-lifnr IS NOT INITIAL.
            lv_low = ls_unfiltered_object-lifnr.
            CALL METHOD me->add_select_option
              EXPORTING
                iv_sign          = 'I'
                iv_option        = 'EQ'
                iv_low           = lv_low
              IMPORTING
                es_select_option = ls_seloption.
            INSERT ls_seloption INTO TABLE lt_unfiltered_seloption_lifnr.
          ENDIF.

        ELSE.
          lv_contained = abap_false.
          LOOP AT lt_ext_criteria INTO ls_temp_ext WHERE tablename = 'EINA'.
            READ TABLE ls_temp_ext-frange_t INTO ls_temp_range WITH KEY fieldname = 'MATNR'.
            IF sy-subrc = 0.
              READ TABLE ls_temp_range-selopt_t INTO ls_final_unfilt WITH KEY sign = 'I' low = ls_unfiltered_object-matnr.
              IF sy-subrc <> 0.
                EXIT.
              ELSE.
                ls_fieldname_found = 'MATNR'.
                APPEND ls_fieldname_found TO lt_fieldname_found.
                lv_contained = abap_true.
                EXIT.
              ENDIF.
            ENDIF.
          ENDLOOP.
          IF lv_contained EQ abap_true.
            LOOP AT lt_ext_criteria INTO ls_temp_ext WHERE tablename = 'EINA'.
              READ TABLE ls_temp_ext-frange_t INTO ls_temp_range WITH KEY fieldname = 'LIFNR'.
              IF sy-subrc = 0.
                READ TABLE ls_temp_range-selopt_t INTO ls_final_unfilt WITH KEY sign = 'I' low = ls_unfiltered_object-lifnr.
                IF sy-subrc <> 0.
                  lv_contained = abap_false.
                  EXIT.
                ELSE.
                  ls_fieldname_found = 'LIFNR'.
                  APPEND ls_fieldname_found TO lt_fieldname_found.
                  lv_contained = abap_true.
                  EXIT.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.
          IF lv_contained EQ abap_true.
* This loop can execute a maximum of 2 times as there a 2 fields in the composite key structure
* The purpose of the below evuluation is to discard occurrences of the same fields in the filter and key structure
            LOOP AT lr_descr->components INTO ls_comp.
              READ TABLE lt_fieldname_found WITH KEY fieldname = ls_comp-name TRANSPORTING NO FIELDS.
              IF sy-subrc <> 0.
                IF ls_comp-name EQ 'MATNR'.
                  IF ls_unfiltered_object-matnr IS NOT INITIAL.
                    lv_low = ls_unfiltered_object-matnr.
                    CALL METHOD me->add_select_option
                      EXPORTING
                        iv_sign          = 'I'
                        iv_option        = 'EQ'
                        iv_low           = lv_low
                      IMPORTING
                        es_select_option = ls_seloption.
                    INSERT ls_seloption INTO TABLE lt_unfiltered_seloption_matnr.
                  ENDIF.
                ENDIF.
                IF ls_comp-name EQ 'LIFNR'.
                  IF ls_unfiltered_object-lifnr IS NOT INITIAL.
                    lv_low = ls_unfiltered_object-lifnr.
                    CALL METHOD me->add_select_option
                      EXPORTING
                        iv_sign          = 'I'
                        iv_option        = 'EQ'
                        iv_low           = lv_low
                      IMPORTING
                        es_select_option = ls_seloption.
                    INSERT ls_seloption INTO TABLE lt_unfiltered_seloption_lifnr.
                  ENDIF.
                ENDIF.

              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.
* add the keys to the selection criteria to take them into account within the selection
* add MATNR
    CLEAR: ls_ext_criteria,lt_filter_range,ls_filter_range.
    IF lt_unfiltered_seloption_matnr IS NOT INITIAL.
      DELETE ADJACENT DUPLICATES FROM lt_unfiltered_seloption_matnr.
      ls_filter_range-fieldname = 'MATNR'.
      ls_filter_range-selopt_t = lt_unfiltered_seloption_matnr.
      ls_ext_criteria-tablename = 'EINA'.
      APPEND ls_filter_range TO lt_filter_range.
      ls_ext_criteria-frange_t = lt_filter_range.
      APPEND ls_ext_criteria TO lt_ext_criteria.
    ENDIF.
* add WERKS
    CLEAR: ls_ext_criteria,lt_filter_range,ls_filter_range.
    IF lt_unfiltered_seloption_lifnr IS NOT INITIAL.
      DELETE ADJACENT DUPLICATES FROM lt_unfiltered_seloption_lifnr.
      ls_filter_range-fieldname = 'LIFNR'.
      ls_filter_range-selopt_t = lt_unfiltered_seloption_lifnr.
      ls_ext_criteria-tablename = 'EINA'.
      APPEND ls_filter_range TO lt_filter_range.
      ls_ext_criteria-frange_t = lt_filter_range.
      APPEND ls_ext_criteria TO lt_ext_criteria.
    ENDIF.

    et_ext_criteria = lt_ext_criteria.
  ENDMETHOD.
ENDCLASS.
