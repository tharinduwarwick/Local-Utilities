@EndUserText.label: 'Fiori User Defaults'
define table function ZZTF_FIORI_DEFAULTS
with parameters
    @Environment.systemField: #CLIENT
    p_client       : abap.clnt,
    @Environment.systemField: #USER
    p_user : bname
returns {
  client : abap.clnt;
  username : bname;
  param : abap.char( 100 );
  value : abap.char( 100 );
  
}
implemented by method zzcl_amdp_fiori_defaults=>get_fiori_user_defaults;
