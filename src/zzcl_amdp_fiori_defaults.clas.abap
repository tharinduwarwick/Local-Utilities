CLASS zzcl_amdp_fiori_defaults DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
    CLASS-METHODS:
      get_fiori_user_defaults FOR TABLE FUNCTION zztf_fiori_defaults.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zzcl_amdp_fiori_defaults IMPLEMENTATION.

  METHOD get_fiori_user_defaults BY DATABASE FUNCTION
  FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS  READ-ONLY USING :/ui2/item.

    RETURN select
                    session_context( 'CLIENT' ) as Client,
                    user_id as username,
                    id as param,
                    json_value( value, '$.value' ) as value

                  FROM "/UI2/ITEM"
                   where
                   user_id = session_context( 'APPLICATIONUSER' ) and
                   cont_category = 'P' and
                   cont_id = 'sap.ushell.UserDefaultParameter' and
                   json_value( value, '$.value' ) is not null ;

  ENDMETHOD.

ENDCLASS.
