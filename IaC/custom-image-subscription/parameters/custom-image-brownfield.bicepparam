// Update the path below to the correct relative location of custom-image-deploy.bicep
// This paramater file is for deployment using existing VNet

using '../../../workload/bicep/brownfield/customImageTemplatesPrerequisites/deploy.bicep'

param computeGalleryName = 'gal_avd_tst_01'
param deploymentScriptName = 'ds-avd-shd-tst-01'
param existingResourceGroup = true
param existingVirtualNetworkResourceId = '<existing VNet Resource ID>'
param imageDefinitionIsAcceleratedNetworkSupported = false
param imageDefinitionIsHibernateSupported = false
param imageDefinitionName = 'win11-24h2-avd'
param imageDefinitionSecurityType = 'TrustedLaunch'
param imageOffer = 'Windows-11'
param imagePublisher = 'MicrosoftWindowsDesktop'
param imageSku = 'win11-24h2-avd'
param location = 'eastus'
param resourceGroupName = 'rg-avd-shd-tst-01'
param storageAccountName = '<storage account name>'
param subnetName = 'SharedServices'
param tags = {
  'Workload Name': 'avd'
  'Workload Type': 'epic'
  'Data Classification': 'application'
  'Department': 'IT'
  'Workload Criticality': 'High'
  'Application Name': 'Epic Framework'
  'Workload SLA': 'TBD'
  'Operation Team': 'Apotti IT'
  'Owner': 'TBD'
  'Cost Center': 'TBD'
}
param userAssignedIdentityName = 'id-avd-shd-tst-01'
