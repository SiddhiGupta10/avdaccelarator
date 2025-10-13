// Update the path below to the correct relative location of custom-image-deploy.bicep
// This paramater file is for deployment using existing VNet

using '../../custom-image-subscription/workload/custom-image-greenfield.bicep'

param sharedServicesSubId = '<shared subscription id>'
param deploymentLocation = 'eastus'
param resourceGroupCustomName = 'rg-avd-shd-tst-01'
param customNaming = true
param enableTelemetry = true
param userAssignedManagedIdentityCustomName = 'id-avd-shd-tst-01'
param existingPrivateDnsZoneResourceId = '/subscriptions/<subscription id>/resourceGroups/<resource group name>/providers/Microsoft.Network/privateDnsZones'
param automationAccountCustomName = 'aa-avd-shd-tst-01'
param buildSchedule = 'OneTime'
param schedulerStartTime = 'PT15M'

//Storage
param existingStorageAccountResourceId = ''
param storageAccountCustomName = '<storage account name>'
param storageAccountNetworkRules = ['<storage account network rules>']

//Network
param existingSubnetName = '<subnet name>'
param existingVirtualNetworkResourceId = '<existing VNet Resource ID>'

//Image
param imageVersionPrimaryLocation = 'swedencentral'
param imageDefinitionCustomName = 'win11-24h2-avd'
param imageDefinitionAcceleratedNetworkSupported = true
param imageDefinitionHibernateSupported = false
param imageDefinitionSecurityType = 'TrustedLaunch'
param imageGalleryCustomName = 'gal_avd_tst_01'
param imageTemplateCustomName = 'it-win11-24h2-avd'
param imageVersionDisasterRecoveryLocation = ''
param imageVersionStorageAccountType = 'Standard_LRS'
param vmSize = 'Standard_D8ds_v5' // VM size for the image builder VM. Change it if you need a different size
param mpImageOffer = 'Windows-11'
param mpImageSku = 'win11-24h2-avd'
param mpImagePublisher  = 'MicrosoftWindowsDesktop'
param softwareInstallation = true // Keep it 'false' for very first deployment. Make it true once storage account is deployed and updated with softwares
param deploymentScriptCustomName = 'ds-avd-shd-tst-01'

//Alert
param enableMonitoringAlerts = true
param alertsActionGroupCustomName = 'ag-avd-shd-tst-01'
param alertsDistributionGroup = [ '<email address>']
param existingLogAnalyticsWorkspaceResourceId = '<existing Log Analytics Workspace Resource ID>'

//Tags
param enableResourceTags = true
param tags = {}
param aibTags = {
  ImageBuilderPipeline: 'AVD-custom-image-deploy'
  GoldenImageId: 'galleries/gal_avd_tst_01/images/win11-24h2-avd/versions/1.0.0'
  ImageVersion: '1.0.0'
  ProfileStore: 'TBD'
}

