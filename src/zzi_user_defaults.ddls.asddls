@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'User Defaults (Fiori and GUI)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/* Author : Tharindu Wickramasooriya (University of Warwick)
 * Date   : 30-JAN-2026
 * Description : Custom view entity to read Fiori Launchpad Default Values 
 */
 
define view entity ZZI_USER_DEFAULTS
 /*
    Most fiori launchpad parameters are read from GET/SET parameters that are retrieved in the second part
    of the union block below. Other parameters are stored in /UI2/ITEM table as personalization JSON tokens.
    The view entity ZZI_FIORI_DEFAULTS implements a table function to retrieve value embedded within the JSON token.
*/
  as select distinct from ZZI_FIORI_DEFAULTS
{
  key username,
      cast( param as abap.char( 100 ) ) as UserParameter,
      cast( value as abap.char( 100 ) ) as UserParameterValue
}

union select distinct from I_UserParameter_F2200
{
  key $session.user                                  as username,
      cast( 
            /*
                The case statement below was built by looking at the DEFAULTPARAMETER_GET_ENTITY
                method of CL_FIN_USER_DEFAUaLTPAR_DPC_EXT class of the gateway service 
                FIN_USER_DEFAULTPARAMETER
                
                This case statement will need to be looked at an updated as new parameters get added.
                Follow Jocelyn Dart's blog below to potentially spot these updates with patches.
                https://community.sap.com/t5/technology-blog-posts-by-sap/applying-user-defaults-in-sap-s-4hana/ba-p/13341777
            */
            case UserParameter
                  when 'BUK' then 'CompanyCode'
                  when 'CAC' then 'ControllingArea'
                  when 'LAR' then 'ActivityType'
                  when 'LSG' then 'ActivityTypeGroup'
                  when 'ANK' then 'AssetClass'
                  when 'AN1' then 'MasterFixedAsset'
                  when 'AN2' then 'FixedAsset'
                  when 'GSB' then 'BusinessArea'
                  when 'KWP' then 'BusinessProcess'
                  when 'KPL' then 'ChartOfAccounts'
                  when 'UDM_GROUP' then 'CollectionGroup'
                  when 'UDM_SEGMENT' then 'CollectionSegment'
                  when 'UDM_SPECIALIST' then 'CollectionSpecialist'
                  when 'KOS' then 'CostCenter'
                  when 'KSG' then 'CostCenterGroup'
                  when 'KAT' then 'CostElement'
                  when 'KAG' then 'CostElementGroup'
                  when 'KTR' then 'CostObject'
                  when 'UKM_SEGMENT' then 'CreditSegment'
                  when 'KUN' then 'Customer'
                  when 'BAR' then 'AccountingDocumentType'
                  when 'KUT' then 'ExchangeRateType'
                  when 'BIL' then 'FinancialStatementVariant'
                  when 'GJR' then 'FiscalYear'
                  when 'FBE' then 'FunctionalArea'
                  when 'SAK' then 'GLAccount'
                  when 'GLN' then 'Ledger'
                  when 'ANR' then 'InternalOrder'
                  when 'GLDGRP_FLEX' then 'LedgerGroup'
                  when 'MAT' then 'Material'
                  when 'WRK' then 'Plant'
                  when 'PRC' then 'ProfitCenter'
                  when 'STA' then 'StatisticalKeyFigure'
                  when 'PC5' then 'StatisticalKeyFigureGroup'
                  when 'XTX' then 'TaxIsCalculatedAutomatically'
                  when 'BWT' then 'ControlllingValuationType'
                  when 'LIF' then 'Supplier'
                  when 'PRO' then 'WBSElement'
                  when 'BKL' then 'BankCountry'
                  when 'BNK' then 'Bank'
                  when 'BKT' then 'BankAccount'
                  when 'FARP_HBKID' then 'HouseBank'
                  when 'FARP_HKTID' then 'HouseBankAccount'
                  when 'FUCN_SEG' then 'Segment'
                  when 'PSP' then 'Project'
                  when 'AUN' then 'SalesOrder'
                  when 'FWS' then 'DisplayCurrency'
                  when 'VKD' then 'CustomerGroup'
                  when 'FCOM_GL_ACCT_GRP' then 'GLAccountGroup'
                  when 'CSV' then 'BillOfMaterialVariantUsage'
                  when 'AEN' then 'ChangeNumber'
                  when 'VKB' then 'SalesOffice'
                  when 'VKG' then 'SalesGroup'
                  when 'VKO' then 'SalesOrganization'
                  when 'VTW' then 'DistributionChannel'
                  when 'SPA' then 'Division'
                  when 'VAG' then 'SoldToParty'
                  when 'KWE' then 'ShipToParty'
                  when 'VRE' then 'BillToParty'
                  when 'KRG' then 'PayerParty'
                  when 'VST' then 'ShippingPoint'
                  when 'LAG' then 'StorageLocation'
                  when 'FIK' then 'FinancialManagementArea'
                  when 'FIC' then 'Fund'
                  when 'FIS' then 'FundsCenter'
                  when 'FPS' then 'CommitmentItem'
                  when 'FM_MEASURE' then 'FundedProgram'
                  when 'BUDPER' then 'BudgetPeriod'
                  when 'DOTY' then 'BudgetEntryDocumentType'
                  when 'BP2' then 'BudgetVersion'
                  when 'AGR' then 'WorkCenter'
                  when 'EKO' then 'PurchasingOrganization'
                  when 'EKG' then 'PurchasingGroup'
                  when 'KNT' then 'AccountAssignmentCategory'
                  when 'MKL' then 'MaterialGroup'
                  when 'MTA' then 'MaterialType'
                  when 'AAT' then 'SalesDocumentType'
                  when 'CSA' then 'BOMExplosionApplication'
                  when 'AFB' then 'AssetDepreciationArea'
                  when 'PWS' then 'ProjectProfileCode'
                  when 'FINS_FIS_FICO_BAL' then 'IsPeriodBasedBalanceReporting'
                  when '/SCWM/LGN' then 'Warehouse'
                  when '/SCWM/WST' then 'WarehouseWorkCenter'
                  when 'TPM_VAL_AREA' then 'TreasuryValuationArea'
                  when 'ACCOUNTING_PRINCIPLE' then 'AccountingPrinciple'
                  when 'ERB' then 'OperatingConcern'
                  when 'CRM_PROCESS_TYPE' then 'ServiceOrderType'
                  when 'FCOM_GL_ACCT_HIER' then 'GLAccountHierarchy'
                  else UserParameter
                end
      as abap.char( 100 ) )                          as UserParameter,
      cast( UserParameterValue as abap.char( 100 ) ) as UserParameterValue
}
