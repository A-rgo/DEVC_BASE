class ZZMDG_CL_PIR_EX_SPI_PROP_ACC definition
  public
  final
  create public .

public section.

  interfaces /PLMB/IF_EX_SPI_PRPTY_ACCESS .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS ZZMDG_CL_PIR_EX_SPI_PROP_ACC IMPLEMENTATION.


  method /PLMB/IF_EX_SPI_PRPTY_ACCESS~GET_OPERATION_PROPERTIES.

  endmethod.


  method /PLMB/IF_EX_SPI_PRPTY_ACCESS~GET_PROPERTIES.

  DATA : ls_properties LIKE LINE OF ct_properties,
         ls_req_fields LIKE LINE OF it_requested_field,
         lv_idx        TYPE sy-tabix.


  IF iv_node_name = 'ZPURCHGEN' OR iv_target_node_name = 'ZPURCHGEN'.

    LOOP AT it_requested_field INTO ls_req_fields.

      IF ls_req_fields = 'LIFNR'.
        ls_properties-node_field = 'LIFNR'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'LIFNR' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'MATERIAL'.
        ls_properties-node_field = 'MATERIAL'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'MATERIAL' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'INFNR'.
        ls_properties-node_field = 'INFNR'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'INFNR' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'MAHN1'.
        ls_properties-node_field = 'MAHN1'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'MAHN1' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'MAHN2'.
        ls_properties-node_field = 'MAHN2'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'MAHN2' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'MAHN3'.
        ls_properties-node_field = 'MAHN3'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'MAHN3' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'WGLIF'.
        ls_properties-node_field = 'WGLIF'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'WGLIF' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'IDNLF'.
        ls_properties-node_field = 'IDNLF'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'IDNLF' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'VERKF'.
        ls_properties-node_field = 'VERKF'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'VERKF' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'TELF1'.
        ls_properties-node_field = 'TELF1'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'TELF1' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'RUECK'.
        ls_properties-node_field = 'RUECK'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'RUECK' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'MEINS'.
        ls_properties-node_field = 'MEINS'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'MEINS' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'URZTP'.
        ls_properties-node_field = 'URZTP'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'URZTP' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.
    ENDLOOP.
  ENDIF.

  IF iv_node_name = 'ZPURCHINF' OR iv_target_node_name = 'ZPURCHINF'.

    LOOP AT it_requested_field INTO ls_req_fields.

      IF ls_req_fields = 'MATERIAL'.
        ls_properties-node_field = 'MATERIAL'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'MATERIAL' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'INFNR'.
        ls_properties-node_field = 'INFNR'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'INFNR' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'LIFNR'.
        ls_properties-node_field = 'LIFNR'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'LIFNR' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'EKWRK'.
        ls_properties-node_field = 'EKWRK'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'EKWRK' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'EKORG'.
        ls_properties-node_field = 'EKORG'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'EKORG' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'ESOKZ'.
        ls_properties-node_field = 'ESOKZ'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'ESOKZ' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'APLFZ'.
        ls_properties-node_field = 'APLFZ'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'APLFZ' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'EKGRP_P'.
        ls_properties-node_field = 'EKGRP_P'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'EKGRP_P' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'NORBM'.
        ls_properties-node_field = 'NORBM'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'NORBM' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'MINBM'.
        ls_properties-node_field = 'MINBM'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'MINBM' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'BSTMA_P'.
        ls_properties-node_field = 'BSTMA_P'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'BSTMA_P' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'NETPR'.
        ls_properties-node_field = 'NETPR'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'NETPR' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.
      IF ls_req_fields = 'INCO1'.
        ls_properties-node_field = 'INCO1'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'INCO1' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

    ENDLOOP.
  ENDIF.

  IF iv_node_name = 'ZPIRCOND' OR iv_target_node_name = 'ZPIRCOND'.

    LOOP AT it_requested_field INTO ls_req_fields.

      IF ls_req_fields = 'DATAB'.
        ls_properties-node_field = 'DATAB'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'DATAB' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'DATBI'.
        ls_properties-node_field = 'DATBI'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'DATBI' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'LIFNR'.
        ls_properties-node_field = 'LIFNR'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'LIFNR' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'EKORG'.
        ls_properties-node_field = 'EKORG'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'EKORG' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'ESOKZ'.
        ls_properties-node_field = 'ESOKZ'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'ESOKZ' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'KONWA'.
        ls_properties-node_field = 'KONWA'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'KONWA' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'EKWRK'.
        ls_properties-node_field = 'EKWRK'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'EKWRK' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'KPEIN'.
        ls_properties-node_field = 'KPEIN'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'KPEIN' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'KMEIN'.
        ls_properties-node_field = 'KMEIN'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'KMEIN' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'MWSK1_C'.
        ls_properties-node_field = 'MWSK1_C'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'MWSK1_C' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'KZBZG'.
        ls_properties-node_field = 'KZBZG'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'KZBZG' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'KRECH'.
        ls_properties-node_field = 'KRECH'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'KRECH' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'LOEVM_KO'.
        ls_properties-node_field = 'LOEVM_KO'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'LOEVM_KO' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'KBETR'.
        ls_properties-node_field = 'KBETR'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'KBETR' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'ZTERM'.
        ls_properties-node_field = 'ZTERM'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'ZTERM' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'VALDT'.
        ls_properties-node_field = 'VALDT'.
        ls_properties-option = '3'.
       lv_idx = line_index( ct_properties[ node_field = 'VALDT' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

      IF ls_req_fields = 'VALTG'.
        ls_properties-node_field = 'VALTG'.
        ls_properties-option = '1'.
       lv_idx = line_index( ct_properties[ node_field = 'VALTG' ] ).
       IF lv_idx <> 0.
         MODIFY ct_properties INDEX lv_idx FROM ls_properties TRANSPORTING option.
       ELSE.
         INSERT ls_properties INTO TABLE ct_properties.
       ENDIF.
       CLEAR: lv_idx, ls_properties.
      ENDIF.

    ENDLOOP.
  ENDIF.
  endmethod.
ENDCLASS.
