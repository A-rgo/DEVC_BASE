CLASS YCL_MDC_AMDP_YB_BNKA000 DEFINITION PUBLIC CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .
    TYPES: ty_t_but000 TYPE STANDARD TABLE OF but000.

    METHODS MATCH
      IMPORTING
                VALUE(v_process_id)      TYPE mdc_process_id
                VALUE(v_process_step_no) TYPE mdc_process_step_no
                VALUE(v_own_system)      TYPE mdg_business_system
                VALUE(v_now)             TYPE tzntstmps
                VALUE(v_limit)           TYPE mdc_hdb_limit
                VALUE(v_offset)          TYPE mdc_hdb_offset
                value(v_ruleset)         TYPE mdc_hdb_ruleset_name
      RAISING   cx_amdp_execution_failed.


ENDCLASS.

CLASS YCL_MDC_AMDP_YB_BNKA000 IMPLEMENTATION.

  METHOD MATCH BY DATABASE PROCEDURE FOR HDB LANGUAGE
                  SQLSCRIPT USING
                                  MDC_MTC_LOG
                                  ZZTAB_BNK_ACT_SR
                                  ZTAB_BNK_ACT
                                  ZZTAB_BNK_ACT_PR
                                  .

*select the source records that has to be used as criteria while calling search ruleset
* Joins on the process tables is done to get the source records instead of using process view due
* to dependency created by view that is view should be available in the target system before transporting the AMDP class
* offset and limit are used to enable parallel processing of packages and each package should consider differnt src record

    DECLARE cursor c_request for
             select * from
             (
                       SELECT
                        ZZTAB_BNK_ACT_PR.PROCESS_ID,
                        ZZTAB_BNK_ACT_PR.PROCESS_STEP_NO,
                        ZZTAB_BNK_ACT_PR.SOURCE_ID,
                        ZZTAB_BNK_ACT_PR.SOURCE_SYSTEM,
                        ZZTAB_BNK_ACT_PR.BANKL AS ZZTAB_BNK_ACT_PR_BANKL,
                        ZZTAB_BNK_ACT_PR.CLIENT AS ZZTAB_BNK_ACT_PR_CLIENT
                        FROM ZZTAB_BNK_ACT_PR
              )
                where ZZTAB_BNK_ACT_PR_CLIENT = SESSION_CONTEXT ('CLIENT') AND
                      process_id =:v_process_id
                      and process_step_no = lpad( :v_process_step_no - 1,4,'0')
                      and ( ZZTAB_BNK_ACT_PR_CLIENT, process_id, process_step_no, source_system, source_id )
                          in ( select CLIENT, process_id, process_step_no, source_system, source_id from ZZTAB_BNK_ACT_PR
                                  where process_id = :v_process_id and
                                        process_step_no = lpad( :v_process_step_no - 1,4,'0' ) and
                                        CLIENT = SESSION_CONTEXT ('CLIENT')
                                  order by CLIENT, process_id, process_step_no, source_system, source_id asc
                                  limit :v_limit offset :v_offset )
                order by ZZTAB_BNK_ACT_PR_CLIENT, process_id, process_step_no, source_system, source_id asc;

     DECLARE v_i int := 0;
     DECLARE v_sql_insert nvarchar(5000);
     DECLARE v_rs_string nvarchar(5000);
     DECLARE v_rs_part1 nvarchar(5000);
     DECLARE v_rs_part2 nvarchar(5000);
     DECLARE v_source_system  nvarchar(60) := '';
     DECLARE v_source_id  nvarchar(60) := '';
     DECLARE v_sql_ins_update nvarchar(5000);
     DECLARE v_count int :=0;
     DECLARE v_step_no char(4);
     DECLARE v_sql_delete nvarchar(5000);
     DECLARE v_packno int := 0;
     DECLARE v_enable_log nvarchar(1) := '';
     DECLARE v_string_special nvarchar(5000);

     select count( * ) into v_count from mdc_mtc_log where client = SESSION_CONTEXT ('CLIENT');

     IF v_count > 0 THEN
         select enable_log INTO v_enable_log from mdc_mtc_log WHERE client = SESSION_CONTEXT ('CLIENT');
     END IF;

     IF :v_limit > 0 THEN
        v_packno := (  :v_offset / :v_limit ) + 1 ;
     END IF;

     v_step_no := lpad( :v_process_step_no - 1,4,'0');

