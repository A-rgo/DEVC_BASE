class YZ_CLASS_COM2SAP_UTILITY definition
  public
  final
  create public .

public section.

  types:
    begin of gty_usmd_t_search_result,
          KEY_VAL   TYPE ATTRIB_VALUE.
          INCLUDE TYPE usmd_s_search_result.
  types: end of gty_usmd_t_search_result .
  types:
    TT_SEARCH_RESULT  TYPE TABLE OF gty_usmd_t_search_result .

  class-methods GET_SEARCH_HELP_DATA
    importing
      !I_MODEL type USMD_MODEL optional
    changing
      !C_INPUT type YZM_S_INPUT_TAB .
  class-methods GET_SEARCH_HELP_VALUE_FROM_DOM
    importing
      !I_MODE type YZDTEL_MODE optional
      !I_MODEL type USMD_MODEL optional
      !I_SCOPE type YZDTEL_SCOPE_ID optional
      !I_TEMPID type YZDTEL_TEMPLATE_ID optional
    changing
      !C_INPUT type YZM_S_INPUT_TAB .
  class-methods GET_MODEL_DATA
    changing
      value(CT_INPUT_TAB) type YZM_S_INPUT_TAB .
  class-methods GET_TEMPLATEID_FROM_SCOPE_DATA
    importing
      value(LV_MODEL) type YZDTEL_MODEL
      value(LV_SCOPE) type YZDTEL_SCOPE_ID
    changing
      value(CT_INPUT_TAB) type YZM_S_INPUT_TAB .
  class-methods GET_SCOPE_MODEL_DATA
    importing
      value(LV_MODEL) type YZDTEL_MODEL
    changing
      value(CT_INPUT_TAB) type YZM_S_INPUT_TAB .
  class-methods GET_TEMPLATE_FROM_ID
    importing
      value(IV_MODEL) type YZDTEL_MODEL
      value(IV_SCOPE) type YZDTEL_SCOPE_ID
      value(IV_TEMPLATEID) type YZDTEL_TEMPLATE_ID
    exporting
      value(ET_TEMPLATE) type YZM_T_TEMPLT_DET .
  class-methods VALIDATE_MATERIAL
    importing
      !I_MODEL type USMD_MODEL
      !I_SCOPE type YZDTEL_SCOPE_ID
      !I_TEMPID type YZDTEL_TEMPLATE_ID
      !I_ACTIONID type YZDTEL_ACTION_ID
      !IT_MATERIAL type YZM_T_MATERIAL_DETAILS
      !I_JSON_REQUEST type STRING
    exporting
      !ET_ERROR_TEMPLATE type YZM_T_TEMPLT_DET
      !ET_ERRORS type YZM_T_ERROR_DETAILS .
  class-methods GET_CHARACTERISTICS
    importing
      !IV_CLASS_TYPE type KLASSENART
      !IV_CLASS type KLASSE_D
      !IV_LANGU type SY-LANGU optional
    exporting
      !ET_CHARACTERISTIC type YZM_T_CHARA_DETAILS .
  class-methods GET_CLASS_CHARACTERICS
    importing
      !I_MODEL type USMD_MODEL
      !I_JSON_INPUT type STRING
    exporting
      !ET_CLASS_CHARA_DETAILS type YZM_T_CHARA_DETAILS
    changing
      !C_INPUT type YZM_S_INPUT_TAB .
  class-methods DESERIALIZE_JSON_INPUT
    importing
      !I_MODE type YZDTEL_MODE optional
      !I_MODEL type YZDTEL_MODEL
      !I_SCOPE type YZDTEL_SCOPE_ID
      !I_TEMPID type YZDTEL_TEMPLATE_ID
      !I_ACTIONID type YZDTEL_ACTION_ID
      !I_USE_ATTRIBUTES type CHAR01 optional
      !I_JSON_INPUT type STRING
    exporting
      !ET_DATA type ref to DATA .
  class-methods GET_CREQUEST_DATA
    importing
      !I_MODE type YZDTEL_MODE
      !I_MODEL type YZDTEL_MODEL
      !I_SCOPE type YZDTEL_SCOPE_ID
      !I_TEMPID type YZDTEL_TEMPLATE_ID
      !I_ACTIONID type YZDTEL_ACTION_ID
      !I_JSON_REQUEST type STRING
    exporting
      !E_JSON_RESPONSE type STRING .
  class-methods DUPLICATE_CHECK
    importing
      !I_MODE type YZDTEL_MODE
      !I_MODEL type YZDTEL_MODEL
      !I_SCOPE type YZDTEL_SCOPE_ID
      !I_TEMPID type YZDTEL_TEMPLATE_ID
      !I_ACTIONID type YZDTEL_ACTION_ID
      !I_INPUT_DATA type STRING
    exporting
      !E_OUTPUT type STRING .
  class-methods BUSINESS_RULE_CHECK
    importing
      !I_MODE type YZDTEL_MODE
      !I_MODEL type YZDTEL_MODEL
      !I_SCOPE type YZDTEL_SCOPE_ID
      !I_TEMPID type YZDTEL_TEMPLATE_ID
      !I_ACTIONID type YZDTEL_ACTION_ID
      !I_INPUT_DATA type STRING
    exporting
      !E_OUTPUT type STRING .
  class-methods GET_SELECTION_CRITERIA
    exporting
      !E_JSON_RESPONSE type STRING .
  class-methods GET_DUPLICATE_CHECK_CRITERIA
    importing
      !I_MODE type YZDTEL_MODE optional
      !I_MODEL type YZDTEL_MODEL optional
      !I_SCOPE type YZDTEL_SCOPE_ID optional
      !I_TEMPID type YZDTEL_TEMPLATE_ID optional
      !I_ACTIONID type YZDTEL_ACTION_ID optional
      !I_INPUT_DATA type STRING
    exporting
      !E_OUTPUT_DATA type STRING
      !ET_CRITERIA type ANY TABLE .
  class-methods GET_DUPLICATE_RECORDS
    importing
      !I_MODEL type YZDTEL_MODEL
      !I_SCOPE type YZDTEL_SCOPE_ID
      !I_TEMPID type YZDTEL_TEMPLATE_ID
      !I_PRIMARY_ENTITY type USMD_ENTITY
      !I_KEY_ATTRIBUTE type USMD_ATTRIBUTE
      !I_MATCH_PROFILE_ID type MDG_DQS_FIELD_ID
      !IS_DATA type ref to DATA
    exporting
      !ET_DUPLICATES type TT_SEARCH_RESULT .
  class-methods DUPLICATE_CHECK_CUSTOM
    importing
      !I_MODE type YZDTEL_MODE
      !I_MODEL type YZDTEL_MODEL
      !I_SCOPE type YZDTEL_SCOPE_ID
      !I_TEMPID type YZDTEL_TEMPLATE_ID
      !I_ACTIONID type YZDTEL_ACTION_ID
      !I_INPUT_DATA type STRING
    exporting
      !E_OUTPUT type STRING .
  class-methods GET_DERIVED_DATA
    importing
      !I_JSON_INPUT type STRING optional
    exporting
      !E_JSON_OUTPUT type STRING .
protected section.
private section.

  types:
    BEGIN OF s_hana_objects,
            hana_staging_view TYPE mdg_hviewname,
            hana_reuse_view TYPE mdg_hviewname,
            hana_union_sql_view TYPE mdg_hviewname,
            hana_reuse_clf_view TYPE mdg_hviewname,
            ruleset TYPE usmd_ruleset_name,
            ruleset_clf TYPE usmd_ruleset_name,
          END OF s_hana_objects .
  types:
    TT_DQDC_ATTRIBUTES TYPE TABLE OF yztabl_dqdc_conf .

  class-data GV_ONLY_ACTIVE_RECORDS type ABAP_BOOL value ABAP_FALSE ##NO_TEXT.
  class-data GS_HANA_VIEWS type S_HANA_OBJECTS .
  class-data GV_IS_REUSE type BOOLEAN value ABAP_FALSE ##NO_TEXT.
  class-data GV_ISEMPTY_CHAR type BOOLEAN value ABAP_FALSE ##NO_TEXT.
  class-data GT_MAPPING_INFO type MDG_HDB_TT_REUSE_MAPPING .
  class-data:
    MT_ATTRIBUTES_REUSE type table of mdg_sdq_s_reuse_dup_attr .
  class-data MT_ATTRIBUTES type TT_DQDC_ATTRIBUTES .
  class-data MT_CMPLX_SEARCH_ATTR_TEMP type USMD_TS_SEL .
  class-data GV_DEFAULT_WEIGHT type ABAP_BOOL value ABAP_TRUE ##NO_TEXT.
  class-data GV_DEFAULT_FUZZY type ABAP_BOOL value ABAP_TRUE ##NO_TEXT.
  class-data GT_CHARA_LIST type YZM_T_CHARA_DETAILS .

  class-methods BUILD_QUERY_CONDITION_DQDC
    importing
      !IS_SEARCH_ATTRIBUTE type USMD_S_SEL
      !IV_VIEW_INDICATOR type INT2 default 1
      !IV_CMPLX_CRITERIA type BOOLEAN
      !IV_INPUT_QUOTED type BOOLEAN default '-'
      !IV_CASE_SENSITIVE type BOOLEAN optional
    exporting
      !EV_SEL_CONDITION type STRING
    changing
      !CV_PREV_OPRTR_IS_NEGATION type BOOLEAN optional .
  class-methods BUILD_CLF_QUERY_ON_ATCOD_DQDC
    importing
      !IT_SEARCH_ATTRIBUTE type USMD_TS_SEL
      !IV_VIEW_INDICATOR type INT2 default 1
    exporting
      !EV_SEL_CONDITION type STRING .
  class-methods JOIN_QUERY_PARTS_DQDC
    importing
      !IT_SEARCH_ATTRIBUTE type USMD_TS_SEL
      !IV_CMPLX_CRITERIA type BOOLEAN optional
      !IV_VIEW_INDICATOR type INT2 default 1
      !IV_CASE_SENSITIVE type BOOLEAN optional
    exporting
      !EV_SEL_CONDITION type STRING .
  class-methods HANDLE_COMPLX_SEARCH_CRIT_DQDC
    importing
      !IT_TAB_SEARCH_ATTRIBUTE type TT_USMD_TS_SEL
      !IV_VIEW_INDICATOR type INT2 default 1
    exporting
      !EV_SEL_CONDITION type STRING
      !EV_CMPLX_CLF type ABAP_BOOL .
  class-methods BUILD_QUERY_PART_INIT_DQDC
    importing
      !IV_VIEW_INDICATOR type INT2 default 1
      !IV_SEL_FIELDS_ATR type STRING
      !IV_WITH_SCORE type ABAP_BOOL default ABAP_TRUE
    exporting
      !EV_SEL_STMT type STRING
      !EV_GROUPBY type STRING .
  class-methods GET_CLASS_BASED_SEARCH_ATTRI
    importing
      !IO_DATA_MODEL_EXT type ref to IF_USMD_MODEL_EXT
      !IT_DUP_CHECK_ATTR type USMD_TS_DUPLICATE_CHECK_ATTR
      !IT_SEARCH_KEY type USMD_TS_SEL
      !IV_ENTITY type USMD_ENTITY optional
      !IV_SEARCH_MODE type USMD_SEARCH_MODE
    exporting
      !ET_SEARCH_ATTRIBUTES_ADDR type USMD_TS_SEL .
  class-methods GET_MAPPED_SEARCH_ATTRIBS_DQDC
    importing
      !IS_SEARCH_CONTEXT type USMD_S_SEARCH_CONTEXT
    exporting
      !ET_AUTH_ATTR type USMD_TS_SEL
      !ET_AUTH_ATTR_REUSE type USMD_TS_SEL
      !ET_TAB_SEARCH_ATTR_REUSE type TT_USMD_TS_SEL
      !ET_SEARCH_ATTR_REUSE type USMD_TS_SEL
    changing
      !CT_TAB_SEARCH_ATTRIBUTE type TT_USMD_TS_SEL
      !CT_SEARCH_ATTRIBUTE type USMD_TS_SEL .
  class-methods CHECK_FOR_REUSE_QUERY_DQDC
    importing
      !IT_SEARCH_ATTRIBUTE type USMD_TS_SEL
      !IT_SEARCH_ATTRIBUTE_REUSE type USMD_TS_SEL
      !IT_TAB_SEARCH_ATTRIBUTE_REUSE type TT_USMD_TS_SEL
      !IT_TAB_SEARCH_ATTRIBUTE type TT_USMD_TS_SEL
    exporting
      !EV_CONSTRUCT_REUSE_QUERY type ABAP_BOOL .
  class-methods BUILD_QUERY_DQDC
    importing
      !IS_SEARCH_CONTEXT type USMD_S_SEARCH_CONTEXT
      !ID_SEARCH_STRING type STRING
      !IT_SEARCH_ATTRIBUTE type USMD_TS_SEL
      !IV_RULSESET_AUTH_QUERY type STRING optional
      !IV_VIEW_INDICATOR type INT2 default 1
      !IT_TAB_SEARCH_ATTRIBUTE type TT_USMD_TS_SEL
    exporting
      !EV_SEL_STMT type STRING
      !EV_FILTER_RULESET type STRING .
  class-methods GET_RESULTS_DQDC
    importing
      !IS_SEARCH_CONTEXT type USMD_S_SEARCH_CONTEXT
      !IT_SEARCH_ATTRIBUTE type USMD_TS_SEL
      !IV_SEL_STMT type STRING
      !IV_SEL_STMT_REUSE type STRING
      !IV_FILTER_RULESET type STRING
      !IT_TAB_SEARCH_ATTRIBUTE type TT_USMD_TS_SEL
    changing
      !CT_DATA type USMD_T_SEARCH_RESULT
      !CT_MESSAGE type USMD_T_MESSAGE .
ENDCLASS.



CLASS YZ_CLASS_COM2SAP_UTILITY IMPLEMENTATION.


method get_characteristics.
  data lt_class_descr     type table of bapi1003_catch_r.
  data lt_class_ltxt      type table of bapi1003_longtext_r.
  data lt_chara           type table of bapi1003_charact_r.
  data lt_chara_val       type table of bapi1003_char_val_r.
  data ls_charactaristic  type yzm_s_chara_details.
  data ls_valuelist       type yzm_s_value_list.

  call function 'BAPI_CLASS_READ'
    exporting
      classtype            = iv_class_type
      classnum             = iv_class
      languint             = iv_langu
    tables
      classdescriptions    = lt_class_descr
      classlongtexts       = lt_class_ltxt
      classcharacteristics = lt_chara
      classcharactvalues   = lt_chara_val.

  sort lt_chara_val by name_char.
  if lt_chara is not initial.
    select a~atinn, a~atnam, a~msehi, b~msehl from cabn as a left join t006a as b
      on a~msehi = b~msehi
      into table @data(lt_uom)
      for all entries in @lt_chara
      where a~atnam = @lt_chara-name_char
      and b~spras = @iv_langu.
  endif.


  loop at lt_chara into data(ls_chara).
    ls_charactaristic-spras = iv_langu.
    ls_charactaristic-class = iv_class.
    ls_charactaristic-atnam = ls_chara-name_char.
    ls_charactaristic-atbez = ls_chara-descr.
    read table lt_uom into data(ls_uom) with key atnam = ls_chara-name_char.
    if sy-subrc = 0.
      ls_charactaristic-msehl = ls_uom-msehl.
    endif.
    read table lt_chara_val with key name_char = ls_chara-name_char
    transporting no fields binary search.
    if sy-subrc = 0.
      loop at lt_chara_val into data(ls_chara_val) from sy-tabix.
        if ls_chara_val-name_char ne ls_chara-name_char.
          exit.
        endif.
*        ls_valuelist-id = ls_chara_val-char_value.
*        ls_valuelist-description = ls_chara_val-descr_cval.
*        append ls_valuelist to ls_charactaristic-atwrt.
*        clear ls_valuelist.
        ls_charactaristic-atwrt = ls_chara_val-char_value.
        append ls_charactaristic to et_characteristic.
*        clear ls_charactaristic.

      endloop.
    else.
      ls_charactaristic-class = iv_class.
      ls_charactaristic-atnam = ls_chara-name_char.
      ls_charactaristic-atbez = ls_chara-descr.
      append ls_charactaristic to et_characteristic.
    endif.
*    append ls_charactaristic to et_characteristic.
    clear ls_charactaristic.
  endloop.
endmethod.


method get_class_characterics.
  types: begin of lty_input,
           i_mode      type yzdtel_mode,
           i_model     type yzdtel_model,
           i_scope     type yzdtel_scope_id,
           i_tempid    type yzdtel_template_id,
           i_actionid  type yzdtel_action_id,
           i_input_tab type yzm_s_input_tab,
           i_langu      type sy-langu,
         end of lty_input.
  data ls_input       type lty_input.

   /ui2/cl_json=>deserialize(
    exporting
      json = i_json_input   " JSON string
    changing
      data = ls_input         " Data to serialize
  ).

  get_search_help_data(
    exporting
      i_model = i_model                  " Data Model
    changing
      c_input = c_input                 " Input Tab
  ).

  if i_model = 'BP'.
    data(lv_classtype) = 'BUP'.
  elseif i_model = 'MM'.
    lv_classtype = '001'.
    DELETE c_input-e_valuelist WHERE id NP 'CE*'.
  endif.
  loop at c_input-e_valuelist into data(ls_valuelist).
    get_characteristics(
      exporting
        iv_class_type     = conv #( lv_classtype )
        iv_class          = conv #( ls_valuelist-id )                 " Class number
        iv_langu          = ls_input-i_langu
      importing
        et_characteristic = data(lt_chara)                 " Table Type Material Characteristic Details
    ).
    append lines of lt_chara to et_class_chara_details.
    refresh lt_chara.
  endloop.

endmethod.


  METHOD get_model_data.
    DATA: lt_model      TYPE STANDARD TABLE OF yztable_pr_model,
          lt_value_list TYPE yzm_t_value_list,
          ls_value_list LIKE LINE OF lt_value_list.
    SELECT usmd_model, txtmi
      FROM yztable_pr_model
      WHERE usmd_active EQ @abap_true
      INTO CORRESPONDING FIELDS OF TABLE @lt_model.
    IF sy-subrc IS INITIAL.
      ct_input_tab-e_status = 'Success'.
      CLEAR: lt_value_list.
      LOOP AT lt_model ASSIGNING FIELD-SYMBOL(<ls_model>).
        CHECK sy-subrc IS INITIAL AND <ls_model> IS ASSIGNED.
        ls_value_list-id          = <ls_model>-usmd_model.
        ls_value_list-description = <ls_model>-txtmi.
        APPEND ls_value_list TO ct_input_tab-e_valuelist.
        CLEAR: ls_value_list.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD get_scope_model_data.
    DATA: lt_scope      TYPE STANDARD TABLE OF yztable_scope,
          lt_value_list TYPE yzm_t_value_list,
          ls_value_list LIKE LINE OF lt_value_list.
    SELECT scope_id, description
      FROM yztable_scope
      WHERE usmd_model  EQ @lv_model AND
            usmd_active EQ @abap_true
      INTO CORRESPONDING FIELDS OF TABLE @lt_scope.
    IF sy-subrc IS INITIAL.
      ct_input_tab-e_status = 'Success'.
      CLEAR: lt_value_list.
      LOOP AT lt_scope ASSIGNING FIELD-SYMBOL(<ls_scope>).
        CHECK sy-subrc IS INITIAL AND <ls_scope> IS ASSIGNED.
        ls_value_list-id          = <ls_scope>-scope_id.
        ls_value_list-description = <ls_scope>-description.
        APPEND ls_value_list TO ct_input_tab-e_valuelist.
        CLEAR: ls_value_list.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


method get_search_help_data.
  data lt_values        type table of seahlpres.
  data ls_shlp          type shlp_descr.
  data lt_SHLP          type table of shlp_descr.
  data ls_callcontrol  type ddshf4ctrl.
*  data ls_ocx type ddshocxint.
  data ls_valuelist       type yzm_s_value_list.

*
*  data lt_chara       type table of bapi1003_charact_r.
*  data lt_chara_val    type table of bapi1003_char_val_r.
*  data lt_class_descr type table of bapi1003_catch_r.
*  data lt_class_ltxt  type table of bapi1003_longtext_r.
*  data ls_charactaristic  type yzm_s_chara_details.

  if c_input-i_searchhelp is not initial.
    call function 'F4IF_GET_SHLP_DESCR'
      exporting
        shlpname = c_input-i_searchhelp
      importing
        shlp     = ls_shlp.

    ls_callcontrol-step = 'SELECT'.
    ls_callcontrol-top_shlp = c_input-i_searchhelp.

    if ls_shlp-intdescr-selmexit is not initial.
      if i_model = 'BP'.
        data(lv_classtype) = 'BUP'.
      elseif i_model = 'MM'.
        lv_classtype = '001'.
      endif.
      ls_shlp-selopt = value #( base ls_shlp-selopt (
                                                      ""shlpname = c_input-i_searchhelp
                                                      shlpfield = 'CLASSTYPE'
                                                      sign = 'I' option = 'EQ' low = lv_classtype ) ).

      lt_shlp = value #( base lt_shlp ( corresponding #( ls_shlp ) ) ).

      call function ls_shlp-intdescr-selmexit
        tables
          shlp_tab    = lt_shlp
          record_tab  = lt_values
        changing
          shlp        = ls_shlp
          callcontrol = ls_callcontrol.

      sort ls_shlp-fielddescr by offset.

      describe table ls_shlp-fielddescr lines data(lv_line).
      loop at lt_values into data(ls_values).
        read table ls_shlp-fielddescr into data(ls_fielddescr) index 1.
        if sy-subrc = 0.
          ls_fielddescr-offset /= 2.
          ls_valuelist-id = ls_values-string+ls_fielddescr-offset(ls_fielddescr-outputlen).
        endif.
        read table ls_shlp-fielddescr into ls_fielddescr index lv_line.
        if sy-subrc = 0.
          ls_fielddescr-offset /= 2.
          ls_valuelist-description = ls_values-string+ls_fielddescr-offset(ls_fielddescr-outputlen).
        endif.
        append ls_valuelist to c_input-e_valuelist.
        clear ls_valuelist.
      endloop.
    elseif c_input-i_searchhelp = 'ZCV_DEMO_MTYPE'.
      select from ZCV_DEMO_MTYPE fields mtart, mtbez into table @c_input-e_valuelist.
    elseif c_input-i_searchhelp = 'ZCV_DEMO_UNIT'.
      select from ZTECH_MAT_UNIT fields MSEHI, MSEHL into table @c_input-e_valuelist.
      sort c_input-e_valuelist by id.
      delete adjacent duplicates from c_input-e_valuelist comparing id.
    endif.
  endif.


endmethod.


method get_search_help_value_from_dom.
  data ls_shlp type shlp_descr.
  data lt_values type table of seahlpres.

  if c_input-i_searchhelp is not initial.
    get_search_help_data(
      exporting
        i_model = 'MM'                 " Data Model
      changing
        c_input = c_input                 " Input Tab
    ).
  endif.

  check c_input-e_valuelist is initial.

  if c_input-i_tablename is not initial and c_input-i_inputfield is not initial.
    call function 'F4IF_DETERMINE_SEARCHHELP'
      exporting
        tabname           = c_input-i_tablename
        fieldname         = c_input-i_inputfield
      importing
        shlp              = ls_shlp
      exceptions
        field_not_found   = 1
        no_help_for_field = 2
        inconsistent_help = 3
        others            = 4.
    if sy-subrc = 0.

      call function 'DD_SHLP_GET_HELPVALUES'
        tables
          output_values               = lt_values
        changing
          shlp                        = ls_shlp
        exceptions
          cursor_selection_impossible = 1
          others                      = 2.
      if sy-subrc = 0.
        if ls_shlp-shlptype ne 'FV'.
          delete ls_shlp-fieldprop where shlpoutput is initial.
          sort ls_shlp-fielddescr by offset.
          loop at lt_values into data(ls_value).
            append initial line to c_input-e_valuelist assigning field-symbol(<lfs_valuelist>).
            if <lfs_valuelist> is assigned.
              read table ls_shlp-fieldprop into data(ls_fieldprop) index 1.
              if sy-subrc = 0.
                read table ls_shlp-fielddescr into data(ls_fielddescr) with key fieldname = ls_fieldprop-fieldname.
                if sy-subrc = 0.
                  ls_fielddescr-offset /= 2.
                  <lfs_valuelist>-id = cond #( when ls_fielddescr-offset = 1 then ls_value-string(ls_fielddescr-leng)
                                                else ls_value-string+ls_fielddescr-offset(ls_fielddescr-leng) ).

                endif.
              endif.

              read table ls_shlp-fieldprop into ls_fieldprop index 2.
              if sy-subrc = 0.
                read table ls_shlp-fielddescr into ls_fielddescr with key fieldname = ls_fieldprop-fieldname.
                if sy-subrc = 0.
                  ls_fielddescr-offset /= 2.
                  if c_input-i_inputfield = 'SPRAS'.
                  <lfs_valuelist>-description = ls_value-string+ls_fielddescr-offset(ls_fielddescr-leng) .

                  else.
                  <lfs_valuelist>-description = cond #( when ls_fielddescr-offset = 1 then ls_value-string(ls_fielddescr-leng)
                                                else ls_value-string+ls_fielddescr-offset(ls_fielddescr-leng) ).
                  endif.
                endif.
              endif.
            endif.
          endloop.
        else.
          loop at lt_values into ls_value.
            append initial line to c_input-e_valuelist assigning <lfs_valuelist>.
            if <lfs_valuelist> is assigned.
              read table ls_shlp-fielddescr into ls_fielddescr with key fieldname = '_LOW'.
              if sy-subrc = 0.
                ls_fielddescr-offset /= 2.
                <lfs_valuelist>-id = cond #( when ls_fielddescr-offset = 1 then ls_value-string(ls_fielddescr-leng)
                                              else ls_value-string+ls_fielddescr-offset(ls_fielddescr-leng) ).
              endif.
              read table ls_shlp-fielddescr into ls_fielddescr with key fieldname = '_TEXT'.
              if sy-subrc = 0.
                ls_fielddescr-offset /= 2.
*                ls_fielddescr-offset /= 2.
                <lfs_valuelist>-description = cond #( when ls_fielddescr-offset = 1 then ls_value-string(ls_fielddescr-leng)
                                              else ls_value-string+ls_fielddescr-offset(ls_fielddescr-leng) ).

              endif.
            endif.
          endloop.
        endif.
      else.
        case sy-subrc.
          when 1.
            c_input-e_status = 'Error'(001).
            c_input-e_message = 'Cursor selection impossible'(002).
          when others.
            c_input-e_status = 'Error'(001).
        endcase.
      endif.
    else.
      case sy-subrc.
        when 1.
          c_input-e_status = 'Error'(001).
          c_input-e_message = 'Field not found'(003).
        when 2.
          c_input-e_status = 'Error'(001).
          c_input-e_message = 'No search help defined'(004).
        when 3.
          c_input-e_status = 'Error'(001).
          c_input-e_message = 'Incosistent Help'(005).
        when others.
          c_input-e_status = 'Error'(001).
      endcase.
    endif.
  elseif c_input-i_searchhelp is not initial.
    get_search_help_data( exporting i_model = i_model changing c_input = c_input ).
  endif.

  sort c_input-e_valuelist by id.
  delete adjacent duplicates from c_input-e_valuelist comparing id.
endmethod.


  METHOD get_templateid_from_scope_data.
    DATA: lt_template_id TYPE STANDARD TABLE OF yztable_template,
          lt_value_list  TYPE yzm_t_value_list,
          ls_value_list  LIKE LINE OF lt_value_list.
    SELECT template_id, description
      FROM yztable_template
      WHERE usmd_model  EQ @lv_model  AND
            scope_id    EQ @lv_scope AND
            usmd_active EQ @abap_true
      INTO CORRESPONDING FIELDS OF TABLE @lt_template_id.
    IF sy-subrc IS INITIAL.
      ct_input_tab-e_status = 'Success'.
      CLEAR: lt_value_list.
      LOOP AT lt_template_id ASSIGNING FIELD-SYMBOL(<ls_template_id>).
        CHECK sy-subrc IS INITIAL AND <ls_template_id> IS ASSIGNED.
        ls_value_list-id          = <ls_template_id>-template_id.
        ls_value_list-description = <ls_template_id>-description.
        APPEND ls_value_list TO ct_input_tab-e_valuelist.
        CLEAR: ls_value_list.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  method get_template_from_id.
    data: lt_template type standard table of yzm_s_templt_det.

    select details~client, details~usmd_model, details~scope_id, details~template_id, details~view_id, details~column_id,
      details~usmd_entity, details~usmd_attribute, details~active_tab_name, details~active_field_name,
      details~field_domain, details~searchhelp, details~filter_field_name, details~description, details~auto_generate,
      SELECTION, is_key, details~included, details~usmd_active, descr~description as view_descr
      from   yztab_templt_det as details inner join yztabl_temp_view as descr
      on details~usmd_model = descr~usmd_model and
         details~scope_id = descr~scope_id and
         details~template_id = descr~template_id and
         details~view_id = descr~view_id
           where  details~usmd_model  eq @iv_model      and
                  details~scope_id    eq @iv_scope      and
                  details~template_id eq @iv_templateid and
                  details~included    eq @abap_true     and
                  details~usmd_active eq @abap_true
          into corresponding fields of table @lt_template.
    if sy-subrc is initial.
      sort lt_template by view_id column_id.
      et_template = lt_template.
    endif.
  endmethod.


method validate_material.

  data lt_amara_ueb     type table of mara_ueb.
  data lt_aMAKT_UEB     type table of makt_ueb.
  data lt_aMArc_UEB     type table of marc_ueb.
  data lt_AMARD_UEB     type table of mard_ueb.
  data lt_AMFHM_UEB     type table of mfhm_ueb.
  data lt_AMARM_UEB     type table of marm_ueb.
  data lt_AMEA1_UEB     type table of mea1_ueb.
  data lt_AMBEW_UEB     type table of mbew_ueb.
  data lt_ASTEU_UEB     type table of steu_ueb.
  data lt_ASTMM_UEB     type table of steumm_ueb.
  data lt_AMLGN_UEB     type table of mlgn_ueb.
  data lt_AMLGT_UEB     type table of mlgt_ueb.
  data lt_AMPGD_UEB     type table of mpgd_ueb.
  data lt_AMPOP_UEB     type table of mpop_ueb.
  data lt_AMVEG_UEB     type table of mveg_ueb.
  data lt_AMVEU_UEB     type table of mveu_ueb.
  data lt_AMVKE_UEB     type table of mvke_ueb.
  data lt_ALTX1_UEB     type table of ltx1_ueb.
  data lt_AMPRW_UEB     type table of mprw_ueb.
  data lt_enq_tmp       type table of seqg3.
  data lt_enq           type table of seqg3.
  data lv_args          type EQEGRAARG.
data lT_DATA  Type Ref To DATA.


  data lt_error_list    type table of merrdat.
  data ls_errors        type yzm_s_error_details.
  data lv_msg           type bapi_msg.

  field-symbols: <lfs_table> type table.
  field-symbols: <lfs_single> type any.

  select from yztabl_temp_view as head inner join yztab_templt_det as details on
    head~usmd_model = details~usmd_model and
    head~scope_id = details~scope_id and
    head~template_id = details~template_id and
    head~view_id = details~view_id
    fields usmd_entity, head~view_id, primary_table, active_tab_name
    where details~usmd_model = @i_model and details~template_id = @i_tempid
    into table @data(lt_views).
  if sy-subrc = 0.
    sort lt_views by view_id.
    delete adjacent duplicates from lt_views comparing view_id.
*    sort lt_views by view_id.
  endif.

  yz_class_com2sap_utility=>deserialize_json_input(
          exporting
*            i_mode       = i_mode                  " Model for Mass Process Enrichment
            i_model      = i_model                 " Data Model value for mass process enrichment
            i_scope      = i_scope                 " Scope Id for Data model
            i_tempid     = i_tempid                " Template ID for mass process enrichment
            i_actionid   = i_actionid                " Data element for action id
            i_json_input = i_json_request
          importing
            et_data      = lt_data
        ).

  if i_json_request is not initial and lt_data is bound.
    assign lt_data->* to field-symbol(<lfs_data>).
    loop at lt_views into data(ls_view).
      DATA(lv_table) = '_' && ls_view-view_id.
      assign component lv_table of structure <lfs_data> to field-symbol(<lfs_tab>).
      if <lfs_tab> is assigned and ls_view-primary_table is not initial.
        unassign <lfs_table>.
        data(lv_tab) = 'LT_A' && ls_view-primary_table && '_UEB'.
        assign (lv_tab) to <lfs_table>.
        if <lfs_table> is assigned.
          <lfs_table> = corresponding #( <lfs_tab> ).
        endif.
      endif.
    endloop.

    loop at lt_amara_ueb assigning field-symbol(<lfs_amara_ueb>).
      <lfs_amara_ueb>-tcode = 'MM01'.
      <lfs_amara_ueb>-tranc = sy-tabix.
    endloop.
    sort lt_amara_ueb by tranc.
    loop at lt_amakt_ueb assigning field-symbol(<lfs_amakt_ueb>).
      unassign <lfs_amara_ueb>.
      read table lt_amara_ueb assigning <lfs_amara_ueb> with key matnr  = <lfs_amakt_ueb>-matnr binary search.
      if <lfs_amara_ueb> is assigned.
        <lfs_amakt_ueb>-tranc = <lfs_amara_ueb>-tranc.
      endif.
    endloop.

    loop at lt_aMArc_UEB assigning field-symbol(<lfs_amarc_ueb>).
      unassign <lfs_amara_ueb>.
      read table lt_amara_ueb assigning <lfs_amara_ueb> with key matnr  = <lfs_amarc_ueb>-matnr binary search.
      if <lfs_amara_ueb> is assigned.
        <lfs_amarc_ueb>-tranc = <lfs_amara_ueb>-tranc.
      endif.
    endloop.

    loop at lt_AMARD_UEB assigning field-symbol(<lfs_aMARD_ueb>).
      unassign <lfs_amara_ueb>.
      read table lt_amara_ueb assigning <lfs_amara_ueb> with key matnr  = <lfs_aMARD_ueb>-matnr binary search.
      if <lfs_amara_ueb> is assigned.
        <lfs_aMARD_ueb>-tranc = <lfs_amara_ueb>-tranc.
      endif.
    endloop.

    call function 'MATERIAL_MAINTAIN_DARK'
      exporting
        p_kz_no_warn           = 'E'
        kz_prf                 = 'E'
      tables
        amara_ueb              = lt_amara_ueb
        amakt_ueb              = lt_amakt_ueb
        amarc_ueb              = lt_aMArc_UEB
        amard_ueb              = lt_AMARD_UEB
        amfhm_ueb              = lt_AMFHM_UEB
        amarm_ueb              = lt_AMARM_UEB
        amea1_ueb              = lt_AMEA1_UEB
        ambew_ueb              = lt_AMBEW_UEB
        asteu_ueb              = lt_ASTEU_UEB
        astmm_ueb              = lt_ASTMM_UEB
        amlgn_ueb              = lt_AMLGN_UEB
        amlgt_ueb              = lt_AMLGT_UEB
        ampgd_ueb              = lt_AMPGD_UEB
        ampop_ueb              = lt_AMPOP_UEB
        amveg_ueb              = lt_AMVEG_UEB
        amveu_ueb              = lt_AMVEU_UEB
        amvke_ueb              = lt_AMVKE_UEB
        altx1_ueb              = lt_ALTX1_UEB
        amprw_ueb              = lt_AMPRW_UEB
        amerrdat               = lt_error_list
      exceptions
        kstatus_empty          = 1
        tkstatus_empty         = 2
        t130m_error            = 3
        internal_error         = 4
        too_many_errors        = 5
        update_error           = 6
        error_propagate_header = 7
        others                 = 8.
    if sy-subrc <> 0.
