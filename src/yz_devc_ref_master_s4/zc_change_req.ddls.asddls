@AbapCatalog.sqlViewName: 'ZCCHANGEREQ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Change Request Details'
define view ZC_CHANGE_REQ as select from usmd120c {
    @Consumption.filter:{ selectionType: #SINGLE, mandatory: false, hidden: false}
    key usmd_crequest as Request,
    usmd_creq_type as Request_type
}
