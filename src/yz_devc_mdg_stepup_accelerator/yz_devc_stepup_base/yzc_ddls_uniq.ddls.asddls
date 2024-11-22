@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Join condition for Uniqueness check'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZC_DDLS_UNIQ as select from mdghdb_pp_tjoin as join_table
    left outer join mdghdb_pp_fjoin as join_field on join_table.otc = join_field.otc 
                                                  and join_table.left_table = join_field.left_table 
                                                  and join_table.right_table = join_field.right_table 
{
key join_table.otc as otc, 
key join_table.left_table as left_table, 
key join_table.right_table as right_table, 
key join_field.left_field as left_field,
    join_field.right_field as right_field, 
    join_table.jointype as jointype 
}  where join_field.left_field <> 'CLIENT' and join_field.left_field <> 'MANDT' 