* Implement suitable error handling here
    endif.
  else.
    data ls_amara_ueb like line of lt_amara_ueb.
    data ls_amakt_ueb like line of lt_amakt_ueb.

    loop at it_material into data(ls_material).
      ls_amara_ueb = corresponding #( ls_material ).
      ls_amara_ueb-gtin_variant = ls_material-gtin_var1. """""
      ls_amara_ueb-lvorm    = ls_material-lvoma.    """"""
      ls_amara_ueb-matnr_external = ls_material-matnr_ext.  """""""
      ls_amara_ueb-mtpos_mara    = ls_material-mtpos.     """"""
      ls_amara_ueb-ean11   = ls_material-numtp1.  """
      ls_amara_ueb-tcode = 'MM01'.
      append ls_amara_ueb to lt_amara_ueb.
      clear ls_amara_ueb.

      ls_amakt_ueb = corresponding #( ls_material ).
      append ls_amakt_ueb to lt_amakt_ueb.
      clear ls_amakt_ueb.
    endloop.

    call function 'MATERIAL_MAINTAIN_DARK'
      exporting
        p_kz_no_warn           = 'E'
        kz_prf                 = 'E'
      tables
        amara_ueb              = lt_amara_ueb
        amakt_ueb              = lt_amakt_ueb
        amerrdat               = lt_error_list
      exceptions
        kstatus_empty          = 1
        tkstatus_empty         = 2
        t130m_error            = 3
        internal_error         = 4
        too_many_errors        = 5
        update_error           = 6
        error_propagate_header = 7
        others                 = 8.
    if sy-subrc <> 0.
* Implement suitable error handling here
    endif.
  endif.

  if lt_error_list is not initial.

    loop at lt_amara_ueb into ls_amara_ueb.
      lv_args = sy-mandt && ls_amara_ueb-matnr && '*'.
      call function 'ENQUEUE_READ'
        exporting
          garg                  = lv_args
        tables
          enq                   = lt_enq_tmp
        exceptions
          communication_failure = 1
          system_failure        = 2
          others                = 3.
      if sy-subrc = 0.
        lt_enq = value #( base lt_enq ( lines of  lt_enq_tmp  ) ).
      endif.
    endloop.
    if lt_enq is not initial.
      call function 'ENQUE_DELETE'
        tables
          enq = lt_enq.
    endif.


    data(lo_description) = cast cl_abap_tabledescr( cl_abap_tabledescr=>describe_by_data( et_errors ) ).
    data(lt_components) = cast cl_abap_structdescr( lo_description->get_table_line_type( ) )->get_components( ).

    data(lv_cntr) = 0.
    loop at lt_components assigning field-symbol(<component>).
      data(elem) = cast cl_abap_elemdescr( <component>-type )->get_ddic_field( ).
      lv_cntr += 1.
      append value #( usmd_model = i_model column_id =  lv_cntr active_field_name = <component>-name description = elem-fieldtext ) to et_error_template.
    endloop.

    loop at lt_error_list into data(ls_error_list).
      ls_errors = corresponding #( ls_error_list ).
      call function 'BAPI_MESSAGE_GETDETAIL'
        exporting
          id         = ls_error_list-msgid
          number     = ls_error_list-msgno
*         LANGUAGE   = SY-LANGU
          textformat = 'RTF'
          message_v1 = ls_error_list-msgv1
          message_v2 = ls_error_list-msgv2
          message_v3 = ls_error_list-msgv3
          message_v4 = ls_error_list-msgv4
        importing
          message    = lv_msg.

      ls_errors-message = lv_msg.

      append ls_errors to et_errors.
      clear ls_errors.
    endloop.
  endif.

endmethod.


method deserialize_json_input.

  data lr_table type ref to data.
  data lr_main  type ref to data.
  data lt_components    type abap_component_tab.
  data lt_xlcomponents  type abap_component_tab.
  data ls_xlcomponents  like line of lt_components.
  data ls_components    like line of lt_components.


  yz_class_com2sap_utility=>get_template_from_id(
    exporting
      iv_model      = i_model                 " Data Model value for mass process enrichment
      iv_scope      = i_scope                 " Scope Id for Data model
      iv_templateid = i_tempid
    importing
      et_template   = data(lt_template)                 " Input Tab
  ).
  sort lt_template by view_id column_id.

  try.
      loop at lt_template assigning field-symbol(<lfs_template>).
        call method cl_abap_typedescr=>describe_by_name
          exporting
            p_name         = <lfs_template>-field_domain
          receiving
            p_descr_ref    = data(lo_field_ref)
          exceptions
            type_not_found = 1
            others         = 2.
        if sy-subrc <> 0.
*     Implement suitable error handling here
        endif.

        ls_components-name = cond #(  when i_use_attributes = 'X' and <lfs_template>-usmd_attribute is not initial
                                          then <lfs_template>-usmd_attribute
                                          else <lfs_template>-active_field_name ).
        ls_components-type ?= lo_field_ref.
        append ls_components to lt_components.
        clear ls_components.

        at end of view_id.
          call method cl_abap_structdescr=>create
            exporting
              p_components = lt_components
            receiving
              p_result     = data(lo_ref_struct).

          refresh lt_components.
          call method cl_abap_tabledescr=>create
            exporting
              p_line_type = lo_ref_struct
            receiving
              p_result    = data(lo_ref_sheet).

          ls_xlcomponents-name = '_' && <lfs_template>-view_id. "<lfs_template>-usmd_entity.
          ls_xlcomponents-type = lo_ref_sheet.
          append ls_xlcomponents to lt_xlcomponents.
          clear ls_xlcomponents.
        endat.
      endloop.
      call method cl_abap_structdescr=>create
        exporting
          p_components = lt_xlcomponents
        receiving
          p_result     = data(lo_ref_xl).

      call method cl_abap_tabledescr=>create
        exporting
          p_line_type = lo_ref_xl
        receiving
          p_result    = data(lo_table_xl).

*      data lr_table2 type ref to data.
*      create data lr_table2 type handle lo_table_ref2.
*      assign lr_table2 to field-symbol(<lfs_table2>).
    catch cx_root into data(lo_ex).
      data(lv_ltext) = lo_ex->get_longtext( ).
      data(lv_text) = lo_ex->get_text( ).
  endtry.

*  data lr_xl  type ref to data.
  create data et_data type handle lo_ref_xl."lo_table_xl.
  assign et_data->* to field-symbol(<lfs_xl>).
  /ui2/cl_json=>deserialize(
    exporting
      json = i_json_input               " JSON string
    changing
      data = <lfs_xl> " Data to serialize
  ).

endmethod.


method get_crequest_data.

  types: begin of lty_sel_crit,
           field  type char50,
           sign   type bapisign,
           option type bapioption,
           low    type string,
           high   type string,
         end of lty_sel_crit.
  data lt_sel_crit      type table of lty_sel_crit.
  data lr_table         type ref to data.
  data lr_main          type ref to data.
  data lt_components    type abap_component_tab.
  data lt_xlcomponents  type abap_component_tab.
  data ls_xlcomponents  like line of lt_components.
  data ls_components    like line of lt_components.
  data lt_out           type ref to data.
  data ls_out           type ref to data.
  data lv_table         type string.    ""inline declaration gives length issue

  field-symbols <lfs_entities>  type standard table.
  field-symbols <lfs_req_data>  type any.
  field-symbols <lfs_table>     type any.
  field-symbols <lfs_struct>    type any.
  field-symbols <lfs_entity>    type any.
  field-symbols <lfs_field_s>   type any.
  field-symbols <lfs_field_d>   type any.
  field-symbols <lfs_field_key> type any.


  /ui2/cl_json=>deserialize(
    exporting
      json = i_json_request  " JSON string
    changing
      data = lt_sel_crit      " Data to serialize
  ).


  cl_usmd_gov_api=>get_instance(
    exporting
      iv_model_name = i_model
    receiving
      ro_gov_api    = data(lo_api)
  ).



  read table lt_sel_crit into data(ls_sel_crit) with key field = 'USMD_CREQUEST'.
  if sy-subrc = 0.

    if lo_api is bound.
      lo_api->get_crequest_data(
        exporting
          iv_crequest_id          = conv #( ls_sel_crit-low ) " Change Request
        importing
          et_entity_data_inactive = data(lt_data) " Data
      ).

      select usmd_entity from usmd1213 into @data(lv_entity) up to 1 rows
    where usmd_crequest = @ls_sel_crit-low and usmd_seqnr = 1.
      endselect.
      if sy-subrc ne 0.
        clear lv_entity.
      endif.

      get_template_from_id(
        exporting
          iv_model      = i_model          " Data Model value for mass process enrichment
          iv_scope      = i_scope          " Scope Id for Data model
          iv_templateid = i_tempid         " Template ID for mass process enrichment
        importing
          et_template   = data(lt_template)                 " Input Tab
      ).

      sort lt_template by view_id column_id.

      try.
          loop at lt_template assigning field-symbol(<lfs_template>).
            at new view_id.
              data(lv_view_name) = <lfs_template>-usmd_entity.
            endat.
            call method cl_abap_typedescr=>describe_by_name
              exporting
                p_name         = <lfs_template>-field_domain
              receiving
                p_descr_ref    = data(lo_field_ref)
              exceptions
                type_not_found = 1
                others         = 2.
            if sy-subrc <> 0.
*     Implement suitable error handling here
            endif.
            ls_components-name = cond #( when <lfs_template>-usmd_attribute is initial
                                        then <lfs_template>-active_field_name "cond #( when <lfs_template>-column_id = '01'
                                  else <lfs_template>-usmd_attribute ).
            ls_components-type ?= lo_field_ref.
            append ls_components to lt_components.
            clear ls_components.

            at end of view_id.
              call method cl_abap_structdescr=>create
                exporting
                  p_components = lt_components
                receiving
                  p_result     = data(lo_ref_struct).

              refresh lt_components.
              call method cl_abap_tabledescr=>create
                exporting
                  p_line_type = lo_ref_struct
                receiving
                  p_result    = data(lo_ref_sheet).

              ls_xlcomponents-name = '_' && <lfs_template>-view_id."lv_view_name.
              ls_xlcomponents-type = lo_ref_sheet.
              append ls_xlcomponents to lt_xlcomponents.
              clear ls_xlcomponents.
            endat.
          endloop.
          call method cl_abap_structdescr=>create
            exporting
              p_components = lt_xlcomponents
            receiving
              p_result     = data(lo_ref_xl).

          call method cl_abap_tabledescr=>create
            exporting
              p_line_type = lo_ref_xl
            receiving
              p_result    = data(lo_table_xl).

        catch cx_sy_struct_creation into data(lo_ex).
          data(lv_ltext) = lo_ex->get_longtext( ).
          data(lv_text) = lo_ex->get_text( ).
      endtry.

      create data lt_out type handle lo_ref_xl."lo_table_xl.
      assign lt_out->* to field-symbol(<lfs_xl>).
    endif.
  endif.


  loop at lt_data into data(ls_data).
    assign ls_data-r_data->* to <lfs_req_data>.
    if ls_data-usmd_entity = lv_entity and ls_data-struct = 'KATTR'
      and ls_data-usmd_entity_cont is initial.
      data(lv_method) = 'SET_' && ls_data-usmd_entity.
      call method yz_clas_mdg_mm_data_process=>(lv_method)
        exporting
          it_data = <lfs_req_data>.
    elseif ls_data-usmd_entity = lv_entity and ls_data-struct = 'KLTXT'
      and ls_data-usmd_entity_cont is initial.
      lv_method = 'SET_MMTXT'.
      call method yz_clas_mdg_mm_data_process=>(lv_method)
        exporting
          it_data = <lfs_req_data>.
    elseif ls_data-usmd_entity_cont is not initial.
      lv_method = 'SET_' && ls_data-usmd_entity_cont.
      call method yz_clas_mdg_mm_data_process=>(lv_method)
        exporting
          it_data = <lfs_req_data>.
    endif.
  endloop.



  data(lv_key_field) = 'MATERIAL'.

  unassign: <lfs_entities>, <lfs_req_data>, <lfs_table>, <lfs_struct>,
  <lfs_entity>, <lfs_field_s>, <lfs_field_d>.

  loop at lt_template assigning <lfs_template>.
    if <lfs_template>-usmd_entity = lv_entity
      and ( <lfs_template>-usmd_attribute = 'TXTMI' or <lfs_template>-usmd_attribute = 'LANGU' ).
      lv_table = 'GT_MMTXT'.
    else.
      lv_table = 'GT_' && <lfs_template>-usmd_entity.
    endif.
    unassign <lfs_table>.
    assign yz_clas_mdg_mm_data_process=>(lv_table) to <lfs_table>.
    check <lfs_table> is assigned.
    unassign <lfs_struct>.
    loop at <lfs_table> assigning <lfs_struct>.
      data(lv_view) = '_' && <lfs_template>-view_id.
      unassign <lfs_entities>.
      assign component lv_view of structure <lfs_xl> to <lfs_entities>.
      check <lfs_entities> is assigned.
      assign component lv_key_field of structure <lfs_struct> to <lfs_field_key>.
      check <lfs_field_key> is assigned.
      unassign <lfs_entity>.
      read table <lfs_entities> assigning <lfs_entity> index sy-tabix.
      if sy-subrc = 0 and <lfs_entity> is assigned.
        unassign: <lfs_field_s>, <lfs_field_d>.
        assign component <lfs_template>-usmd_attribute of structure <lfs_struct> to <lfs_field_s>.
        assign component <lfs_template>-usmd_attribute of structure <lfs_entity> to <lfs_field_d>.
        if <lfs_field_s> is assigned and <lfs_field_d> is assigned.
          <lfs_field_d> = <lfs_field_s>.
        endif.
      else.
        create data ls_out like line of <lfs_entities>.
        assign ls_out->* to <lfs_entity>.
        if <lfs_entity> is assigned.

          loop at lt_template into data(ls_template_tmp) where view_id = <lfs_template>-view_id
                                              and is_key = 'X'.
            unassign: <lfs_field_s>, <lfs_field_d>.
            assign component ls_template_tmp-usmd_attribute of structure <lfs_struct> to <lfs_field_s>.
            assign component ls_template_tmp-usmd_attribute of structure <lfs_entity> to <lfs_field_d>.
            if <lfs_field_s> is assigned and <lfs_field_d> is assigned.
              <lfs_field_d> = <lfs_field_s>.
            endif.
          endloop.
          unassign: <lfs_field_s>, <lfs_field_d>.
          assign component <lfs_template>-usmd_attribute of structure <lfs_struct> to <lfs_field_s>.
          assign component <lfs_template>-usmd_attribute of structure <lfs_entity> to <lfs_field_d>.
          if <lfs_field_s> is assigned and <lfs_field_d> is assigned.
            <lfs_field_d> = <lfs_field_s>.
          endif.
          append <lfs_entity> to <lfs_entities>.
        endif.
      endif.
    endloop.
  endloop.

  e_json_response = /ui2/cl_json=>serialize(
    exporting
      data = <lfs_xl> ).         " Data to serialize

endmethod.


METHOD business_rule_check.
  TYPES: BEGIN OF lty_message,
           type    TYPE char01,
           message TYPE string,
         END OF lty_message.
  TYPES: BEGIN OF lty_return,
           errors TYPE TABLE OF lty_message WITH KEY type message,
         END OF lty_return.
  TYPES: BEGIN OF lty_matnr,
           old_matnr TYPE char18,
           new_matnr TYPE char18,
         END OF lty_matnr.
  TYPES: BEGIN OF lty_material,
           material TYPE matnr,
         END OF lty_material.
  DATA lt_material TYPE TABLE OF lty_material.
  DATA lt_matnr         TYPE TABLE OF lty_matnr.
  DATA ls_matnr         TYPE lty_matnr.
  DATA lv_table         TYPE string.
  DATA lt_out           TYPE REF TO data.
  DATA ls_out           TYPE REF TO data.
  DATA lt_query         TYPE TABLE OF string.
  DATA lt_xlcomponents  TYPE abap_component_tab.
  DATA ls_xlcomponents  LIKE LINE OF lt_xlcomponents.
  DATA lo_struct        TYPE REF TO cl_abap_datadescr.
  DATA lt_output        TYPE TABLE OF lty_message.
  DATA ls_output        TYPE lty_message.
  DATA ls_return        TYPE lty_return.
  DATA lv_args          TYPE eqegraarg.
  DATA lt_enq_tmp       TYPE TABLE OF seqg3.
  DATA lt_enq           TYPE TABLE OF seqg3.
  DATA lv_msg           TYPE bapi_msg.
  DATA lt_messages      TYPE usmd_t_message.
  DATA lv_numc          TYPE char50.
  DATA ls_valuation     TYPE /mdgmm/_s_mm_pp_valuation.
  DATA lv_atnam         TYPE atnam.
  DATA lv_langu         TYPE spras.
  DATA lv_langtxt       TYPE spras.

  FIELD-SYMBOLS <lfs_entities>  TYPE STANDARD TABLE.
  FIELD-SYMBOLS <lfs_temp_tab>  TYPE ANY TABLE.
  FIELD-SYMBOLS <lfs_table>     TYPE STANDARD TABLE.
  FIELD-SYMBOLS <lfs_struct>    TYPE any.
  FIELD-SYMBOLS <lfs_entity>    TYPE any.
  FIELD-SYMBOLS <lfs_field_s>   TYPE any.
  FIELD-SYMBOLS <lfs_field_d>   TYPE any.
  FIELD-SYMBOLS <lfs_field_d1>   TYPE any.
  FIELD-SYMBOLS <lfs_field_d2>   TYPE any.
  FIELD-SYMBOLS <lfs_atnam>   TYPE any.
  FIELD-SYMBOLS <lfs_key>  TYPE any.
  FIELD-SYMBOLS <lfs_purchtxt> TYPE /mdgmm/_s_mm_pp_purchtxt.
  FIELD-SYMBOLS <lfs_entity_purch> TYPE STANDARD TABLE.


  get_template_from_id(
    EXPORTING
      iv_model      = i_model          " Data Model value for mass process enrichment
      iv_scope      = i_scope          " Scope Id for Data model
      iv_templateid = i_tempid         " Template ID for mass process enrichment
    IMPORTING
      et_template   = DATA(lt_template)                 " Input Tab
  ).
  deserialize_json_input(
    EXPORTING
      i_mode           = i_mode                 " Model for Mass Process Enrichment
      i_model          = i_model                 " Data Model value for mass process enrichment
      i_scope          = i_scope                 " Scope Id for Data model
      i_tempid         = i_tempid                 " Template ID for mass process enrichment
      i_actionid       = i_actionid                 " Data element for action id
      i_use_attributes = 'X'                  " Character Field of Length 1
      i_json_input     = i_input_data
    IMPORTING
      et_data          = DATA(lt_data) ).

  ASSIGN lt_data->* TO FIELD-SYMBOL(<lfs_data_full>).
  SORT lt_template BY view_id.
  READ TABLE lt_template ASSIGNING FIELD-SYMBOL(<lfs_template>)
    WITH KEY view_id = '01' column_id = '01' is_key = 'X' included = 'X' usmd_active = 'X'.
  IF sy-subrc = 0.
    DATA(lv_primary_entity) = <lfs_template>-usmd_entity.
    DATA(lv_key_attrib) = <lfs_template>-usmd_attribute.
    DATA(lv_prev_view) = <lfs_template>-view_id.
    DATA(lv_prev_entity) = <lfs_template>-usmd_entity.
  ENDIF.
  TRY .
      DATA(lt_template_tmp) = lt_template.
      SORT lt_template_tmp BY usmd_entity.
      DELETE ADJACENT DUPLICATES FROM lt_template_tmp COMPARING usmd_entity. SORT lt_template_tmp BY view_id.
      LOOP AT lt_template_tmp ASSIGNING <lfs_template>.
        lv_table = 'GT_' && <lfs_template>-usmd_entity.
        UNASSIGN <lfs_temp_tab>.
        ASSIGN yz_clas_mdg_mm_data_process=>(lv_table) TO <lfs_temp_tab>.
        CHECK <lfs_temp_tab> IS ASSIGNED.
        CREATE DATA ls_out LIKE LINE OF <lfs_temp_tab>.
        lo_struct ?= cl_abap_structdescr=>describe_by_data_ref(
          EXPORTING
            p_data_ref = ls_out ). " Reference to described data object
        IF sy-subrc = 0.
          CALL METHOD cl_abap_tabledescr=>get
            EXPORTING
              p_line_type = lo_struct                   " Row Type
            RECEIVING
              p_result    = DATA(lo_table).                   " Result Type
        ENDIF.
        ls_xlcomponents-name = lv_table.
        ls_xlcomponents-type = lo_table.
        APPEND ls_xlcomponents TO lt_xlcomponents.
        CLEAR ls_xlcomponents.
      ENDLOOP.

      READ TABLE lt_template ASSIGNING <lfs_template> WITH KEY
      usmd_entity = lv_primary_entity usmd_attribute = 'TXTMI'.
      IF sy-subrc = 0.
        lv_table = 'GT_MMTXT'.
        UNASSIGN <lfs_temp_tab>.
        ASSIGN yz_clas_mdg_mm_data_process=>(lv_table) TO <lfs_temp_tab>.
        CHECK <lfs_temp_tab> IS ASSIGNED.
        CREATE DATA ls_out LIKE LINE OF <lfs_temp_tab>.
        lo_struct ?= cl_abap_structdescr=>describe_by_data_ref(
          EXPORTING
            p_data_ref = ls_out ). " Reference to described data object
        IF sy-subrc = 0.
          CALL METHOD cl_abap_tabledescr=>get
            EXPORTING
              p_line_type = lo_struct                   " Row Type
            RECEIVING
              p_result    = lo_table.                   " Result Type
        ENDIF.
        ls_xlcomponents-name = lv_table.
        ls_xlcomponents-type = lo_table.
        APPEND ls_xlcomponents TO lt_xlcomponents.
        CLEAR ls_xlcomponents.
      ENDIF.
      READ TABLE lt_template WITH KEY usmd_entity = 'CLASSASGN' TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        READ TABLE lt_template WITH KEY usmd_entity = 'VALUATION' TRANSPORTING NO FIELDS.
        IF sy-subrc NE 0.
          lv_table = 'GT_VALUATION'.
          UNASSIGN <lfs_temp_tab>.
          ASSIGN yz_clas_mdg_mm_data_process=>(lv_table) TO <lfs_temp_tab>.
          CHECK <lfs_temp_tab> IS ASSIGNED.
          CREATE DATA ls_out LIKE LINE OF <lfs_temp_tab>.
          lo_struct ?= cl_abap_structdescr=>describe_by_data_ref(
            EXPORTING
              p_data_ref = ls_out ). " Reference to described data object
          IF sy-subrc = 0.
            CALL METHOD cl_abap_tabledescr=>get
              EXPORTING
                p_line_type = lo_struct                   " Row Type
              RECEIVING
                p_result    = lo_table.                   " Result Type
          ENDIF.
          ls_xlcomponents-name = lv_table.
          ls_xlcomponents-type = lo_table.
          APPEND ls_xlcomponents TO lt_xlcomponents.
          CLEAR ls_xlcomponents.
        ENDIF.
      ENDIF.
*      read table lt_template with key usmd_entity = 'CLASSASGN' transporting no fields.
*      if sy-subrc = 0.
      lv_table = 'GT_PURCHTXT'.
      UNASSIGN <lfs_temp_tab>.
      ASSIGN yz_clas_mdg_mm_data_process=>(lv_table) TO <lfs_temp_tab>.
      IF <lfs_temp_tab> IS ASSIGNED.
        CREATE DATA ls_out LIKE LINE OF <lfs_temp_tab>.
        lo_struct ?= cl_abap_structdescr=>describe_by_data_ref(
          EXPORTING
            p_data_ref = ls_out ). " Reference to described data object
        IF sy-subrc = 0.
          CALL METHOD cl_abap_tabledescr=>get
            EXPORTING
              p_line_type = lo_struct                   " Row Type
            RECEIVING
              p_result    = lo_table.                   " Result Type
        ENDIF.
        ls_xlcomponents-name = lv_table.
        ls_xlcomponents-type = lo_table.
        APPEND ls_xlcomponents TO lt_xlcomponents.
        CLEAR ls_xlcomponents.
      ENDIF.
*      endif.

      CALL METHOD cl_abap_structdescr=>create
        EXPORTING
          p_components = lt_xlcomponents
        RECEIVING
          p_result     = DATA(lo_ref_xl).

      CALL METHOD cl_abap_tabledescr=>create
        EXPORTING
          p_line_type = lo_ref_xl
        RECEIVING
          p_result    = DATA(lo_table_xl).

      CREATE DATA lt_out TYPE HANDLE lo_ref_xl."lo_table_xl.
      ASSIGN lt_out->* TO FIELD-SYMBOL(<lfs_cr_data>).
      """End of internal table creation
      """Start of Data Mapping

*      assign component '_01' of structure <lfs_data_full> to <lfs_entities>.
*      loop at <lfs_entities> assigning <lfs_entity>.
*        assign component 'MATERIAL' of structure <lfs_entity> to <lfs_field_s>.
*        if not line_exists( lt_matnr[ old_matnr = <lfs_field_s> ] ).
*          call function 'NUMBER_GET_NEXT'
*            exporting
*              nr_range_nr             = '01'
*              object                  = 'MDG_BS_MAT'
**             QUANTITY                = '1'
**             SUBOBJECT               = ' '
**             TOYEAR                  = '0000'
**             IGNORE_BUFFER           = ' '
*            importing
*              number                  = ls_matnr-new_matnr
**             QUANTITY                =
**             RETURNCODE              =
*            exceptions
*              interval_not_found      = 1
*              number_range_not_intern = 2
*              object_not_found        = 3
*              quantity_is_0           = 4
*              quantity_is_not_1       = 5
*              interval_overflow       = 6
*              buffer_overflow         = 7
*              others                  = 8.
*          if sy-subrc = 0.
*            ls_matnr-old_matnr = <lfs_field_s>.
*            shift ls_matnr-new_matnr left deleting leading '0'.
*            ls_matnr-new_matnr = '$' && ls_matnr-new_matnr.
*            append ls_matnr to lt_matnr.
*          endif.
*        endif.
*      endloop.

      LOOP AT lt_template ASSIGNING <lfs_template> WHERE usmd_entity NE 'CLASSASGN'.
        UNASSIGN: <lfs_entities>, <lfs_entity>, <lfs_table>, <lfs_struct>,
                  <lfs_field_s>,<lfs_field_d>.
        lv_table = 'GT_' && <lfs_template>-usmd_entity.
        ASSIGN COMPONENT lv_table OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
        DATA(lv_view) = '_' && <lfs_template>-view_id.
        ASSIGN COMPONENT lv_view OF STRUCTURE <lfs_data_full> TO <lfs_entities>.
        LOOP AT <lfs_entities> ASSIGNING <lfs_entity>.
          UNASSIGN <lfs_struct>.
          READ TABLE <lfs_table> ASSIGNING <lfs_struct> INDEX sy-tabix.
          IF <lfs_struct> IS ASSIGNED.
            ASSIGN COMPONENT <lfs_template>-usmd_attribute OF STRUCTURE <lfs_entity> TO <lfs_field_s>.
            ASSIGN COMPONENT <lfs_template>-usmd_attribute OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
            IF <lfs_field_s> IS ASSIGNED AND <lfs_field_d> IS ASSIGNED.
              <lfs_field_d> = <lfs_field_s>.
            ENDIF.
            IF <lfs_template>-usmd_attribute = 'MEINS' AND <lfs_field_s> = 'PC'.
              <lfs_field_d> = 'ST'.
            ENDIF.
*            if <lfs_template>-usmd_attribute = 'MATERIAL'.
*              <lfs_field_d> = value #( lt_matnr[ old_matnr = <lfs_field_s> ]-new_matnr optional ).
*            endif.
          ELSE.
            CREATE DATA ls_out LIKE LINE OF <lfs_table>.
            ASSIGN ls_out->* TO <lfs_struct>.
            IF <lfs_struct> IS ASSIGNED.
              ASSIGN COMPONENT <lfs_template>-usmd_attribute OF STRUCTURE <lfs_entity> TO <lfs_field_s>.
              ASSIGN COMPONENT <lfs_template>-usmd_attribute OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
              IF <lfs_field_s> IS ASSIGNED AND <lfs_field_d> IS ASSIGNED.
                <lfs_field_d> = <lfs_field_s>.
              ENDIF.
              IF <lfs_template>-usmd_attribute = 'MEINS' AND <lfs_field_s> = 'PC'.
                <lfs_field_d> = 'ST'.
              ENDIF.
*              if <lfs_template>-usmd_attribute = 'MATERIAL' and not line_exists( lt_matnr( old_matnr = <lfs_field_d> ) ).
*                call function 'NUMBER_GET_NEXT'
*                  exporting
*                    nr_range_nr             = '01'
*                    object                  = 'MDG_BS_MAT'
**                   QUANTITY                = '1'
**                   SUBOBJECT               = ' '
**                   TOYEAR                  = '0000'
**                   IGNORE_BUFFER           = ' '
**                 IMPORTING
*                    number                  = ls_matnr-new_matnr
**                   QUANTITY                =
**                   RETURNCODE              =
*                  exceptions
*                    interval_not_found      = 1
*                    number_range_not_intern = 2
*                    object_not_found        = 3
*                    quantity_is_0           = 4
*                    quantity_is_not_1       = 5
*                    interval_overflow       = 6
*                    buffer_overflow         = 7
*                    others                  = 8.
*                if sy-subrc = 0.
*                  ls_matnr-old_matnr = <lfs_field_d>.
*                endif.
*              endif.
*              if <lfs_template>-usmd_attribute = 'MATERIAL'.
*                <lfs_field_d> = value #( lt_matnr[ old_matnr = <lfs_field_s> ]-new_matnr optional ).
*              endif.
              INSERT <lfs_struct> INTO TABLE <lfs_table>.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDLOOP.

      UNASSIGN: <lfs_template>,<lfs_table>,<lfs_entities> .
      READ TABLE lt_template ASSIGNING <lfs_template> WITH KEY
      usmd_entity = lv_primary_entity usmd_attribute = 'TXTMI'.
      IF <lfs_template> IS ASSIGNED.
        lv_table = 'GT_MMTXT'.
        ASSIGN COMPONENT lv_table OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
        lv_view = '_' && <lfs_template>-view_id.
        ASSIGN COMPONENT lv_view OF STRUCTURE <lfs_data_full> TO <lfs_entities>.
        IF <lfs_table> IS ASSIGNED AND <lfs_entities> IS ASSIGNED.
          <lfs_table> = CORRESPONDING #( <lfs_entities> ).
        ENDIF.
      ENDIF.

      ASSIGN COMPONENT 'GT_CLASSASGN' OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
      CLEAR <lfs_table>.
      ASSIGN COMPONENT 'GT_VALUATION' OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
      CLEAR <lfs_table>.

      LOOP AT lt_template INTO DATA(ls_template) WHERE usmd_entity = 'CLASSASGN'.
        lv_view = '_' && ls_template-view_id.
        DATA(lv_txtview) = lv_view.
        ASSIGN COMPONENT lv_view OF STRUCTURE <lfs_data_full> TO <lfs_entities>.
        lv_table = COND #( WHEN ls_template-usmd_attribute = 'CLASS' THEN 'GT_CLASSASGN' ELSE 'GT_VALUATION' ).
        ASSIGN COMPONENT lv_table OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
        LOOP AT <lfs_entities> ASSIGNING <lfs_entity>.
          UNASSIGN <lfs_struct>.
          READ TABLE <lfs_table> ASSIGNING <lfs_struct> INDEX sy-tabix.
          IF sy-subrc = 0 AND <lfs_struct> IS ASSIGNED.
            ASSIGN COMPONENT ls_template-usmd_attribute OF STRUCTURE <lfs_entity> TO <lfs_field_s>.
            CHECK <lfs_field_s> IS ASSIGNED.
            IF ls_template-usmd_attribute = 'ATNAM' .
              ASSIGN COMPONENT 'CHARID' OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
              CHECK <lfs_field_s> IS ASSIGNED.
              CALL FUNCTION 'CONVERSION_EXIT_ATINN_INPUT'
                EXPORTING
                  input  = <lfs_field_s>
                IMPORTING
                  output = <lfs_field_s>.
            ELSE.
              ASSIGN COMPONENT 'ATNAM' OF STRUCTURE <lfs_entity> TO <lfs_atnam>.
              IF ls_template-usmd_attribute = 'ATWRT' AND <lfs_atnam> IS ASSIGNED.
                SELECT SINGLE atfor FROM cabn WHERE atnam = @<lfs_atnam> INTO @DATA(lv_ATFOR).
                IF lv_ATFOR = 'NUM'.
                  ASSIGN COMPONENT 'ATFLV' OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
                ELSE.
                  ASSIGN COMPONENT 'ATWRT' OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
                ENDIF.
              ELSE.
                ASSIGN COMPONENT ls_template-usmd_attribute OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
              ENDIF.
            ENDIF.
            IF <lfs_field_s> IS ASSIGNED AND <lfs_field_d> IS ASSIGNED.
              <lfs_field_d> = <lfs_field_s>.
            ENDIF.
          ELSE.
            CREATE DATA ls_out LIKE LINE OF <lfs_table>.
            ASSIGN ls_out->* TO <lfs_struct>.
            IF <lfs_struct> IS ASSIGNED.
              ASSIGN COMPONENT ls_template-usmd_attribute OF STRUCTURE <lfs_entity> TO <lfs_field_s>.
              CHECK <lfs_field_s> IS ASSIGNED.
              IF ls_template-usmd_attribute = 'ATNAM' .
                ASSIGN COMPONENT 'CHARID' OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
                CHECK <lfs_field_s> IS ASSIGNED.
                CALL FUNCTION 'CONVERSION_EXIT_ATINN_INPUT'
                  EXPORTING
                    input  = <lfs_field_s>
                  IMPORTING
                    output = <lfs_field_s>.
              ELSE.
                ASSIGN COMPONENT 'ATNAM' OF STRUCTURE <lfs_entity> TO <lfs_atnam>.
                IF ls_template-usmd_attribute = 'ATWRT' AND <lfs_atnam> IS ASSIGNED.
                  SELECT SINGLE atfor FROM cabn WHERE atnam = @<lfs_atnam> INTO @lv_ATFOR.
                  IF lv_ATFOR = 'NUM'.
                    ASSIGN COMPONENT 'ATFLV' OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
                  ELSE.
                    ASSIGN COMPONENT 'ATWRT' OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
                  ENDIF.
                ELSE.
                  ASSIGN COMPONENT ls_template-usmd_attribute OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
                ENDIF.
