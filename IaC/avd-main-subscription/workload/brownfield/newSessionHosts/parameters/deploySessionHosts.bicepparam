using '.../../../deploy.bicep'

param location = 'eastus'
param customNaming = true
param deploySessionHosts = true
param sessionHostCustomNamePrefix = 'vmavdtstadd'
param hostPoolResourceId = '/subscriptions/<subscription-id>/resourcegroups/<rg-name>/providers/Microsoft.DesktopVirtualization/hostpools/<hostpool-name>'
param keyVaultResourceId = '/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.KeyVault/vaults/kv-avd-tst-001'
param configureFslogix = false
param computeRgResourceGroupName = 'rg-avd-vm-tst-001'
param countIndex = 3
param count = 1
param customImageDefinitionId = '/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/galleries/gal_tst_avd_001/images/win11-24h2-avd/versions/<image-version>'
param customOsDiskSizeGB = 256
param dataCollectionRuleId = ''
param diskEncryptionSetResourceId = ''
param diskType = 'Premium_LRS'
param securityType = 'TrustedLaunch'
param subnetResourceId = '/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>'
param vmSize = 'Standard_D8ads_v5'
param useSharedImage = true
param timeZoneSessionHosts = 'FLE Standard Time'
param hostPoolRdpProperties = ''
param storageAccountName = '<storage account name>'
param deploymentEnvironment = 'tst'
