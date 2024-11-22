INTERFACE yz_intf_mdg_yb_data_types
  PUBLIC .
  TYPES:
      gty_t_y_bankl TYPE SORTED TABLE OF  yxx_s_yb_pp_y_bankl WITH UNIQUE KEY y_bankl .
  TYPES:
      BEGIN OF gty_s_yb_where,
      yb    TYPE BANKk,
      where TYPE comt_clear_string,
    END OF gty_s_yb_where .
  types:
    gty_t_yb_where TYPE SORTED TABLE OF gty_s_yb_where WITH NON-UNIQUE KEY yb .
  types:
    BEGIN OF gty_s_yb_message.
  TYPES         bankey TYPE bankk.
  INCLUDE TYPE usmd_s_message.
  TYPES         END OF gty_s_yb_message .
  types:
    gty_t_yb_message TYPE STANDARD TABLE OF gty_s_yb_message .
ENDINTERFACE.
