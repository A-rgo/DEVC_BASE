class YCL_MAT_BOM_FLD_PROP definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_ACC_FLD_PROP_CDS .
protected section.
private section.
ENDCLASS.



CLASS YCL_MAT_BOM_FLD_PROP IMPLEMENTATION.


  method IF_EX_USMD_ACC_FLD_PROP_CDS~IS_FIELD_PROP_HIDDEN_SUPPORTED.
  endmethod.


  method IF_EX_USMD_ACC_FLD_PROP_CDS~MODIFY_ENTITY_PROPERTIES.
    DATA : lt_ent_prop TYPE TABLE OF ymdgbom_fld_prop,
           ls_ent_prop TYPE ymdgbom_fld_prop.
*    if sy-uname = 'ASWARUP'.

    SELECT * FROM ymdgbom_fld_prop
            INTO TABLE lt_ent_prop
            WHERE data_model = io_model->d_usmd_model
            AND entity = i_entity
            AND field_name = 'NA'
            AND wf_step = io_context->mv_crequest_step " IF_USMD_APP_CONTEXT->MV_CREQUEST_STEP
            AND crequest = io_context->mv_crequest_type.
    IF sy-subrc = 0.
      LOOP AT lt_ent_prop INTO ls_ent_prop.
        IF ls_ent_prop-property = 'R'.
          cf_read_only = abap_true.
        ENDIF.
      ENDLOOP.
    ENDIF.

*    ENDIF.
  endmethod.


  METHOD if_ex_usmd_acc_fld_prop_cds~modify_fld_prop_attr.
*   define field symbol based on structure configured for field properties
    FIELD-SYMBOLS: <lfs_fld_prop> TYPE any,
                   <lfs_usmd_fp>  TYPE any,
                   <lfs_fld_name> TYPE any,
                   <lfs_field>    TYPE any.

* Declaration for Table
    DATA : ls_fld_prop TYPE ztmdg_fld_prop,
           lt_fld_prop TYPE TABLE OF ztmdg_fld_prop.

    DATA :
      lfs_messages   TYPE usmd_t_message,
      lt_data_entity TYPE STANDARD TABLE OF /mdg/_s_0g_pp_account,
      ls_data_entity TYPE  /mdg/_s_0g_pp_account,
      lt_sel         TYPE usmd_ts_sel,
      ls_sel         TYPE usmd_s_sel.

    " - DERIVE PROPERTIES .
    CASE iv_fld_prop_wfs.

      WHEN '00' OR '10' OR '20' OR '30' OR  '40' OR '90'.

        """ This code is responsible for field property in BOM

*        SELECT * FROM ymdgbom_fld_prop
*          INTO TABLE lt_fld_prop
*          WHERE data_model = io_model->d_usmd_model
*          AND entity = iv_entity
*          AND wf_step = iv_fld_prop_wfs
*          AND crequest = iv_creq_type .

        """ This code is responsible for field property in Material
        SELECT * FROM ztmdg_fld_prop
          INTO TABLE lt_fld_prop
          WHERE data_model = io_model->d_usmd_model
          AND entity = iv_entity
          AND wf_step = iv_fld_prop_wfs
          AND crequest = iv_creq_type .

        IF sy-subrc = 0.

          "SET Properties .
          LOOP AT  ct_fld_prop ASSIGNING <lfs_fld_prop>.
            IF <lfs_fld_prop> IS ASSIGNED.
              ASSIGN COMPONENT 'USMD_FP' OF STRUCTURE <lfs_fld_prop> TO <lfs_usmd_fp>.
              LOOP AT lt_fld_prop INTO ls_fld_prop.
                ASSIGN COMPONENT ls_fld_prop-field_name OF STRUCTURE <lfs_usmd_fp> TO <lfs_field>.
                IF <lfs_field> IS ASSIGNED.

                  IF ls_fld_prop-property IS NOT INITIAL.
                    <lfs_field> = ls_fld_prop-property.
                  ENDIF.

                ENDIF.
                CLEAR ls_fld_prop.
                UNASSIGN <lfs_field>.
              ENDLOOP.
**              REFRESH lt_fld_prop.
            ENDIF.
          ENDLOOP.

        ENDIF.

    ENDCASE.

    IF iv_entity = 'YBOMHDR' AND iv_creq_type = 'YBMAT01F'.
*      LOOP AT it_data ASSIGNING FIELD-SYMBOL(<lfs_data>).
*        ASSIGN COMPONENT 'WERKS' OF STRUCTURE <lfs_data> TO FIELD-SYMBOL(<lfs_werksval>).
*        IF sy-subrc = 0 AND <lfs_werksval> IS ASSIGNED AND <lfs_werksval> IS INITIAL.
*          <lfs_werksval> = 'BM01'.
*        ENDIF.
*      ENDLOOP.
      LOOP AT ct_fld_prop ASSIGNING <lfs_fld_prop>.
        ASSIGN COMPONENT 'USMD_FP' OF STRUCTURE <lfs_fld_prop> TO <lfs_usmd_fp>.
        IF sy-subrc = 0 AND <lfs_usmd_fp> IS ASSIGNED.
          ASSIGN COMPONENT 'WERKS' OF STRUCTURE <lfs_usmd_fp> TO FIELD-SYMBOL(<lfs_werks>).
          IF sy-subrc = 0 AND <lfs_werks> IS ASSIGNED.
            <lfs_werks> = 'R'.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
