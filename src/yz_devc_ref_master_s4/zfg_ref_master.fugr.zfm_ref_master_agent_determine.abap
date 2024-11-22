FUNCTION zfm_ref_master_agent_determine.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(HEADER) TYPE  ZREF_MASTER OPTIONAL
*"  TABLES
*"      ACTOR_TAB STRUCTURE  SWHACTOR
*"      AC_CONTAINER STRUCTURE  SWCONT
*"----------------------------------------------------------------------
  "used in Scenario:
  REFRESH actor_tab.

  INCLUDE <cntn01>.
  DATA lv_obj_class TYPE zde_ref_master_obj_class.
  DATA lv_req_type  TYPE zde_ref_master_chng_req_type.
  swc_get_element ac_container 'OBJECT_CLASS' lv_obj_class.
  swc_get_element ac_container 'CHANGE_REQ_TYPE' lv_obj_class.

  zcl_ref_master_flex=>get_1st_approver(
    EXPORTING
      iv_obj_class       = lv_obj_class                 " Flexible Workflow Context
      iv_change_req_type = lv_req_type                 " Change Request Type
    IMPORTING
      et_user            = DATA(lt_approver)                " User Name in User Master Record
  ).

  actor_tab[] = VALUE #( FOR lw_approver IN lt_approver ( otype = 'US' objid = lw_approver ) ).

ENDFUNCTION.