*                assign component ls_template-usmd_attribute of structure <lfs_struct> to <lfs_field_d>.
              ENDIF.

              IF <lfs_field_s> IS ASSIGNED AND <lfs_field_d> IS ASSIGNED.
                <lfs_field_d> = <lfs_field_s>.
              ENDIF.
              IF <lfs_struct> IS ASSIGNED.
                ASSIGN COMPONENT 'CLASSTYPE' OF STRUCTURE <lfs_struct> TO <lfs_field_d>.
                CHECK <lfs_field_d> IS ASSIGNED.
                <lfs_field_d> = '001'.
              ENDIF.
              UNASSIGN <lfs_field_d1>.
              ASSIGN COMPONENT 'VALCNT' OF STRUCTURE <lfs_struct> TO <lfs_field_d1>.
              IF <lfs_field_d1> IS ASSIGNED.
                <lfs_field_d1> = '001'.
              ENDIF.
              UNASSIGN <lfs_field_d2>.
              ASSIGN COMPONENT 'ATCOD' OF STRUCTURE <lfs_struct> TO <lfs_field_d2>.
              IF <lfs_field_d2> IS ASSIGNED.
                <lfs_field_d2> = 1.
              ENDIF.

              INSERT <lfs_struct> INTO TABLE <lfs_table>.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDLOOP.

      ASSIGN COMPONENT 'GT_VALUATION' OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
      ASSIGN COMPONENT 'GT_CLASSASGN' OF STRUCTURE <lfs_cr_data> TO <lfs_entities>..
      IF <lfs_table> IS ASSIGNED AND <lfs_entities> IS ASSIGNED.
*        <lfs_entities> = CORRESPONDING #( <lfs_table> EXCEPT clas ).
*        lt_material = CORRESPONDING #( <lfs_table> ).
*        <lfs_entities> = CORRESPONDING #( lt_material ).
        LOOP AT <lfs_table> ASSIGNING <lfs_struct>.
          READ TABLE <lfs_entities> ASSIGNING <lfs_entity> INDEX sy-tabix.
          IF <lfs_entity> IS ASSIGNED.
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_struct> TO <lfs_field_s>.
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_entity> TO <lfs_field_d>.
            CHECK <lfs_field_s> IS ASSIGNED AND <lfs_field_d> IS ASSIGNED.
            <lfs_field_d> = <lfs_field_s> .
          ENDIF.
        ENDLOOP.
      ENDIF.

      """End of Data Mapping
      """Set Data to GET SET class.

      """Creation of CR
      DATA(lo_gov_api) = cl_usmd_gov_api=>get_instance(
        iv_model_name = 'MM' ).
      DATA(lv_cr_new) = lo_gov_api->create_crequest( EXPORTING iv_crequest_type = 'ZMATCV01'  " Type of Change Request
                                                               iv_description   = 'Business Rule Validation via Excel' ). " Description (long text)
      IF 1 = 2.

        lo_gov_api->enqueue_crequest(
          EXPORTING
            iv_crequest_id = lv_cr_new                 " Change Request
*           iv_lock_mode   = 'E'              " Lock Mode
*           iv_scope       = '1'              " Lock Behavior
        ).

      ENDIF.

      ASSIGN COMPONENT 'GT_MATERIAL' OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
      IF <lfs_table> IS ASSIGNED.
        LOOP AT <lfs_table> ASSIGNING <lfs_struct>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_struct> TO <lfs_key>.
          IF <lfs_key> IS ASSIGNED.
            ls_matnr-old_matnr = <lfs_key>.
            lo_gov_api->create_entity_tmp_key(
              EXPORTING
                iv_entity = lv_primary_entity               " Entity Type
*               is_key    = <lfs_key>
              IMPORTING
                es_key    = <lfs_key>              " Entity Key
            ).
            ls_matnr-new_matnr = <lfs_key>.
            APPEND ls_matnr TO lt_matnr.
            CLEAR ls_matnr.
          ENDIF.
        ENDLOOP.
        lo_gov_api->enqueue_entity(
          EXPORTING
            iv_crequest_id = lv_cr_new      " Change Request
            iv_entity_name = lv_primary_entity "<lfs_template>-usmd_entity                 " Entity Type of Storage and Use Type 1
            it_data        = <lfs_table>                 " Must Contain Entity Key
*          importing
*           et_locked      =                  " Blocked Entities
        ).
        lo_gov_api->write_entity(
          EXPORTING
            iv_crequest_id = lv_cr_new      " Change Request
            iv_entity_name = <lfs_template>-usmd_entity                 " Entity Type of Storage and Use Type 1
            it_data        = <lfs_table>                 " Must Contain Entity Key
*           it_attribute   =                  " List of Field Names with Changed Data
        ).
      ENDIF.

      LOOP AT lt_template_tmp ASSIGNING <lfs_template> WHERE usmd_entity NE 'MATERIAL'
        AND usmd_entity NE 'VALUATION'.
        lv_table = 'GT_' && <lfs_template>-usmd_entity.
        UNASSIGN <lfs_table>.
        ASSIGN COMPONENT lv_table OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
        CHECK <lfs_table> IS ASSIGNED AND <lfs_table> IS NOT INITIAL.
        LOOP AT <lfs_table> ASSIGNING <lfs_struct>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_struct> TO <lfs_key>.
          CHECK <lfs_key> IS ASSIGNED.
          <lfs_key> = VALUE #( lt_matnr[ old_matnr = <lfs_key> ]-new_matnr OPTIONAL ).
        ENDLOOP.

***        field-symbols: <lfs_key> type any.
***        data : lv_val type char4.
***
***        if <lfs_template>-usmd_entity = 'MATERIAL'.
***          read table <lfs_table> assigning <lfs_struct> index 1.
***          if <lfs_struct> is assigned .
***            assign component 'MATERIAL' of structure <lfs_struct> to <lfs_key>.
***            if <lfs_key> is assigned.
***              lo_gov_api->create_entity_tmp_key(
***                exporting
***                  iv_entity = lv_primary_entity               " Entity Type
***                  is_key    = <lfs_key>
***                importing
***                  es_key    = <lfs_key>              " Entity Key
***              ).
***            endif.
***          endif.
***        endif.


        lo_gov_api->enqueue_entity(
          EXPORTING
            iv_crequest_id = lv_cr_new      " Change Request
            iv_entity_name = lv_primary_entity "<lfs_template>-usmd_entity                 " Entity Type of Storage and Use Type 1
            it_data        = <lfs_table>                 " Must Contain Entity Key
*          importing
*           et_locked      =                  " Blocked Entities
        ).
        lo_gov_api->write_entity(
          EXPORTING
            iv_crequest_id = lv_cr_new      " Change Request
            iv_entity_name = <lfs_template>-usmd_entity                 " Entity Type of Storage and Use Type 1
            it_data        = <lfs_table>                 " Must Contain Entity Key
*           it_attribute   =                  " List of Field Names with Changed Data
        ).
      ENDLOOP.

      READ TABLE lt_template ASSIGNING <lfs_template> WITH KEY
      usmd_entity = lv_primary_entity usmd_attribute = 'TXTMI'.
      IF sy-subrc = 0.
        lv_table = 'GT_MMTXT'.
        ASSIGN COMPONENT lv_table OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
        CHECK <lfs_table> IS ASSIGNED AND <lfs_table> IS NOT INITIAL.
        LOOP AT <lfs_table> ASSIGNING <lfs_struct>.
          ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_struct> TO <lfs_key>.
          CHECK <lfs_key> IS ASSIGNED.
          <lfs_key> = VALUE #( lt_matnr[ old_matnr = <lfs_key> ]-new_matnr OPTIONAL ).
        ENDLOOP.
        lo_gov_api->enqueue_entity(
          EXPORTING
            iv_crequest_id = lv_cr_new      " Change Request
            iv_entity_name = lv_primary_entity                 " Entity Type of Storage and Use Type 1
            it_data        = <lfs_table>                 " Must Contain Entity Key
        ).
        lo_gov_api->write_entity(
          EXPORTING
            iv_crequest_id = lv_cr_new      " Change Request
            iv_entity_name = <lfs_template>-usmd_entity                 " Entity Type of Storage and Use Type 1
            it_data        = <lfs_table>                 " Must Contain Entity Key
        ).
      ENDIF.

      READ TABLE lt_template ASSIGNING <lfs_template> WITH KEY
      usmd_entity = 'CLASSASGN'.
      IF sy-subrc = 0.
        lv_table = 'GT_VALUATION'.
        ASSIGN COMPONENT lv_table OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
        IF <lfs_table> IS ASSIGNED AND <lfs_table> IS NOT INITIAL.
          DATA(lv_matnr) = '$12345'.
          LOOP AT <lfs_table> ASSIGNING <lfs_struct>.
            CLEAR: lv_atnam.
            DATA(lv_index) = sy-tabix.
            ASSIGN COMPONENT 'MATERIAL' OF STRUCTURE <lfs_struct> TO <lfs_key>.
            CHECK <lfs_key> IS ASSIGNED.
            <lfs_key> = VALUE #( lt_matnr[ old_matnr = <lfs_key> ]-new_matnr OPTIONAL ).
****start of changes by Faheem
            ASSIGN COMPONENT lv_txtview OF STRUCTURE <lfs_data_full> TO <lfs_entity_purch>.
            IF <lfs_entity_purch> IS ASSIGNED.
              READ TABLE <lfs_entity_purch> ASSIGNING FIELD-SYMBOL(<lfs_purtxt>) INDEX ( lv_index ).
              IF sy-subrc EQ 0 AND <lfs_purtxt> IS ASSIGNED.
                ASSIGN COMPONENT 'ATNAM' OF STRUCTURE <lfs_purtxt> TO FIELD-SYMBOL(<ls_atnam>).
                IF <ls_atnam> IS ASSIGNED AND <ls_atnam> IS NOT INITIAL.
                  lv_atnam = <ls_atnam>.
                  ASSIGN COMPONENT 'LANGU' OF STRUCTURE <lfs_purtxt> TO FIELD-SYMBOL(<ls_langu>).
                  IF <ls_langu> IS ASSIGNED AND <ls_langu> IS NOT INITIAL.
                    lv_langu = <ls_langu>.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
            IF lv_matnr NE <lfs_key> OR lv_langtxt NE lv_langu.
***End of changes by Faheem
              ASSIGN COMPONENT 'GT_PURCHTXT' OF STRUCTURE <lfs_cr_data> TO <lfs_entities>.
              IF <lfs_entities> IS ASSIGNED.
                APPEND INITIAL LINE TO <lfs_entities> ASSIGNING <lfs_purchtxt>.
                lv_matnr = <lfs_key>.
              ENDIF.
            ENDIF.
            lv_langtxt = lv_langu.  "Added by Faheem
            IF <lfs_purchtxt> IS ASSIGNED.
              ls_valuation = CORRESPONDING #( <lfs_struct> ).
              <lfs_purchtxt>-material = <lfs_key>.
***Start of changes by Faheem
              IF lv_atnam EQ ls_valuation-charid.
                <lfs_purchtxt>-langucode = lv_langu.
              ENDIF.
***End of changes by Faheem
              "Commented by Faheem <lfs_purchtxt>-langucode = 'E'.
              IF <lfs_purchtxt>-txtpurch IS NOT INITIAL.
                "   <lfs_purchtxt>-txtpurch = <lfs_purchtxt>-txtpurch && ','.
                CONCATENATE <lfs_purchtxt>-txtpurch cl_abap_char_utilities=>newline INTO <lfs_purchtxt>-txtpurch.
              ENDIF.
              CALL FUNCTION 'CONVERSION_EXIT_ATINN_OUTPUT'
                EXPORTING
                  input  = ls_valuation-charid
                IMPORTING
                  output = lv_atnam.

              SELECT SINGLE atbez FROM cabnt INTO @DATA(lv_atdes)
                WHERE atinn = @ls_valuation-charid AND spras = @<lfs_purchtxt>-langucode.
              "Commented by Faheem   SELECT SINGLE atbez FROM cabnt INTO @DATA(lv_atdes) WHERE atinn = @ls_valuation-charid AND spras = 'E'.
              IF ls_valuation-atwrt IS NOT INITIAL.
                <lfs_purchtxt>-txtpurch = <lfs_purchtxt>-txtpurch && lv_atdes && ':' && ls_valuation-atwrt.
              ELSE.
                <lfs_purchtxt>-txtpurch = <lfs_purchtxt>-txtpurch && lv_atdes && ':' && ls_valuation-atflv.
              ENDIF.

            ENDIF.
          ENDLOOP.
          lo_gov_api->enqueue_entity(
            EXPORTING
              iv_crequest_id = lv_cr_new      " Change Request
              iv_entity_name = lv_primary_entity                " Entity Type of Storage and Use Type 1
              it_data        = <lfs_table>                 " Must Contain Entity Key
          ).
          lo_gov_api->write_entity(
            EXPORTING
              iv_crequest_id = lv_cr_new      " Change Request
              iv_entity_name = 'VALUATION'                 " Entity Type of Storage and Use Type 1
              it_data        = <lfs_table>                 " Must Contain Entity Key
          ).
        ENDIF.
      ENDIF.

      lv_table = 'GT_PURCHTXT'.
      ASSIGN COMPONENT lv_table OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
      IF <lfs_table> IS ASSIGNED AND <lfs_table> IS NOT INITIAL.
*        loop at <lfs_table> assigning <lfs_struct>.
*          assign component 'MATERIAL' of structure <lfs_struct> to <lfs_key>.
*          check <lfs_key> is assigned.
*          <lfs_key> = value #( lt_matnr[ old_matnr = <lfs_key> ]-new_matnr optional ).
*        endloop.
        lo_gov_api->enqueue_entity(
          EXPORTING
            iv_crequest_id = lv_cr_new      " Change Request
            iv_entity_name = lv_primary_entity                " Entity Type of Storage and Use Type 1
            it_data        = <lfs_table>                 " Must Contain Entity Key
        ).
        lo_gov_api->write_entity(
          EXPORTING
            iv_crequest_id = lv_cr_new      " Change Request
            iv_entity_name = 'PURCHTXT'                 " Entity Type of Storage and Use Type 1
            it_data        = <lfs_table>                 " Must Contain Entity Key
        ).
      ENDIF.

      lo_gov_api->check_complete_data(
        EXPORTING
          iv_crequest_id     = lv_cr_new                 " Change Request
        IMPORTING
          eo_interruption    = DATA(lo_interruption)                 " Interruption of Check
          eo_delta_reference = DATA(lo_delta_ref)                 " Read-Interface to Data Buffer
      ).
      lo_gov_api->save(
*        i_mode = if_usmd_ui_services=>gc_save_mode_draft
      ).
      lo_gov_api->dequeue_entity_all( ).
      lo_gov_api->dequeue_crequest(
        EXPORTING
          iv_crequest_id = lv_cr_new ).
      COMMIT WORK AND WAIT.
      lo_gov_api->start_workflow( iv_crequest_id = lv_cr_new ).
      APPEND VALUE #( msgid = '00' msgty = 'S' msgno = '001' msgv1 = 'Change Request `' && space && lv_cr_new && space && '` Created'  )
      TO lt_messages.
    CATCH cx_usmd_gov_api_core_error INTO DATA(lx_api2). " CX_USMD_CORE_DYNAMIC_CHECK
      lt_messages = lx_api2->mt_messages.
    CATCH cx_sy_table_creation INTO DATA(lo_ex).
    CATCH BEFORE UNWIND cx_usmd_gov_api_entity_lock INTO DATA(lx_lock). " RESUMABLE Error While Blocking an Entity
      APPEND LINES OF lx_lock->mt_messages TO lt_messages.
    CATCH cx_usmd_gov_api INTO DATA(lx_api).            " General Processing Error GOV_API
      APPEND LINES OF lx_api->mt_messages TO lt_messages.
  ENDTRY.

  lv_table = 'GT_' && lv_primary_entity.
  ASSIGN COMPONENT lv_table OF STRUCTURE <lfs_cr_data> TO <lfs_table>.
  IF <lfs_table> IS ASSIGNED.
    LOOP AT <lfs_table> ASSIGNING <lfs_struct>.
      ASSIGN COMPONENT lv_key_attrib OF STRUCTURE <lfs_struct> TO <lfs_field_s>.
      CHECK <lfs_field_s> IS ASSIGNED.
      lv_args = sy-mandt && '*' && <lfs_field_s> && '*'.
      CALL FUNCTION 'ENQUEUE_READ'
        EXPORTING
          garg                  = lv_args
        TABLES
          enq                   = lt_enq_tmp
        EXCEPTIONS
          communication_failure = 1
          system_failure        = 2
          OTHERS                = 3.
      IF sy-subrc = 0.
        lt_enq = VALUE #( BASE lt_enq ( LINES OF  lt_enq_tmp  ) ).
      ENDIF.
    ENDLOOP.
    IF lt_enq IS NOT INITIAL.
      CALL FUNCTION 'ENQUE_DELETE'
        TABLES
          enq = lt_enq.
    ENDIF.
  ENDIF.


  LOOP AT lt_messages INTO DATA(ls_messages).
    ls_output-type = ls_messages-msgty.
    CALL FUNCTION 'BAPI_MESSAGE_GETDETAIL'
      EXPORTING
        id         = ls_messages-msgid
        number     = ls_messages-msgno
        textformat = 'RTF'
        message_v1 = ls_messages-msgv1
        message_v2 = ls_messages-msgv2
        message_v3 = ls_messages-msgv3
        message_v4 = ls_messages-msgv4
      IMPORTING
        message    = lv_msg.

    ls_output-message = lv_msg.

    APPEND ls_output TO lt_output.
    CLEAR ls_output.
  ENDLOOP.
  ls_return-errors = lt_output.
  DATA lv_mode TYPE char1.
  /ui2/cl_json=>serialize(
    EXPORTING
      data        = ls_return         " Data to serialize
      pretty_name = lv_mode               " Pretty Print property names
    RECEIVING
      r_json      = e_output          " JSON string
  ).
ENDMETHOD.


method duplicate_check.
  types:
    begin of lty_search_class,
      entity_type         type usmd_entity,
      search_mode         type usmd_search_mode,
      search_class        type usmd_search_class,
      complex_selection   type usmd_complex_selection_sup,
      search_class_object type ref to if_usmd_search_data,
    end of lty_search_class,
    begin of lty_output,
      error type bapiret2_t,
    end of lty_output.

  data lt_search_class          type table of lty_search_class.
  data lt_search_attribute      type usmd_ts_sel.
  data lt_tab_search_attributes type tt_usmd_ts_sel.
  data lt_search_attribute_temp type usmd_ts_sel.
  data lt_return                type bapiret2_t.

  data ls_search_context        type usmd_s_search_context.
  data ls_search_attribute      type usmd_s_sel.
  data ls_return                type bapiret2.
  data ls_output                type lty_output.
  data ls_search_key            type usmd_s_value.

  data lv_cc252179_is_active    type abap_bool.


  data lr_search_data     type ref to if_usmd_search_data.
  data lo_class           type ref to cl_oo_class.

  field-symbols <lfs_data>      type standard table.
  field-symbols <lfs_struct>    type any.
  field-symbols <lfs_field>     type any.
  field-symbols <lfs_data_full> type any.

  constants lc_classname type classname value 'CL_MDG_CC_2021_252179'.
  constants lc_method    type seocmpname value 'IS_ACTIVE'.

  deserialize_json_input(
    exporting
      i_mode           = i_mode                 " Model for Mass Process Enrichment
      i_model          = i_model                 " Data Model value for mass process enrichment
      i_scope          = i_scope                 " Scope Id for Data model
      i_tempid         = i_tempid                 " Template ID for mass process enrichment
      i_actionid       = i_actionid                 " Data element for action id
      i_use_attributes = 'X'                  " Character Field of Length 1
      i_json_input     = i_input_data
    importing
      et_data          = data(lt_data) ).

  assign lt_data->* to <lfs_data_full>.

*  get_template_from_id(
*    exporting
*      iv_model      = i_model                 " Data Model value for mass process enrichment
*      iv_scope      = i_scope                 " Scope Id for Data model
*      iv_templateid = i_tempid                 " Template ID for mass process enrichment
*    importing
*      et_template   = data(lt_templt_data) ).
  select * from yztab_templt_det into table @data(lt_templt_data)
    where usmd_model = @i_model and scope_id = @i_scope and template_id = @i_tempid
    and view_id = '01' and usmd_active = 'X'.
  if sy-subrc = 0.
    sort lt_templt_data by column_id.
  endif.

  read table lt_templt_data into data(ls_templt_det)
  with key view_id = '01' column_id = '01' is_key = 'X' included = 'X' usmd_active = 'X'.
  if sy-subrc = 0.
    data(lv_primary_entity) = ls_templt_det-usmd_entity.
    data(lv_key_attrib) = ls_templt_det-usmd_attribute.
  endif.


  call method cl_usmd_services=>entity2otc
    exporting
      i_model            = i_model
      i_entity           = lv_primary_entity
    importing
      e_object_type_code = data(lv_otc).


  if cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is not initial and
   cl_usmd_switch_check=>application_switch_ehp6( i_model ) is not initial.

    call method cl_usmd_sdq_duplicate_check=>search_mode
      exporting
        iv_model                  = i_model "io_data_model_ext->d_usmd_model    " Data Model
        iv_entity                 = lv_primary_entity "'MATERIAL' "iv_entity    " Entity Type
      importing
        ev_search_mode            = data(lv_search_mode)
        ev_low_threshold          = data(lv_low_threshold)
        ev_high_threshold         = data(lv_high_threshold)
        ev_duplicate_check_exists = data(lv_duplicate_check_exists)
        ev_match_profile_id       = data(lv_match_profile_id)
        ev_search_help            = data(lv_search_help).

  elseif cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is initial or
   cl_usmd_switch_check=>application_switch_ehp6( i_model ) is initial.

    call method cl_usmd_sdq_duplicate_check=>search_mode
      exporting
        iv_model                  = i_model "io_data_model_ext->d_usmd_model    " Data Model
        iv_entity                 = lv_primary_entity "iv_entity    " Entity Type
      importing
        ev_search_mode            = lv_search_mode
        ev_low_threshold          = lv_low_threshold
        ev_high_threshold         = lv_high_threshold
        ev_duplicate_check_exists = lv_duplicate_check_exists.

  endif.

  if lv_duplicate_check_exists = abap_true.
    if lv_search_mode is not initial.
      if cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is not initial and
         cl_usmd_switch_check=>application_switch_ehp6( i_model ) is not initial.

        read table lt_search_class into data(ls_search_class) with key search_mode = lv_search_mode
                                                                 entity_type = lv_primary_entity.
        if sy-subrc ne 0.

          call method cl_usmd_entity_search_gui_wd=>get_searchclass
            exporting
              id_search_mode       = lv_search_mode
            importing
              ed_searchclass       = data(lv_search_class)
              ef_complex_selection = data(lf_complex_selection).

          ls_search_class-entity_type       = lv_primary_entity.
          ls_search_class-search_mode       = lv_search_mode.
          ls_search_class-search_class      = lv_search_class.
          ls_search_class-complex_selection = lf_complex_selection.
          append ls_search_class to lt_search_class.
        else.
          lv_search_class      = ls_search_class-search_class.
          lf_complex_selection = ls_search_class-complex_selection.
        endif.
        clear: ls_search_class.

      elseif cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is initial or
             cl_usmd_switch_check=>application_switch_ehp6( i_model ) is initial.
        " if the switch is not active, call the old code
        read table lt_search_class into ls_search_class with key search_mode = lv_search_mode
                                                                 entity_type = lv_primary_entity.
        if sy-subrc is not initial.
          call method cl_usmd_entity_search_gui_wd=>get_searchclass
            exporting
              id_search_mode = lv_search_mode
            importing
              ed_searchclass = lv_search_class.

          ls_search_class-entity_type  = lv_primary_entity  .
          ls_search_class-search_mode  = lv_search_mode.
          ls_search_class-search_class = lv_search_class.
          append ls_search_class to lt_search_class.
        else.
          lv_search_class      = ls_search_class-search_class.
        endif.
        clear: ls_search_class.
      endif.
    else.
      " else if search mode is empty, use DB search by default
      lv_search_class = 'CL_USMD_SEARCH_DATA_DB'. "gc_db_search_class . "'CL_USMD_SEARCH_DATA_DB' .
      if cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is not initial and
         cl_usmd_switch_check=>application_switch_ehp6( i_model ) is not initial.
        lf_complex_selection = abap_false.
      endif.
    endif.
    " instantiate the search class
    if lv_search_class is not initial.
      read table lt_search_class assigning field-symbol(<ls_search_class>) with key search_mode = lv_search_mode
                                                                      entity_type = lv_primary_entity.
      if sy-subrc eq 0.
        if <ls_search_class>-search_class_object is initial.
          create object lr_search_data type (lv_search_class).
          <ls_search_class>-search_class_object = lr_search_data.
        else.
          lr_search_data = <ls_search_class>-search_class_object.
        endif.
      endif.
      unassign: <ls_search_class>.
    else.
      return.
    endif.

    try.
        lo_class ?= cl_oo_class=>get_instance( lc_classname ).
        if lo_class is bound.
          call method (lc_classname)=>(lc_method) receiving rv_active = lv_cc252179_is_active.
        endif.
      catch cx_class_not_existent.
        "Do Nothing
    endtry.
    unassign <lfs_data>.
        assign component '_01' of structure <lfs_data_full> to <lfs_data>.
    loop at <lfs_data> assigning <lfs_struct>.
      if lr_search_data is bound.
        " Populate the search context
        call method cl_usmd_model_ext=>get_instance
          exporting
            i_usmd_model = i_model
          importing
            eo_instance  = data(lo_model_ext).

        ls_search_context-entity_main   = lv_primary_entity.
        ls_search_context-o_model       = lo_model_ext.
        ls_search_context-search_mode   = lv_search_mode.
        ls_search_context-update_mode   = 'I'.
        ls_search_context-search_help   = lv_search_help.
        ls_search_context-max_num_records = 10.
        ls_search_context-threshold     = lv_low_threshold.

        call method lr_search_data->get_dup_check_attr
          exporting
            is_search_context = ls_search_context
          importing
            et_dup_check_attr = data(lt_dup_check_attr)
            et_message        = data(lt_message).

        if ( lv_otc = if_mdg_sdq_const=>otc_material ).
          call method get_class_based_search_attri
            exporting
              io_data_model_ext         = lo_model_ext    " MDM Data Model for Access from Non-SAP-Standard Code
              it_dup_check_attr         = lt_dup_check_attr    " Attributes That Are Relevant for Duplicate Check
              it_search_key             = lt_search_attribute
              iv_search_mode            = lv_search_mode    " Type of Search
            importing
              et_search_attributes_addr = data(lt_search_attribute_temp1). "lt_search_attribute_temp.  " note 2073100
        endif.

**      loop at <lfs_data> into <lfs_struct>.
**        loop at lt_dup_check_attr into data(ls_dup_check_attr).
**          ls_search_attribute-fieldname = ls_dup_check_attr-attr_res.
**          loop at lt_templt_data into ls_templt_det where usmd_entity = ls_dup_check_attr-usmd_entity
**            and usmd_attribute = ls_dup_check_attr-attr_res.
**            assign component ls_templt_det-usmd_attribute of structure <lfs_struct> to <lfs_field>.
**            check <lfs_field> is assigned.
**            if <lfs_field> is not initial.
**              ls_search_attribute-sign      = usmd0_cs_ra-sign_i. "'I'.
**              ls_search_attribute-option    = usmd0_cs_ra-option_eq."'EQ'.
**              ls_search_attribute-low       = <lfs_field>.
**              condense ls_search_attribute-low.
**              insert ls_search_attribute into table lt_search_attribute_temp.
**            endif.
**          endloop.
**        endloop.
**      endloop.


        assign component lv_key_attrib of structure <lfs_struct> to <lfs_field>.
        if <lfs_field> is assigned.
          ls_search_key-fieldname = lv_key_attrib.
          ls_search_key-value = <lfs_field>.
        endif.
        loop at lt_dup_check_attr into data(ls_dup_check_attr).
          unassign <lfs_field>.
          assign component ls_dup_check_attr-attr_res of structure <lfs_struct> to <lfs_field>.
          check <lfs_field> is assigned and <lfs_field> is not initial.
          ls_search_attribute-fieldname = ls_dup_check_attr-attr_res.
          ls_search_attribute-sign      = usmd0_cs_ra-sign_i. "'I'.
          ls_search_attribute-option    = usmd0_cs_ra-option_eq."'EQ'.
          ls_search_attribute-low       = <lfs_field>.
          condense ls_search_attribute-low.
          insert ls_search_attribute into table lt_search_attribute_temp.
        endloop.


        if lt_search_attribute_temp is not initial.
          lt_search_attribute = lt_search_attribute_temp.
          insert lt_search_attribute into table lt_tab_search_attributes.
        endif.

        " check if the EHP6 switch is not active then the old code will work fine carrying a single type 4 entity( i.e type 4 entity of type 1:N)
        if cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is initial or
           cl_usmd_switch_check=>application_switch_ehp6( i_model ) is initial.
          " if there are no error messages and if attributes are existing, then call the execute method of if_usmd_search_data
          if lt_search_attribute is not initial.
            " if instance is bound
            if lr_search_data is bound.
              clear: lt_message.
              " call search class for duplicate check
              call method lr_search_data->execute
                exporting
                  is_search_context   = ls_search_context
                  if_fuzzy_search     = abap_true
                  it_search_attribute = lt_search_attribute
                importing
                  et_data             = data(lt_duplicates)
                  et_message          = lt_message.
              " Check for error messages, if any exit from that point
            endif.
          endif.
          " else if the EHP6 code is active then then new code will work, able to support multiple type 4 entities of cardinality 1:N.
        elseif cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is not initial and
             cl_usmd_switch_check=>application_switch_ehp6( i_model ) is not initial.
          data(lr_context) = cl_usmd_app_context=>get_context( ).

          if lr_context is bound.
            lr_context->get_attributes(
              importing
                ev_crequest_type = data(lv_crequest_type)    " Type of Change Request
                ev_crequest_step = data(lv_crequest_step)    " Workflow Step Number
            ).
          endif.

          if lv_crequest_type is not initial and lv_crequest_step is not initial.
            try.
                call method cl_usmd_dq_access_validation=>read_config_check
                  exporting
                    iv_crequest_type = lv_crequest_type
                    iv_crequest_step = lv_crequest_step
                  importing
                    et_checktype     = data(lt_checktype).
              catch cx_dqs_db_not_found .
            endtry.

            read table lt_checktype into data(ls_checktype) with table key check_type = '02'.
            if sy-subrc is initial and ls_checktype is not initial.
              data(lv_dc_val_config) = ls_checktype-execution.
            endif.
          endif.
* Duplicate check functionality should only work for active area recoreds, therefore we need to add the
* USMD_ACTIVE = 1 in the lt_tab_search_attribute table.
          loop at lt_tab_search_attributes into lt_search_attribute.
            ls_search_attribute-fieldname = if_mdg_sdq_const=>active_field.
            ls_search_attribute-sign      = usmd0_cs_ra-sign_i. "'I'.
            ls_search_attribute-option    = usmd0_cs_ra-option_eq.  "'EQ'.
            ls_search_attribute-low       = if_mdg_sdq_const=>active_flag.
            insert ls_search_attribute into table lt_search_attribute.
            modify lt_tab_search_attributes from lt_search_attribute.
            refresh lt_search_attribute.
          endloop.

*       This piece of codeblock required to determine only active area records.
          ls_search_attribute-fieldname = if_mdg_sdq_const=>active_field.
          ls_search_attribute-sign      = usmd0_cs_ra-sign_i. "'I'.
          ls_search_attribute-option    = usmd0_cs_ra-option_eq.  "'EQ'.
          ls_search_attribute-low       = if_mdg_sdq_const=>active_flag.
          insert ls_search_attribute into table lt_search_attribute.


          " if there are no error messages and if attributes are existing, then call the execute method of if_usmd_search_data
          if lt_tab_search_attributes is not initial.
            " First check the buffer, if data is already buffered then read from the buffer, else fetch the data once again
            if lr_search_data is bound.
              if lv_otc = if_mdg_sdq_const=>otc_material and ls_search_context-search_mode eq 'ES'.
                lf_complex_selection = abap_true.
              endif.
              if lf_complex_selection is initial. " flag to check if complex selection is available
                loop at lt_tab_search_attributes into lt_search_attribute.
                  clear: lt_data,lt_message.
                  call method lr_search_data->execute
                    exporting
                      is_search_context   = ls_search_context
                      if_fuzzy_search     = abap_true
                      it_search_attribute = lt_search_attribute
                    importing
                      et_data             = lt_duplicates
                      et_message          = lt_message.
                endloop.

              elseif lf_complex_selection = abap_true.
                clear: lt_message.
                " call search class for duplicate check
                call method lr_search_data->execute
                  exporting
                    is_search_context       = ls_search_context
                    if_fuzzy_search         = abap_true
*                   id_search_string        =
                    it_search_attribute     = lt_search_attribute
                    it_tab_search_attribute = lt_tab_search_attributes
                  importing
                    et_data                 = lt_duplicates
                    et_message              = lt_message.
              endif.
              if lt_duplicates is not initial.
                unassign <lfs_field>.
                assign component ls_templt_det-usmd_attribute of structure <lfs_struct> to <lfs_field>.
                check <lfs_field> is assigned.
                ls_return-type = 'E'.
                ls_return-message = |Material | & |{ ls_search_key-value }| & | has potential duplicates|.
                append ls_return to lt_return.
                clear ls_return.
              else.
                unassign <lfs_field>.
                assign component ls_templt_det-usmd_attribute of structure <lfs_struct> to <lfs_field>.
                check <lfs_field> is assigned.
                ls_return-type = 'E'.
                ls_return-message = |Material | & |{ ls_search_key-value }| & | has no potential duplicates|.
                append ls_return to lt_return.
                clear ls_return.
              endif.
            endif.
            refresh: lt_search_attribute, lt_search_attribute_temp, lt_tab_search_attributes, lt_duplicates.
          endif.
        endif.
      endif.
    endloop.
  endif.

  ls_output-error = lt_return.

  /ui2/cl_json=>serialize(
    exporting
      data        = ls_output         " Data to serialize
      pretty_name = 'X'               " Pretty Print property names
    receiving
      r_json      = e_output          " JSON string
  ).

endmethod.


method get_class_based_search_attri.

  data lt_search_attributes_addr     type usmd_ts_sel.
  data ls_search_attribute_addr      type usmd_s_sel.
  data ls_search_attr_collective     type usmd_s_sel.
  data lt_key                        type usmd_ts_field.
  data ls_key                        type usmd_s_field.
  data ls_entity_prop                type usmd_s_entity_prop_ext.
  data ls_entity_attr_prop           type usmd_s_entity_attr_prop_ext.
  data ls_entity_cont                type usmd_s_entity_cont.
  data l_entity                      type usmd_entity.
  data ls_dup_check_attr             type usmd_s_duplicate_check_attr.
  data l_fieldname_classasgn         type usmd_fieldname.
  data l_fieldname_valuation         type usmd_fieldname.
  data lr_data_classasgn             type ref to data.
  data lr_data_line_classasgn        type ref to data.
  data lr_data_val                   type ref to data.
  data lr_data_line_val              type ref to data.
  data lt_cabn                       type standard table of cabn.
  data ls_cabn                       type  cabn.
  data ls_charid                     type clatinnrange.
  data lt_charid                     type standard table of clatinnrange.
  data lv_atflv                      type string.
  data ls_attribute                  type usmd_s_sel.
  data lt_search_attribute           type usmd_ts_sel.
  data lv_from                       type usmd_value.
  data lv_to                         type usmd_value.
  data lv_uom                        type usmd_value.
  data lv_search_value_from          type usmd_value.
  data lv_search_value_to            type usmd_value.
  data lt_search_key_temp            type usmd_ts_sel.

  field-symbols <lt_data_classasgn>    type any table.
  field-symbols <ls_data_classasgn>    type any .
  field-symbols <lt_data_val>          type any table.
  field-symbols <ls_data_val>          type any .
  field-symbols <fs_field>             type any .
  field-symbols <fs_charid>            type any .
  field-symbols <fs_atwrt>             type any .
  field-symbols <fs_atflv>             type any .
  field-symbols <fs_atawe>             type any .
  field-symbols <fs_inactclass>        type any .
  field-symbols <ls_search_attributes> type usmd_s_sel.
  field-symbols <fs_fieldname>         type usmd_s_sel-fieldname .


  check iv_search_mode = 'HA' or
        iv_search_mode = 'ES'.

* Begin: Ehp6 Duplicate Check logic for classification **********************************
  if cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is not initial and
     cl_usmd_switch_check=>application_switch_ehp6( io_data_model_ext->d_usmd_model ) is not initial.

    clear et_search_attributes_addr.
    insert lines of it_search_key      into table lt_search_key_temp.
    insert lines of lt_search_key_temp into table et_search_attributes_addr.

    if iv_search_mode = 'HA'.
**   Separate classification lines
      loop at et_search_attributes_addr into ls_search_attribute_addr
           where fieldname = 'ATWRT' or
                 fieldname = 'ATFLB' or
                 fieldname = 'ATFLV' or
                 fieldname = 'CHARID' or
                 fieldname = 'CLASSTYPE' or
                 fieldname = 'CLASS' or
                 fieldname = 'CLINT' or
                 fieldname = 'DATUV_CLA' or
                 fieldname = 'DATUV_VAL' or
                 fieldname = 'LKENZ_CLA' or
                 fieldname = 'LKENZ_VAL' or
                 fieldname = 'CHARID' or
                 fieldname = 'ATAW1' or
                 fieldname = 'ATAWE' or
                 fieldname = 'ATCOD' or
                 fieldname = 'ATFLV' or
                 fieldname = 'ATIMB' or
                 fieldname = 'ATWRT' or
                 fieldname = 'CHANGENO' or
                 fieldname = 'CLSTATUS' or
                 fieldname = 'ECOCNTR' or
                 fieldname = 'ATAUT' or
                 fieldname = 'ATSRT' or
                 fieldname = 'ATVGLART' or
                 fieldname = 'VALCNT'.

        delete et_search_attributes_addr index sy-tabix.
        insert ls_search_attribute_addr into table lt_search_attributes_addr.
      endloop.

      delete lt_search_attributes_addr
             where fieldname <> 'ATWRT' and
                   fieldname <> 'ATFLB' and
                   fieldname <> 'ATFLV' and
                   fieldname <> 'CHARID' and
                   fieldname <> 'CLASSTYPE' and
                   fieldname <> 'CLASS' and
                   fieldname <> 'CLINT' and
                   fieldname <> 'DATUV_CLA' and
                   fieldname <> 'DATUV_VAL' and
                   fieldname <> 'LKENZ_CLA' and
                   fieldname <> 'LKENZ_VAL'.
      insert lines of lt_search_attributes_addr into table et_search_attributes_addr.

    elseif ( iv_search_mode = 'ES' ).
*     Assumption: you always get non empty low entries
      loop at et_search_attributes_addr assigning <ls_search_attributes>.
        assign component 'FIELDNAME' of structure <ls_search_attributes> to <fs_fieldname>.
        if <fs_fieldname> is not assigned.
          continue.
        endif.

        case <fs_fieldname>.
          when if_mdg_sdq_const=>dm_truncated_attr-gc_charact_charid_attr. "Charid
            clear ls_attribute.
            ls_attribute = <ls_search_attributes>.
            delete et_search_attributes_addr index sy-tabix.
            ls_attribute-fieldname = 'PROPERTY_UUID'.
            insert ls_attribute into table lt_search_attribute.

          when if_mdg_sdq_const=>dm_truncated_attr-gc_charact_char_val_attr. "ATWRT
            clear ls_attribute.
            ls_attribute           = <ls_search_attributes>.
            ls_attribute-fieldname = 'VALUE_STRING'.
            insert ls_attribute into table lt_search_attribute.

          when if_mdg_sdq_const=>dm_truncated_attr-gc_charact_uom_flt_frm_attr. "AWAWE
            lv_uom = <fs_fieldname>.
            delete et_search_attributes_addr index sy-tabix.

          when if_mdg_sdq_const=>dm_truncated_attr-gc_charact_flt_frm_attr. "ATFLB To
            lv_to = <ls_search_attributes>-low.
            delete et_search_attributes_addr index sy-tabix.

          when if_mdg_sdq_const=>dm_truncated_attr-gc_charact_flt_to_attr. "ATFLV from
            lv_from = <ls_search_attributes>-low.
            delete et_search_attributes_addr index sy-tabix.

          when if_mdg_sdq_const=>dm_truncated_attr-gc_class_status_attr or
               'CLSTATUS'.
            clear ls_attribute.
            ls_attribute = <ls_search_attributes>.
            delete et_search_attributes_addr index sy-tabix.
            ls_attribute-fieldname = 'STATU'.
            insert ls_attribute into table lt_search_attribute.

          when if_mdg_sdq_const=>dm_truncated_attr-gc_class_type_attr . "Classtype
            clear ls_attribute.
            ls_attribute = <ls_search_attributes>.
            delete et_search_attributes_addr index sy-tabix.
            ls_attribute-fieldname = 'CLASS_TYPE'.
            insert ls_attribute into table lt_search_attribute.
        endcase.
      endloop.

      if lv_from is not initial.
        concatenate lv_from lv_uom into lv_search_value_from separated by space.
*       Remove Leading Spaces and trailing spaces
        lv_search_value_from = condense( val = lv_search_value_from from = `` ).
      endif.

      if lv_to is not initial.
        concatenate lv_to lv_uom into lv_search_value_to separated by space.
*       Remove Leading Spaces and trailing spaces
        lv_search_value_to = condense( val = lv_search_value_to from = `` ).
      endif.

      if lv_search_value_from is not initial or
         lv_search_value_to is not initial.
        clear ls_attribute.
        ls_attribute-fieldname  = 'SEARCH_VALUE'.
        ls_attribute-sign       = 'I'.
        ls_attribute-option     = 'EQ'.
        ls_attribute-low        = lv_search_value_from.
        ls_attribute-high       = lv_search_value_to.
        insert ls_attribute into table lt_search_attribute.
      endif.

      delete et_search_attributes_addr where
          fieldname = 'CHARID' or
          fieldname = 'ATAW1' or
          fieldname = 'ATAWE' or
          fieldname = 'ATCOD' or
          fieldname = 'ATFLV' or
          fieldname = 'ATIMB' or
          fieldname = 'ATWRT' .
      insert lines of lt_search_attribute into table et_search_attributes_addr.
    endif.
*   end Ehp6 Duplicate Check logic for classification ***********************************

  else.
*   Create structure from 'CLASSASGN' Entity type
    read table io_data_model_ext->dt_entity_prop into ls_entity_prop
         with key usmd_entity = 'CLASSASGN'.
    if sy-subrc is initial and
       ls_entity_prop is not initial.
      l_fieldname_classasgn = ls_entity_prop-r_fprop->fieldname.
    endif.

    io_data_model_ext->create_data_reference(
      exporting
        i_fieldname = l_fieldname_classasgn    " Field Name
        i_struct    = if_usmd_model_ext=>gc_struct_key_attr
        if_table    = 'X'    " Financial MDM: General Indicator
        i_tabtype   = if_usmd_model_ext=>gc_tabtype_standard    " Single-Character Indicator
      importing
        er_data     = lr_data_classasgn ).

    assign lr_data_classasgn->* to <lt_data_classasgn>.
    create data lr_data_line_classasgn like line of <lt_data_classasgn>.
    assign lr_data_line_classasgn->* to <ls_data_classasgn>.

*   Create structure from 'VALUATION' Entity type
    read table io_data_model_ext->dt_entity_prop into ls_entity_prop
         with key usmd_entity = 'VALUATION'.
    if sy-subrc is initial and
       ls_entity_prop is not initial.
      l_fieldname_valuation = ls_entity_prop-r_fprop->fieldname.
    endif.

    io_data_model_ext->create_data_reference(
      exporting
        i_fieldname = l_fieldname_valuation    " Field Name
        i_struct    = if_usmd_model_ext=>gc_struct_key_attr
        if_table    = 'X'    " Financial MDM: General Indicator
        i_tabtype   = if_usmd_model_ext=>gc_tabtype_standard    " Single-Character Indicator
      importing
        er_data     = lr_data_val ).

    assign lr_data_val->* to <lt_data_val>.
    create data lr_data_line_val like line of <lt_data_val>.
    assign lr_data_line_val->* to <ls_data_val>.

*   Reading classification data
    io_data_model_ext->read_char_value(
      exporting
        i_fieldname       = l_fieldname_classasgn
        it_sel            = it_search_key
        if_edition_logic  = 'X'
        i_readmode        = if_usmd_model_ext=>gc_readmode_all_inact    " Read mode
        if_use_edtn_slice = ' '
      importing
        et_data           = <lt_data_classasgn> ).

*   Reading valuation data
    io_data_model_ext->read_char_value(
      exporting
        i_fieldname       = l_fieldname_valuation
        it_sel            = it_search_key
        if_edition_logic  = 'X'
        i_readmode        = if_usmd_model_ext=>gc_readmode_all_inact    " Read mode
        if_use_edtn_slice = ' '
      importing
        et_data           = <lt_data_val> ).

*   Map the duplicate check attribute of Material to the corresponding attributes of the MM data model
    if it_dup_check_attr is not initial.
      loop at it_dup_check_attr into ls_dup_check_attr.
        read table io_data_model_ext->dt_entity_attr_prop into ls_entity_attr_prop
             with key usmd_entity   = ls_dup_check_attr-usmd_entity
                      attr_res      = ls_dup_check_attr-attr_res
                      f_read_only   = abap_false.
        if sy-subrc is initial. "AND ls_entity_attr_prop IS NOT INITIAL.
          ls_key-fieldname = ls_entity_attr_prop-r_fprop->fieldname.
          insert ls_key into table lt_key.
        else.
          read table io_data_model_ext->dt_entity_cont into ls_entity_cont
               with key entity_main
               components usmd_entity_cont = ls_dup_check_attr-usmd_entity.
          if sy-subrc is initial.
            loop at ls_entity_cont-t_entity_key into l_entity.
              if l_entity = ls_dup_check_attr-attr_res.
                clear ls_key.
                ls_key-fieldname = l_entity.
                insert ls_key into table lt_key.
                exit.
              endif.
            endloop.
          endif.
        endif.
      endloop.
    endif.

*   Get the Description of Characteristics
    loop at <lt_data_val> into <ls_data_val>.
      assign component if_mdg_sdq_const=>dm_truncated_attr-gc_charact_charid_attr of structure <ls_data_val> to <fs_charid>.
      if <fs_charid> is assigned and
         <fs_charid> is not initial.
        ls_charid-low    = <fs_charid>.
        ls_charid-sign   = usmd0_cs_ra-sign_i."'I'.
        ls_charid-option = usmd0_cs_ra-option_eq."'EQ'.
        append ls_charid to lt_charid .
      endif.
    endloop.

    if lt_charid is not initial.
      call function 'CLSE_SELECT_CABN'
        tables
          in_cabn        = lt_charid
          t_cabn         = lt_cabn
        exceptions
          no_entry_found = 1
          others         = 2.
      if sy-subrc <> 0.
*       Implement suitable error handling here
      endif.

      if lt_cabn is not initial.
        loop at <lt_data_val> into <ls_data_val>.
*         Proces the steps only for ATCOD = 1 Ignore others.
          unassign <fs_field>.
          assign component if_mdg_sdq_const=>dm_truncated_attr-gc_charact_intvl_tc_attr of structure <ls_data_val> to <fs_field>. "ATCOD

          if <fs_field> is assigned and
             <fs_field> eq '1'.
*           Check if the CHARID is present in every record and then check for values like ATWRT, ATFLV, ATFLB & ATAWE
            if <ls_data_val> is assigned.
              ls_search_attribute_addr-fieldname = if_mdg_sdq_const=>gc_char_fieldname.
              ls_search_attribute_addr-sign      = usmd0_cs_ra-sign_i."'I'.
              ls_search_attribute_addr-option    = usmd0_cs_ra-option_eq."'EQ'.

*             Form the Query for Characteristics Value e.g. Color:Blue, Dimension: 5.2 M
              unassign <fs_charid>.
              assign component if_mdg_sdq_const=>dm_truncated_attr-gc_charact_charid_attr of structure <ls_data_val> to <fs_charid>. "CHARID

              if sy-subrc is initial.
                if <fs_charid> is assigned and
                   <fs_charid> is not initial.
                  read table lt_cabn into ls_cabn
                       with key atinn = <fs_charid>.
                endif.

*               Check for Characterstics Like Blue, Red etc. e.g. Color:Blue
                assign component if_mdg_sdq_const=>dm_truncated_attr-gc_charact_char_val_attr of structure <ls_data_val> to <fs_atwrt>. "ATWRT
                if <fs_atwrt> is assigned and
                   <fs_atwrt> is not initial.
                  concatenate ls_cabn-atnam ':' <fs_atwrt>
                              into ls_search_attribute_addr-low.
                else.
*                 Check for Dimensions Like 5.2, 3.4 etc. e.g. Dimension:5.2
                  assign component if_mdg_sdq_const=>dm_truncated_attr-gc_charact_flt_to_attr of structure <ls_data_val> to <fs_atflv>."ATFLV
                  if <fs_atflv> is assigned and
                     <fs_atflv> is not initial.
                    lv_atflv = <fs_atflv>.
                    concatenate ls_cabn-atnam ':' lv_atflv
                                into ls_search_attribute_addr-low.

*                   Check for Unit of Dimension Like M, CM etc. e.g. Dimension:5.2 M
                    assign component if_mdg_sdq_const=>dm_truncated_attr-gc_charact_uom_flt_frm_attr of structure <ls_data_val> to <fs_atawe>.
                    if <fs_atawe> is assigned and
                       <fs_atawe> is not initial.
                      concatenate ls_search_attribute_addr-low <fs_atawe>
                                  into ls_search_attribute_addr-low separated by space.
                    endif.
                  endif.
                endif.

*               Form the Characteristics String e.g. Char1:Value1 OR Char2:Value2 and so on..
                if ls_search_attr_collective-low is initial.
                  ls_search_attr_collective-low = ls_search_attribute_addr-low.
                else.
                  concatenate ls_search_attr_collective-low 'OR' ls_search_attribute_addr-low
                              into ls_search_attr_collective-low separated by space.
                endif.
              endif.
            endif.
          endif.
          clear ls_search_attribute_addr.
        endloop.

*       Append the Characteristics
        if ls_search_attr_collective-low is not initial.
          ls_search_attr_collective-fieldname = if_mdg_sdq_const=>gc_char_fieldname.
          ls_search_attr_collective-sign      = usmd0_cs_ra-sign_i."'I'.
          ls_search_attr_collective-option    = usmd0_cs_ra-option_eq."'EQ'.
          insert ls_search_attr_collective into table lt_search_attributes_addr.
        endif.
      endif.
    endif.

    clear ls_search_attribute_addr.
    clear ls_key.

*   Add classification attributes
    loop at <lt_data_classasgn> into <ls_data_classasgn>.
      loop at lt_key into ls_key.
        assign component if_mdg_sdq_const=>dm_truncated_attr-gc_class_del_flg_attr of structure <ls_data_classasgn> to <fs_inactclass>.
        if <fs_inactclass> is assigned and
           <fs_inactclass> is not initial.
        else.
          unassign <fs_field>.
          ls_search_attribute_addr-fieldname = ls_key-fieldname.
          assign component ls_key-fieldname of structure <ls_data_classasgn> to <fs_field>.
          if <fs_field> is assigned and
             <fs_field> is not initial.
            ls_search_attribute_addr-low    = <fs_field>.
            ls_search_attribute_addr-sign   = usmd0_cs_ra-sign_i."'I'.
            ls_search_attribute_addr-option = usmd0_cs_ra-option_eq."'EQ'.
            insert ls_search_attribute_addr into table lt_search_attributes_addr.
          endif.
        endif.
      endloop.
    endloop.

*   return the attributes
    et_search_attributes_addr = lt_search_attributes_addr.
  endif.

endmethod.


method get_selection_criteria.
  clear gt_chara_list.
  select from yztable_pr_model as model
    inner join yztable_scope as scope on model~usmd_model = scope~usmd_model
    inner join yztable_template as template on scope~usmd_model = template~usmd_model
    and scope~scope_id = template~scope_id
    fields model~usmd_model, txtmi,
    scope~scope_id, scope~description as scope_description,
    template_id, template~description as template_description
    where model~usmd_active = 'X' and scope~usmd_active = 'X' and scope~langu = @sy-langu
    and template~usmd_active = 'X' into table @data(lt_output) .
  if sy-subrc = 0.
    e_json_response = /ui2/cl_json=>serialize(
      data = lt_output ).
  endif.
endmethod.


method duplicate_check_custom.

  types: begin of temp_usmd_table,
           fieldname type  fieldname,
           sign      type  ddsign,
           option    type  ddoption,
           low       type  usmd_value,
           high1     type  usmd_value,
         end of temp_usmd_table,
         begin of lty_return,
           type    type msgtyp,
           message type string,
         end of lty_return.

  data lt_return                type bapiret2_t.
  data ls_return                type bapiret2.
  data ls_search_key            type usmd_s_value.
  data lt_search_attribute      type usmd_ts_sel.
  data lt_tab_search_attribute  type tt_usmd_ts_sel.
  data lt_search_attribute_temp type usmd_ts_sel.
  data ls_search_attribute      type usmd_s_sel.
  data lv_conv_value            type char16.
  data ls_temp_usmd_table       type temp_usmd_table.
  data lt_temp_usmd_table       type standard table of temp_usmd_table.
  data ld_search_string         type string.
  data ls_search_context        type usmd_s_search_context.
  data ls_attribute_reuse       type mdg_sdq_s_reuse_dup_attr.
  data lv_selst_atr             type string.
  data ls_metadata              type adbc_rs_metadata_descr.
  data ls_mapping_info          like line of gt_mapping_info.
  data lt_duplicates            type usmd_t_search_result.
  data lv_msg                   type string.
  data lv_score                 type p length 3 decimals 2 value '100.00'.
  data ls_output                type ref to data.
  data lt_output                type ref to data.
  data lv_field_name            type string.


  field-symbols <lfs_struct>    type any.
  field-symbols <lfs_field>     type any.
  field-symbols <lfs_data>      type standard table.
  field-symbols <lfs_out>       type any.
  field-symbols <lfv_out>       type any.
  field-symbols <lft_out>       type standard table.

  ""Deserialize

gv_default_fuzzy = gv_default_weight = abap_true.
clear: gv_only_active_records, gs_hana_views, gv_is_reuse, gv_isempty_char,
        gt_mapping_info, mt_attributes_reuse, mt_attributes.

  deserialize_json_input(
    exporting
      i_mode           = i_mode                 " Model for Mass Process Enrichment
      i_model          = i_model                 " Data Model value for mass process enrichment
      i_scope          = i_scope                 " Scope Id for Data model
      i_tempid         = i_tempid                 " Template ID for mass process enrichment
      i_actionid       = i_actionid                 " Data element for action id
      i_use_attributes = 'X'                  " Character Field of Length 1
      i_json_input     = i_input_data
    importing
      et_data          = data(lt_data) ).

  assign lt_data->* to field-symbol(<lfs_data_full>).

  """Fetch template duplicate check criteria

  select * from yztab_templt_det into table @data(lt_templt_data)
    where usmd_model = @i_model and scope_id = @i_scope and template_id = @i_tempid
    and view_id = '01' and usmd_active = 'X'.
  if sy-subrc = 0.
    sort lt_templt_data by column_id.
  endif.

  read table lt_templt_data into data(ls_templt_det)
    with key view_id = '01' column_id = '01' is_key = 'X' included = 'X' usmd_active = 'X'.
  if sy-subrc = 0.
    data(lv_primary_entity) = ls_templt_det-usmd_entity.
    data(lv_key_attrib) = ls_templt_det-usmd_attribute.
  endif.

  select from yztabl_dqdc_conf fields * where usmd_search_mode = 'HA' and usmd_model = @i_model
    and scope_id = @i_scope and template_id = @i_tempid and active = 'X' into table @data(lt_dqdc).
  if sy-subrc = 0.
    sort lt_dqdc by attr_sequence.
  endif.

  check lt_dqdc is not initial.

  """Create output strucure
  data lt_components    type abap_component_tab.
  data ls_components    like line of lt_components.

  ls_components-name = lv_key_attrib.
  call method cl_abap_typedescr=>describe_by_name
    exporting
      p_name         = ls_templt_det-field_domain
    receiving
      p_descr_ref    = data(lo_field_ref)
    exceptions
      type_not_found = 1
      others         = 2.
  if sy-subrc = 0.
    ls_components-type ?= lo_field_ref .
  endif.
  append ls_components to lt_components.
  clear ls_components.

  ls_components-name = 'Score'.
  ls_components-type ?= cl_abap_typedescr=>describe_by_data( p_data = lv_msg ).
  append ls_components to lt_components.
  clear ls_components.
  ls_components-name = 'DUPKEY'.
  call method cl_abap_typedescr=>describe_by_name
    exporting
      p_name         = ls_templt_det-field_domain
    receiving
      p_descr_ref    = lo_field_ref
    exceptions
      type_not_found = 1
      others         = 2.
  if sy-subrc = 0.
    ls_components-type ?= lo_field_ref.
  endif.
  append ls_components to lt_components.
  clear ls_components.

  loop at lt_dqdc into data(ls_dqdc).
    ls_components-name = ls_dqdc-attr_name.
    call method cl_abap_typedescr=>describe_by_name
      exporting
        p_name         = ls_templt_det-field_domain
      receiving
        p_descr_ref    = lo_field_ref
      exceptions
        type_not_found = 1
        others         = 2.
    if sy-subrc = 0.
      ls_components-type ?= lo_field_ref.
    endif.
    append ls_components to lt_components.
    clear ls_components.
  endloop.

  ls_components-name = 'Remarks'.
  ls_components-type ?= cl_abap_typedescr=>describe_by_data( p_data = lv_msg ).
  append ls_components to lt_components.
  clear ls_components.

  call method cl_abap_structdescr=>create
    exporting
      p_components = lt_components
    receiving
      p_result     = data(lo_out_struct).

  refresh lt_components.

  call method cl_abap_tabledescr=>create
    exporting
      p_line_type = lo_out_struct
    receiving
      p_result    = data(lo_out_tab).
  """

  mt_attributes = lt_dqdc.

  call method cl_usmd_model_ext=>get_instance
    exporting
      i_usmd_model = i_model
    importing
      eo_instance  = data(lo_model_ext).

  read table lo_model_ext->dt_entity_prop into data(ls_entity_prop) with key usmd_entity = lv_primary_entity.
  if ls_entity_prop-f_has_pp = 'X'.
    gv_is_reuse = 'X'.
  endif.

  call method cl_usmd_sdq_duplicate_check=>search_mode
    exporting
      iv_model                  = i_model "io_data_model_ext->d_usmd_model    " Data Model
      iv_entity                 = lv_primary_entity "iv_entity    " Entity Type
    importing
      ev_search_mode            = data(lv_search_mode)
      ev_low_threshold          = data(lv_low_threshold)
      ev_high_threshold         = data(lv_high_threshold)
      ev_duplicate_check_exists = data(lv_duplicate_check_exists).


  ls_search_context-entity_main   = lv_primary_entity.
  ls_search_context-o_model       = lo_model_ext.
  ls_search_context-search_mode   = lv_search_mode.
  ls_search_context-update_mode   = 'I'.
