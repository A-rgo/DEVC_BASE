CLASS ycl_addict_transport_req_imp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF input_dict,
             sysnam       TYPE tmssysnam,
             rfcdest      TYPE rfcdest,
             mandt        TYPE symandt,
             trkorr       TYPE ytt_addict_trkorr_det,
             show_popup   TYPE abap_bool,
             notify_users TYPE abap_bool,
           END OF input_dict.

*    METHODS execute
*      IMPORTING !input TYPE input_dict
*      RAISING   ycx_addict_class_method.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: BEGIN OF state_dict,
             input TYPE input_dict,
           END OF state_dict.

    CONSTANTS: BEGIN OF field,
                 sysnam TYPE seocpdname VALUE 'SYSNAM',
                 trkorr TYPE seocpdname VALUE 'TRKORR',
               END OF field.

    CONSTANTS: BEGIN OF method,
                 execute TYPE seocpdname VALUE 'EXECUTE',
               END OF method.

    CONSTANTS: BEGIN OF class,
                 me TYPE seoclsname VALUE 'YCL_ADDICT_TRANSPORT_REQ_IMP',
               END OF class.

    CONSTANTS: BEGIN OF trkorr,
                 some TYPE trkorr VALUE 'SOME',
               END OF trkorr.

    CONSTANTS: critical_message_types TYPE char3 VALUE 'EAX'.

    DATA state TYPE state_dict.

*    METHODS validate_input RAISING ycx_addict_method_parameter.
*    METHODS notify_users.

*    METHODS import_requests
*      RAISING
*        ycx_addict_function_subrc
*        ycx_addict_class_method.
ENDCLASS.



CLASS YCL_ADDICT_TRANSPORT_REQ_IMP IMPLEMENTATION.
ENDCLASS.
