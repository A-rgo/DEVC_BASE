@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view for BNKA table'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #MIXED
}
define view entity Yb_I_Bnka
  as select from bnka
{
  key concat(banks, bankl) as BankKey,
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
