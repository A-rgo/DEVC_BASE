*&---------------------------------------------------------------------*
*&  Include           YZ_PROG_RARE_INCI_UI
*&---------------------------------------------------------------------*
*&Developed by      : Automation and Innovation Team
*&Transport request :
*&Description       : Rreport for RaRe incident management logs
*&---------------------------------------------------------------------*

DATA:
  lv_guid              TYPE   sysuuid_c32,
  lv_user_name         TYPE   yz_dtel_rare_caller,
  lv_tcode             TYPE   tcode,
  lv_inc_no            TYPE   yz_dtel_rare_inc_no,
  lv_short_description TYPE   yz_dtel_rare_sdescription,
  lv_impact            TYPE   yz_dtel_rare_impact,
  lv_state             TYPE   yz_dtel_rare_state,
  lv_urgency           TYPE   yz_dtel_rare_urgency,
  lv_wi_id             TYPE   sww_wiid,
  lv_req_timestamp     TYPE   yz_dtel_ltrm_tstmp,
  lv_inc_timestamp     TYPE   yz_dtel_ltrm_tstmp,
  lv_last_d_timestamp  TYPE   yz_dtel_ltrm_tstmp,
  lv_command           TYPE   yz_dtel_rare_command,
  lv_download_count    TYPE   yz_dtel_download_count,
*lv_LONG_DESCRIPTION   TYPE   YZ_DTEL_RARE_ldesc,
  lv_status_mesg       TYPE   yz_dtel_rare_status,
  lv_data_file         TYPE   flag,
  lv_sub_category      TYPE   yz_dtel_rare_sub_category,
  lv_assignment_grp    TYPE   yz_dtel_rare_assignment_grp.


SELECT-OPTIONS:

s_guid     FOR  lv_guid              ,
s_user     FOR  lv_user_name         ,
s_tcode    FOR  lv_tcode             ,
s_incno    FOR  lv_inc_no            ,
s_sdesc    FOR  lv_short_description ,
s_impact   FOR  lv_impact            ,
s_state    FOR  lv_state             ,
s_urgen    FOR  lv_urgency           ,
s_wi_id    FOR  lv_wi_id             ,
s_req_t    FOR  lv_req_timestamp     ,
s_inc_t    FOR  lv_inc_timestamp     ,
s_last_d   FOR  lv_last_d_timestamp  ,
s_comand   FOR  lv_command           ,
s_dcount   FOR  lv_download_count    ,
*s_ldesc    for  lv_LONG_DESCRIPTION  ,
s_status   FOR  lv_status_mesg       ,
s_data     FOR  lv_data_file         ,
s_subcat   FOR  lv_sub_category       ,
s_grp      FOR  lv_assignment_grp  .

SELECTION-SCREEN SKIP.
PARAMETERS:
  lv_width TYPE   int1 DEFAULT 200,
  lv_hits  TYPE   int4 DEFAULT 250.
