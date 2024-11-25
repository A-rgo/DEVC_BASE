@AbapCatalog.sqlViewName: 'YBADRC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View for Adrc table'
define view YB_ADRC as select from adrc 
{
    key addrnumber as Addrnumber,
    key date_from as DateFrom,
    key nation as Nation,
    date_to as DateTo,
    title as Title,
    name1 as Name1,
    name2 as Name2,
    name3 as Name3,
    name4 as Name4,
    name_text as NameText,
    name_co as NameCo,
    city1 as City1,
    city2 as City2,
    city_code as CityCode,
    cityp_code as CitypCode,
    home_city as HomeCity,
    cityh_code as CityhCode,
    chckstatus as Chckstatus,
    regiogroup as Regiogroup,
    post_code1 as PostCode1,
    post_code2 as PostCode2,
    post_code3 as PostCode3,
    pcode1_ext as Pcode1Ext,
    pcode2_ext as Pcode2Ext,
    pcode3_ext as Pcode3Ext,
    po_box as PoBox,
    dont_use_p as DontUseP,
    po_box_num as PoBoxNum,
    po_box_loc as PoBoxLoc,
    city_code2 as CityCode2,
    po_box_reg as PoBoxReg,
    po_box_cty as PoBoxCty,
    postalarea as Postalarea,
    transpzone as Transpzone,
    street as Street,
    dont_use_s as DontUseS,
    streetcode as Streetcode,
    streetabbr as Streetabbr,
    house_num1 as HouseNum1,
    house_num2 as HouseNum2,
    house_num3 as HouseNum3,
    str_suppl1 as StrSuppl1,
    str_suppl2 as StrSuppl2,
    str_suppl3 as StrSuppl3,
    location as Location,
    building as Building,
    floor as Floor,
    roomnumber as Roomnumber,
    country as Country,
    langu as Langu,
    region as Region,
    addr_group as AddrGroup,
    flaggroups as Flaggroups,
    pers_addr as PersAddr,
    sort1 as Sort1,
    sort2 as Sort2,
    sort_phn as SortPhn,
    deflt_comm as DefltComm,
    tel_number as TelNumber,
    tel_extens as TelExtens,
    fax_number as FaxNumber,
    fax_extens as FaxExtens,
    flagcomm2 as Flagcomm2,
    flagcomm3 as Flagcomm3,
    flagcomm4 as Flagcomm4,
    flagcomm5 as Flagcomm5,
    flagcomm6 as Flagcomm6,
    flagcomm7 as Flagcomm7,
    flagcomm8 as Flagcomm8,
    flagcomm9 as Flagcomm9,
    flagcomm10 as Flagcomm10,
    flagcomm11 as Flagcomm11,
    flagcomm12 as Flagcomm12,
    flagcomm13 as Flagcomm13,
    addrorigin as Addrorigin,
    mc_name1 as McName1,
    mc_city1 as McCity1,
    mc_street as McStreet,
    extension1 as Extension1,
    extension2 as Extension2,
    time_zone as TimeZone1,
    taxjurcode as Taxjurcode,
    address_id as AddressId,
    langu_crea as LanguCrea,
    adrc_uuid as AdrcUuid,
    uuid_belated as UuidBelated,
    id_category as IdCategory,
    adrc_err_status as AdrcErrStatus,
    po_box_lobby as PoBoxLobby,
    deli_serv_type as DeliServType,
    deli_serv_number as DeliServNumber,
    county_code as CountyCode,
    county as County,
    township_code as TownshipCode,
    township as Township,
    mc_county as McCounty,
    mc_township as McTownship,
    xpcpt as Xpcpt,
    _dataaging as Dataaging,
    duns as Duns,
    dunsp4 as Dunsp4
}
