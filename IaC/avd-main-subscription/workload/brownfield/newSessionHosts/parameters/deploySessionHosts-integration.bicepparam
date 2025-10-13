using '.../../../deploy.bicep'

param location = 'swedencentral'
param customNaming = true
param deploySessionHosts = true
param sessionHostCustomNamePrefix = 'vmavdtstiad'
param hostPoolResourceId = '/subscriptions/bf71c834-f4b7-4e3e-b221-d4052b2aabe6/resourceGroups/rg-avd-epcint-tst-euw-008/providers/Microsoft.DesktopVirtualization/hostpools/avd-tst-epcint-euw-hostpool'
param keyVaultResourceId = '/subscriptions/bf71c834-f4b7-4e3e-b221-d4052b2aabe6/resourceGroups/rg-avd-epcint-tst-euw-008/providers/Microsoft.KeyVault/vaults/kv-avd-tst-sec-003'
param configureFslogix = false
param computeRgResourceGroupName = 'rg-avd-epcint-tst-sec-0010'
param countIndex = 3
param count = 1
param customImageDefinitionId = '/subscriptions/dea22b47-2006-40f9-bc94-2eee53d8ddb9/resourceGroups/rg-avd-shd-epc-tst-sec-007/providers/Microsoft.Compute/galleries/gal_tst_avd_07/images/win11-24h2-avd/versions/1.0.31'
param customOsDiskSizeGB = 256
param dataCollectionRuleId = ''
param diskEncryptionSetResourceId = ''
param diskType = 'Premium_LRS'
param securityType = 'TrustedLaunch'
param subnetResourceId = '/subscriptions/bf71c834-f4b7-4e3e-b221-d4052b2aabe6/resourceGroups/rg-avd-epcint-tst-sec-009/providers/Microsoft.Network/virtualNetworks/vnet-avd-tst-sec-002/subnets/snet-avd-tst-sec-002'
param vmSize = 'Standard_D8ads_v5'
param useSharedImage = true
param timeZoneSessionHosts = 'FLE Standard Time'
param hostPoolRdpProperties = 'disabletimezone:i:1;drivestoredirect:s:*;usbdevicestoredirect:s:*;redirectclipboard:i:1;redirectprinters:i:1;audiomode:i:0;videoplaybackmode:i:1;devicestoredirect:s:*;redirectcomports:i:0;redirectsmartcards:i:1;redirectwebauthn:i:1;use multimon:i:1;audiocapturemode:i:1;enablerdsaadauth:i:1;redirectlocation:i:0'
param storageAccountName = 'stavdshdtstsec007'
param deploymentEnvironment = 'int'
