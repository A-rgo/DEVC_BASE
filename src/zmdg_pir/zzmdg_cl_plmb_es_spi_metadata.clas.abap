class ZZMDG_CL_PLMB_ES_SPI_METADATA definition
  public
  final
  create public .

public section.

  interfaces /PLMB/IF_EX_SPI_METADATA .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS ZZMDG_CL_PLMB_ES_SPI_METADATA IMPLEMENTATION.


  method /PLMB/IF_EX_SPI_METADATA~ENRICH_NODE_DEFINITION.

    DATA : ls_node   LIKE LINE OF ct_metadata_node,
           ls_d_node TYPE         /plmb/s_spi_node_name,
           lt_action TYPE STANDARD TABLE OF /plmb/s_spi_metadata_action,
           ls_action LIKE LINE OF lt_action.


      READ TABLE ct_metadata_node INTO ls_node WITH KEY name = 'MARA'.
      IF sy-subrc IS INITIAL.
        ls_node-name           =    'ZPURCHGEN'.
        ls_node-name_parent    =   'MARA'.
        ls_node-transient      =    abap_false.
        ls_node-data_struc     =    'ZZMDG_S_MM_PP_ZPURCHGEN'.
        ls_node-update_relevant =   'K'.
        ls_node-supported_operation_group =  31.
        CLEAR : ls_node-data_description,
*              ls_node-actions[],
                ls_node-update_sideeffect.

        ls_node-supported_properties-fields-node = abap_true.
        ls_node-supported_properties-fields-insert = abap_true.
        ls_node-supported_properties-fields-data_records_by_association = abap_true.

        INSERT ls_node INTO TABLE ct_metadata_node.
        CLEAR ls_node.

        READ TABLE ct_metadata_node INTO ls_node WITH KEY name = 'MARA'.
        ls_node-name           =    'ZPURCHINF'.
        ls_node-name_parent    =    'MARA'.
        ls_node-transient      =    abap_false.
        ls_node-data_struc     =    'ZZMDG_S_MM_PP_ZPURCHINF'.
        ls_node-update_relevant =   'K'.
        ls_node-supported_operation_group =  31.
        CLEAR : ls_node-data_description,
*              ls_node-actions[],
                ls_node-update_sideeffect.

        ls_node-supported_properties-fields-node = abap_true.
        ls_node-supported_properties-fields-insert = abap_true.
        ls_node-supported_properties-fields-data_records_by_association = abap_true.
        ls_action-name = 'PIR_DETAIL'.
        ls_action-action_description = 'PIR_DETAIL'.
        ls_action-not_save_rel = abap_true.
        lt_action = ls_node-actions.
        APPEND ls_action TO lt_action.
        ls_node-actions = lt_action.
        CLEAR : ls_action, lt_action.

        INSERT ls_node INTO TABLE ct_metadata_node.
        CLEAR ls_node.

        READ TABLE ct_metadata_node INTO ls_node WITH KEY name = 'MARA'.
        ls_node-name           =    'ZPIRCOND'.
        ls_node-name_parent    =    'MARA'.
        ls_node-transient      =    abap_false.
        ls_node-data_struc     =    'ZZMDG_S_MM_PP_ZPIRCOND'.
        ls_node-update_relevant =   'K'.
        ls_node-supported_operation_group =  31.
        CLEAR : ls_node-data_description,
*              ls_node-actions[],
                ls_node-update_sideeffect.

        ls_node-supported_properties-fields-node = abap_true.
        ls_node-supported_properties-fields-insert = abap_true.
        ls_node-supported_properties-fields-data_records_by_association = abap_true.
        ls_action-name = 'PIR_CONDITION'.
        ls_action-action_description = 'PIR_CONDITION ENTITY'.
        ls_action-not_save_rel = abap_true.
        lt_action = ls_node-actions.
        APPEND ls_action TO lt_action.
        ls_node-actions = lt_action.
        CLEAR : ls_action, lt_action.

        INSERT ls_node INTO TABLE ct_metadata_node.
        CLEAR ls_node.
      ENDIF.

  endmethod.
ENDCLASS.
