@AbapCatalog.sqlViewName: 'YB_V_BNKA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View for BNKA Table'
define view YB_I_BNKA_S as select from bnka
{
  key concat(banks, bankl) as BanKey,
      banka                as BankName,
      bgrup                as BankGroup,
      bnklz                as BankNumber,
      brnch                as BankBranch,
      erdat                as CreationDate,
      ernam                as CreatedBy,
      loevm                as DeletionIndicator,
      ort01                as City,
      provz                as Region,
      stras                as Street,
      swift                as SWIFTCode,
      xpgro                as PostOffice
}