*  ls_search_context-search_help   = 'ZMDG_MM_ORGS_NEW'.
  ls_search_context-max_num_records = 10.
  ls_search_context-threshold     = lv_low_threshold.
  read table lt_dqdc into ls_dqdc index 1.
  if sy-subrc = 0.
    ls_search_context-search_help = ls_dqdc-match_profile_id.
  endif.


  call method cl_mdg_hdb_util=>get_hana_object_path_for_query
    exporting
      iv_search_help     = ls_search_context-search_help "'ZMDG_MM_ORGS_NEW'
      iv_attr_view_indic = 'X'
    importing
      ev_relative_path   = data(lv_hana_viewname).  " path relatively to a pacakage
  replace all occurrences of '/' in lv_hana_viewname with '_'.
  gs_hana_views-hana_staging_view = lv_hana_viewname.

  if gv_is_reuse eq abap_true.
    "   Transform Flex view name to Reuse view name by appending the suffix
    concatenate lv_hana_viewname if_mdg_hdb_search_constants=>reuse_view_suffix into lv_hana_viewname.
    gs_hana_views-hana_reuse_view = lv_hana_viewname.
  endif.



  if gs_hana_views-hana_union_sql_view is initial.
    data(lv_hana_view_name) = gs_hana_views-hana_staging_view.
  else.
    lv_hana_view_name = gs_hana_views-hana_union_sql_view.
  endif.

  try .
      if gs_hana_views-hana_union_sql_view is initial.
        lv_hana_view_name = gs_hana_views-hana_staging_view.
      else.
        lv_hana_view_name = gs_hana_views-hana_union_sql_view.
      endif.
      call method cl_mdg_hdb_util=>get_db_conn_details
        importing
          e_dbcon_name = data(lv_con_name).
      data(lo_con) = cl_sql_connection=>get_connection( con_name = lv_con_name ).
      data(lo_stmt) = lo_con->create_statement( ).
      concatenate
                      `SELECT TOP 1  * FROM "` lv_hana_view_name `" WHERE 1 = 2`
                      into lv_selst_atr.

      data(lr_result) = lo_stmt->execute_query( statement = lv_selst_atr ).
      data(lt_metadata_atr) = lr_result->get_metadata( ).
      ls_metadata-column_name = if_mdg_hdb_search_constants=>score.
      data(lr_data_type) = cl_abap_typedescr=>describe_by_name( if_mdg_hdb_search_constants=>rank_roll_name ).
      ls_metadata-data_type = lr_data_type->kind.
      ls_metadata-length = lr_data_type->length.
      ls_metadata-decimals = lr_data_type->decimals.
      insert ls_metadata into table lt_metadata_atr.
    catch: cx_sql_exception into data(lx_sql_exception). " Exception Class for SQL Error

  endtry.

  call method cl_mdg_hdb_access=>get_model_entity_attr
    exporting
      iv_technical_name         = ls_search_context-search_help
    importing
      et_mdg_hdb_tt_entity_attr = data(lt_mdghdb001d).

  loop at lt_metadata_atr into ls_metadata.
    read table lt_mdghdb001d into data(ls_mdghdb001d) with key technical_name = ls_search_context-search_help attribute = ls_metadata-column_name.
    if sy-subrc = 0.
      ls_mapping_info-entity = ls_mdghdb001d-entityname.
      ls_mapping_info-model_fieldname = ls_metadata-column_name.
      insert ls_mapping_info into table gt_mapping_info.
    elseif ls_metadata-column_name = if_mdg_hdb_search_constants=>langu.
      ls_mapping_info-entity = ls_search_context-entity_main.
      ls_mapping_info-model_fieldname = if_mdg_hdb_search_constants=>langu.
      insert ls_mapping_info into table gt_mapping_info.

* This has to be done as the regenerated view contains the attributes which not present in the MDGHDB000D table
*    ELSEIF sy-subrc <> 0.
*      DELETE TABLE lt_metadata_atr FROM ls_metadata.
    endif.
  endloop.

  cl_usmd_pp_access_factory_ext=>get_pp_hana_search(
    exporting
      iv_model          = ls_search_context-o_model->d_usmd_model " Data Model
      iv_entity         = ls_search_context-entity_main " Entity Type
    receiving
      ro_pp_hana_search = data(lo_pp_access_class) " Hana Search Interface for Reuse Area
  ).

  if lo_pp_access_class is bound.
    call method lo_pp_access_class->get_mapping_info
      exporting
        is_search_context = ls_search_context
      importing
        et_messages       = data(lt_message)
      changing
        ct_mapping_info   = gt_mapping_info.
  endif.

  loop at mt_attributes into data(ls_attributes).
    if gs_hana_views-hana_union_sql_view is not initial.
      " Ruleset
      read table gt_mapping_info into ls_mapping_info with key model_fieldname = ls_attributes-attr_name .
      if sy-subrc = 0 and ls_mapping_info-reuse_view_fieldname is initial.  " Mapping not found
        delete table mt_attributes from ls_attributes.
        continue.
      else.
        ls_attribute_reuse-attr_name_reuse = ls_mapping_info-reuse_view_fieldname.
        move-corresponding ls_attributes to ls_attribute_reuse. "#EC ENHOK

        append ls_attribute_reuse to mt_attributes_reuse.
      endif.
    else.
      " Attribute View
      read table gt_mapping_info into ls_mapping_info with key model_fieldname = ls_attributes-attr_name.
      if sy-subrc = 0.
        ls_attribute_reuse-attr_name_reuse = ls_mapping_info-reuse_view_fieldname.
        move-corresponding ls_attributes to ls_attribute_reuse. "#EC ENHOK
        append ls_attribute_reuse to mt_attributes_reuse.
      endif.
    endif.
    if gv_default_weight eq abap_true and ls_attributes-weigtage is not initial.
      gv_default_weight = abap_false.  " Use weight from match profile
    endif.
    if gv_default_fuzzy eq abap_true and ls_attributes-fuzziness is not initial.
      gv_default_fuzzy = abap_false.  " Use fuzziness from match profile
    endif.
  endloop.

  call method cl_mdg_hdb_util=>get_db_conn_details
    importing
      e_dbcon_name = lv_con_name.
  if lv_con_name is initial.
    call method cl_mdg_hdb_search=>add_message
      exporting
        iv_message_id   = 'MDG_HDB_SEARCH'
        iv_message_type = 'E'
        iv_message_no   = '074'
      importing
        es_message      = data(ls_message).
*    append ls_message to lt_return.
    call function 'BAPI_MESSAGE_GETDETAIL'
      exporting
        id         = ls_message-msgid
        number     = ls_message-msgno
*       LANGUAGE   = SY-LANGU
        textformat = 'RTF'
        message_v1 = ls_message-msgv1
        message_v2 = ls_message-msgv2
        message_v3 = ls_message-msgv3
        message_v4 = ls_message-msgv4
      importing
        message    = lv_msg.
    ls_return = corresponding #( ls_message ).
    ls_return-type = 'E'.
    ls_return-message = lv_msg.
    append ls_return to lt_return.

    /ui2/cl_json=>serialize(
      exporting
        data        = ls_output         " Data to serialize
        pretty_name = 'X'               " Pretty Print property names
      receiving
        r_json      = e_output          " JSON string
    ).
    return.
  endif.

  try.
      lo_con = cl_sql_connection=>get_connection( con_name = lv_con_name ).
    catch cx_sql_exception.    " Exception Class for SQL Error
      call method cl_mdg_hdb_search=>add_message
        exporting
          iv_message_id   = 'MDG_HDB_SEARCH'
          iv_message_type = 'E'
          iv_message_no   = '032'
        importing
          es_message      = ls_message.
      append ls_message to lt_return.
  endtry.

  call method cl_mdg_hdb_access=>get_search_model_details
    exporting
      iv_search_help  = ls_search_context-search_help "'ZMDG_MM_ORGS_NEW'
    importing
      es_search_model = data(ls_search_model)
      es_sm_status    = data(ls_sm_status).

  unassign <lfs_data>.
  assign component '_01' of structure <lfs_data_full> to <lfs_data>.
  create data lt_output type handle lo_out_tab.
  assign lt_output->* to <lft_out>.
  loop at <lfs_data> assigning <lfs_struct>.


    create data ls_output type handle lo_out_struct.
    assign ls_output->* to <lfs_out>.

    assign component lv_key_attrib of structure <lfs_struct> to <lfs_field>.
    if <lfs_field> is assigned.
      ls_search_key-fieldname = lv_key_attrib.
      ls_search_key-value = <lfs_field>.
      assign component lv_key_attrib of structure <lfs_out> to <lfv_out>.
      check <lfv_out> is assigned.
      <lfv_out> = <lfs_field>.
    endif.
    loop at lt_dqdc into ls_dqdc.
      unassign <lfs_field>.
      assign component ls_dqdc-attr_name of structure <lfs_struct> to <lfs_field>.
      check <lfs_field> is assigned and <lfs_field> is not initial.
      ls_search_attribute-fieldname = ls_dqdc-attr_name.
      ls_search_attribute-sign      = usmd0_cs_ra-sign_i. "'I'.
      ls_search_attribute-option    = usmd0_cs_ra-option_eq."'EQ'.
      ls_search_attribute-low       = <lfs_field>.
      condense ls_search_attribute-low.
      insert ls_search_attribute into table lt_search_attribute_temp.
*      read table lt_templt_data into ls_templt_det with key usmd_attribute = ls_dqdc-attr_name.
*      check sy-subrc = 0.
*      lv_field_name = ls_templt_det-description.
*      replace all occurrences of ` ` in lv_field_name with '~'.
      assign component ls_dqdc-attr_name of structure <lfs_out> to <lfv_out>.
      check <lfv_out> is assigned.
      <lfv_out> = <lfs_field>.
    endloop.


    if lt_search_attribute_temp is not initial.
      lt_search_attribute = lt_search_attribute_temp.
      insert lt_search_attribute into table lt_tab_search_attribute.
    endif.

    if  lt_search_attribute is not initial.
