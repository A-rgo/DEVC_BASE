CLASS yz_clas_python_library_base DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      ty_execprot TYPE STANDARD TABLE OF btcxpglog .

    CLASS-METHODS execute_python_script
      IMPORTING
        !i_inclname   TYPE sobj_name DEFAULT 'YZINC_EXE_PY_SCRPT'
        !i_scriptname TYPE string    DEFAULT 'TEXT2IMAGE.PY'
        !i_filename   TYPE text1024  DEFAULT '/hana/log/Python_MDG_Files/we will win.png'
      EXPORTING
        !t_execprot   TYPE ty_execprot .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YZ_CLAS_PYTHON_LIBRARY_BASE IMPLEMENTATION.


  METHOD execute_python_script.
*--------------------------------------------------------------------*
* Developed By Rahul Bhayani For Deloitte India internal Asset For MDG
*--------------------------------------------------------------------*

    CALL FUNCTION 'YZFUNC_EXECUTE_PYTHON_SCRIPT'
      EXPORTING
        i_inclname   = i_inclname
        i_scriptname = i_scriptname
        i_filename   = i_filename
      TABLES
        t_execprot   = t_execprot[].

  ENDMETHOD.
ENDCLASS.
