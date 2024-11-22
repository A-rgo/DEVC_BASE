FUNCTION ybapi_mat_bom_group_create.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TESTRUN) TYPE  BAPIFLAG DEFAULT SPACE
*"     VALUE(IV_ALL_ERROR) TYPE  XFLAG DEFAULT SPACE
*"  TABLES
*"      IT_BOMGROUP STRUCTURE  BAPI1080_BGR_C
*"      IT_VARIANTS STRUCTURE  BAPI1080_BOM_C
*"      IT_ITEMS STRUCTURE  BAPI1080_ITM_C OPTIONAL
*"      IT_SUBITEMS STRUCTURE  BAPI1080_SUI_C OPTIONAL
*"      IT_MATERIALRELATIONS STRUCTURE  BAPI1080_MBM_C
*"      IT_ITEMASSIGNMENTS STRUCTURE  BAPI1080_REL_ITM_BOM_C OPTIONAL
*"      IT_SUBITEMASSIGNMENTS STRUCTURE  BAPI1080_REL_SUI_ITM_C
*"       OPTIONAL
*"      IT_TEXTS STRUCTURE  BAPI1080_TXT_C OPTIONAL
*"      IT_RETURN STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------


  DATA : lt_return TYPE bapiret2_t."TECHNICAL_TYPE
  DATA : lt_message TYPE mdg_bs_mat_t_mat_msg.
  DATA : lw_message LIKE LINE OF lt_message.

  CALL FUNCTION 'BAPI_MATERIAL_BOM_GROUP_CREATE' " Commented by Anand
    EXPORTING
*     TESTRUN           = ' '
      all_error         = abap_true
    TABLES
      bomgroup          = it_bomgroup
      variants          = it_variants
      items             = it_items
*     SUBITEMS          =
      materialrelations = it_materialrelations
      itemassignments   = it_itemassignments
*     SUBITEMASSIGNMENTS       =
*     TEXTS             =
      return            = lt_return.

  IF line_exists( lt_return[ type = 'E' ] ) OR line_exists( lt_return[ type = 'A' ] ).

    LOOP AT lt_return INTO DATA(lw_return).

      lw_message = VALUE #( msgty = lw_return-type  msgid = lw_return-id
                              msgno = lw_return-number msgv1 = lw_return-message msgv2 = lw_return-message_v1 msgv3 = lw_return-message_v2
                              msgv4 = lw_return-message_v4
                              matnr = it_bomgroup-object_id werks = it_bomgroup-created_in_plant ).
      APPEND lw_message TO lt_message.
    ENDLOOP.

*    et_message = lt_message.

  ELSE.

    lt_message = VALUE #( ( msgty = 'S' msgid = 'YMDMBOM' msgno = 000 matnr = it_bomgroup-object_id ) ).
*    et_message = lt_message.

  ENDIF.




ENDFUNCTION.