*      LOOP AT lt_search_attribute_init INTO ls_search_attribute.
      loop at lt_search_attribute assigning field-symbol(<lfs_search_attr>).
* Start of insertion ~note 2468270

* Find the internal data type and call the floating type conversion for the relevant fields.
        call method cl_abap_typedescr=>describe_by_name
          exporting
            p_name         = <lfs_search_attr>-fieldname
          receiving
            p_descr_ref    = data(lo_descr)
          exceptions
            type_not_found = 1
            others         = 2.
        if sy-subrc <> 0.
          read table gt_mapping_info into ls_mapping_info with key reuse_view_fieldname = <lfs_search_attr>-fieldname.
          if sy-subrc = 0.
            call method cl_abap_typedescr=>describe_by_name
              exporting
                p_name         = ls_mapping_info-model_fieldname
              receiving
                p_descr_ref    = lo_descr
              exceptions
                type_not_found = 1
                others         = 2.
          endif.
        endif.
        if lo_descr is bound.
          data(lv_internal_type) = lo_descr->type_kind.
        endif.
        if lv_internal_type = if_mdg_hdb_search_constants=>decimal or lv_internal_type =  'N' or  lv_internal_type = 'D' or lv_internal_type =  'T' or
        lv_internal_type = 'F' or lv_internal_type =  'P' or  lv_internal_type = 'a'.
          clear:lv_conv_value,ls_temp_usmd_table.
          if <lfs_search_attr>-fieldname is assigned and
             <lfs_search_attr>-low       is assigned.
            call method cl_mdg_hdb_util=>convert_float_to_double_type
              exporting
                iv_fieldname  = <lfs_search_attr>-fieldname
                iv_fieldvalue = <lfs_search_attr>-low
              importing
                ev_conv_value = lv_conv_value.
            ls_temp_usmd_table = <lfs_search_attr>.
            clear ls_temp_usmd_table-low.
            ls_temp_usmd_table-low = lv_conv_value.
          else.
            ls_temp_usmd_table = <lfs_search_attr>.
          endif.
          if <lfs_search_attr>-fieldname is assigned and
           <lfs_search_attr>-high      is assigned.
            call method cl_mdg_hdb_util=>convert_float_to_double_type
              exporting
                iv_fieldname  = <lfs_search_attr>-fieldname
                iv_fieldvalue = <lfs_search_attr>-high
              importing
                ev_conv_value = lv_conv_value.
            clear ls_temp_usmd_table-high1.
            ls_temp_usmd_table-high1 = lv_conv_value.
          else.
            ls_temp_usmd_table = <lfs_search_attr>.
          endif.
        else.
          ls_temp_usmd_table = <lfs_search_attr>.
        endif.

        append ls_temp_usmd_table to lt_temp_usmd_table.
* End of insertion ~note 2468270
      endloop.
      if lt_temp_usmd_table is not initial.
        refresh lt_search_attribute.
        lt_search_attribute[] = lt_temp_usmd_table[].
      endif.
    endif.


    refresh lt_temp_usmd_table.
    if lt_tab_search_attribute is not initial.
      loop at lt_tab_search_attribute into data(lt_tab_val).
        loop at lt_tab_val assigning <lfs_search_attr>.
* Find the internal data type and call the floating type conversion for the relevant fields.
          lo_descr = cl_abap_typedescr=>describe_by_name( p_name = <lfs_search_attr>-fieldname ).
          lv_internal_type = lo_descr->type_kind.
* Float data type to double data type conversion
          if lv_internal_type = if_mdg_hdb_search_constants=>decimal or lv_internal_type =  'N' or  lv_internal_type = 'D' or lv_internal_type =  'T' or
          lv_internal_type = 'F' or lv_internal_type =  'P' or  lv_internal_type = 'a'.
            clear: lv_conv_value,ls_temp_usmd_table.
            if <lfs_search_attr>-fieldname is assigned and
               <lfs_search_attr>-low       is assigned.
              call method cl_mdg_hdb_util=>convert_float_to_double_type
                exporting
                  iv_fieldname  = <lfs_search_attr>-fieldname
                  iv_fieldvalue = <lfs_search_attr>-low
                importing
                  ev_conv_value = lv_conv_value.

              ls_temp_usmd_table = <lfs_search_attr>.
              clear ls_temp_usmd_table-low.
              ls_temp_usmd_table-low = lv_conv_value.
            else.
              ls_temp_usmd_table = <lfs_search_attr>.
            endif.
            if <lfs_search_attr>-fieldname is assigned and
              <lfs_search_attr>-high      is assigned.
              call method cl_mdg_hdb_util=>convert_float_to_double_type
                exporting
                  iv_fieldname  = <lfs_search_attr>-fieldname
                  iv_fieldvalue = <lfs_search_attr>-high
                importing
                  ev_conv_value = lv_conv_value.
              clear ls_temp_usmd_table-high1.
              ls_temp_usmd_table-high1 = lv_conv_value.
            else.
              ls_temp_usmd_table = <lfs_search_attr>.
            endif.
          else.
            ls_temp_usmd_table = <lfs_search_attr>.
          endif.
          append ls_temp_usmd_table to lt_temp_usmd_table.
*           <ls_search_attr>-low = lv_conv_value.
        endloop.
*        LT_TAB_VAL[] = lt_temp_usmd_table[].
*        INSERT LT_TAB_VAL INTO TABLE LT_TAB_SEARCH_ATTRIBUTE_INIT_.
        refresh lt_temp_usmd_table.
      endloop.
    endif.


    if lt_search_attribute is initial and lt_tab_search_attribute is initial and ld_search_string is initial.
      data(lv_empty_search) = abap_true.
    endif.

    call method cl_mdg_hdb_access=>get_search_model_details
      exporting
        iv_search_help = ls_search_context-search_help "'ZMDG_MM_ORGS_NEW'
      importing
        es_sm_status   = ls_sm_status.

    if ( ls_sm_status-view_status ne if_mdg_hdb_search_constants=>gc_view_status_generated_flag ).
      call method cl_mdg_hdb_search=>add_message
        exporting
          iv_message_id   = 'MDG_HDB_SEARCH'
          iv_message_type = 'E'
          iv_message_no   = '061'
          iv_message_var1 = 'ZMDG_MM_ORGS_NEW'
        importing
          es_message      = ls_message.
*      append ls_message to lt_return.
      call function 'BAPI_MESSAGE_GETDETAIL'
        exporting
          id         = ls_message-msgid
          number     = ls_message-msgno
*         LANGUAGE   = SY-LANGU
          textformat = 'RTF'
          message_v1 = ls_message-msgv1
          message_v2 = ls_message-msgv2
          message_v3 = ls_message-msgv3
          message_v4 = ls_message-msgv4
        importing
          message    = ls_return-message.
      ls_return = corresponding #( ls_message ).
      ls_return-type = 'E'.
*      ls_return-message = lv_msg.
      append ls_return to lt_return.

      /ui2/cl_json=>serialize(
        exporting
          data        = ls_output         " Data to serialize
          pretty_name = 'X'               " Pretty Print property names
        receiving
          r_json      = e_output          " JSON string
      ).
      return.
    endif.
    ls_search_attribute-fieldname = if_mdg_hdb_search_constants=>usmd_active.
    ls_search_attribute-sign = 'I'.
    ls_search_attribute-option = 'EQ'.
    ls_search_attribute-low = '1'.
    append ls_search_attribute to lt_search_attribute.
    clear ls_search_attribute.

    if ld_search_string is not initial.
      read table lt_search_attribute into ls_search_attribute index 1. " read usmd_active flag has been passed
      if lines(  lt_tab_search_attribute ) ge 1
          or
         lines( lt_search_attribute ) gt 1
          or
        ( ls_search_attribute-fieldname ne if_mdg_hdb_search_constants=>usmd_active
          and
        ls_search_attribute-fieldname is not initial ).
        ls_search_attribute-fieldname = '*'.
        ls_search_attribute-sign = 'I'.
        ls_search_attribute-option = 'EQ'.
        ls_search_attribute-low = ld_search_string.
        clear ld_search_string.
*      ms_freestyle_srch_attr = ls_search_attribute.
      endif.
    endif.

    read table lt_search_attribute transporting no fields with key
    fieldname = if_mdg_hdb_search_constants=>usmd_active  low = '1'.
    if sy-subrc = 0.
      gv_only_active_records = abap_true.
    endif.
    ls_search_context-entity_main   = lv_primary_entity.
    ls_search_context-o_model       = lo_model_ext.
    ls_search_context-search_mode   = lv_search_mode.
    ls_search_context-update_mode   = 'I'.
    ls_search_context-max_num_records = 10.
    ls_search_context-threshold     = lv_low_threshold.

    if gv_is_reuse eq abap_true.
*MDG Specific Authorizations are cleared incase of REUSE Model as there is no Auth Query built for reuse incase
*of MDG-Specific Authorization, and it will be  relevant only for Flex models
*        CLEAR: lv_no_auth,lv_auth_query_mdg,lv_auth_ruleset_query_mdg.

      """""""""""""""""""""""""""""""""""""" Reuse query"""""""""""""""""""""""""""""
*   CONVERT IT_SEARCH_ATTRIBUTES fieldnames to reuse names to build reuse query
      call method get_mapped_search_attribs_dqdc
        exporting
          is_search_context        = ls_search_context  " Search Context
        importing
          et_auth_attr             = data(lt_auth_attr_staging)  " Auth attr in staging names
          et_auth_attr_reuse       = data(lt_auth_attr_reuse)    " Auth attr in reuse names
          et_tab_search_attr_reuse = data(lt_tab_search_attr_reuse)  " ITAB attr in reuse names
          et_search_attr_reuse     = data(lt_search_attr_reuse)  " Basic IT_search attr in reuse names
        changing
          ct_tab_search_attribute  = lt_tab_search_attribute  " ITAB attr in staging names
          ct_search_attribute      = lt_search_attribute.  " Basic IT_search attr in staging names


      check_for_reuse_query_dqdc(
        exporting
          it_search_attribute           = lt_search_attribute    " Sorted Table: Selection Condition (Range per Field)
          it_search_attribute_reuse     = lt_search_attr_reuse    " Sorted Table: Selection Condition (Range per Field)
          it_tab_search_attribute_reuse = lt_tab_search_attr_reuse    " Table type of USMD_TS_SEL
          it_tab_search_attribute       = lt_tab_search_attribute    " Table type of USMD_TS_SEL
        importing
          ev_construct_reuse_query      = data(lv_construct_reuse_query)
      ).
      if lv_construct_reuse_query eq abap_true.
*       Build SQL query for Reuse

        call method build_query_dqdc
          exporting
            it_tab_search_attribute = lt_tab_search_attr_reuse
            is_search_context       = ls_search_context
            id_search_string        = ld_search_string
            it_search_attribute     = lt_search_attr_reuse
*           iv_auth_query           = lv_auth_query  " SQL WHERE Condition for authorization
            iv_view_indicator       = if_mdg_hdb_search_constants=>reuse_view_indicator
          importing
            ev_sel_stmt             = data(lv_sel_stmt_reuse).     " SQL Statement with input
      endif.
      """"""""""""""""""""""""""""""""""""""End of Build Reuse query"""""""""""""""""""""""""""""
    endif.
    """"""""""""""""""""""""""""""""""""""Build Staging query"""""""""""""""""""""""""""""""""""
    call method build_query_dqdc
      exporting
        it_tab_search_attribute = lt_tab_search_attribute
        is_search_context       = ls_search_context
        id_search_string        = ld_search_string
        it_search_attribute     = lt_search_attribute
        iv_view_indicator       = if_mdg_hdb_search_constants=>stag_view_indicator
      importing
        ev_sel_stmt             = data(lv_sel_stmt)      " SQL Statement with input
        ev_filter_ruleset       = data(lv_filter_ruleset).
    """"""""""""""""""""""""""""""""""""""Build Staging query"""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""FETCH SEARCH RESULTS"""""""""""""""""""""""""""""""""""
*    Fetch search results
    call method get_results_dqdc
      exporting
        is_search_context       = ls_search_context
        it_search_attribute     = lt_search_attribute
        it_tab_search_attribute = lt_tab_search_attribute
        iv_sel_stmt             = lv_sel_stmt
        iv_sel_stmt_reuse       = lv_sel_stmt_reuse
        iv_filter_ruleset       = lv_filter_ruleset
      changing
        ct_data                 = lt_duplicates
        ct_message              = lt_message.

    if lt_duplicates is not initial.
      unassign <lfs_field>.
      assign component 'REMARKS' of structure <lfs_out> to <lfv_out>.
      check <lfv_out> is assigned and <lft_out> is assigned.
      clear ls_templt_det.
      describe table lt_duplicates lines data(lv_dups).
      read table lt_templt_data into ls_templt_det with key usmd_attribute = lv_key_attrib.
      <lfv_out> = |{ ls_templt_det-description }| & | | & |{ ls_search_key-value }| & | has | & |{ lv_dups }| & | potential duplicates|.
      append <lfs_out> to <lft_out>.
      loop at lt_duplicates into data(ls_duplicate).
        create data ls_output type handle lo_out_struct.
        assign ls_output->* to <lfs_out>.
        assign component 'SCOPE' of structure ls_duplicate to <lfs_field>.
        assign component 'SCORE' of structure <lfs_out> to <lfv_out>.
        <lfv_out> = <lfs_field> && '%'.

        data lt_ref type ref to data.
        assign ls_duplicate-r_data->* to field-symbol(<lfs_duplicate>).
        assign component 'DUPKEY' of structure <lfs_out> to <lfv_out>.
        unassign <lfs_field>.
        assign component lv_key_attrib of structure <lfs_duplicate> to <lfs_field>.
        if <lfs_field> is not assigned.
          read table gt_mapping_info into ls_mapping_info with key model_fieldname = lv_key_attrib.
          if sy-subrc = 0.
            assign component ls_mapping_info-reuse_view_fieldname of structure <lfs_duplicate> to <lfs_field>.
            check <lfs_field> is assigned and <lfv_out> is assigned.
            <lfv_out> = |{ <lfs_field> alpha = out }|.

          endif.
        else.
          check <lfv_out> is assigned.
          <lfv_out> = <lfs_field>.
        endif.
        loop at lt_dqdc into ls_dqdc.
          read table lt_templt_data into ls_templt_det with key usmd_attribute = ls_dqdc-attr_name.
          check sy-subrc = 0.
*          lv_field_name = ls_templt_det-description.
*          replace all occurrences of ` ` in lv_field_name with '~'.
          unassign: <lfv_out>,<lfs_field>.
          assign component ls_dqdc-attr_name of structure <lfs_out> to <lfv_out>.
          assign component ls_dqdc-attr_name of structure <lfs_duplicate> to <lfs_field>.
          if <lfs_field> is not assigned.
            read table gt_mapping_info into ls_mapping_info with key model_fieldname = ls_dqdc-attr_name.
            if sy-subrc = 0.
              assign component ls_mapping_info-reuse_view_fieldname of structure <lfs_duplicate> to <lfs_field>.
              check <lfs_field> is assigned and <lfv_out> is assigned.
              <lfv_out> = <lfs_field>.
            endif.
          else.
            check <lfv_out> is assigned.
            <lfv_out> = <lfs_field>.
          endif.
          check <lfv_out> is assigned.
          <lfv_out> = <lfs_field>.
        endloop.
        append <lfs_out> to <lft_out>.
      endloop.
    else.
      unassign <lfs_field>.
      assign component 'REMARKS' of structure <lfs_out> to <lfv_out>.
      check <lfv_out> is assigned and <lft_out> is assigned.
      <lfv_out> = |Material | & |{ ls_search_key-value }| & | has no potential duplicates|.
      append <lfs_out> to <lft_out>.
    endif.
    clear: ls_search_key, lt_search_attribute_temp, lt_tab_search_attribute, lt_search_attribute, lt_temp_usmd_table,
            lt_search_attribute, lt_duplicates, lt_search_attr_reuse, lv_sel_stmt_reuse, lv_sel_stmt.
  endloop.



  clear: lt_components, ls_components.
  ls_components-name = 'Errors'.
  ls_components-type ?= lo_out_tab.
  append ls_components to lt_components.
  clear ls_components.
  try .
      call method cl_abap_structdescr=>create
        exporting
          p_components = lt_components
        receiving
          p_result     = data(lo_json_out).

    catch cx_sy_struct_creation into data(lo_ex).
      data(lv_ltext) = lo_ex->get_longtext( ).
      data(lv_text) = lo_ex->get_text( ).
  endtry.

  data lt_names type /ui2/cl_json=>NAME_MAPPINGS.
  data ls_names like line of lt_names.

  create data lt_output type handle lo_json_out."lo_table_xl.
  assign lt_output->* to <lfs_out>.
  check <lfs_out> is assigned.
  assign component 'Errors' of structure <lfs_out> to <lfv_out>.
  check <lfv_out> is assigned and <lft_out> is assigned.
  <lfv_out> = <lft_out>.

  read table lt_templt_data into ls_templt_det with key usmd_attribute = lv_key_attrib.
  if sy-subrc = 0.
    ls_names-abap = lv_key_attrib.
    ls_names-json = ls_templt_det-description.
    replace all occurrences of ` ` in ls_names-json with '_'.
      insert ls_names into table lt_names.
  endif.
  loop at lt_dqdc into ls_dqdc.
    read table lt_templt_data into ls_templt_det with key usmd_attribute = ls_dqdc-attr_name.
    if sy-subrc = 0.
      ls_names-abap = ls_dqdc-attr_name.
      ls_names-json = ls_templt_det-description.
      replace all occurrences of ` ` in ls_names-json with '_'.
      insert ls_names into table lt_names.
    endif.
  endloop.
  ls_names-abap = 'DUPKEY'.
  ls_names-json = 'Duplicate_Key'.
    insert ls_names into table lt_names.

  /ui2/cl_json=>serialize(
    exporting
      data        = <lfs_out>        " Data to serialize
*      pretty_name = 'X'               " Pretty Print property names
      name_mappings = lt_names
    receiving
      r_json      = e_output          " JSON string
  ).
endmethod.


method get_duplicate_check_criteria.
  types: begin of lty_search_class,
           entity_type         type usmd_entity,
           search_mode         type usmd_search_mode,
           search_class        type usmd_search_class,
           complex_selection   type usmd_complex_selection_sup,
           search_class_object type ref to if_usmd_search_data,
         end of lty_search_class,
         begin of lty_input,
           i_mode   type yzdtel_mode,
           i_model  type yzdtel_model,
           i_scope  type yzdtel_scope_id,
           i_tempid type yzdtel_template_id,
         end of lty_input.

  data ls_input           type lty_input.
  data lt_search_class    type table of lty_search_class.
  data ls_search_context  type usmd_s_search_context.

  data lr_search_data     type ref to if_usmd_search_data.

  if i_input_data is not initial.
    /ui2/cl_json=>deserialize(
      exporting
        json = i_input_data                 " JSON string
      changing
        data = ls_input                 " Data to serialize
    ).
  else.
    ls_input-i_model = i_model .
    ls_input-i_scope = i_scope.
    ls_input-i_tempid = i_tempid.
  endif.
  select * from yztab_templt_det into table @data(lt_templt_data)
    where usmd_model = @ls_input-i_model and scope_id = @ls_input-i_scope and template_id = @ls_input-i_tempid
    and view_id = '01' and usmd_active = 'X'.
  if sy-subrc = 0.
    sort lt_templt_data by column_id.
  endif.

  read table lt_templt_data into data(ls_templt_det)
  with key view_id = '01' column_id = '01' is_key = 'X' included = 'X' usmd_active = 'X'.
  if sy-subrc = 0.
    data(lv_primary_entity) = ls_templt_det-usmd_entity.
    data(lv_key_attrib) = ls_templt_det-usmd_attribute.
  endif.
  """Code for standard duplicate check.
