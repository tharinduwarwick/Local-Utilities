@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fiori User Defaults'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZZI_FIORI_DEFAULTS as select from ZZTF_FIORI_DEFAULTS( p_client: $session.client, p_user: $session.user )
{
    key username,
    param,
    value
}
