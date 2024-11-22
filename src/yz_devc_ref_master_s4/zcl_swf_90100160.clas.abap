CLASS ZCL_SWF_90100160 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS read_meta
      FOR TABLE FUNCTION ZSWFM_90100160.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS ZCL_SWF_90100160 IMPLEMENTATION.

  METHOD read_meta BY database function for hdb language sqlscript using swwcntp0 swf_flex_cds_sim.
    DECLARE lv_xml clob;
    DECLARE lv_sim_row_count int;

    DECLARE lv__WF_INITIATOR "$ABAP.type( SWP_INITIA )";
    DECLARE lv__WF_PRIORITY "$ABAP.type( SWW_PRIO )";
    DECLARE lv__WF_VERSION "$ABAP.type( SWD_VERSIO )";
    DECLARE lv_REQ_DATA "$ABAP.type( ZREFMASTER_HTML_STRING )";
    DECLARE lv_EV_USER "$ABAP.type( XUBNAME )";
    DECLARE lv_CUSTOMER "$ABAP.type( KUNNR_V )";
    DECLARE lv_CUSTOMER001 "$ABAP.type( KUNNR_V )";
    DECLARE lv_SALES_COND "$ABAP.type( KSCHL )";
    DECLARE lv_SALES_COND001 "$ABAP.type( KSCHL )";
    DECLARE lv_SALES_ORG "$ABAP.type( VKORG )";
    DECLARE lv_SALES_ORG001 "$ABAP.type( VKORG )";
    DECLARE lv_DIST_CHA "$ABAP.type( VTWEG )";
    DECLARE lv_DIST_CHA001 "$ABAP.type( VTWEG )";
    DECLARE lv_IV_OBJ_CLASS "$ABAP.type( ZDE_REF_MASTER_OBJ_CLASS )";
    DECLARE lv_IV_CHANGE_REQ_TYPE "$ABAP.type( ZDE_REF_MASTER_CHNG_REQ_TYPE )";


    DECLARE CURSOR c_xml FOR SELECT bintostr(to_binary(data)) AS xml  FROM swwcntp0 WHERE client = SESSION_CONTEXT('CLIENT') AND wi_id = :wf_id ORDER BY tabix;

    SELECT COUNT(*) AS sim_row_count INTO lv_sim_row_count FROM swf_flex_cds_sim;
    IF :wf_id = '000000000000' OR :lv_sim_row_count > 0 THEN
      lt_simple_attr = SELECT attr_name as name, attr_value as value FROM swf_flex_cds_sim;
    ELSE
      FOR ls_container AS c_xml DO
        SELECT CONCAT(IFNULL(:lv_xml,''), ls_container.xml) INTO lv_xml  FROM PUBLIC.DUMMY;
      END FOR;

      lt_dataref = WITH MYTAB AS (SELECT :lv_xml as xml FROM PUBLIC.DUMMY)
        SELECT *
          FROM XMLTABLE(
            XMLNAMESPACE( 'http://www.sap.com/abapxml' AS 'asx',
                          'http://www.sap.com/abapxml/classes/global' AS  'cls' ),
            '/asx:abap/asx:heap/cls:CL_SWF_CNT_CONTAINER/CL_SWF_CNT_CONTAINER/ELMT/SWFDELMDEFXML'
            PASSING MYTAB.xml
            COLUMNS
              name nvarchar(40) PATH 'NAME',
              value_ref nvarchar(10) PATH 'VALUE/@href',
              type  nvarchar(256) PATH 'TYPE'
        ) as X;

      lt_datavalue = WITH MYTAB AS (SELECT :lv_xml as xml FROM PUBLIC.DUMMY)
        SELECT CONCAT( '#', X.value_ref ) AS value_ref, X.value
          FROM XMLTABLE(
            xmlnamespace( 'http://www.sap.com/abapxml' AS 'asx',  'http://www.sap.com/abapxml/classes/global' AS 'cls' ),
            '/asx:abap/asx:heap/*'
            PASSING MYTAB.xml
            COLUMNS
              value_ref nvarchar(10) PATH '@id',
              value nvarchar(4000) PATH 'text()'
        ) as X;

      lt_simple_attr = SELECT r.name, v.value FROM :lt_dataref AS r
        LEFT OUTER JOIN :lt_datavalue AS v ON r.value_ref = v.value_ref;
    END IF;

* Each simple data container attribute gets selected now
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv__WF_INITIATOR FROM :lt_simple_attr WHERE name =  '_WF_INITIATOR';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv__WF_PRIORITY FROM :lt_simple_attr WHERE name =  '_WF_PRIORITY';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv__WF_VERSION FROM :lt_simple_attr WHERE name =  '_WF_VERSION';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_REQ_DATA FROM :lt_simple_attr WHERE name =  'REQ_DATA';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_EV_USER FROM :lt_simple_attr WHERE name =  'EV_USER';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_CUSTOMER FROM :lt_simple_attr WHERE name =  'CUSTOMER';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_CUSTOMER001 FROM :lt_simple_attr WHERE name =  'CUSTOMER001';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_SALES_COND FROM :lt_simple_attr WHERE name =  'SALES_COND';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_SALES_COND001 FROM :lt_simple_attr WHERE name =  'SALES_COND001';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_SALES_ORG FROM :lt_simple_attr WHERE name =  'SALES_ORG';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_SALES_ORG001 FROM :lt_simple_attr WHERE name =  'SALES_ORG001';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_DIST_CHA FROM :lt_simple_attr WHERE name =  'DIST_CHA';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_DIST_CHA001 FROM :lt_simple_attr WHERE name =  'DIST_CHA001';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_IV_OBJ_CLASS FROM :lt_simple_attr WHERE name =  'IV_OBJ_CLASS';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_IV_CHANGE_REQ_TYPE FROM :lt_simple_attr WHERE name =  'IV_CHANGE_REQ_TYPE';
    END;

* Merge all simple data container attributes into the result struture
    lt_result = SELECT
                  :wf_id AS WorkflowId
                  , :lv__WF_INITIATOR AS _WF_INITIATOR
                  , :lv__WF_PRIORITY AS _WF_PRIORITY
                  , :lv__WF_VERSION AS _WF_VERSION
                  , :lv_REQ_DATA AS REQ_DATA
                  , :lv_EV_USER AS EV_USER
                  , :lv_CUSTOMER AS CUSTOMER
                  , :lv_CUSTOMER001 AS CUSTOMER001
                  , :lv_SALES_COND AS SALES_COND
                  , :lv_SALES_COND001 AS SALES_COND001
                  , :lv_SALES_ORG AS SALES_ORG
                  , :lv_SALES_ORG001 AS SALES_ORG001
                  , :lv_DIST_CHA AS DIST_CHA
                  , :lv_DIST_CHA001 AS DIST_CHA001
                  , :lv_IV_OBJ_CLASS AS IV_OBJ_CLASS
                  , :lv_IV_CHANGE_REQ_TYPE AS IV_CHANGE_REQ_TYPE
                   FROM PUBLIC.DUMMY;

    RETURN :lt_result;
  ENDMETHOD.
ENDCLASS.