*  if cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is not initial and
*   cl_usmd_switch_check=>application_switch_ehp6( ls_input-i_model ) is not initial.
*
*    call method cl_usmd_sdq_duplicate_check=>search_mode
*      exporting
*        iv_model                  = ls_input-i_model "io_data_model_ext->d_usmd_model    " Data Model
*        iv_entity                 = lv_primary_entity "'MATERIAL' "iv_entity    " Entity Type
*      importing
*        ev_search_mode            = data(lv_search_mode)
*        ev_low_threshold          = data(lv_low_threshold)
*        ev_high_threshold         = data(lv_high_threshold)
*        ev_duplicate_check_exists = data(lv_duplicate_check_exists)
*        ev_match_profile_id       = data(lv_match_profile_id)
*        ev_search_help            = data(lv_search_help).
*
*  elseif cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is initial or
*   cl_usmd_switch_check=>application_switch_ehp6( ls_input-i_model ) is initial.
*
*    call method cl_usmd_sdq_duplicate_check=>search_mode
*      exporting
*        iv_model                  = ls_input-i_model "io_data_model_ext->d_usmd_model    " Data Model
*        iv_entity                 = lv_primary_entity "iv_entity    " Entity Type
*      importing
*        ev_search_mode            = lv_search_mode
*        ev_low_threshold          = lv_low_threshold
*        ev_high_threshold         = lv_high_threshold
*        ev_duplicate_check_exists = lv_duplicate_check_exists.
*
*  endif.
*  check lv_duplicate_check_exists is not initial.
*  if lv_search_mode is not initial.
*    select * from mdg_dq_conf_dc into table @data(lt_dup_check_attrib)
*      where usmd_search_mode = @lv_search_mode
*      and datamodel = @ls_input-i_model
*      and match_profile_id = @lv_match_profile_id.
*  endif.
  """"End of code for standard duplicate check.

  if cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is not initial and
   cl_usmd_switch_check=>application_switch_ehp6( ls_input-i_model ) is not initial.

    call method cl_usmd_sdq_duplicate_check=>search_mode
      exporting
        iv_model                  = ls_input-i_model "io_data_model_ext->d_usmd_model    " Data Model
        iv_entity                 = lv_primary_entity "'MATERIAL' "iv_entity    " Entity Type
      importing
        ev_search_mode            = data(lv_search_mode)
        ev_low_threshold          = data(lv_low_threshold)
        ev_high_threshold         = data(lv_high_threshold)
        ev_duplicate_check_exists = data(lv_duplicate_check_exists)
        ev_match_profile_id       = data(lv_match_profile_id)
        ev_search_help            = data(lv_search_help).

  elseif cl_mdg_dq_switch_check=>mdg_dqs_sfws_ehp6( ) is initial or
   cl_usmd_switch_check=>application_switch_ehp6( ls_input-i_model ) is initial.

    call method cl_usmd_sdq_duplicate_check=>search_mode
      exporting
        iv_model                  = ls_input-i_model "io_data_model_ext->d_usmd_model    " Data Model
        iv_entity                 = lv_primary_entity "iv_entity    " Entity Type
      importing
        ev_search_mode            = lv_search_mode
        ev_low_threshold          = lv_low_threshold
        ev_high_threshold         = lv_high_threshold
        ev_duplicate_check_exists = lv_duplicate_check_exists.

  endif.

  select from yztabl_dqdc_conf fields * where usmd_search_mode = 'HA' and usmd_model = @ls_input-i_model
    and scope_id = @ls_input-i_scope and template_id = @ls_input-i_tempid
    and active = 'X' into table @data(lt_dqdc).
  if sy-subrc = 0.
    sort lt_dqdc by attr_sequence.
  endif.

  /ui2/cl_json=>serialize(
    exporting
      data   = lt_dqdc     " Data to serialize
    receiving
      r_json = e_output_data           " JSON string
  ).

endmethod.


method build_clf_query_on_atcod_dqdc.
  data: ls_search_attribute   type usmd_s_sel,
        iatflv                type string,
        ioperator             type string,
        isign                 type string,
        iatflb                type string,
        lv_view_name          type mdg_hviewname,
        lv_fieldname_atcod    type string,
        lv_fieldname_atflv    type string,
        lv_fieldname_atflb    type string,
        lv_atcod1             type string,
        lv_atcod_2_5          type string,
        lv_atcod6             type string,
        lv_atcod7             type string,
        lv_atcod8             type string,
        lv_atcod9             type string,
        lv_sel_stmt           type string,
        lv_sql_with_input_opr type string,
        lv_sql_condition      type string,
        lv_sql_condition1     type string,
        lv_sql_condition2     type string,
        lv_sql_condition3     type string,
        lv_value              type string.



  constants: lc_sql_condition     type string value `($ATTRIBUTE $OPERATOR $VALUE)`,
             lc_sql_between_value type string value `($LOW AND $HIGH)`.

*  Copy the user values into local variables
*  based on reuse or staging query to be constructed
  if iv_view_indicator eq if_mdg_hdb_search_constants=>stag_view_indicator
    or iv_view_indicator eq if_mdg_hdb_search_constants=>sql_view_indicator.
    lv_view_name = gs_hana_views-hana_staging_view.
    read table it_search_attribute transporting all fields into ls_search_attribute with key
fieldname = if_mdg_hdb_search_constants=>gc_field_atflv .
    if sy-subrc = 0.
      iatflv = ls_search_attribute-low.
      iatflb = ls_search_attribute-high.
      ioperator = ls_search_attribute-option.
      isign = ls_search_attribute-sign.
    endif.
*    READ TABLE it_search_attribute TRANSPORTING ALL FIELDS INTO ls_search_attribute WITH KEY
*fieldname = if_mdg_hdb_search_constants=>gc_field_atflb .
*    IF sy-subrc = 0.
*      iatflb = ls_search_attribute-high.
*      ioperator = ls_search_attribute-option.
*    ENDIF.
    lv_fieldname_atcod = if_mdg_hdb_search_constants=>gc_field_atcod.
    lv_fieldname_atflv = if_mdg_hdb_search_constants=>gc_field_atflv.
    lv_fieldname_atflb = if_mdg_hdb_search_constants=>gc_field_atflb.
  elseif iv_view_indicator eq if_mdg_hdb_search_constants=>reuse_view_indicator
    or iv_view_indicator eq if_mdg_hdb_search_constants=>inob_view_indicator.
    read table it_search_attribute transporting all fields into ls_search_attribute with key
fieldname = if_mdg_hdb_search_constants=>gc_field_val_atflv_reuse .
    if sy-subrc = 0.
      iatflv = ls_search_attribute-low.
      iatflb = ls_search_attribute-high.
      ioperator = ls_search_attribute-option.
      isign = ls_search_attribute-sign.
    endif.
*    READ TABLE it_search_attribute TRANSPORTING ALL FIELDS INTO ls_search_attribute WITH KEY
*fieldname = if_mdg_hdb_search_constants=>gc_field_val_atflb_reuse .
*    IF sy-subrc = 0.
*      iatflb = ls_search_attribute-high.
*    ENDIF.
    lv_fieldname_atcod = if_mdg_hdb_search_constants=>gc_field_val_atcod_reuse.
    lv_fieldname_atflv = if_mdg_hdb_search_constants=>gc_field_val_atflv_reuse.
    lv_fieldname_atflb = if_mdg_hdb_search_constants=>gc_field_val_atflb_reuse.
  endif.

* Condense to remove leading and trailing spaces ( but not space in midst )
  condense iatflv.
  condense iatflb.
  if iatflv is not initial.
* Call QUOTE method for Security handling
    call method cl_mdg_hdb_util=>quote_select_options_low_high
      changing
        cv_low = iatflv.
  endif.
  if iatflb is not initial.
* Call QUOTE method for Security handling
    call method cl_mdg_hdb_util=>quote_select_options_low_high
      changing
        cv_low = iatflb.
  endif.
  if iatflv cs '*'.
    replace all  occurrences of '*' in iatflv with '%' in character mode.
  endif.
  if iatflb cs '*'.
    replace all  occurrences of '*' in iatflb with '%' in character mode.
  endif.


***************************************************************************************************
  " BUILD ATCOD constant string
*  Code	Operator Value1	 	Operator Value2
*1  EQ
*2  GE    LT
*3  GE    LE
*4  GT    LT
*5  GT    LE
*6  LT
*7  LE
*8  GT
*9  GE
*  ATCOD =1
  lv_sql_condition = lc_sql_condition.
  replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atcod.
  replace first occurrence of `$VALUE` in lv_sql_condition with `'1'`.
  replace first occurrence of `$OPERATOR` in lv_sql_condition with '='.
  lv_atcod1 = lv_sql_condition.

*  ATCOD BETWEEn 2 to 5
  lv_sql_condition = lc_sql_condition.
  replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atcod.
  replace first occurrence of `$VALUE` in lv_sql_condition with `'2' AND '5'`.
  replace first occurrence of `$OPERATOR` in lv_sql_condition with 'BETWEEN'.
  lv_atcod_2_5 = lv_sql_condition.
* ATCOD =  6
  lv_sql_condition = lc_sql_condition.
  replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atcod.
  replace first occurrence of `$VALUE` in lv_sql_condition with `'6'`.
  replace first occurrence of `$OPERATOR` in lv_sql_condition with '='.
  lv_atcod6 = lv_sql_condition.
* ATCOD =  7
  lv_sql_condition = lc_sql_condition.
  replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atcod.
  replace first occurrence of `$VALUE` in lv_sql_condition with `'7'`.
  replace first occurrence of `$OPERATOR` in lv_sql_condition with '='.
  lv_atcod7 = lv_sql_condition.
* ATCOD =  8
  lv_sql_condition = lc_sql_condition.
  replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atcod.
  replace first occurrence of `$VALUE` in lv_sql_condition with `'8'`.
  replace first occurrence of `$OPERATOR` in lv_sql_condition with '='.
  lv_atcod8 = lv_sql_condition.
* ATCOD =  9
  lv_sql_condition = lc_sql_condition.
  replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atcod.
  replace first occurrence of `$VALUE` in lv_sql_condition with `'9'`.
  replace first occurrence of `$OPERATOR` in lv_sql_condition with '='.
  lv_atcod9 = lv_sql_condition.


  " END OF BUILD ATCOD constant string
****************************************************************************************************


  if ( iatflv is not initial and iatflb is initial ). " Scalar Values filled

* Use input operator in query as is ??
    ls_search_attribute-fieldname = lv_fieldname_atflv.
    ls_search_attribute-option = ioperator.
    ls_search_attribute-low = iatflv.
    build_query_condition_dqdc(
      exporting
        iv_cmplx_criteria   = abap_true
        is_search_attribute = ls_search_attribute  " Row Structure: Selection Condition (Range per Field)\
        iv_input_quoted     = abap_true
        iv_case_sensitive   = abap_true   " so that UPPER is not used
      importing
        ev_sel_condition    = lv_sql_with_input_opr
    ).
*ATCOD = 1 and ATFLV = iATFLV (Take Input Operator)

    lv_sql_condition = lv_sql_with_input_opr.
    concatenate '(' lv_atcod1 `AND` lv_sql_condition ')' into lv_sel_stmt separated by space.
*OR ( ATCOD BETWEEn 2 and 5  and ( ( ATFLV <= iATFLV and ATFLB >= iATFLV ) OR ( ATLFLV <OP> IATFLV ) )
    lv_sql_condition = lc_sql_condition.
    replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
    replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
    replace first occurrence of `$OPERATOR` in lv_sql_condition with '<='.
    lv_sql_condition1 = lv_sql_condition.
    lv_sql_condition = lc_sql_condition.
    replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
    replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
    replace first occurrence of `$OPERATOR` in lv_sql_condition with '>='.
    lv_sql_condition2 = lv_sql_condition.

    lv_sql_condition3 = lv_sql_with_input_opr.

    concatenate lv_sel_stmt
    `OR` '(' lv_atcod_2_5 `AND` `((` lv_sql_condition1 `AND` lv_sql_condition2 `)` `OR` `(`  lv_sql_condition3 `))` ')'
    into lv_sel_stmt separated by space.

* OR ATCOD = <6 > (LT) ATFLV > iATFV OR ATFLV <Oper> iATFLV
* DATA in the backend is stored in ATFLB for ATCOD =6 and 7
    lv_sql_condition = lc_sql_condition.
    replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
    replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
    replace first occurrence of `$OPERATOR` in lv_sql_condition with '>'.
    lv_sql_condition1 = lv_sql_condition.

*    lv_sql_condition = lc_sql_condition.
*    REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflb.
*    REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflv.
*    REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '>'.
*    lv_sql_condition2 = lv_sql_condition.

    lv_sql_condition2 = lv_sql_with_input_opr.

    concatenate lv_sel_stmt
   `OR` '(' lv_atcod6 `AND` '(' lv_sql_condition1 `OR` lv_sql_condition2  ')' ')'
   into lv_sel_stmt separated by space.

*  CONCATENATE lv_sel_stmt
*   `OR` '(' lv_atcod6 `AND` '('  lv_sql_condition2  ')' ')'
*   INTO lv_sel_stmt SEPARATED BY space.

* OR ATCOD = <7 > (LE) ATFLV >= iATFV OR ATFLV <Oper> iATFLV
    lv_sql_condition = lc_sql_condition.
    replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
    replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
    replace first occurrence of `$OPERATOR` in lv_sql_condition with '>='.
    lv_sql_condition1 = lv_sql_condition.


*     lv_sql_condition = lc_sql_condition.
*    REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflb.
*    REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflv.
*    REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '<='.
*    lv_sql_condition2 = lv_sql_condition.
    lv_sql_condition2 = lv_sql_with_input_opr.

    concatenate lv_sel_stmt
   `OR` '(' lv_atcod7 `AND` '(' lv_sql_condition1 `OR` lv_sql_condition2 ')' ')'
   into lv_sel_stmt separated by space.

*   CONCATENATE lv_sel_stmt
*   `OR` '(' lv_atcod7 `AND` '(' lv_sql_condition2 ')' ')'
*   INTO lv_sel_stmt SEPARATED BY space.

* OR ATCOD = <8>  (GT) ATFLV < iATFLV OR ATFV <Oper> iATFLV
    lv_sql_condition = lc_sql_condition.
    replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
    replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
    replace first occurrence of `$OPERATOR` in lv_sql_condition with '<'.
    lv_sql_condition1 = lv_sql_condition.

*     lv_sql_condition = lc_sql_condition.
*    REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*    REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflv.
*    REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '>'.
*    lv_sql_condition2 = lv_sql_condition.

    lv_sql_condition2 = lv_sql_with_input_opr.

    concatenate lv_sel_stmt
   `OR` '(' lv_atcod8 `AND` '(' lv_sql_condition1 `OR` lv_sql_condition2 ')' ')'
   into lv_sel_stmt separated by space.

*    CONCATENATE lv_sel_stmt
*   `OR` '(' lv_atcod8 `AND` lv_sql_condition1 ')'
*   INTO lv_sel_stmt SEPARATED BY space.

* OR ATCOD = <9>  (GT) ATFLV < iATFLV OR ATFV <Oper> iATFLV
    lv_sql_condition = lc_sql_condition.
    replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
    replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
    replace first occurrence of `$OPERATOR` in lv_sql_condition with '<='.
    lv_sql_condition1 = lv_sql_condition.

*     lv_sql_condition = lc_sql_condition.
*    REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*    REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflv.
*    REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '>='.
*    lv_sql_condition2 = lv_sql_condition.

    lv_sql_condition2 = lv_sql_with_input_opr.

    concatenate lv_sel_stmt
   `OR` '(' lv_atcod9 `AND` '(' lv_sql_condition1 `OR` lv_sql_condition2 ')' ')'
   into lv_sel_stmt separated by space.
*       CONCATENATE lv_sel_stmt
*   `OR` '(' lv_atcod9 `AND` lv_sql_condition1 ')'
*   INTO lv_sel_stmt SEPARATED BY space.

  elseif ( iatflv is not initial and iatflb is not initial ). " Range Filled

    if isign = 'I'.
*ATCOD = 1 and ATFLV BETWEEN iATFLV and iATFLB
      lv_sql_condition = lc_sql_condition.
      concatenate iatflv `AND` iatflb into lv_sql_with_input_opr separated by space.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
      replace first occurrence of `$VALUE` in lv_sql_condition with lv_sql_with_input_opr.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with 'BETWEEN'.

      concatenate '(' lv_atcod1 `AND` lv_sql_condition ')' into lv_sel_stmt separated by space.
*OR (ATCOD BT 2 and 5 and ((ATFLV <= iATFLV and ATFLB >=iATFLV) OR (ATFLV <= iATFLB and ATFLB >= iATFLB))

      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '<='.
      lv_sql_condition1 = lv_sql_condition.
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '>='.
      concatenate '(' lv_sql_condition1 `AND` lv_sql_condition ')' into lv_sql_condition1 separated by space.


      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflb.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '<='.
      lv_sql_condition2 = lv_sql_condition.
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflb.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '>='.
      concatenate '(' lv_sql_condition2 `AND` lv_sql_condition ')' into lv_sql_condition2 separated by space.

      concatenate lv_sel_stmt
     `OR` '(' lv_atcod_2_5 `AND` lv_sql_condition1 `OR` lv_sql_condition2 ')'
     into lv_sel_stmt separated by space.

*ATCOD = 6 ATFLV > iATFLV  OR  ATFLv > iATFLB  with out overlapping
*ATCOD = 6 ATFLV > iATFLV  with over lapping
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '>'.
      lv_sql_condition1 = lv_sql_condition.

*    As overlapping is required second condition is not needed
*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflb.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '>'.
*      lv_sql_condition2 = lv_sql_condition.

*      CONCATENATE lv_sel_stmt
*     `OR` '(' lv_atcod6 `AND` lv_sql_condition1 `AND` lv_sql_condition2 ')'
*     INTO lv_sel_stmt SEPARATED BY space.

      concatenate lv_sel_stmt
   `OR` '(' lv_atcod6 `AND` lv_sql_condition1  ')'
   into lv_sel_stmt separated by space.

*ATCOD = 7 ATFLV > iATFLV  OR  ATFLv > iATFLB
*ATCOD = 7 ATFLV > iATFLV    with overlapping

      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '>='.
      lv_sql_condition1 = lv_sql_condition.
*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflb.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '>='.
*      lv_sql_condition2 = lv_sql_condition.

*      CONCATENATE lv_sel_stmt
*     `OR` '(' lv_atcod7 `AND` lv_sql_condition1 `AND` lv_sql_condition2 ')'
*     INTO lv_sel_stmt SEPARATED BY space.
      concatenate lv_sel_stmt
`OR` '(' lv_atcod7 `AND` lv_sql_condition1 ')'
into lv_sel_stmt separated by space.

*ATCOD = 8 ATFLV < iATFLV  OR  ATFLV < iATFLB
*ATCOD = 8 ATFLB < iATFLB with overlapping
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflb.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '<'.
      lv_sql_condition1 = lv_sql_condition.
*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflv.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '<'.
*      lv_sql_condition1 = lv_sql_condition.
*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflb.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '<'.
*      lv_sql_condition2 = lv_sql_condition.

*      CONCATENATE lv_sel_stmt
*     `OR` '(' lv_atcod8 `AND` lv_sql_condition1 `AND` lv_sql_condition2 ')'
*     INTO lv_sel_stmt SEPARATED BY space.

      concatenate lv_sel_stmt
     `OR` '(' lv_atcod8 `AND` lv_sql_condition1  ')'
     into lv_sel_stmt separated by space.

*ATCOD = 9 ATFLV <= iATFLV  OR  ATFLv <= iATFLB
*ATCOD = 9 ATFLB < iATFLB with overlapping

*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflv.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '<='.
*      lv_sql_condition1 = lv_sql_condition.
*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflb.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '<='.
*      lv_sql_condition2 = lv_sql_condition.
*
*      CONCATENATE lv_sel_stmt
*     `OR` '(' lv_atcod9 `AND` lv_sql_condition1 `AND` lv_sql_condition2 ')'
*     INTO lv_sel_stmt SEPARATED BY space.
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflb.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '<='.
      lv_sql_condition1 = lv_sql_condition.
      concatenate lv_sel_stmt
           `OR` '(' lv_atcod9 `AND` lv_sql_condition1 ')'
           into lv_sel_stmt separated by space.

    elseif isign = 'E'.
*ATCOD = 1 and ATFLV NOT BETWEEN iATFLV and iATFLB
*ATCOD = 1 and ATFLV < iATFLV OR ATFLV > iATFLB
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '<'.
      lv_sql_condition1 = lv_sql_condition.
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflb.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '>'.
      lv_sql_condition2 = lv_sql_condition.

      concatenate
      '(' lv_atcod1 `AND` lv_sql_condition1 `OR` lv_sql_condition2 ')'
     into lv_sel_stmt separated by space.

*OR (ATCOD BT 2 and 5 and ((ATFLV < iATFLV and ATFLB < iATFLV) OR (ATFLV > iATFLB and ATFLB > iATFLB))
*Overlapping is needed
*  (ATCOD BT 2 and 5 and ((ATFLV < iATFLV ) OR ( ATFLB > iATFLB))

*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflv.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '<'.
*      lv_sql_condition1 = lv_sql_condition.
*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflb.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflv.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '<'.
*      CONCATENATE '(' lv_sql_condition1 `AND` lv_sql_condition ')' INTO lv_sql_condition1 SEPARATED BY space.
*
*
*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflv.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflb.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '>'.
*      lv_sql_condition2 = lv_sql_condition.
*      lv_sql_condition = lc_sql_condition.
*      REPLACE FIRST OCCURRENCE OF `$ATTRIBUTE` IN lv_sql_condition WITH lv_fieldname_atflb.
*      REPLACE FIRST OCCURRENCE OF `$VALUE` IN lv_sql_condition WITH iatflb.
*      REPLACE FIRST OCCURRENCE OF `$OPERATOR` IN lv_sql_condition WITH '>'.
*      CONCATENATE '(' lv_sql_condition2 `AND` lv_sql_condition ')' INTO lv_sql_condition2 SEPARATED BY space.
*
*      CONCATENATE lv_sel_stmt
*     `OR` '(' lv_atcod_2_5 `AND` lv_sql_condition1 `OR` lv_sql_condition2 ')'
*     INTO lv_sel_stmt SEPARATED BY space.

* With Overlap
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '<'.
      lv_sql_condition1 = lv_sql_condition.

*      CONCATENATE '(' lv_sql_condition1 ')' INTO lv_sql_condition1 SEPARATED BY space.

      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflb.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '>'.
      lv_sql_condition2 = lv_sql_condition.

      concatenate lv_sel_stmt
     `OR` '(' lv_atcod_2_5 `AND` lv_sql_condition1 `OR` lv_sql_condition2 ')'
     into lv_sel_stmt separated by space.

*      *ATCOD = 6 (LT) ATFLB < iATFLV  OR  ATFLB < iATFLB


      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '<'.
      lv_sql_condition1 = lv_sql_condition.
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflb.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflb.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '<'.
      lv_sql_condition2 = lv_sql_condition.

      concatenate lv_sel_stmt
     `OR` '(' lv_atcod6 `AND` lv_sql_condition1 `OR` lv_sql_condition2 ')'
     into lv_sel_stmt separated by space.

*ATCOD = 7 (LE) ATFLV < iATFLV  OR  ATFLv < iATFLB

      concatenate lv_sel_stmt
     `OR` '(' lv_atcod7 `AND` lv_sql_condition1 `OR` lv_sql_condition2 ')'
     into lv_sel_stmt separated by space.

*ATCOD = 8 (GT) ATFLV < iATFLV  OR  ATFLV > iATFLB
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflv.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '<'.
      lv_sql_condition1 = lv_sql_condition.
      lv_sql_condition = lc_sql_condition.
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname_atflv.
      replace first occurrence of `$VALUE` in lv_sql_condition with iatflb.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with '>'.
      lv_sql_condition2 = lv_sql_condition.

      concatenate lv_sel_stmt
     `OR` '(' lv_atcod8 `AND` lv_sql_condition1 `OR` lv_sql_condition2 ')'
     into lv_sel_stmt separated by space.

*ATCOD = 9 (GE) ATFLV < iATFLV  OR  ATFLv > iATFLB

      concatenate lv_sel_stmt
     `OR` '(' lv_atcod9 `AND` lv_sql_condition1 `OR` lv_sql_condition2 ')'
     into lv_sel_stmt separated by space.
    endif.
  endif.
  if lv_sel_stmt is not initial.
    concatenate '(' lv_sel_stmt ')'
        into lv_sel_stmt separated by space.
  endif.
  ev_sel_condition = lv_sel_stmt.
endmethod.


method build_query_condition_dqdc.
*   Builds query condition for each attribute (ls_search_attribute)
*   Here we consider the operator passed and map it accordingly to HANA SQL operator
*   example
*   EQ -(UPPER(MEINS) = UPPER('EA'))
*   BT - (MEINS BETWEEN 'AA' AND 'EA')
*   GT, LT, GE, LE - ( UPPER(MEINS) '>' UPPER('EA'))
*   EXACT (CONTAINS(MEINS,'EA')
*   FUZZY (CONTAINS (MEINS,'EA',FUZZY)
*

  data: lv_search_hi_str     type string,
        lv_search_lo_str     type string,
        lv_fieldname         type string,
        lv_operator          type string,
        lv_condition_part2   type string,
        ls_search_attribute  type usmd_s_sel,
        lv_is_key            type boolean,
        lv_roll_name         type string,
        ls_mapping_info      type mdg_hdb_s_reuse_mapping,
        lv_internal_datatype type inttype,
        lv_length            type i.



  data:
    lv_sql_condition             type string value `($ATTRIBUTE $OPERATOR $VALUE)`,
    lv_sql_condition_upper       type string value `(UPPER($ATTRIBUTE) $OPERATOR UPPER($VALUE))`,
    lv_sql_contains              type string value `CONTAINS($ATTRIBUTE,$VALUE)`,
    lv_sql_contains_fuzzy        type string value `CONTAINS($ATTRIBUTE,$VALUE,FUZZY)`,   "#NEEDED
    lv_empty_str                 type string value '''''',
    lv_null_empty_sql_condition  type string value `($ATTRIBUTE $OPERATOR $VALUE OR $ATTRIBUTE IS NULL)`,
    lv_nullp_empty_sql_condition type string value `($ATTRIBUTE IS NULL)`,
    lv_sql_contains_weight       type string value `CONTAINS($ATTRIBUTE,$VALUE,$FUZZY,$WEIGHT)`,
    lv_weight_value              type string value 'WEIGHT($VALUE)',
    lv_fuzzy_value               type string value 'FUZZY($VALUE)'.
  data  lv_fuzzy_conf_flag type boolean.
  data  ls_fuzzy_conf type mdg_dq_conf.
  data  lv_fuzzy type string.
  constants lc_classname type  classname value 'CL_MDG_CC_2021_252631'.
  constants lc_method type  seocmpname value 'IS_ACTIVE'.
  data  lo_class type ref to  cl_oo_class.
  data  lv_val type  abap_bool.
  data  lv_is_active type  abap_bool.

  clear: lv_internal_datatype.

  try .
      lo_class ?= cl_oo_class=>get_instance( lc_classname ).
      if lo_class is bound.
        call method (lc_classname)=>(lc_method) receiving rv_active = lv_is_active.
      endif.
      if lv_is_active = abap_true.
*        if gt_fuzzy_conf is not initial.
*          lv_fuzzy_conf_flag = abap_true.
*        else.
*          lv_fuzzy_conf_flag = abap_false.
*        endif.
      endif.
    catch cx_class_not_existent.
      "Do Nothing
  endtry.

* Copy the user values into local variables
  lv_search_lo_str = is_search_attribute-low.
  lv_search_hi_str = is_search_attribute-high.
  lv_fieldname = is_search_attribute-fieldname.

  if lv_fieldname ca '/'.
    lv_fieldname = |"{ lv_fieldname }"|.
  endif.
  if lv_search_lo_str co 'OR'.       " To handle the special case where "OR" is used as search criteria but can't be used in HANA as this is reserved word.
    translate lv_search_lo_str to lower case.
  endif.
*    Check whether the attribute is a key,if it is a key fuzziness should not be considered while creating the condition
**  if iv_view_indicator = if_mdg_hdb_search_constants=>reuse_view_indicator .
**    read table gt_key_field_reuse with key fieldname = is_search_attribute-fieldname transporting no fields .
**    if sy-subrc = 0.
**      lv_is_key   = abap_true.
**    endif.
**  elseif iv_view_indicator = if_mdg_hdb_search_constants=>stag_view_indicator ..
**    read table gt_key_field with key fieldname = is_search_attribute-fieldname transporting no fields .
**    if sy-subrc = 0.
**      lv_is_key   = abap_true.
**    endif.
**  endif.

* Get the internal data type for the given fieldname.
*  find_internal_data_type(
*    exporting
*      iv_fieldname     = is_search_attribute-fieldname   " Field Name
*    importing
*      ev_internal_type = lv_internal_datatype   " ABAP data type (C,D,N,...)
*  ).
*  call method cl_abap_typedescr=>describe_by_name
*    exporting
*      p_name         = is_search_attribute-fieldname
*    receiving
*      p_descr_ref    = data(lo_descr)
*    exceptions
*      type_not_found = 1
*      others         = 2.
*  if sy-subrc <> 0.
*    read table gt_mapping_info into ls_mapping_info with key REUSE_VIEW_FIELDNAME = is_search_attribute-fieldname.
*    if sy-subrc = 0.
*      call method cl_abap_typedescr=>describe_by_name
*        exporting
*          p_name         = ls_mapping_info-model_fieldname
*        receiving
*          p_descr_ref    = lo_descr
*        exceptions
*          type_not_found = 1
*          others         = 2.
*    endif.
*  endif.
*  if lo_descr is bound.
*    DATA(lv_internal_type) = lo_descr->type_kind.
*  endif.

  call method cl_abap_typedescr=>describe_by_name
    exporting
      p_name         = is_search_attribute-fieldname
    receiving
      p_descr_ref    = DATA(lo_descr)
    exceptions
      type_not_found = 1
      others         = 2.
  if sy-subrc <> 0.
    read table gt_mapping_info into ls_mapping_info with key REUSE_VIEW_FIELDNAME = is_search_attribute-fieldname.
    if sy-subrc = 0.
      call method cl_abap_typedescr=>describe_by_name
        exporting
          p_name         = ls_mapping_info-model_fieldname
        receiving
          p_descr_ref    = lo_descr
        exceptions
          type_not_found = 1
          others         = 2.
    endif.
  endif.
if lo_descr is bound.
    DATA(lv_internal_type) = lo_descr->type_kind.
  endif.


  if lv_internal_datatype = if_mdg_hdb_search_constants=>decimal or lv_internal_datatype =  'N' or  lv_internal_datatype = 'D' or lv_internal_datatype =  'T' or
    lv_internal_datatype = 'F' or lv_internal_datatype =  'P' or  lv_internal_datatype = 'a' or lv_internal_datatype = 'I'.
    clear: lv_sql_condition_upper.
    lv_sql_condition_upper = lv_sql_condition.
  endif.

  if lv_internal_datatype = 'C'.
*    read table gt_key_field transporting no fields with key fieldname = is_search_attribute-fieldname.
*    if sy-subrc = 0.
*      lv_sql_condition_upper = lv_sql_condition.
*    else.
*      read table gt_key_field_reuse transporting no fields with key fieldname = is_search_attribute-fieldname.
*      if sy-subrc = 0.
*        lv_sql_condition_upper = lv_sql_condition.
*      endif.
*    endif.
  endif.

  if  iv_input_quoted <> abap_true.
* Condense to remove leading and trailing spaces ( but not space in midst )
    condense lv_search_lo_str.
    condense lv_search_hi_str.

    lv_length = strlen( lv_search_lo_str ).
    if ( lv_length > 58 ).
      lv_search_lo_str = lv_search_lo_str(58).
    endif.
    lv_length = strlen( lv_search_hi_str ).
    if ( lv_length > 58 ).
      lv_search_hi_str = lv_search_hi_str(58).
    endif.
*  Call QUOTE method for Security handling
    call method cl_mdg_hdb_util=>quote_select_options_low_high
      changing
        cv_low  = lv_search_lo_str
        cv_high = lv_search_hi_str.
    if lv_search_lo_str cs '*'.
      replace all  occurrences of '*' in lv_search_lo_str with '%' in character mode.
    endif.
    if lv_search_hi_str cs '*'.
      replace all  occurrences of '*' in lv_search_hi_str with '%' in character mode.
    endif.
  endif.
*  if is_search_attribute = ms_freestyle_srch_attr.
*    replace first occurrence of `$ATTRIBUTE` in lv_sql_contains_fuzzy with lv_fieldname.
*    replace first occurrence of `$VALUE` in lv_sql_contains_fuzzy with lv_search_lo_str.
*    lv_sql_condition = lv_sql_contains_fuzzy.
*
*  else.
  case is_search_attribute-option.
    when 'BT'.
      lv_operator = 'BETWEEN' .
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname.
      concatenate lv_search_lo_str `AND` lv_search_hi_str  into lv_search_lo_str separated by space.
      replace first occurrence of `$VALUE` in lv_sql_condition with lv_search_lo_str.
      replace first occurrence of `$OPERATOR` in lv_sql_condition with lv_operator.

    when 'EQ'.
      if  lv_search_lo_str cs '%' or lv_is_key eq abap_true. "if the search on the field is %(*)/ it is a search on key field fuzziness doesnot apply .
        lv_operator = 'LIKE' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
      elseif ( lv_search_lo_str is initial ) or ( lv_search_lo_str = lv_empty_str ). " IS EMPTY
        if lv_internal_datatype =  'P'.
          lv_null_empty_sql_condition = lv_nullp_empty_sql_condition.
        endif.
        if iv_view_indicator eq 1.
          read table gt_mapping_info into ls_mapping_info with key model_fieldname = is_search_attribute-fieldname.
          if sy-subrc eq 0.
            lv_roll_name = ls_mapping_info-reuse_rollname.
            if lv_roll_name cs 'LONGTEXT'.
              replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname.
              replace first occurrence of `$VALUE` in lv_sql_condition with 'NULL'.
              replace first occurrence of `$OPERATOR` in lv_sql_condition with 'IS'.
            else.
              lv_operator = '=' .
              replace all occurrences of `$ATTRIBUTE` in lv_null_empty_sql_condition with lv_fieldname.
              replace first occurrence of `$VALUE` in lv_null_empty_sql_condition with ''''''.
              replace first occurrence of `$OPERATOR` in lv_null_empty_sql_condition with lv_operator.
              lv_sql_condition = lv_null_empty_sql_condition.
            endif.
          endif.
        elseif iv_view_indicator eq 2.
          read table gt_mapping_info into ls_mapping_info with key reuse_view_fieldname = is_search_attribute-fieldname.
          if sy-subrc eq 0.
            lv_roll_name = ls_mapping_info-reuse_rollname.
            if lv_roll_name cs 'LONGTEXT'.
              replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname.
              replace first occurrence of `$VALUE` in lv_sql_condition with 'NULL'.
              replace first occurrence of `$OPERATOR` in lv_sql_condition with 'IS'.
            else.
              lv_operator = '=' .
              replace all occurrences of `$ATTRIBUTE` in lv_null_empty_sql_condition with lv_fieldname.
              replace first occurrence of `$VALUE` in lv_null_empty_sql_condition with ''''''.
              replace first occurrence of `$OPERATOR` in lv_null_empty_sql_condition with lv_operator.
              lv_sql_condition = lv_null_empty_sql_condition.
            endif.
          endif.
        else.
          lv_operator = '=' .
          replace all occurrences of `$ATTRIBUTE` in lv_null_empty_sql_condition with lv_fieldname.
          replace first occurrence of `$VALUE` in lv_null_empty_sql_condition with ''''''.
          replace first occurrence of `$OPERATOR` in lv_null_empty_sql_condition with lv_operator.
          lv_sql_condition = lv_null_empty_sql_condition.
        endif.

      elseif lv_internal_datatype = if_mdg_hdb_search_constants=>decimal.
*           Don't apply fuzzy search on Decimal fields (P)
*           As of now this will be if else should be switched to CASE when we have to handle many data types.
        lv_operator = '=' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition with lv_operator.
      else.
*             Don't apply fuzzy search on technical key fields.USMD_EDTN_NUMBER, USMD_ACTIVE
        if is_search_attribute-fieldname eq if_mdg_hdb_search_constants=>usmd_edtn_number.
          lv_operator = '=' .
          replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname.
          replace first occurrence of `$VALUE` in lv_sql_condition with lv_search_lo_str.
          replace first occurrence of `$OPERATOR` in lv_sql_condition with lv_operator.

        elseif is_search_attribute-fieldname eq if_mdg_hdb_search_constants=>usmd_active.
          replace first occurrence of `$ATTRIBUTE` in lv_sql_contains with lv_fieldname.
          replace first occurrence of `$VALUE` in lv_sql_contains with lv_search_lo_str.
          lv_sql_condition = lv_sql_contains.

        elseif iv_cmplx_criteria eq abap_true.  " Complex criteria for search or Duplicate check
          if iv_case_sensitive eq abap_false. "nt_2484985 : UPPER conversion should be done for only case sensitive criteria.
            lv_operator = '=' .
            replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname.
            replace first occurrence of `$OPERATOR` in lv_sql_condition with lv_operator.
            replace first occurrence of `$VALUE` in lv_sql_condition with lv_search_lo_str.

          else.
            lv_operator = '=' .
            replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
            replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
            replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
            lv_sql_condition = lv_sql_condition_upper.

          endif.
          "3.Duplicate check threshold
        elseif gs_hana_views-ruleset is initial.
          ls_search_attribute = is_search_attribute.
          ls_search_attribute-low = lv_search_lo_str.
          data:
         lv_weight            type string.


          if iv_view_indicator = if_mdg_hdb_search_constants=>stag_view_indicator
             or iv_view_indicator = if_mdg_hdb_search_constants=>sql_view_indicator.
            read table mt_attributes into data(ls_attribute) with key attr_name = is_search_attribute-fieldname. "#EC WARNOK
            if sy-subrc = 0.
              lv_weight = ls_attribute-weigtage.

              lv_fuzzy = ls_attribute-fuzziness.
              replace first occurrence of `$VALUE` in lv_fuzzy_value with lv_fuzzy.
            endif.
          else .
            read table mt_attributes_reuse into data(ls_attribute_reuse) with key attr_name_reuse = is_search_attribute-fieldname. "#EC WARNOK
            if sy-subrc = 0.
              lv_weight = ls_attribute_reuse-weigtage.
              lv_fuzzy = ls_attribute_reuse-fuzziness.
              replace first occurrence of `$VALUE` in lv_fuzzy_value with lv_fuzzy.
            endif.
          endif.
          replace first occurrence of `$VALUE` in lv_weight_value with lv_weight.
          replace first occurrence of `$ATTRIBUTE` in lv_sql_contains_weight with is_search_attribute-fieldname.
          replace first occurrence of `$VALUE` in lv_sql_contains_weight with lv_search_lo_str.
          replace first occurrence of `$FUZZY` in lv_sql_contains_weight with lv_fuzzy_value.
          replace first occurrence of `$WEIGHT` in lv_sql_contains_weight with lv_weight_value.
          lv_sql_condition = lv_sql_contains_weight.


        elseif lv_fuzzy_conf_flag = abap_true.
          if iv_view_indicator eq 2.
            read table gt_mapping_info into ls_mapping_info with key reuse_view_fieldname = is_search_attribute-fieldname.
          elseif iv_view_indicator eq 1.
            read table gt_mapping_info into ls_mapping_info with key model_fieldname = is_search_attribute-fieldname.
          endif.
          if ls_mapping_info is not initial.
            replace first occurrence of `$ATTRIBUTE` in lv_sql_contains_fuzzy with lv_fieldname.
            replace first occurrence of `$VALUE` in lv_sql_contains_fuzzy with lv_search_lo_str.
            lv_sql_condition = lv_sql_contains_fuzzy.

          endif.
        else.
          replace first occurrence of `$ATTRIBUTE` in lv_sql_contains_fuzzy with lv_fieldname.
          replace first occurrence of `$VALUE` in lv_sql_contains_fuzzy with lv_search_lo_str.
          lv_sql_condition = lv_sql_contains_fuzzy.
        endif.
      endif.
    when 'CP'.
      lv_operator = 'LIKE' .
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
      replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
      replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
      lv_sql_condition = lv_sql_condition_upper.

    when 'LE'.
      if  lv_search_lo_str cs '%'.
        lv_operator = 'LIKE' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
      else.
        lv_operator = '<=' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
      endif.

    when 'GE'.
      if  lv_search_lo_str cs '%'.
        lv_operator = 'LIKE' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
      else.
        lv_operator = '>=' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
      endif.

    when 'NE'.
      cv_prev_oprtr_is_negation = abap_true.
      lv_condition_part2 = lv_sql_condition_upper.
      if  lv_search_lo_str cs '%'.
        lv_operator = 'NOT LIKE' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
        lv_operator = '<>' .
        replace first occurrence of `$ATTRIBUTE` in lv_condition_part2 with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_condition_part2 with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_condition_part2 with lv_operator.
        concatenate
          lv_sql_condition_upper  space 'AND' space lv_condition_part2 into lv_sql_condition_upper.
        lv_sql_condition = lv_sql_condition_upper.
      else.
        lv_operator = '<>' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
      endif.

    when 'NB'.
      cv_prev_oprtr_is_negation = abap_true.
      lv_operator = 'NOT BETWEEN' .
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
      concatenate lv_search_lo_str `AND` lv_search_hi_str  into lv_search_lo_str separated by space.
      replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
      replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.


    when 'NP'.
      cv_prev_oprtr_is_negation = abap_true.
      lv_operator = 'NOT LIKE' .
      replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
      replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
      replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
      lv_sql_condition = lv_sql_condition_upper.

    when 'LT'.
      if  lv_search_lo_str cs '%'.
        lv_operator = 'LIKE' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
        lv_operator = '<>' .
        replace first occurrence of `$ATTRIBUTE` in lv_condition_part2 with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_condition_part2 with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_condition_part2 with lv_operator.
        concatenate
          lv_sql_condition_upper  space 'AND' space lv_condition_part2 into lv_sql_condition_upper.
        lv_sql_condition = lv_sql_condition_upper.
      else.
        lv_operator = '<' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition with lv_operator.
*            lv_sql_condition = lv_sql_condition_upper.
      endif.

    when 'GT'.
      if  lv_search_lo_str cs '%'.
        lv_operator = 'LIKE' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
        lv_operator = '<>' .
        replace first occurrence of `$ATTRIBUTE` in lv_condition_part2 with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_condition_part2 with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_condition_part2 with lv_operator.
        concatenate
          lv_sql_condition_upper  space 'AND' space lv_condition_part2 into lv_sql_condition_upper.
        lv_sql_condition = lv_sql_condition_upper.
      else.
        lv_operator = '>' .
        replace first occurrence of `$ATTRIBUTE` in lv_sql_condition_upper with lv_fieldname.
        replace first occurrence of `$VALUE` in lv_sql_condition_upper with lv_search_lo_str.
        replace first occurrence of `$OPERATOR` in lv_sql_condition_upper with lv_operator.
        lv_sql_condition = lv_sql_condition_upper.
      endif.
  endcase.
*  endif.
  if lv_sql_condition is not initial.
    ev_sel_condition = lv_sql_condition.
  endif.
endmethod.


method build_query_dqdc.
  data  lv_is_active type  abap_bool.
  data lv_sel_fields          type string.
  data lv_equals_operator     type abap_bool value abap_false.
  data: lv_low          type string,
        lv_sel_stmt     type string, "#NO_TEXT
        lv_blank_search type abap_bool value abap_false,
        lv_query_part1  type string value `SELECT DISTINCT $SEL_FIELDS , (SCORE() * 100) AS _SCORE FROM "$VIEW_NAME"`.
  data lv_concatenate_term  type string.
  data lv_threshold         type string.

  constants lc_classname type  classname value 'CL_MDG_CC_2021_252631'.
  constants lc_method type  seocmpname value 'IS_ACTIVE'.

  clear: ev_sel_stmt.
  if iv_view_indicator = if_mdg_hdb_search_constants=>reuse_view_indicator.
    lv_sel_fields = REDUCE #( INIT text = `` FOR <line> IN gt_mapping_info NEXT text = text && <line>-reuse_view_fieldname && ',' ).
    data(lv_len) = strlen( lv_sel_fields ) - 1.
    lv_sel_fields = lv_sel_fields+0(lv_len).

  elseif iv_view_indicator = if_mdg_hdb_search_constants=>stag_view_indicator.
    lv_sel_fields = REDUCE #( INIT text = `` FOR <line> IN gt_mapping_info NEXT text = text && <line>-model_fieldname && ',').
    lv_len = strlen( lv_sel_fields ) - 1.
    lv_sel_fields = lv_sel_fields+0(lv_len).
  endif.

* Remove USMD_ACTIVE from input attributes as this is handled in GET_RESULTS
  data(lt_search_attr_valid) = it_search_attribute.
  read table it_search_attribute
  transporting all fields into data(ls_search_attribute) with key fieldname = if_mdg_hdb_search_constants=>usmd_active .
  if sy-subrc = 0.
    delete table lt_search_attr_valid from ls_search_attribute.
  endif.

*******************************FreeStyle Search*********************************************************
* If id_search_string is filled then perform Free style search
  if id_search_string is not initial or ( id_search_string is initial and lt_search_attr_valid is initial and it_tab_search_attribute is initial ). "#EC BOOL_OK

* Call method build_freestyle_query to get the query for Free style search
    clear : ev_sel_stmt.


* Freestyle style search will always be on attribute view Clear the Ruleset value from the member variable
    if gs_hana_views-ruleset is not initial.
      clear: gs_hana_views-ruleset.
    endif.

    call method build_query_part_init_dqdc
      exporting
        iv_view_indicator = iv_view_indicator
        iv_sel_fields_atr = lv_sel_fields
      importing
        ev_sel_stmt       = lv_query_part1.

* Validate input search term
    if id_search_string is initial.  " blank search
      lv_blank_search = abap_true.
    else.
      lv_low = id_search_string.
*      REPLACE ALL  OCCURRENCES OF '%' IN lv_low WITH '\%' IN CHARACTER MODE.
*      REPLACE ALL  OCCURRENCES OF '*' IN lv_low WITH '\*' IN CHARACTER MODE.
      replace all  occurrences of '%' in lv_low with '%' in character mode.
      replace all  occurrences of '*' in lv_low with '*' in character mode.
* Call QUOTE method for handling Security
      call method cl_abap_dyn_prg=>quote
        exporting
          val = lv_low
        receiving
          out = lv_low.

      concatenate lv_sel_stmt ' ( contains(*,' lv_low ',fuzzy))' into lv_sel_stmt. "#EC NOTEXT

    endif.

    concatenate lv_query_part1 lv_sel_stmt into lv_sel_stmt separated by space.

    if lv_blank_search eq abap_true.
      concatenate lv_sel_stmt ' CONTAINS(MANDT, ''' sy-mandt ''')' into lv_sel_stmt.
    else.
      concatenate ev_sel_stmt ' AND (MANDT = ''' sy-mandt ''')' into ev_sel_stmt.
    endif.


* Assign the final query to the exporting variable.
    ev_sel_stmt = lv_sel_stmt.

*******************************Attribute Based Search - Fuzzy ***********************************************************
  elseif lt_search_attr_valid is not initial or it_tab_search_attribute is not initial. " Fuzzy Search

* If Ruleset is defined then build the Ruleset query
    if it_tab_search_attribute is not initial . " Complex search - Build Selection condition by handling complex criteria
      handle_complx_search_crit_dqdc(
        exporting
          it_tab_search_attribute = it_tab_search_attribute
          iv_view_indicator       = iv_view_indicator
        importing
          ev_sel_condition        = data(lv_cmplx_sel_condition)
          ev_cmplx_clf            = data(lv_cmplx_criteria)
      ).
    endif.

*  Build query for it_search_attribute / Basic data

    call method build_query_part_init_dqdc
      exporting
        iv_view_indicator = iv_view_indicator
        iv_sel_fields_atr = lv_sel_fields
      importing
        ev_sel_stmt       = lv_sel_stmt.

    lv_threshold = is_search_context-threshold / 100.
    concatenate lv_sel_stmt lv_concatenate_term ' SCORE() > ' lv_threshold "#EC NOTEXT
                into lv_sel_stmt separated by space .
    lv_concatenate_term = 'AND'.




    condense lv_sel_stmt.
    ev_sel_stmt = lv_sel_stmt.

*  Construct the MANDT in CONTAINS for score calculation when no other contains clause exist
    try .
        data(lo_class) = cl_oo_class=>get_instance( lc_classname ).
        if lo_class is bound.
          call method (lc_classname)=>(lc_method) receiving rv_active = lv_is_active.
        endif.
        if lv_is_active = abap_true.
          data(lv_fuzzy_conf_flag) = abap_false.
        endif.
      catch cx_class_not_existent.
        "DO nothhing
    endtry.

    if ( lv_equals_operator eq abap_false ) or
       ( lv_equals_operator eq abap_true and lv_fuzzy_conf_flag eq abap_true ).
      concatenate ev_sel_stmt ' ' lv_concatenate_term ` CONTAINS(MANDT,'` sy-mandt `')` into ev_sel_stmt respecting blanks.
    else.
* ELSE MANDT as a simple attribute
      concatenate ev_sel_stmt ' ' lv_concatenate_term ` (MANDT = '` sy-mandt `')` into ev_sel_stmt respecting blanks.
    endif.

*  Concatenate the Basic search condition and complex search condition
    if lv_cmplx_sel_condition is not initial.
      concatenate ev_sel_stmt  'AND' lv_cmplx_sel_condition  into ev_sel_stmt separated by space.
    endif.
  endif.
endmethod.


method build_query_part_init_dqdc.
  data:
    lv_sel_stmt_score       type string value `SELECT DISTINCT $RESULT_FIELDS, (SCORE() * 100) AS _SCORE FROM "$VIEW_NAME" WHERE`,
    lv_sel_stmt_score_empty type string value `SELECT DISTINCT $RESULT_FIELDS, 100 AS _SCORE FROM "$VIEW_NAME" WHERE`,
    lv_sel_stmt             type string value `SELECT DISTINCT $RESULT_FIELDS FROM "$VIEW_NAME" WHERE`,
    lv_view_name            type mdg_hviewname,
    lv_hana_view_name_alias type string value if_mdg_hdb_search_constants=>gc_view_name_alias.


  " If reuse or staging query to be constructed
* Set view name to be used in query and the corresponding keyfields
  if iv_view_indicator eq if_mdg_hdb_search_constants=>stag_view_indicator.
    lv_view_name = gs_hana_views-hana_staging_view.
  elseif iv_view_indicator eq if_mdg_hdb_search_constants=>reuse_view_indicator.
    lv_view_name = gs_hana_views-hana_reuse_view.
  elseif iv_view_indicator eq if_mdg_hdb_search_constants=>sql_view_indicator.
    lv_view_name = gs_hana_views-hana_union_sql_view.
  elseif iv_view_indicator eq if_mdg_hdb_search_constants=>inob_view_indicator.
    lv_view_name = gs_hana_views-hana_reuse_clf_view.
  endif.

  if iv_with_score eq abap_true.
    concatenate 'AS ' lv_hana_view_name_alias ' WHERE ' into lv_hana_view_name_alias respecting blanks.

    lv_sel_stmt = lv_sel_stmt_score.

    replace all occurrences of 'WHERE' in lv_sel_stmt with lv_hana_view_name_alias.
  endif.

* 1. Specify resultlist
  replace `$VIEW_NAME` in lv_sel_stmt with lv_view_name.
  replace `$RESULT_FIELDS` in lv_sel_stmt with iv_sel_fields_atr.

  if lv_sel_stmt cs 'LNGTXT' or lv_sel_stmt cs 'TXTLG' or lv_sel_stmt cs 'LONGTEXT'
    or lv_sel_stmt cs 'URL'.
    replace all occurrences of 'DISTINCT' in lv_sel_stmt with ''.
  endif.
  ev_sel_stmt = lv_sel_stmt.
endmethod.


method check_for_reuse_query_dqdc.
  IF ( gv_only_active_records EQ abap_true AND lines( it_search_attribute ) EQ '1' AND lines( it_tab_search_attribute ) EQ '0')
      OR
     ( lines( it_search_attribute_reuse ) GT '0' OR lines( it_tab_search_attribute_reuse ) GT '0' )
      OR
     ( ( lines( it_search_attribute ) EQ '0' AND lines( it_tab_search_attribute ) EQ '0')
         AND ( lines( it_search_attribute_reuse ) EQ '0' AND lines( it_tab_search_attribute_reuse ) EQ '0') ).

    ev_construct_reuse_query = abap_true.

  ENDIF.
endmethod.


method get_mapped_search_attribs_dqdc.
  data:

    lt_search_attribute        type        usmd_ts_sel,
    lt_search_attr_valid       type        usmd_ts_sel,
    ls_search_attribute        type        usmd_s_sel,
    lt_search_attr_reuse       type        usmd_ts_sel,
    lt_search_attr_valid_reuse type        usmd_ts_sel,
    ls_search_attr_reuse       type        usmd_s_sel,
    lt_tab_search_attribute    type        tt_usmd_ts_sel,
    lt_auth_attr_reuse         type        usmd_ts_sel,
    lt_auth_attr_staging       type        usmd_ts_sel,
    ls_mapping                 type        mdg_hdb_s_reuse_mapping,
    lv_no_auth                 type        boolean,
    lv_fieldname               type       usmd_s_sel-fieldname.
  data ls_mapping_info       type          mdg_hdb_s_reuse_mapping.
  data lt_metadata_atr       type          adbc_rs_metadata_descr_tab.
  data lv_selst_atr          type          string.
*    DATA lt_mapping_info      type MDG_HDB_TT_REUSE_MAPPING.
  data ls_metadata           type          adbc_rs_metadata_descr.

  field-symbols:  <ls_search_attribute> type usmd_s_sel.
  field-symbols <lt_search_attribute> type  usmd_ts_sel.

  field-symbols:
    <ls_search_attr_reuse>      type usmd_s_sel.


  lt_tab_search_attribute = ct_tab_search_attribute.
  lt_search_attribute = ct_search_attribute.
  clear: ct_tab_search_attribute,ct_search_attribute.
************** Step 1 : From input search attributes with staging names build reuse attribute list
  try.
*        IF lt_search_attribute IS NOT INITIAL.
      loop at lt_search_attribute assigning <ls_search_attribute>.
        read table gt_mapping_info into ls_mapping
        with key model_fieldname = <ls_search_attribute>-fieldname.
        if ( sy-subrc = 0 and ls_mapping-reuse_view_fieldname is not initial ).
          ls_search_attr_reuse = <ls_search_attribute>.
          ls_search_attr_reuse-fieldname = ls_mapping-reuse_view_fieldname.
          insert ls_search_attr_reuse into table lt_search_attr_valid_reuse.
          delete table lt_search_attr_valid from <ls_search_attribute>.
        endif.
      endloop.


*************** Step 2 : Call merge_reuse_auth with reuse attribute list
      cl_usmd_pp_access_factory_ext=>get_pp_hana_search(
        exporting
          iv_model          = is_search_context-o_model->d_usmd_model " Data Model
          iv_entity         = is_search_context-entity_main " Entity Type
        receiving
          ro_pp_hana_search = data(lo_pp_access_class) " Hana Search Interface for Reuse Area
      ).
      call method lo_pp_access_class->merge_reuse_authorization
        exporting
          is_search_context    = is_search_context  " Search Context
        importing
          ev_no_authorization  = lv_no_auth   " Boolean Variable (X=True, -=False, Space=Unknown)
          et_auth_attributes   = lt_auth_attr_reuse
        changing
          ct_search_attributes = lt_search_attr_valid_reuse.   " Sorted Table: Selection Condition
      "  User has no authorisation : returned from reuse
      if lv_no_auth eq abap_true.
        return.
      endif.


************* Step 3 : Based on attributes returned build staging attribute list again
* Authorisation attributes
      loop at lt_auth_attr_reuse assigning <ls_search_attribute>.
        read table gt_mapping_info into ls_mapping with key reuse_view_fieldname = <ls_search_attribute>-fieldname.
        if ( sy-subrc = 0 and ls_mapping-model_fieldname is not initial ).
          ls_search_attribute = <ls_search_attribute>.
          ls_search_attribute-fieldname = ls_mapping-model_fieldname.
          insert ls_search_attribute into table lt_auth_attr_staging.
        endif.
      endloop.
** search attributes
* If usmd_active flag has been set , retain it
      read table lt_search_attribute into ls_search_attribute with key fieldname = if_mdg_hdb_search_constants=>usmd_active.
      clear : lt_search_attr_valid.
      if sy-subrc = 0.
        insert ls_search_attribute into table lt_search_attr_valid.
      endif.
      loop at lt_search_attr_valid_reuse assigning <ls_search_attr_reuse>.
        read table gt_mapping_info into ls_mapping
        with key reuse_view_fieldname = <ls_search_attr_reuse>-fieldname.
        if ( sy-subrc = 0 and ls_mapping-model_fieldname is not initial ).
          ls_search_attribute = <ls_search_attr_reuse>.
          ls_search_attribute-fieldname = ls_mapping-model_fieldname.
          insert ls_search_attribute into table lt_search_attr_valid.
        endif.
      endloop.
*        ENDIF.
      insert lines of lt_auth_attr_reuse into table et_auth_attr_reuse .
      insert lines of lt_auth_attr_staging into table et_auth_attr .
      insert lines of lt_search_attr_valid_reuse into table et_search_attr_reuse.
      insert lines of lt_search_attr_valid into table ct_search_attribute.


*****************************   Repeat the steps for ITAB *********************************

      if lt_tab_search_attribute is not initial.

**********Step 1 ITAB: From input search attributes with staging names build reuse attribute list
        loop at lt_tab_search_attribute assigning <lt_search_attribute>.
          clear: lt_search_attr_reuse, lt_search_attribute.
          loop at <lt_search_attribute> assigning <ls_search_attribute>.
            read table gt_mapping_info into ls_mapping
            with key model_fieldname =  <ls_search_attribute>-fieldname.
            if ( sy-subrc = 0 and ls_mapping-reuse_view_fieldname is not initial ).
              ls_search_attr_reuse = <ls_search_attribute>.
              ls_search_attr_reuse-fieldname = ls_mapping-reuse_view_fieldname.
              insert ls_search_attr_reuse into table lt_search_attr_reuse.
            endif.
            delete table <lt_search_attribute> from <ls_search_attribute>.
          endloop.

********Step 2 ITAB: Call merge_reuse_auth with reuse attribute list
          call method lo_pp_access_class->merge_reuse_authorization
            exporting
              is_search_context    = is_search_context  " Search Context
            importing
              ev_no_authorization  = lv_no_auth   " Boolean Variable
              et_auth_attributes   = lt_auth_attr_reuse
            changing
              ct_search_attributes = lt_search_attr_reuse.   " Sorted Table: Selection Condition
          "  User has no authorisation : returned from reuse
          if lv_no_auth eq abap_true.
            return.
          endif.

**********Step 3 ITAB: Based on attributes returned build staging attribute list again
*  Authorisation attributes
          loop at lt_auth_attr_reuse assigning <ls_search_attribute>.
            insert <ls_search_attribute> into table et_auth_attr_reuse.
            read table gt_mapping_info into ls_mapping with key reuse_view_fieldname = <ls_search_attribute>-fieldname.
            if ( sy-subrc = 0 and ls_mapping-model_fieldname is not initial ).
              ls_search_attribute = <ls_search_attribute>.
              ls_search_attribute-fieldname = ls_mapping-model_fieldname.
              insert ls_search_attribute into table et_auth_attr.
            endif.
          endloop.
*  search attributes
          loop at lt_search_attr_reuse assigning <ls_search_attr_reuse>.
            read table gt_mapping_info into ls_mapping
            with key reuse_view_fieldname = <ls_search_attr_reuse>-fieldname.
            if ( sy-subrc = 0 and ls_mapping-model_fieldname is not initial ).
              ls_search_attribute = <ls_search_attr_reuse>.
              ls_search_attribute-fieldname = ls_mapping-model_fieldname.
              insert ls_search_attribute into table lt_search_attribute.
            endif.
          endloop.
          insert lt_search_attr_reuse into table et_tab_search_attr_reuse.
          insert lt_search_attribute into table ct_tab_search_attribute.
*      INSERT LINES OF lt_auth_attr_reuse INTO TABLE ET_AUTH_ATTR_REUSE.
*      INSERT LINES OF lt_auth_attr_staging INTO TABLE ET_AUTH_ATTR .
        endloop.
      endif.
    catch cx_sy_itab_duplicate_key  .                   "#EC NO_HANDLER
      " donot throw error , ignore duplicates
  endtry.
endmethod.


method get_results_dqdc.
  data lv_sel_stmt      type string.
  data lt_components    type abap_component_tab.
  data ls_components    like line of lt_components.
  data lr_result_ref                 type ref to data.
  data ls_data                       type usmd_s_search_result.
  data lv_score         type p length 3 decimals 2 value '0.50'.

  try.
      call method cl_mdg_hdb_util=>get_db_conn_details
        importing
          e_dbcon_name = data(lv_con_name).
      data(lo_con) = cl_sql_connection=>get_connection( con_name = lv_con_name ).
      data(lo_stmt) = lo_con->create_statement( ).

      if is_search_context is not initial.
        call method cl_usmd_services=>entity2otc
          exporting
            i_model            = is_search_context-o_model->d_usmd_model
            i_entity           = is_search_context-entity_main
          importing
            e_object_type_code = data(lv_otc).

      endif.

      loop at gt_mapping_info into data(ls_mapping_info).
        call method cl_abap_typedescr=>describe_by_name
          exporting
            p_name         = ls_mapping_info-reuse_rollname
          receiving
            p_descr_ref    = data(lo_field_ref)
          exceptions
            type_not_found = 1
            others         = 2.
        if sy-subrc = 0.
          ls_components-name = cond #(  when iv_sel_stmt = lv_sel_stmt
                                          then ls_mapping_info-model_fieldname
                                          else ls_mapping_info-reuse_view_fieldname ).
          ls_components-type ?= lo_field_ref.
          append ls_components to lt_components.
          clear ls_components.
        endif.
      endloop.
      call method cl_abap_typedescr=>describe_by_data
        exporting
          p_data      = lv_score                 " Field
        receiving
          p_descr_ref = lo_field_ref.    " Reference to description object
      ls_components-name = if_mdg_hdb_search_constants=>score.
      ls_components-type ?= lo_field_ref.
      append ls_components to lt_components.
      clear ls_components.
      delete lt_components where name is initial.
      call method cl_abap_structdescr=>create
        exporting
          p_components = lt_components
        receiving
          p_result     = data(lo_ref_struct).

      if iv_sel_stmt_reuse is not initial and gv_is_reuse is not initial.
        data(lr_result) = lo_stmt->execute_query( statement = iv_sel_stmt_reuse ).
        do.
          create data lr_result_ref type handle  lo_ref_struct.
*   Set Parameter structure - Reference to Output Variable
          lr_result->set_param_struct( struct_ref = lr_result_ref ).
*   Fetch the next row from the result set
          data(lv_rows) = lr_result->next( ).
          if lv_rows = 0.
            exit.
          endif.
          assign lr_result_ref->* to field-symbol(<lfs_data>).
          assign component if_mdg_hdb_search_constants=>score of structure <lfs_data> to field-symbol(<lfs_score>).
          ls_data-scope = cond #( when <lfs_score> is assigned then <lfs_score> else '0.00').
          ls_data-r_data = lr_result_ref.
          append ls_data to ct_data.
        enddo.
      endif.
      if iv_sel_stmt is not initial.
        clear lr_result.
        lr_result = lo_stmt->execute_query( statement = iv_sel_stmt ).
        do.
          create data lr_result_ref type handle  lo_ref_struct.
*   Set Parameter structure - Reference to Output Variable
          lr_result->set_param_struct( struct_ref = lr_result_ref ).
*   Fetch the next row from the result set
          lv_rows = lr_result->next( ).
          if lv_rows = 0.
            exit.
          endif.
          assign lr_result_ref->* to <lfs_data>.
          assign component if_mdg_hdb_search_constants=>score of structure <lfs_data> to <lfs_score>.
          ls_data-scope = cond #( when <lfs_score> is assigned then <lfs_score> else '0.00').
          ls_data-r_data = lr_result_ref.
          append ls_data to ct_data.
        enddo.
      endif.
    catch cx_sql_exception into data(lo_ex).    " Exception Class for SQL Error
      data(lv_msg) = lo_ex->get_longtext( ).
      lv_msg = lo_ex->get_text( ).
      call method cl_mdg_hdb_search=>add_message
        exporting
          iv_message_id   = 'MDG_HDB_SEARCH'
          iv_message_type = 'E'
          iv_message_no   = '032'
        importing
          es_message      = data(ls_message).
*      append ls_message to lt_return.
      catch cx_root into data(lx_root).
  endtry.
endmethod.


method handle_complx_search_crit_dqdc.

*    When It_tab is filled
*    1) Separate classification and basic attributes from each row
*    2) Build separate query part for each row
*    3) Join these with intersect for CLF queries , concatenate with AND for basic attibutes

  types:
      tt_string type standard table of string .

  data:
    lt_search_attribute type usmd_ts_sel,
    ls_search_attribute type usmd_s_sel,
    lv_sel_condition    type string,
    lv_sel_stmt         type string,
    lv_characteristic   type atinn,
    lv_case_sensitive   type boolean,
    lv_cmplx_criteria   type boolean.

  data lt_tab_search_attr          type    tt_usmd_ts_sel.
  data lt_tab_search_attr_clf      type    tt_usmd_ts_sel.
  data lt_tab_search_attr_char     type    tt_usmd_ts_sel.
  data lt_tab_search_attr_class    type    tt_usmd_ts_sel.
  data lt_tab_sel_stmt_basic       type    tt_string.
  data lt_tab_sel_stmt_clf         type    tt_string.
  data lt_tab_sel_stmt_class       type    tt_string.
  data lt_tab_sel_stmt_char        type    tt_string.

****separate_clf_data**
*    CALL METHOD separate_clf_data
*      EXPORTING
*        it_tab_search_attribute = it_tab_search_attribute   " Table type of USMD_TS_SEL
*      IMPORTING
*        et_tab_search_attr      = lt_tab_search_attr  " Table type of USMD_TS_SEL
*        et_tab_search_attr_clf  = lt_tab_search_attr_clf.
****separate_clf_data
  data lt_search_attr_clf             type        usmd_ts_sel.
  data lt_search_attr                 type        usmd_ts_sel.
  data lt_tcla                        type        tt_tcla.
  data ls_tcla                        type        tcla.
  data lv_classtype                   type        klassenart.
  data lv_ruleset                     type        usmd_ruleset_name.
  data: ls_search_condition           type        usmd_s_sel.
  data: lv_suffix                     type        string.
  field-symbols:<lt_search_condition> type usmd_ts_sel,
                <ls_search_condition> type usmd_s_sel.


  if it_tab_search_attribute is initial.
    return.
  endif.

*     Prepare data
  loop at it_tab_search_attribute assigning <lt_search_condition>.
    clear: lt_search_attr,lt_search_attr_clf .
*       check if search conditions contain class information
    loop at <lt_search_condition> assigning <ls_search_condition>.
      case <ls_search_condition>-fieldname.
        when  if_mdg_hdb_search_constants=>gc_classasgn_changeno or
          if_mdg_hdb_search_constants=>gc_classasgn_ecocntr or
          if_mdg_hdb_search_constants=>gc_classasgn_guid or
          if_mdg_hdb_search_constants=>gc_valuation_changeno or
          if_mdg_hdb_search_constants=>gc_valuation_ecocntr or
          if_mdg_hdb_search_constants=>gc_valuation_guid or
          if_mdg_hdb_search_constants=>gc_field_ecocntr or
          if_mdg_hdb_search_constants=>gc_field_class_guid or
          if_mdg_hdb_search_constants=>gc_field_changeno or
          if_mdg_hdb_search_constants=>gc_field_datuv or
          if_mdg_hdb_search_constants=>gc_field_lkenz or
          if_mdg_hdb_search_constants=>gc_field_clstatus or
          if_mdg_hdb_search_constants=>gc_field_ecocntr_reuse or
          if_mdg_hdb_search_constants=>gc_field_changeno_reuse or
          if_mdg_hdb_search_constants=>gc_field_datuv_reuse or
          if_mdg_hdb_search_constants=>gc_field_lkenz_reuse or
          if_mdg_hdb_search_constants=>gc_field_clstatus_reuse or
          if_mdg_hdb_search_constants=>gc_field_lkenz_reuse or
          if_mdg_hdb_search_constants=>gc_field_charid or
          if_mdg_hdb_search_constants=>gc_field_atwrt or
          if_mdg_hdb_search_constants=>gc_field_atflb or
          if_mdg_hdb_search_constants=>gc_field_atflv or
          if_mdg_hdb_search_constants=>gc_field_atinn or
          if_mdg_hdb_search_constants=>gc_field_val_lkenz or
          if_mdg_hdb_search_constants=>gc_field_val_datuv or
          if_mdg_hdb_search_constants=>gc_field_val_ecocntr_reuse or
          if_mdg_hdb_search_constants=>gc_field_val_changeno_reuse or
          if_mdg_hdb_search_constants=>gc_field_val_lkenz_reuse or
          if_mdg_hdb_search_constants=>gc_field_val_datuv_reuse or
          if_mdg_hdb_search_constants=>gc_field_val_atwrt_reuse or
          if_mdg_hdb_search_constants=>gc_field_val_atflb_reuse or
          if_mdg_hdb_search_constants=>gc_field_val_atflv_reuse or
          if_mdg_hdb_search_constants=>gc_field_val_atinn_reuse.
          insert <ls_search_condition> into table lt_search_attr_clf.

        when
            if_mdg_hdb_search_constants=>gc_field_class or
            if_mdg_hdb_search_constants=>gc_field_clint or
            if_mdg_hdb_search_constants=>gc_valuation_classtype or
            if_mdg_hdb_search_constants=>gc_classasgn_classtype or
            if_mdg_hdb_search_constants=>gc_field_classtype_reuse or
            if_mdg_hdb_search_constants=>gc_field_val_classtype_reuse or
            if_mdg_hdb_search_constants=>gc_field_clint_reuse.

*            READ TABLE mt_cmplx_search_attr_temp TRANSPORTING NO FIELDS WITH TABLE KEY
*            fieldname = <ls_search_condition>-fieldname
*            sign = <ls_search_condition>-option
*            option = <ls_search_condition>-sign
*            low = <ls_search_condition>-low
*            high = <ls_search_condition>-high .
*            IF sy-subrc <> 0.
*              INSERT <ls_search_condition> INTO TABLE mt_cmplx_search_attr_temp.
*              INSERT <ls_search_condition> INTO TABLE lt_search_attr_clf.
*            ENDIF.
*           Store classtype to determine multiobject support
          if lv_classtype is initial and ( <ls_search_condition>-fieldname = if_mdg_hdb_search_constants=>gc_field_classtype_reuse or
            <ls_search_condition>-fieldname = if_mdg_hdb_search_constants=>gc_field_val_classtype_reuse or
            <ls_search_condition>-fieldname = if_mdg_hdb_search_constants=>gc_classasgn_classtype or
            <ls_search_condition>-fieldname = if_mdg_hdb_search_constants=>gc_valuation_classtype ).
            lv_classtype  = <ls_search_condition>-low.
          endif.
        when others.
          " TODO : check for a simpler way of comaprison
            READ TABLE mt_cmplx_search_attr_temp TRANSPORTING NO FIELDS WITH TABLE KEY
              fieldname = <ls_search_condition>-fieldname
              sign = <ls_search_condition>-option
              option = <ls_search_condition>-sign
              low = <ls_search_condition>-low
              high = <ls_search_condition>-high .
            IF sy-subrc <> 0.
              INSERT <ls_search_condition> INTO TABLE mt_cmplx_search_attr_temp.
              INSERT <ls_search_condition> INTO TABLE lt_search_attr.  " in Duplicate check Basic attributes are also part of ITAB
            ENDIF.
      endcase.
    endloop.
    if lt_search_attr is not initial.
      insert lt_search_attr into table lt_tab_search_attr.
    endif.
    if lt_search_attr_clf is not initial.
      insert lt_search_attr_clf into table lt_tab_search_attr_clf.
    endif.
  endloop.



* If the classtype supports multiobject query upon INOB views
  call method cl_mdg_hdb_util=>get_tclax
    exporting
      iv_objtype   = if_mdg_hdb_search_constants=>gc_object_material_main_table " Name of database table for object  "TODO : Use constant
      iv_classtype = lv_classtype
    receiving
      et_tclax     = lt_tcla.  " Class Type Info
  read table lt_tcla index 1 into ls_tcla.
  if ls_tcla-multobj eq abap_true.
    " If classfication supports multiple object type use Reuse INOB view.
    if gs_hana_views-hana_reuse_clf_view is initial.
      concatenate
      gs_hana_views-hana_staging_view if_mdg_hdb_search_constants=>inob_view_suffix
      into gs_hana_views-hana_reuse_clf_view.
    endif.
    if gs_hana_views-ruleset is not initial.
      lv_ruleset = gs_hana_views-ruleset.
      split lv_ruleset at '.searchruleset' into lv_ruleset lv_suffix. "#EC NOTEXT '/'
      concatenate lv_ruleset if_mdg_hdb_search_constants=>inob_view_suffix lv_suffix into lv_ruleset.
      gs_hana_views-ruleset_clf = lv_ruleset.
    endif.
  endif.
****separate_clf_data**

  loop at lt_tab_search_attr into lt_search_attribute.
    call method join_query_parts_dqdc
      exporting
        iv_cmplx_criteria   = lv_cmplx_criteria
        it_search_attribute = lt_search_attribute   " Table type of USMD_TS_SEL
        iv_view_indicator   = iv_view_indicator
      importing
        ev_sel_condition    = lv_sel_condition.

* TABLE 1 : Basic Search attr
    insert lv_sel_condition into table lt_tab_sel_stmt_basic.
  endloop.


  if lt_tab_search_attr_clf is not initial.
    " Query part for classification
    lv_cmplx_criteria = abap_true. " Now set complex condition to true so that contains clause is not used
    loop at lt_tab_search_attr_clf into lt_search_attribute.
      " check if the fieldname is ATWRT and if ATINN is case sensitive
      if iv_view_indicator = if_mdg_hdb_search_constants=>stag_view_indicator or
         iv_view_indicator = if_mdg_hdb_search_constants=>sql_view_indicator.
        read table lt_search_attribute
        transporting no fields with key fieldname = if_mdg_hdb_search_constants=>gc_field_atwrt.
        if sy-subrc = 0.
          read table lt_search_attribute transporting all fields into ls_search_attribute
          with key fieldname = if_mdg_hdb_search_constants=>gc_field_atinn.
          lv_characteristic = ls_search_attribute-low.
        endif.
      else.
        read table lt_search_attribute
       transporting no fields with key fieldname = if_mdg_hdb_search_constants=>gc_field_val_atwrt_reuse.
        if sy-subrc = 0.
          read table lt_search_attribute transporting all fields into ls_search_attribute
          with key fieldname = if_mdg_hdb_search_constants=>gc_field_val_atinn_reuse.
          lv_characteristic = ls_search_attribute-low.
        endif.
      endif.

      clear:lv_case_sensitive.
      if lv_characteristic is not initial.

        call method cl_mdg_hdb_util=>check_atinn_case_sensitivity
          exporting
            iv_atinn          = lv_characteristic   " Internal characteristic
          importing
            ev_case_sensitive = lv_case_sensitive.   " Boolean Variable (X=True, -=False, Space=Unknown)
      endif.
      call method join_query_parts_dqdc
        exporting
          iv_cmplx_criteria   = lv_cmplx_criteria
          it_search_attribute = lt_search_attribute   " Table type of USMD_TS_SEL
          iv_view_indicator   = iv_view_indicator
          iv_case_sensitive   = lv_case_sensitive
        importing
          ev_sel_condition    = lv_sel_condition.

*     TABLE 2 : sel condition for classification
      insert lv_sel_condition into table lt_tab_sel_stmt_clf .
    endloop.
  endif.


*   Join Basic search condition , complx search condition
*    CALL METHOD combine_cmplx_qry_prts
*      EXPORTING
*        it_sel_stmt_basic = lt_tab_sel_stmt_basic
*        it_sel_stmt_clf   = lt_tab_sel_stmt_clf
*        it_sel_stmt_class = lt_tab_sel_stmt_class
*        it_sel_stmt_char  = lt_tab_sel_stmt_char
*        iv_view_indicator = iv_view_indicator
*      IMPORTING
*        ev_sel_stmt       = lv_sel_stmt.
*    ev_sel_condition = lv_sel_stmt.
*    ev_cmplx_clf = lv_cmplx_criteria.
  """"Combine code
  data:
    lv_sel_fields           type string,
    lv_sel_stmt_init        type string,
    lv_sel_stmt_class       type string,
    lv_sel_stmt_char        type string,
    lv_sel_key              type string,
    lv_view_indicator       type int2,
    lv_sel_stmt_cmplx       type string,
    lv_sel_stmt_basic       type string,
    lt_key_field            type usmd_ts_field,
    ls_key_field            type usmd_s_field,
    lv_key_fields           type string,
    lv_selstmt_init         type string,
    lv_sel_condtn           type string,
    lv_tmp_selstmt          type string,
    lv_isempty_selstmt      type string,
    lv_index_stag           type i value 0,
    lv_index_charid         type i value 0,
    lv_atinn_sel_condition  type string,
    lv_charid_sel_condition type string.

  " If reuse or staging query to be constructed
