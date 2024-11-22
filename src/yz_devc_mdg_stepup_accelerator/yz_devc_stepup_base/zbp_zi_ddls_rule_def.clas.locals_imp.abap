class lhc_YZI_DDLS_rule_def definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for YZI_DDLS_rule_def result result.

endclass.

class lhc_YZI_DDLS_rule_def implementation.

  method get_instance_authorizations.
  endmethod.

endclass.


