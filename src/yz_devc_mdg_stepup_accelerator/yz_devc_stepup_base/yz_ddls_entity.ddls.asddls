@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Entity CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZ_DDLS_ENTITY
  as select from usmd0020 as ent
  association to usmd0020t         as txt   on  txt.langu        = $session.system_language
                                            and txt.usmd_model   = ent.usmd_model
                                            and txt.usmd_entity  = ent.usmd_entity
                                            and txt.usmd_objstat = ent.usmd_objstat
  //  association to usmd0050          as obj   on  obj.usmd_model   = ent.usmd_model
  //                                            and obj.usmd_objstat = ent.usmd_objstat
  association to dd04t             as _04t  on  _04t.rollname   = ent.rollname
                                            and _04t.ddlanguage = $session.system_language
                                            and _04t.as4local   = ent.usmd_objstat
                                            and _04t.as4vers    is initial

  association to YZ_DDLS_CREQ_TYPE as crtyp on  crtyp.entity = ent.usmd_entity


{
  key usmd_model       as Model,
  key usmd_entity      as Entity,
 //   obj.usmd_otc     as otc,

      case
          when txt.txtlg is not initial
          then txt.txtlg
          else _04t.ddtext
      end              as EntityDescription,
      crtyp.mainentity as mainentity
}
where
  usmd_objstat = 'A'
group by
  usmd_model,
  usmd_entity,
  txt.txtlg,
  _04t.ddtext,
  crtyp.mainentity