*  if iv_view_indicator eq if_mdg_hdb_search_constants=>stag_view_indicator
*     or iv_view_indicator eq if_mdg_hdb_search_constants=>sql_view_indicator.
*    lt_key_field = gt_key_field.
*  elseif iv_view_indicator eq if_mdg_hdb_search_constants=>reuse_view_indicator
*     or iv_view_indicator eq if_mdg_hdb_search_constants=>inob_view_indicator.
*    lt_key_field = gt_key_field_reuse.
*  endif.
*
*  " Build resultlist / selection fields structure
*  loop at lt_key_field into ls_key_field.
*    if lv_sel_fields is initial.
*      lv_sel_fields = ls_key_field-fieldname.
*    else.
*      concatenate lv_sel_fields ',' ls_key_field-fieldname into lv_sel_fields.
*    endif.
*  endloop.
  lv_sel_fields = '*'.


  loop at lt_tab_sel_stmt_basic into lv_sel_condition.
    concatenate '(' lv_sel_condition ')' into lv_sel_condition.
    if lv_sel_stmt is initial.
      lv_sel_stmt = lv_sel_condition.
    else.
*        IF ( gv_search_context_update_mode = 'I' OR gv_search_context_update_mode = 'U' ).
*          CONCATENATE '(' lv_sel_stmt ')' space  'OR' space '(' lv_sel_condition ')' INTO lv_sel_stmt SEPARATED BY space.
*        ELSE.
      concatenate '(' lv_sel_stmt ')' space  'AND' space '(' lv_sel_condition ')' into lv_sel_stmt separated by space.
*        ENDIF.
    endif.
  endloop.



  if lt_tab_sel_stmt_clf is not initial.
**************************************************** CLASSIFICATION ATTRIBUTES ***************************************
    if gs_hana_views-hana_reuse_clf_view is initial or iv_view_indicator = if_mdg_hdb_search_constants=>stag_view_indicator.
      lv_view_indicator = iv_view_indicator.   " TODO : If basic attr shld be searched in reuse view and clf in INOB view ??
    else.
      lv_view_indicator = if_mdg_hdb_search_constants=>inob_view_indicator.
    endif.
    call method build_query_part_init_dqdc
      exporting
        iv_view_indicator = lv_view_indicator
        iv_sel_fields_atr = lv_sel_fields                       "  pass the keyfields
        iv_with_score     = abap_false
      importing
        ev_sel_stmt       = lv_sel_stmt_init.


    if lv_sel_stmt is not initial.
      lv_sel_stmt_basic = lv_sel_stmt.
      clear : lv_sel_stmt.
    endif.

************************************ INTERSECT -- REPLACED BY EXISTS Clause


    loop at lt_tab_sel_stmt_clf into lv_sel_condition.
      concatenate ' = ' if_mdg_hdb_search_constants=>gc_view_name_alias into lv_sel_key.
      lv_sel_key = lv_sel_key && '.' && ls_key_field-fieldname.
      concatenate lv_sel_stmt_init lv_sel_condition 'AND ' ls_key_field-fieldname lv_sel_key into lv_sel_stmt_cmplx separated by space.
      if lv_sel_stmt is initial.
        concatenate ' EXISTS (' lv_sel_stmt_cmplx ' )' into lv_sel_stmt_cmplx separated by space.
        lv_sel_stmt = lv_sel_stmt_cmplx.
      else.
        concatenate  lv_sel_stmt 'AND EXISTS ( ' lv_sel_stmt_cmplx ')' into lv_sel_stmt separated by space.
      endif.
    endloop.


    " If reuse or staging keyfields to be used
*    if iv_view_indicator eq if_mdg_hdb_search_constants=>stag_view_indicator
*       or iv_view_indicator eq if_mdg_hdb_search_constants=>sql_view_indicator.
*      lt_key_field = gt_key_field.
*    elseif iv_view_indicator eq if_mdg_hdb_search_constants=>reuse_view_indicator
*      or iv_view_indicator eq if_mdg_hdb_search_constants=>inob_view_indicator.
*      lt_key_field = gt_key_field_reuse.
*    endif.

    " Build resultlist / selection fields structure
*    loop at lt_key_field into ls_key_field.
*      if lv_key_fields is initial.
*        lv_key_fields = ls_key_field-fieldname.
*      else.
*        concatenate lv_key_fields ',' ls_key_field-fieldname into lv_key_fields.
*      endif.
*    endloop.
    if lv_sel_stmt_basic is not initial.  " basic search condition
      concatenate '(' lv_sel_stmt_basic  ') AND (' lv_sel_stmt ')' into lv_sel_stmt separated by space.
    else.
      concatenate '(' lv_sel_stmt ')' into lv_sel_stmt separated by space.
    endif.
  endif. " CLF

*   If search is based on is_empty characteristics
  if cl_mdg_cc_2020_230662=>is_active( ) = abap_true.
    if iv_view_indicator = if_mdg_hdb_search_constants=>reuse_view_indicator and gv_isempty_char = abap_true.
      split lv_sel_stmt at 'WHERE' into lv_selstmt_init lv_sel_condtn.
      concatenate lv_selstmt_init 'WHERE ' into lv_tmp_selstmt.
      replace all occurrences of ' IN ' in lv_tmp_selstmt with ' NOT IN '. "Prefixed and suffixed with space to avoid replacing of string ATINN
*      loop at gt_atinn_sel_condition into lv_atinn_sel_condition.
*        clear lv_isempty_selstmt.
*        concatenate space 'AND' space lv_tmp_selstmt '(' lv_atinn_sel_condition ') )' into lv_isempty_selstmt separated by space.
*        concatenate lv_sel_stmt lv_isempty_selstmt into lv_sel_stmt.
*      endloop.
*      if gt_atinn_sel_condition is not initial.
*        concatenate lv_sel_stmt ' ) ' into lv_sel_stmt respecting blanks.
*      endif.
    elseif iv_view_indicator = if_mdg_hdb_search_constants=>stag_view_indicator and gv_isempty_char = abap_true.
      split lv_sel_stmt at 'WHERE' into lv_selstmt_init lv_sel_condtn.
      concatenate lv_selstmt_init 'WHERE ' into lv_tmp_selstmt.
      replace all occurrences of ' IN ' in lv_tmp_selstmt with ' NOT IN '. "Prefixed and suffixed with space to avoid replacing of string ATINN
*      loop at gt_charid_sel_condition into lv_charid_sel_condition.
*        clear lv_isempty_selstmt.
*        concatenate space 'AND' space lv_tmp_selstmt '(' lv_charid_sel_condition ') )' into lv_isempty_selstmt separated by space.
*        concatenate lv_sel_stmt lv_isempty_selstmt into lv_sel_stmt.
*      endloop.
*      if gt_atinn_sel_condition is not initial.
*        concatenate lv_sel_stmt ' ) ' into lv_sel_stmt respecting blanks.
*      endif.
    endif.
  endif.

  ev_sel_condition = lv_sel_stmt.
endmethod.


