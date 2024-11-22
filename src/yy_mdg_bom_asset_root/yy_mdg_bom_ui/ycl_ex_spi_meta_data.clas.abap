class YCL_EX_SPI_META_DATA definition
  public
  final
  create public .

public section.

  interfaces /PLMB/IF_EX_SPI_METADATA .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS YCL_EX_SPI_META_DATA IMPLEMENTATION.


  METHOD /plmb/if_ex_spi_metadata~enrich_node_definition.

    "FIELD-SYMBOLS: <LS_METADATA_NODE> LIKE LINE OF CT_METADATA_NODE.

    LOOP AT ct_metadata_node ASSIGNING FIELD-SYMBOL(<ls_metadata_node>) WHERE name = 'YMDGM_YBOMHDR' OR name = 'YMDGM_YBOMITM'
                                          OR name = 'ZPURCHGEN' OR name = 'ZPURCHINF' OR name = 'ZPIRCOND'.

      IF <ls_metadata_node>-name = 'YMDGM_YBOMHDR'.
      <ls_metadata_node>-name_parent = 'MARC'.
      APPEND VALUE #( node_name = 'MARC') TO <ls_metadata_node>-dependent_nodes.
      ELSEIF <ls_metadata_node>-name = 'YMDGM_YBOMITM'.
        <ls_metadata_node>-name_parent = 'YMDGM_YBOMHDR'.
       APPEND VALUE #( node_name = 'YMDGM_YBOMHDR') TO <ls_metadata_node>-dependent_nodes.
*      ELSEIF  <ls_metadata_node>-name = 'ZPURCHGEN'.
*              <ls_metadata_node>-name_parent = 'MARA'.
*            APPEND VALUE #( node_name = 'MARA') TO <ls_metadata_node>-dependent_nodes.
**       APPEND VALUE #( name = 'DISCARD_ITEM' ACTION_DESCRIPTION = 'Discard Item' STRUCTURE = 'YMDGM_YBOMHDR_S') TO <ls_metadata_node>-actions.
*      ELSEIF  <ls_metadata_node>-name = 'ZPURCHINF'.
*              <ls_metadata_node>-name_parent = 'ZPURCHGEN'."'ZPURCHGEN'.
*      APPEND VALUE #( node_name = 'ZPURCHGEN') TO <ls_metadata_node>-dependent_nodes.
*      ELSEIF  <ls_metadata_node>-name = 'ZPIRCOND'.
*              <ls_metadata_node>-name_parent = 'ZPURCHINF'."'ZPURCHINF'.
*      APPEND VALUE #( node_name = 'ZPURCHINF') TO <ls_metadata_node>-dependent_nodes.

      ENDIF.

    ENDLOOP.

cs_metadata_abbid-pull_properties = abap_true.


  ENDMETHOD.
ENDCLASS.