*START Matching
*Groups numbers : one group for each source

      v_i := :v_offset;

*loop through source records using cursor with one record at a time

     FOR request_row as c_request() DO

*View(Join) can give us the duplicate records when there is a 1-->n cardinality between two entities
*Same source should not create multiple groups

        IF ( request_row.source_system != v_source_system  OR request_row.source_id != v_source_id   ) THEN
            v_i := v_i + 1;
        END IF;

        v_source_system := request_row.source_system;
        v_source_id := request_row.source_id;

*if there is a update for a source record that record has to be considered and filled into the result table as match with update
*Join the root table(ex :but000) and STAT TABLE(BUT-SRC_STAT )for a specific source record to see if there is a update
       v_count := 0;

       SELECT COUNT(*) INTO v_count from ZZTAB_BNK_ACT_SR AS s join ZTAB_BNK_ACT AS a
                  on
                    s.BANKS = a.BANKS
                      WHERE s.source_id = request_row.source_id
                            AND s.source_system = request_row.source_system
                            AND s.status IN ( 'C' )
                            AND s.CLIENT = SESSION_CONTEXT( 'CLIENT' )
                            AND a.MANDT = SESSION_CONTEXT ( 'CLIENT' );

        IF   :v_count  > 0  THEN

* if updates are available insert that update to result table to which ruelset inserts the match result
* oin the root table(ex :but000) and STAT TABLE(BUT-SRC_STAT )for a specific source record with status as 'C' on best record guid

              v_sql_ins_update := 'INSERT INTO MDC_MATCH_RESULT_INTERNAL_TABLE_NOT_IN_DDIC  SELECT ' ||
                            SESSION_CONTEXT( 'CLIENT' ) || ' AS client,' || :v_packno || ' AS Package_num,'''
                            ||:v_process_id || ''' AS process_id,'
                            ||:v_i || ' AS match_group_id,'''||:v_own_system||''' AS source_system ,a.BANKS AS source_id,s.source_system AS source_systemsrc,s.source_id AS source_idsrc,'||
                             ''''|| :v_process_id || ''' AS process_id_src,1 AS _score,'''' AS _rule_id,''X'' AS update_indicator' ||
                             ' FROM ZZTAB_BNK_ACT_SR AS s join ZTAB_BNK_ACT AS a on '||
                   ' s.BANKS = a.BANKS ' ||
                   ' WHERE s.source_id = ''' || request_row.source_id||''' AND s.source_system = '''|| request_row.source_system ||
                              ''' AND  ' ||
                   ' s.BANKS <> '''' AND' ||
                             '  s.status IN ( ''C'' )' ||
                             ' AND s.CLIENT = ' || SESSION_CONTEXT( 'CLIENT' ) ||
                             ' AND a.MANDT = ' || SESSION_CONTEXT ( 'CLIENT' ) ;

            EXEC( :v_sql_ins_update );

        END IF;

* Call the ruleset with match columns and value

        v_rs_part1 := 'call sys.execute_search_rule_set(''<query> ' ||
                                '<ruleset name="' || :v_ruleset ||'" /> ';


       IF ( IFNULL (to_nchar(request_row.ZZTAB_BNK_ACT_PR_BANKL),'0') <> '0' ) OR ( IFNULL (to_nchar(request_row.ZZTAB_BNK_ACT_PR_BANKL),'1') <> '1' )   THEN
*  Handling for special characters
  v_string_special := request_row.ZZTAB_BNK_ACT_PR_BANKL;


*  Escape the doble quote as it is a delimiter in ruleset
                   v_string_special := replace( v_string_special,'"','\"' );