method join_query_parts_dqdc.
*    This method concatenates each query condition with AND / OR
*    and handles grouping based on same attributes
*    Between same attributes we use OR condition , except when the operators are not negated
*    different attributes should be concatenated with AND

    DATA:  lv_sel_stmt          TYPE string,
           lv_sel_condition     TYPE string,
           lv_concatenate_term  TYPE c LENGTH 5,
           lv_first_loop        TYPE boolean,
           lt_distinct_attr     TYPE TABLE OF fieldname,
           lt_key_field         TYPE usmd_ts_sel,           "#EC NEEDED
           lv_prev_oprtr_is_negation   TYPE boolean,
           lt_search_attribute  TYPE usmd_ts_sel,
           lt_search_char_range_values TYPE usmd_ts_sel,
           lv_sel_cond_char_range_values TYPE string,
           lv_isempty_char      TYPE boolean,
           lv_isempty_condition TYPE string,
           lv_usmd_active_cond  TYPE string,
           lv_dummy_condtn      TYPE string.

    FIELD-SYMBOLS:
          <ls_search_attribute> TYPE usmd_s_sel,
          <lv_attr>             TYPE fieldname.


    IF it_search_attribute IS INITIAL.
      RETURN.
    ELSE.
      lt_search_attribute = it_search_attribute.
    ENDIF.

    IF cl_mdg_cc_2020_230662=>is_active( ) = abap_true.
      CLEAR: lv_isempty_char.
*    If search is based on is_empty characteristics set flag GC_ISEMPTY_CHAR to true by checking ATWRT or ATFLV entries
      LOOP AT lt_search_attribute ASSIGNING <ls_search_attribute>.
       IF iv_view_indicator = if_mdg_hdb_search_constants=>stag_view_indicator.
        IF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_atwrt AND <ls_search_attribute>-sign EQ 'I' AND <ls_search_attribute>-option EQ 'EQ'
        AND <ls_search_attribute>-low IS INITIAL AND <ls_search_attribute>-high IS INITIAL.
          lv_isempty_char = abap_true.
          EXIT.
        ELSEIF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_atflv AND <ls_search_attribute>-sign EQ 'I' AND <ls_search_attribute>-option EQ 'EQ'
        AND ( <ls_search_attribute>-low = '0.0000000000000000E+00' OR <ls_search_attribute>-low = '0' ) AND <ls_search_attribute>-high IS INITIAL.
          lv_isempty_char = abap_true.
          EXIT.
        ENDIF.
       ELSEIF iv_view_indicator = if_mdg_hdb_search_constants=>reuse_view_indicator.
        IF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_val_atwrt_reuse AND <ls_search_attribute>-sign EQ 'I' AND <ls_search_attribute>-option EQ 'EQ'
        AND <ls_search_attribute>-low IS INITIAL AND <ls_search_attribute>-high IS INITIAL.
          lv_isempty_char = abap_true.
          EXIT.
        ELSEIF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_val_atflv_reuse AND <ls_search_attribute>-sign EQ 'I' AND <ls_search_attribute>-option EQ 'EQ'
        AND ( <ls_search_attribute>-low = '0.0000000000000000E+00' OR <ls_search_attribute>-low = '0' ) AND <ls_search_attribute>-high IS INITIAL.
          lv_isempty_char = abap_true.
          EXIT.
        ENDIF.
       ENDIF.
      ENDLOOP.
      IF lv_isempty_char EQ abap_true.
        gv_isempty_char = abap_true.    "Set this flag to true if search includes any is_empty char. This is to be used in method COMBINE_CMPLX_QRY_PRTS
      ENDIF.
    ENDIF.

    IF iv_view_indicator = if_mdg_hdb_search_constants=>stag_view_indicator OR
       iv_view_indicator = if_mdg_hdb_search_constants=>sql_view_indicator.
      READ TABLE it_search_attribute TRANSPORTING NO FIELDS WITH KEY fieldname = if_mdg_hdb_search_constants=>gc_field_charid.
    ELSE.
      READ TABLE it_search_attribute TRANSPORTING NO FIELDS WITH KEY fieldname = if_mdg_hdb_search_constants=>gc_field_val_atinn_reuse.
    ENDIF.
    IF sy-subrc = 0.
***separate_char_range_value**
*      me->separate_char_range_values(
*        EXPORTING
*          it_search_attribute       =  it_search_attribute   " Sorted Table: Selection Condition (Range per Field)
*        IMPORTING
*          et_search_attr            =  lt_search_attribute   " Sorted Table: Selection Condition (Range per Field)
*          et_search_attr_char_value =  lt_search_char_range_values    " Sorted Table: Selection Condition (Range per Field)
*      ).
***separate_char_range_value**
      DATA  lt_search_char_values    TYPE        usmd_ts_sel.
    DATA  lt_search_attr           TYPE        usmd_ts_sel.
    DATA: ls_search_condition      TYPE        usmd_s_sel.

    FIELD-SYMBOLS : <lt_search_condition>  TYPE usmd_ts_sel.
    FIELD-SYMBOLS : <ls_search_condition>  TYPE usmd_s_sel.


    IF it_search_attribute IS INITIAL.
      RETURN.
    ENDIF.

*     Prepare data
    LOOP AT it_search_attribute ASSIGNING <ls_search_condition>.
*       check if search conditions contain class information

      CASE <ls_search_condition>-fieldname.
        WHEN
          if_mdg_hdb_search_constants=>gc_field_atflb OR
          if_mdg_hdb_search_constants=>gc_field_atflv OR
          if_mdg_hdb_search_constants=>gc_field_val_atflb_reuse OR
          if_mdg_hdb_search_constants=>gc_field_val_atflv_reuse.
          INSERT <ls_search_condition> INTO TABLE lt_search_char_values.
        WHEN OTHERS.
          INSERT <ls_search_condition> INTO TABLE lt_search_attr.  " in Duplicate check Basic attributes are also part of ITAB
      ENDCASE.
    ENDLOOP.
    lt_search_attribute = lt_search_attr.
    lt_search_char_range_values = lt_search_char_values.
***separate_char_range_value**

      build_clf_query_on_atcod_dqdc(
        EXPORTING
          it_search_attribute =  lt_search_char_range_values   " Sorted Table: Selection Condition (Range per Field)
          iv_view_indicator   =  iv_view_indicator   " Boolean Variable (X=True, -=False, Space=Unknown)
        IMPORTING
          ev_sel_condition    =  lv_sel_cond_char_range_values
      ).
    ENDIF.
    LOOP AT lt_search_attribute ASSIGNING <ls_search_attribute>.
      INSERT <ls_search_attribute>-fieldname INTO TABLE lt_distinct_attr.
    ENDLOOP.
    DELETE ADJACENT DUPLICATES FROM lt_distinct_attr.

* 2. Fill attributes and its input selection value
    LOOP AT lt_distinct_attr ASSIGNING <lv_attr>.
* this loop is visited at every new attribute in search attributes list
* Append the AND if lv_sel_stmt is not Initial
      IF lv_sel_stmt IS NOT INITIAL.
        CONCATENATE lv_sel_stmt space 'AND' space INTO lv_sel_stmt RESPECTING BLANKS.
        CONDENSE lv_sel_stmt.
      ENDIF.
      CONCATENATE lv_sel_stmt '(' INTO lv_sel_stmt.

      lv_first_loop = abap_true.
      LOOP AT lt_search_attribute ASSIGNING <ls_search_attribute> WHERE fieldname = <lv_attr>.
        " APPEND 'OR' - this loop is visited if same attribute is passed multiple times in search attributes list

* Concatenate AND when we have more than one NOT based option i.e NB, NP, NE. This is required
        IF lv_first_loop = abap_false AND lv_sel_stmt IS NOT INITIAL.
          " Concatenation term has to be 'AND' when grouping atibutes with option Not
          IF ( lv_prev_oprtr_is_negation EQ abap_true ) AND
            ( <ls_search_attribute>-option EQ 'NE' OR <ls_search_attribute>-option EQ 'NB' OR <ls_search_attribute>-option EQ 'NP') .
            lv_concatenate_term = 'AND'.
            CONCATENATE lv_sel_stmt space lv_concatenate_term space INTO lv_sel_stmt RESPECTING BLANKS.
            CONDENSE lv_sel_stmt.
          ELSE.
            lv_concatenate_term = 'OR'.
            CONCATENATE lv_sel_stmt space lv_concatenate_term space INTO lv_sel_stmt RESPECTING BLANKS.
            CONDENSE lv_sel_stmt.
          ENDIF.
        ENDIF.

        lv_first_loop = abap_false.

        build_query_condition_dqdc(
          EXPORTING
            iv_cmplx_criteria             =   iv_cmplx_criteria
            is_search_attribute           =   <ls_search_attribute>  " Row Structure: Selection Condition (Range per Field)
            iv_view_indicator             =   iv_view_indicator      " HANA View Name
            iv_case_sensitive             =   iv_case_sensitive
          IMPORTING
            ev_sel_condition              =   lv_sel_condition
          CHANGING
            cv_prev_oprtr_is_negation     =   lv_prev_oprtr_is_negation " Boolean Variable (X=True, -=False, Space=Unknown)
        ).

        IF cl_mdg_cc_2020_230662=>is_active( ) = abap_true.
*         If search is based on is_empty characteristics then do not join query condition of ATINN and ATWRT for reuse.
*          ATINN and ATWRT/ATFLV condition will be added in method COMBINE_CMPLX_QRY_PRTS
          IF iv_view_indicator = if_mdg_hdb_search_constants=>reuse_view_indicator AND lv_isempty_char = abap_true.
            " If the same characteristic is searched with other operators along with is_empty then remove empty ( OR & ( AND from lv_sel_stmt
            REPLACE ALL OCCURRENCES OF '( OR' IN lv_sel_stmt WITH '('.
            REPLACE ALL OCCURRENCES OF '( AND' IN lv_sel_stmt WITH '('.

*            IF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_val_atinn_reuse.
*              IF lt_search_char_range_values IS NOT INITIAL.
*                lv_isempty_condition = '(AUSP_ATFLV <> ''0'')'.
*                CONCATENATE lv_sel_condition 'AND' lv_isempty_condition INTO lv_sel_condition SEPARATED BY space.
*              ELSE.
*                lv_isempty_condition = '(AUSP_ATWRT <> '''')'.
*                CONCATENATE lv_sel_condition 'AND' lv_isempty_condition INTO lv_sel_condition SEPARATED BY space.
*              ENDIF.
*              INSERT lv_sel_condition INTO TABLE gt_atinn_sel_condition. "Select condition for ATINN and ATWRT/ATFLV
*              CONTINUE.
*              "To handle is_empty search of material with only class assigned and all characteristics unassigned.
*              "In this scenario AUSP_KLART will be NULL.
*            ELSEIF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_val_classtype_reuse.
*              SPLIT lv_sel_condition AT '=' INTO lv_isempty_condition lv_dummy_condtn.
*              CONCATENATE lv_isempty_condition 'IS NULL)' INTO lv_isempty_condition SEPARATED BY space.
*              CONCATENATE lv_sel_condition 'OR' lv_isempty_condition INTO lv_sel_condition SEPARATED BY space.
*            ELSEIF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_val_atwrt_reuse
*            OR <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_val_atflv_reuse.
*              CONTINUE.
*            ENDIF.
          ELSEIF iv_view_indicator = if_mdg_hdb_search_constants=>stag_view_indicator AND lv_isempty_char = abap_true.
            REPLACE ALL OCCURRENCES OF '( OR' IN lv_sel_stmt WITH '('.
            REPLACE ALL OCCURRENCES OF '( AND' IN lv_sel_stmt WITH '('.
*            IF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_charid.
*              IF lt_search_char_range_values IS NOT INITIAL.
*                lv_isempty_condition = '(ATFLV <> ''0'')'.
*                CONCATENATE lv_sel_condition 'AND' lv_isempty_condition INTO lv_sel_condition SEPARATED BY space.
*              ELSE.
*                lv_isempty_condition = '(ATWRT <> '''')'.
*                CONCATENATE lv_sel_condition 'AND' lv_isempty_condition INTO lv_sel_condition SEPARATED BY space.
*              ENDIF.
*              lv_usmd_active_cond = '(USMD_ACTIVE = ''0'')'.
*              CONCATENATE lv_sel_condition 'AND' lv_usmd_active_cond INTO lv_sel_condition SEPARATED BY space.
*              INSERT lv_sel_condition INTO TABLE gt_charid_sel_condition.         "Select condition for CHARID and ATWRT/ATFLV
*              CONTINUE.
*              "To handle is_empty search of material with only class assigned and all characteristics unassigned.
*              "In this scenario VALUATION_CLASSTYPE will be NULL.
*            ELSEIF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_valuation_classtype.
*              SPLIT lv_sel_condition AT '=' INTO lv_isempty_condition lv_dummy_condtn.
*              CONCATENATE lv_isempty_condition 'IS NULL)' INTO lv_isempty_condition SEPARATED BY space.
*              CONCATENATE lv_sel_condition 'OR' lv_isempty_condition INTO lv_sel_condition SEPARATED BY space.
*            ELSEIF <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_atwrt
*            OR <ls_search_attribute>-fieldname = if_mdg_hdb_search_constants=>gc_field_atflv.
*              CONTINUE.
*            ENDIF.
          ENDIF.
        ENDIF.

        CONCATENATE lv_sel_stmt lv_sel_condition INTO lv_sel_stmt SEPARATED BY space.
        INSERT <ls_search_attribute> INTO TABLE mt_cmplx_search_attr_temp. " This is used for comparison during separation of cmplx data
      ENDLOOP.
      IF lv_sel_stmt IS NOT INITIAL.
        CONCATENATE lv_sel_stmt ')' INTO lv_sel_stmt.
      ENDIF.
    ENDLOOP.

    IF cl_mdg_cc_2020_230662=>is_active( ) = abap_true.
      REPLACE ALL OCCURRENCES OF '() AND' IN lv_sel_stmt WITH ''.     " If any search attribute was skipped then remove empty () from lv_sel_stmt
    ENDIF.

    IF cl_mdg_cc_2020_230662=>is_active( ) = abap_true.
      IF lv_isempty_char = abap_true.
        "lv_sel_cond_char_range_values not required in lv_sel_stmt for is_empty characteristic search
      ELSE.
        IF lv_sel_cond_char_range_values IS NOT INITIAL.
          CONCATENATE lv_sel_stmt `AND` lv_sel_cond_char_range_values INTO lv_sel_stmt SEPARATED BY space.
        ENDIF.
      ENDIF.
    ELSE.
      IF lv_sel_cond_char_range_values IS NOT INITIAL.
        CONCATENATE lv_sel_stmt `AND` lv_sel_cond_char_range_values INTO lv_sel_stmt SEPARATED BY space.
      ENDIF.
    ENDIF.
    ev_sel_condition = lv_sel_stmt.
endmethod.


method get_duplicate_records.
  types: begin of lty_temp_usmd_table,
           fieldname type  fieldname,
           sign      type  ddsign,
           option    type  ddoption,
           low       type  usmd_value,
           high1     type  usmd_value,
         end of lty_temp_usmd_table.

  data lt_search_attribute_temp type usmd_ts_sel.
  data lt_temp_usmd_table       type table of lty_temp_usmd_table.
  data lt_search_attribute      type usmd_ts_sel.
  data lt_tab_search_attribute  type tt_usmd_ts_sel.
  data lt_duplicates            type usmd_t_search_result.

  data ls_search_attribute      type usmd_s_sel.
  data ls_search_context        type usmd_s_search_context.
  data ls_metadata              type adbc_rs_metadata_descr.
  data ls_mapping_info          like line of gt_mapping_info.
  data ls_attribute_reuse       type mdg_sdq_s_reuse_dup_attr.
*  data ls_duplicates            like line of et_duplicates.
  data ls_search_key            type usmd_s_value.
  data ls_temp_usmd_table       type lty_temp_usmd_table.

  data lv_selst_atr             type string.
  data lv_conv_value            type char16.
  data lv_search_string         type string.

  field-symbols <lfs_data>      type standard table.
  field-symbols <lfs_struct>    type any.
  field-symbols <lfs_field>     type any.

  ""Deserialize
  gv_default_fuzzy = gv_default_weight = abap_true.
  clear: gv_only_active_records, gs_hana_views, gv_is_reuse, gv_isempty_char,
          gt_mapping_info, mt_attributes_reuse.

  if i_model is not initial and i_scope is not initial and i_tempid is not initial.
    select * from yztab_templt_det into table @data(lt_templt_data)
        where usmd_model = @i_model and scope_id = @i_scope and template_id = @i_tempid
        and view_id = '01' and usmd_active = 'X'.
    if sy-subrc = 0.
      sort lt_templt_data by column_id.
    endif.

    read table lt_templt_data into data(ls_templt_det)
      with key view_id = '01' column_id = '01' is_key = 'X' included = 'X' usmd_active = 'X'.
    if sy-subrc = 0.
      data(lv_primary_entity) = ls_templt_det-usmd_entity.
      data(lv_key_attrib) = ls_templt_det-usmd_attribute.
    endif.
  else.
    lv_primary_entity = i_primary_entity.
    lv_key_attrib = i_key_attribute.
  endif.

  assign is_data->* to field-symbol(<lfs_data_full>).

  select from yztabl_dqdc_conf fields * where usmd_search_mode = 'HA' and usmd_model = @i_model
    and scope_id = @i_scope and template_id = @i_tempid
    into table @data(lt_dqdc).
  if sy-subrc = 0.
    sort lt_dqdc by attr_sequence.
  endif.

  call method cl_usmd_model_ext=>get_instance
    exporting
      i_usmd_model = i_model
    importing
      eo_instance  = data(lo_model_ext).

  read table lo_model_ext->dt_entity_prop into data(ls_entity_prop) with key usmd_entity = lv_primary_entity.
  if ls_entity_prop-f_has_pp = 'X'.
    gv_is_reuse = 'X'.
  endif.


  call method cl_usmd_sdq_duplicate_check=>search_mode
    exporting
      iv_model                  = i_model
      iv_entity                 = lv_primary_entity "iv_entity    " Entity Type
    importing
      ev_search_mode            = data(lv_search_mode)
      ev_low_threshold          = data(lv_low_threshold)
      ev_high_threshold         = data(lv_high_threshold)
      ev_duplicate_check_exists = data(lv_duplicate_check_exists).


  ls_search_context-entity_main   = lv_primary_entity.
  ls_search_context-o_model       = lo_model_ext.
  ls_search_context-search_mode   = lv_search_mode.
  ls_search_context-update_mode   = 'I'.
*  ls_search_context-search_help   = 'ZMDG_MM_ORGS_NEW'.
  ls_search_context-max_num_records = 10.
  ls_search_context-threshold     = lv_low_threshold.

  call method cl_mdg_hdb_util=>get_hana_object_path_for_query
    exporting
      iv_search_help     = ls_search_context-search_help "'ZMDG_MM_ORGS_NEW'
      iv_attr_view_indic = 'X'
    importing
      ev_relative_path   = data(lv_hana_viewname).  " path relatively to a pacakage
  replace all occurrences of '/' in lv_hana_viewname with '_'.
  gs_hana_views-hana_staging_view = lv_hana_viewname.

  if gv_is_reuse eq abap_true.
    "   Transform Flex view name to Reuse view name by appending the suffix
    concatenate lv_hana_viewname if_mdg_hdb_search_constants=>reuse_view_suffix into lv_hana_viewname.
    gs_hana_views-hana_reuse_view = lv_hana_viewname.
  endif.


  if gs_hana_views-hana_union_sql_view is initial.
    data(lv_hana_view_name) = gs_hana_views-hana_staging_view.
  else.
    lv_hana_view_name = gs_hana_views-hana_union_sql_view.
  endif.

  try .
      call method cl_mdg_hdb_util=>get_db_conn_details
        importing
          e_dbcon_name = data(lv_con_name).
      data(lo_con) = cl_sql_connection=>get_connection( con_name = lv_con_name ).
      data(lo_stmt) = lo_con->create_statement( ).
      concatenate
                      `SELECT TOP 1  * FROM "` lv_hana_view_name `" WHERE 1 = 2`
                      into lv_selst_atr.

      data(lr_result) = lo_stmt->execute_query( statement = lv_selst_atr ).
      data(lt_metadata_atr) = lr_result->get_metadata( ).
      ls_metadata-column_name = if_mdg_hdb_search_constants=>score.
      data(lr_data_type) = cl_abap_typedescr=>describe_by_name( if_mdg_hdb_search_constants=>rank_roll_name ).
      ls_metadata-data_type = lr_data_type->kind.
      ls_metadata-length = lr_data_type->length.
      ls_metadata-decimals = lr_data_type->decimals.
      insert ls_metadata into table lt_metadata_atr.

      call method cl_mdg_hdb_access=>get_model_entity_attr
        exporting
          iv_technical_name         = ls_search_context-search_help
        importing
          et_mdg_hdb_tt_entity_attr = data(lt_mdghdb001d).

      loop at lt_metadata_atr into ls_metadata.
        read table lt_mdghdb001d into data(ls_mdghdb001d) with key technical_name = ls_search_context-search_help attribute = ls_metadata-column_name.
        if sy-subrc = 0.
          ls_mapping_info-entity = ls_mdghdb001d-entityname.
          ls_mapping_info-model_fieldname = ls_metadata-column_name.
          insert ls_mapping_info into table gt_mapping_info.
        elseif ls_metadata-column_name = if_mdg_hdb_search_constants=>langu.
          ls_mapping_info-entity = ls_search_context-entity_main.
          ls_mapping_info-model_fieldname = if_mdg_hdb_search_constants=>langu.
          insert ls_mapping_info into table gt_mapping_info.
        endif.
      endloop.

      cl_usmd_pp_access_factory_ext=>get_pp_hana_search(
        exporting
          iv_model          = ls_search_context-o_model->d_usmd_model " Data Model
          iv_entity         = ls_search_context-entity_main " Entity Type
        receiving
          ro_pp_hana_search = data(lo_pp_access_class) ). " Hana Search Interface for Reuse Area

      if lo_pp_access_class is bound.
        call method lo_pp_access_class->get_mapping_info
          exporting
            is_search_context = ls_search_context
          importing
            et_messages       = data(lt_message)
          changing
            ct_mapping_info   = gt_mapping_info.
      endif.

      loop at mt_attributes into data(ls_attributes).
        if gs_hana_views-hana_union_sql_view is not initial.
          " Ruleset
          read table gt_mapping_info into ls_mapping_info with key model_fieldname = ls_attributes-attr_name .
          if sy-subrc = 0 and ls_mapping_info-reuse_view_fieldname is initial.  " Mapping not found
            delete table mt_attributes from ls_attributes.
            continue.
          else.
            ls_attribute_reuse = corresponding #( ls_attributes ).
            ls_attribute_reuse-attr_name_reuse = ls_mapping_info-reuse_view_fieldname.
            append ls_attribute_reuse to mt_attributes_reuse.
            clear ls_attribute_reuse.
          endif.
        else.
          " Attribute View
          read table gt_mapping_info into ls_mapping_info with key model_fieldname = ls_attributes-attr_name.
          if sy-subrc = 0.
            ls_attribute_reuse = corresponding #( ls_attributes ).
            ls_attribute_reuse-attr_name_reuse = ls_mapping_info-reuse_view_fieldname.
            append ls_attribute_reuse to mt_attributes_reuse.
          endif.
        endif.
        if gv_default_weight eq abap_true and ls_attributes-weigtage is not initial.
          gv_default_weight = abap_false.  " Use weight from match profile
        endif.
        if gv_default_fuzzy eq abap_true and ls_attributes-fuzziness is not initial.
          gv_default_fuzzy = abap_false.  " Use fuzziness from match profile
        endif.
      endloop.

      call method cl_mdg_hdb_util=>get_db_conn_details
        importing
          e_dbcon_name = lv_con_name.

      call method cl_mdg_hdb_access=>get_search_model_details
        exporting
          iv_search_help  = ls_search_context-search_help "'ZMDG_MM_ORGS_NEW'
        importing
          es_search_model = data(ls_search_model)
          es_sm_status    = data(ls_sm_status).

      unassign <lfs_data>.
      assign component '_01' of structure <lfs_data_full> to <lfs_data>.
      loop at <lfs_data> assigning <lfs_struct>.
        assign component lv_key_attrib of structure <lfs_struct> to <lfs_field>.
        if <lfs_field> is assigned.
          ls_search_key-fieldname = lv_key_attrib.
          ls_search_key-value = <lfs_field>.
        endif.
        loop at lt_dqdc into data(ls_dqdc).
          unassign <lfs_field>.
          assign component ls_dqdc-attr_name of structure <lfs_struct> to <lfs_field>.
          check <lfs_field> is assigned and <lfs_field> is not initial.
          ls_search_attribute-fieldname = ls_dqdc-attr_name.
          ls_search_attribute-sign      = usmd0_cs_ra-sign_i. "'I'.
          ls_search_attribute-option    = usmd0_cs_ra-option_eq."'EQ'.
          ls_search_attribute-low       = <lfs_field>.
          condense ls_search_attribute-low.
          insert ls_search_attribute into table lt_search_attribute_temp.

          call method cl_abap_typedescr=>describe_by_name
            exporting
              p_name         = ls_search_attribute-fieldname
            receiving
              p_descr_ref    = data(lo_descr)
            exceptions
              type_not_found = 1
              others         = 2.
          if sy-subrc <> 0.
            read table gt_mapping_info into ls_mapping_info with key reuse_view_fieldname = ls_search_attribute-fieldname.
            if sy-subrc = 0.
              call method cl_abap_typedescr=>describe_by_name
                exporting
                  p_name         = ls_mapping_info-model_fieldname
                receiving
                  p_descr_ref    = lo_descr
                exceptions
                  type_not_found = 1
                  others         = 2.
            endif.
          endif.

          if lo_descr is bound.
            data(lv_internal_type) = lo_descr->type_kind.
          endif.

          if lv_internal_type = if_mdg_hdb_search_constants=>decimal or lv_internal_type =  'N' or
            lv_internal_type = 'D' or lv_internal_type =  'T' or lv_internal_type = 'F' or
            lv_internal_type =  'P' or  lv_internal_type = 'a'.
            clear:lv_conv_value,ls_temp_usmd_table.
            if ls_search_attribute-fieldname is not initial and
               ls_search_attribute-low       is not initial.
              call method cl_mdg_hdb_util=>convert_float_to_double_type
                exporting
                  iv_fieldname  = ls_search_attribute-fieldname
                  iv_fieldvalue = ls_search_attribute-low
                importing
                  ev_conv_value = lv_conv_value.
              ls_temp_usmd_table = ls_search_attribute.
              clear ls_temp_usmd_table-low.
              ls_temp_usmd_table-low = lv_conv_value.
            else.
              ls_temp_usmd_table = ls_search_attribute.
            endif.
            if ls_search_attribute-fieldname is not initial and ls_search_attribute-high is not initial.
              call method cl_mdg_hdb_util=>convert_float_to_double_type
                exporting
                  iv_fieldname  = ls_search_attribute-fieldname
                  iv_fieldvalue = ls_search_attribute-high
                importing
                  ev_conv_value = lv_conv_value.
              clear ls_temp_usmd_table-high1.
              ls_temp_usmd_table-high1 = lv_conv_value.
            else.
              ls_temp_usmd_table = ls_search_attribute.
            endif.
          else.
            ls_temp_usmd_table = ls_search_attribute.
          endif.

          append ls_temp_usmd_table to lt_temp_usmd_table.
          clear ls_temp_usmd_table.
        endloop.

        if lt_temp_usmd_table is not initial.
          refresh lt_search_attribute.
          lt_search_attribute[] = lt_temp_usmd_table[].
        endif.

        if lt_search_attribute is not initial.
          insert lt_search_attribute into table lt_tab_search_attribute.
        endif.

        if lt_search_attribute is initial and lt_tab_search_attribute is initial and lv_search_string is initial.
          data(lv_empty_search) = abap_true.
        endif.

        call method cl_mdg_hdb_access=>get_search_model_details
          exporting
            iv_search_help = ls_search_context-search_help "'ZMDG_MM_ORGS_NEW'
          importing
            es_sm_status   = ls_sm_status.

        ls_search_attribute-fieldname = if_mdg_hdb_search_constants=>usmd_active.
        ls_search_attribute-sign = 'I'.
        ls_search_attribute-option = 'EQ'.
        ls_search_attribute-low = '1'.
        append ls_search_attribute to lt_search_attribute.
        clear ls_search_attribute.

        read table lt_search_attribute transporting no fields with key fieldname = if_mdg_hdb_search_constants=>usmd_active
        low = '1'.
        if sy-subrc = 0.
          gv_only_active_records = abap_true.
        endif.

        if gv_is_reuse eq abap_true.

          """""""""""""""""""""""""""""""""""""" Reuse query"""""""""""""""""""""""""""""
          call method get_mapped_search_attribs_dqdc
            exporting
              is_search_context        = ls_search_context  " Search Context
            importing
              et_auth_attr             = data(lt_auth_attr_staging)  " Auth attr in staging names
              et_auth_attr_reuse       = data(lt_auth_attr_reuse)    " Auth attr in reuse names
              et_tab_search_attr_reuse = data(lt_tab_search_attr_reuse)  " ITAB attr in reuse names
              et_search_attr_reuse     = data(lt_search_attr_reuse)  " Basic IT_search attr in reuse names
            changing
              ct_tab_search_attribute  = lt_tab_search_attribute  " ITAB attr in staging names
              ct_search_attribute      = lt_search_attribute.  " Basic IT_search attr in staging names


          check_for_reuse_query_dqdc(
            exporting
              it_search_attribute           = lt_search_attribute    " Sorted Table: Selection Condition (Range per Field)
              it_search_attribute_reuse     = lt_search_attr_reuse    " Sorted Table: Selection Condition (Range per Field)
              it_tab_search_attribute_reuse = lt_tab_search_attr_reuse    " Table type of USMD_TS_SEL
              it_tab_search_attribute       = lt_tab_search_attribute    " Table type of USMD_TS_SEL
            importing
              ev_construct_reuse_query      = data(lv_construct_reuse_query)
          ).

          if lv_construct_reuse_query eq abap_true.

            call method build_query_dqdc
              exporting
                it_tab_search_attribute = lt_tab_search_attr_reuse
                is_search_context       = ls_search_context
                id_search_string        = lv_search_string
                it_search_attribute     = lt_search_attr_reuse
*               iv_auth_query           = lv_auth_query  " SQL WHERE Condition for authorization
                iv_view_indicator       = if_mdg_hdb_search_constants=>reuse_view_indicator
              importing
                ev_sel_stmt             = data(lv_sel_stmt_reuse).     " SQL Statement with input
          endif.
          """"""""""""""""""""""""""""""""""""""End of Build Reuse query"""""""""""""""""""""""""""""
        endif.

        """"""""""""""""""""""""""""""""""""""Build Staging query"""""""""""""""""""""""""""""""""""
        call method build_query_dqdc
          exporting
            it_tab_search_attribute = lt_tab_search_attribute
            is_search_context       = ls_search_context
            id_search_string        = lv_search_string
            it_search_attribute     = lt_search_attribute
            iv_view_indicator       = if_mdg_hdb_search_constants=>stag_view_indicator
          importing
            ev_sel_stmt             = data(lv_sel_stmt)      " SQL Statement with input
            ev_filter_ruleset       = data(lv_filter_ruleset).
        """"""""""""""""""""""""""""""""""""""Build Staging query"""""""""""""""""""""""""""""""""""

        """"""""""""""""""""""""""""""""""""""FETCH SEARCH RESULTS"""""""""""""""""""""""""""""""""""
*    Fetch search results
        call method get_results_dqdc
          exporting
            is_search_context       = ls_search_context
            it_search_attribute     = lt_search_attribute
            it_tab_search_attribute = lt_tab_search_attribute
            iv_sel_stmt             = lv_sel_stmt
            iv_sel_stmt_reuse       = lv_sel_stmt_reuse
            iv_filter_ruleset       = lv_filter_ruleset
          changing
            ct_data                 = lt_duplicates
            ct_message              = lt_message.

*        loop at lt_duplicates into data(ls_duplicates).
*          unassign <lfs_field>.
*          assign component ls_search_key-fieldname of structure <lfs_struct> to <lfs_field>.
*          assign component 'KEY_VAL' of structure ls_duplicates_out to field-symbol(<lfs_key>).
*          if <lfs_field> is assigned and <lfs_key> is assigned.
*            <lfs_key> = <lfs_field>.
*          endif.
*          ls_duplicates_out =  corresponding #( ls_duplicates_out )
*        endloop.
        et_duplicates = VALUE #( BASE et_duplicates
                                  FOR ls_duplicates IN lt_duplicates ( key_val = ls_search_key-value ) ).
      endloop.

    catch cx_sql_exception into data(lx_sql_exception).

  endtry.







endmethod.


method get_derived_data.
  types: begin of lty_input,
           i_mode      type yzdtel_mode,
           i_model     type yzdtel_model,
           i_scope     type yzdtel_scope_id,
           i_tempid    type yzdtel_template_id,
           i_actionid  type yzdtel_action_id,
           field_name  type fieldname,
           derive_data type char1,
           field_value type string,
         end of lty_input.
  types: begin of lty_accounting,
*           matnr  type matnr,
           bklas  type bklas,
           vprsv  type vprsv,
           mlast  type ck_ml_abst,
           bwkey  type bwkey,
         end of lty_accounting.
*  types: begin of lty_output,
*          output type table of lty_accounting with KEY matnr,
*         end of lty_output.
  data lt_accounting type table of lty_accounting.
  data ls_accounting type lty_accounting.
  data ls_input       type lty_input.

  /ui2/cl_json=>deserialize(
    exporting
      json = i_json_input   " JSON string
    changing
      data = ls_input         " Data to serialize
  ).

  if ls_input-field_name = 'MTART' and ls_input-field_value = 'YHB'.
    ls_accounting-bklas = '3040'.
    ls_accounting-vprsv = 'V'.
    ls_accounting-mlast = '2'.
    ls_accounting-bwkey = '3040'.
    append ls_accounting to lt_accounting.
  endif.
*  data ls_output type lty_output.
*  ls_output-output = lt_accounting.

  /ui2/cl_json=>serialize(
    exporting
      data             = lt_accounting                 " Data to serialize
*      compress         =                  " Skip empty elements
*      name             =                  " Object name
*      pretty_name      =                  " Pretty Print property names
*      type_descr       =                  " Data descriptor
*      assoc_arrays     =                  " Serialize tables with unique keys as associative array
*      ts_as_iso8601    =                  " Dump timestamps as string in ISO8601 format
*      expand_includes  =                  " Expand named includes in structures
*      assoc_arrays_opt =                  " Optimize rendering of name value maps
*      numc_as_string   =                  " Serialize NUMC fields as strings
*      name_mappings    =                  " ABAP<->JSON Name Mapping Table
*      conversion_exits =                  " Use DDIC conversion exits on serialize of values
*      format_output    =                  " Indent and split in lines serialized JSON
*      hex_as_base64    =                  " Serialize hex values as base64
    receiving
      r_json           =  e_json_output                " JSON string
  ).
endmethod.
ENDCLASS.
