@AbapCatalog.sqlViewName: 'YZ_DDLS_DD03LTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view for Data element and text'
define view YZ_CDS_DD03L_TEXT as select from dd03l as data_element
left outer join dd04t as text_element
    on data_element.rollname = text_element.rollname
   and text_element.ddlanguage = $session.system_language 
{
    key data_element.tabname as tabname,
    key data_element.fieldname as fieldname,
    key data_element.as4local as as4local,
    key data_element.as4vers as as4vers,
    key data_element.position as position,
    key text_element.ddlanguage as language,
        data_element.rollname as rollname,
        text_element.ddtext as ddtext,
        text_element.reptext as reptext,
        text_element.scrtext_s as scrtext_s,
        text_element.scrtext_m as scrtext_m,
        text_element.scrtext_l as scrtext_l
} where data_element.as4local = 'A'
