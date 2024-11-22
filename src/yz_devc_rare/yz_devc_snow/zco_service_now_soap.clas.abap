class ZCO_SERVICE_NOW_SOAP definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !DESTINATION type ref to IF_PROXY_DESTINATION optional
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    preferred parameter LOGICAL_PORT_NAME
    raising
      CX_AI_SYSTEM_FAULT .
  methods DELETE_MULTIPLE
    importing
      !INPUT type ZDELETE_MULTIPLE_SOAP_IN
    exporting
      !OUTPUT type ZDELETE_MULTIPLE_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods DELETE_RECORD
    importing
      !INPUT type ZDELETE_RECORD_SOAP_IN
    exporting
      !OUTPUT type ZDELETE_RECORD_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET
    importing
      !INPUT type ZGET_SOAP_IN
    exporting
      !OUTPUT type ZGET_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_KEYS
    importing
      !INPUT type ZGET_KEYS_SOAP_IN
    exporting
      !OUTPUT type ZGET_KEYS_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_RECORDS
    importing
      !INPUT type ZGET_RECORDS_SOAP_IN
    exporting
      !OUTPUT type ZGET_RECORDS_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods INSERT
    importing
      !INPUT type ZINSERT_SOAP_IN
    exporting
      !OUTPUT type ZINSERT_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods UPDATE
    importing
      !INPUT type ZUPDATE_SOAP_IN
    exporting
      !OUTPUT type ZUPDATE_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
protected section.
private section.
ENDCLASS.



CLASS ZCO_SERVICE_NOW_SOAP IMPLEMENTATION.


  method CONSTRUCTOR.

  super->constructor(
    class_name          = 'ZCO_SERVICE_NOW_SOAP'
    logical_port_name   = logical_port_name
    destination         = destination
  ).

  endmethod.


  method DELETE_MULTIPLE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DELETE_MULTIPLE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DELETE_RECORD.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DELETE_RECORD'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_KEYS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_KEYS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_RECORDS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_RECORDS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method INSERT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'INSERT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UPDATE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UPDATE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.
ENDCLASS.