*                Nullify the special meaning
                    IF(
                        ( length( v_string_special)  > 0 ) and
                        ( locate( v_string_special ,' -') > 0 or
                          locate( v_string_special ,'-') = 1  or
                          left( v_string_special , 1 ) = ' '
                         )
                       )  THEN
                             v_string_special := '"'|| v_string_special || '"';
                    END IF;

* Encode the character that has special meaning in ruelset xml
                   v_string_special :=  replace(replace(replace(replace(replace(replace(replace(replace
                                           ( v_string_special,'&','&amp;')
                                           ,'<','&lt;'),'>','&gt;'),'"','&quot;'),'''','&apos;'),'%','\%'),'*','\*'),' OR ',' or ');


                   v_rs_part1 := v_rs_part1 || ' <column name="ZZTAB_BNK_ACT_PR_BANKL">' || v_string_special  || '</column> ' ;

       END IF;

       v_rs_part2 :=   ' <resulttableschema name="' || CURRENT_SCHEMA || '" />' ||
                         ' <resulttablename name="MDC_MATCH_RESULT_INTERNAL_TABLE_NOT_IN_DDIC" />' ||
                         '<constantcolumn name="CLIENT">' || SESSION_CONTEXT( 'CLIENT' ) || '</constantcolumn>' ||
                         '<constantcolumn name="PACKAGE_NUM">' || :v_packno || '</constantcolumn>' ||
                         '<constantcolumn name="PROCESS_ID_SRC">' || :v_process_id || '</constantcolumn>' ||
                         '<constantcolumn name="MATCH_GROUP_ID">' || :v_i || '</constantcolumn>' ||
                         '<constantcolumn name="SOURCE_SYSTEMSRC">' || request_row.source_system || '</constantcolumn>' ||
                         '<constantcolumn name="SOURCE_IDSRC">' || request_row.source_id || '</constantcolumn>' ||
                         '<constantcolumn name="UPDATE_INDICATOR"></constantcolumn>' ||

                         '<filter>"ZZTAB_BNK_ACT_PR_CLIENT" = ' || SESSION_CONTEXT(  'CLIENT' ) ||
                         ' AND ( "PROCESS_STEP_NO" IS NULL OR "PROCESS_STEP_NO" = ''''' || :v_step_no ||
                         ''''' OR "PROCESS_STEP_NO" = '''''''') ' ||
                         ' AND ( "_PROCESS_ID" = ''''' || :v_process_id || ''''' ) ' || '</filter>'
                         || ' </query>'')';

*  to be checked with anil about the below statement
       v_rs_string := v_rs_part1 || v_rs_part2 ;
       exec (:v_rs_string);

     END FOR;

*  Fill match result table from tmp_table which has the result of ruleset execution
*  As tmp_table will have results of all parallel process that are running
*  During execution records belonging to each session is handled by using offset and limit on process table and using those source records


     v_sql_insert := 'INSERT INTO mdc_match_result SELECT client, process_id_src, lpad(match_group_id,10,''0''), '
                      || 'lpad(row_number() over (partition by match_group_id),10,''0''), source_systemsrc, source_idsrc, ifnull(source_system,'''
                      ||:v_own_system||'''), source_id, '
                      || ' _rule_id, _score*100 ,update_indicator from  MDC_MATCH_RESULT_INTERNAL_TABLE_NOT_IN_DDIC WHERE '
                      || 'process_id_src = ' || '''' || :v_process_id || '''' || 'and package_num = ' || :v_packno ;

     exec (:v_sql_insert);

* Entry in the tmp_table has to be deleted as the data inside it specific to a session
* During execution records belonging to each session is handled by using offset and limit on process table and using those source records

     IF ( v_enable_log != 'X' ) THEN
        v_sql_delete :=  'DELETE FROM MDC_MATCH_RESULT_INTERNAL_TABLE_NOT_IN_DDIC WHERE process_id_src = ' || '''' || :v_process_id || ''''
                          || 'and package_num = ' || :v_packno ;
        exec (:v_sql_delete);
     END IF;

-- END  Matching

  ENDMETHOD.

ENDCLASS.
