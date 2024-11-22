@AbapCatalog.sqlViewName: 'YZ_DDLS_DD02LTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view for Table and Text'
define view YZ_CDS_DD02L_TEXT as select from dd02l as tab
left outer join dd02t as text_tab
    on tab.tabname = text_tab.tabname
   and text_tab.ddlanguage = $session.system_language 
{
    key tab.tabname as tabname,
    key tab.as4local as as4local,
    key tab.as4vers as as4vers,
    key tab.tabclass as tabclass,
    key text_tab.ddlanguage as language,
        text_tab.ddtext as ddtext
} where tab.as4local = 'A' and tab.tabclass = 'TRANSP'
