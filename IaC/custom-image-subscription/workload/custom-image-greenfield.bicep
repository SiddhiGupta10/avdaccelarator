metadata name = 'AVD Accelerator - Baseline Custom Image Deployment'
metadata description = 'AVD Accelerator - Custom Image Baseline'

targetScope = 'subscription'

// ========== //
// Parameters //
// ========== //

@sys.description('Custom name for Action Group.')
param alertsActionGroupCustomName string = 'ag-avd'

@sys.description('Input the email distribution list for alert notifications when avd builds succeed or fail.')
param alertsDistributionGroup array = []

@sys.description('Custom name for the Automation Account.')
param automationAccountCustomName string = 'aa-avd'

@allowed([
  'OneTime'
  'Recurring'
])
@sys.description('Determine whether to build the image template one time or check daily for a new marketplace image and auto build when found. (Default: Recurring)')
param buildSchedule string = 'Recurring'

@sys.description('Input the start time to start scheduled job. (Default: PT15M)')
param schedulerStartTime string = 'PT15M'

@sys.description('Determine whether to enable custom naming for the Azure resources. (Default: false)')
param customNaming bool = false

@allowed([
  'australiaeast'
  'australiasoutheast'
  'brazilsouth'
  'canadacentral'
  'centralindia'
  'centralus'
  'eastasia'
  'eastus'
  'eastus2'
  'francecentral'
  'germanywestcentral'
  'japaneast'
  'jioindiawest'
  'koreacentral'
  'northcentralus'
  'northeurope'
  'norwayeast'
  'qatarcentral'
  'southafricanorth'
  'southcentralus'
  'southeastasia'
  'switzerlandnorth'
  'uaenorth'
  'uksouth'
  'ukwest'
  'usgovarizona'
  'usgoviowa'
  'usgovtexas'
  'usgovvirginia'
  'westcentralus'
  'westeurope'
  'westus'
  'westus2'
  'westus3'
  'swedencentral'
])
@sys.description('Location to deploy the resources in this solution, except the image template. (Default: eastus)')
param deploymentLocation string = 'eastus'

@sys.description('Set to deploy monitoring and alerts for the build automation (Default: false).')
param enableMonitoringAlerts bool = false

@sys.description('Apply tags on resources and resource groups. (Default: false)')
param enableResourceTags bool = false

@sys.description('Enable usage and telemetry feedback to Microsoft.')
param enableTelemetry bool = true

@maxLength(90)
@sys.description('Custom name for Resource Group. (Default: rg-avd-use2-shared-services)')
param resourceGroupCustomName string = 'rg-avd-use2-shared-services'

@sys.description('Input the name of the subnet for the virtual network that the network interfaces on the build virtual machines will join. (Default: "")')
param existingSubnetName string = ''

@sys.description('Existing Azure virtual network resource ID (Default: )')
param existingVirtualNetworkResourceId string = ''

@sys.description('Input private DNS zone resource ID. (Default: )')
param existingPrivateDnsZoneResourceId string = ''

@maxLength(64)
@sys.description('Custom name for Image Definition. (Default: avd-win11-23h2)')
param imageDefinitionCustomName string = 'avd-win11-23h2'

@sys.description('''The image supports accelerated networking.
Accelerated networking enables single root I/O virtualization (SR-IOV) to a VM, greatly improving its networking performance.
This high-performance path bypasses the host from the data path, which reduces latency, jitter, and CPU utilization for the
most demanding network workloads on supported VM types.
''')
param imageDefinitionAcceleratedNetworkSupported bool = true

@sys.description('The image will support hibernation.')
param imageDefinitionHibernateSupported bool = false

@allowed([
  'Standard'
  'TrustedLaunch'
  'ConfidentialVM'
  'ConfidentialVMSupported'
])
@sys.description('Choose the Security Type of the Image Definition. (Default: Standard)')
param imageDefinitionSecurityType string = 'Standard'

@maxLength(64)
@sys.description('Custom name for Image Gallery. (Default: gal_avd_use2_001)')
param imageGalleryCustomName string = 'gal_avd_use2_001'

@maxLength(260)
@sys.description('Custom name for Image Template. (Default: it-avd-win11-23h2)')
param imageTemplateCustomName string = 'it-avd-win11-23h2'

@sys.description('Disaster recovery replication location for Image Version. (Default:"")')
param imageVersionDisasterRecoveryLocation string = ''

@sys.description('Primary replication location for Image Version. (Default:)')
param imageVersionPrimaryLocation string = ''

@allowed([
  //'Premium_LRS' supported by Image Versions but not Image Templates yet
  'Standard_LRS'
  'Standard_ZRS'
])
@sys.description('Determine the Storage Account Type for the Image Version distributed by the Image Template. (Default: Standard_LRS)')
param imageVersionStorageAccountType string = 'Standard_LRS'

@sys.description('The name of the deployment script for configuring an existing subnet.(Default: ds-avd)')
param deploymentScriptCustomName string = 'ds-avd'

@sys.description('Existing Azure log analytics workspace resource ID from management subscription to capture build logs. (Default: )')
param existingLogAnalyticsWorkspaceResourceId string = ''

@sys.description('Custom name for the Log Analytics Workspace.')
param logAnalyticsWorkspaceCustomName string = 'log-avd'

@maxValue(720)
@minValue(30)
@sys.description('Set the data retention in the number of days for the Log Analytics Workspace. (Default: 30)')
param logAnalyticsWorkspaceDataRetention int = 30

@sys.description('Build VM size. (Default: Standard_D4ds_v5)')
param vmSize string = 'Standard_D4ds_v5'

@sys.description('Market place AVD  OS image offer. (Default: Office-365)')
param mpImageOffer string = 'Office-365'

@sys.description('Market place AVD  OS image SKU. (Default: win11-24h2-avd-m365)')
param mpImageSku string = 'win11-24h2-avd-m365'

@sys.description('Market place AVD  OS image publisher.')
param mpImagePublisher string = 'MicrosoftWindowsDesktop'

@sys.description('Market place AVD OS image version.')
param mpImageVersion string = 'latest'

@sys.description('Image Template deployment check. (Default: true)')
param softwareInstallation bool = true // Keep it 'false' for very first deployment. Make it true once storage account is deployed and updated with softwares

@sys.description('AVD shared services subscription ID, multiple subscriptions scenario.')
param sharedServicesSubId string

@sys.description('The name of the storage account for the deployment script.')
param existingStorageAccountResourceId string = ''

@maxLength(24)
@sys.description('Custom name for Storage Account. (Default: stavdshar)')
param storageAccountCustomName string = 'stavdshar'

@allowed([
    'Standard_LRS'
    'Standard_ZRS'
])
@sys.description('Determine the Storage Account SKU for local or zonal redundancy. (Default: Standard_LRS)')
param storageAccountSku string = 'Standard_LRS'

@sys.description('Network rules for Storage Account.')
param storageAccountNetworkRules array = []

@sys.description('Do not modify, used to set unique value for resource deployment.')
param time string = utcNow()

@maxLength(128)
@sys.description('Custom name for User Assigned Identity. (Default: id-avd)')
param userAssignedManagedIdentityCustomName string = ''

@sys.description('Resource Tags object.')
param tags object = {}

@sys.description('AIB Tags object.')
param aibTags object = {}

// =========== //
// Variables   //
// =========== //

var varResourceGroupName = customNaming ? resourceGroupCustomName : 'rg-avd-${varNamingStandard}-shared-services'
var varCommonResourceTags = enableResourceTags ? tags : {}
var varAIBTags = enableResourceTags ? union(tags, aibTags) : {}
var varNamingStandard = '${varLocationAcronym}'
var varLocationAcronym = varLocations[varLocation].acronym
var varLocation = toLower(replace(deploymentLocation, ' ', ''))
var varLocations = loadJsonContent('../../../workload/variables/locations.json')
var varTelemetryId = 'pid-b04f18f1-9100-4b92-8e41-71f0d73e3755-${deploymentLocation}'
var varAzureCloudName = environment().name
var varActionGroupName = customNaming ? alertsActionGroupCustomName : 'ag-avd-${varNamingStandard}'

var varAutomationAccountName = customNaming ? automationAccountCustomName : 'aa-avd-${varNamingStandard}'
var varModules = [
  {
    name: 'Az.Accounts'
    uri: 'https://www.powershellgallery.com/api/v2/package'
    version: '4.0.2'
  }
  {
    name: 'Az.ImageBuilder'
    uri: 'https://www.powershellgallery.com/api/v2/package'
    version: '0.4.1'
  }
]

var varTimeZone = varLocations[varLocation].timeZone
var varImageTemplateName = customNaming ? imageTemplateCustomName : 'it-avd-${mpImageOffer}'
var varUniqueStringSixChar = take('${uniqueString(sharedServicesSubId, time)}', 6)
var varStorageAccountName = empty(existingStorageAccountResourceId) ? (customNaming
  ? storageAccountCustomName
  : 'stavd${varNamingStandard}${varUniqueStringSixChar}') : split(existingStorageAccountResourceId, '/')[8]
var varUserAssignedManagedIdentityName = customNaming ? userAssignedManagedIdentityCustomName
  : 'id-avd-${varNamingStandard}'
var varDeploymentScriptName = customNaming ? deploymentScriptCustomName
  : 'ds-avd-${varNamingStandard}'
var varVnetResourceGroupName = split(existingVirtualNetworkResourceId, '/')[4]
var varVirtualNetworkName = split(existingVirtualNetworkResourceId, '/')[8]
var varSubnetName = existingSubnetName
var varIdentityResourceId = userAssignedManagedIdentity.outputs.resourceId
var varImageDefinitionName = customNaming ? imageDefinitionCustomName : 'avd-${mpImageOffer}-${mpImageSku}'
var varImageGalleryName = customNaming ? imageGalleryCustomName : 'gal_avd_${varNamingStandard}'
var varLogAnalyticsWorkspaceName = customNaming ? logAnalyticsWorkspaceCustomName : 'log-avd-${varNamingStandard}'
var varImageReplicationRegions = empty(imageVersionDisasterRecoveryLocation)
  ? [
      imageVersionPrimaryLocation
    ]
  : [
      imageVersionPrimaryLocation
      imageVersionDisasterRecoveryLocation
    ]

//------------------------
// Alert Rules
//------------------------
var varAlerts = enableMonitoringAlerts
  ? [
      {
        name: 'Azure Image Builder - Build Failure'
        description: 'Sends an error alert when a build fails on an image template for Azure Image Builder.'
        severity: 0
        evaluationFrequency: 'PT5M'
        windowSize: 'PT5M'
        criterias: {
          allOf: [
            {
              query: 'AzureDiagnostics\n| where ResourceProvider == "MICROSOFT.AUTOMATION"\n| where Category  == "JobStreams"\n| where ResultDescription has "Image Template build failed"'
              timeAggregation: 'Count'
              dimensions: [
                {
                  name: 'ResultDescription'
                  operator: 'Include'
                  values: [
                    '*'
                  ]
                }
              ]
              operator: 'GreaterThanOrEqual'
              threshold: 1
              failingPeriods: {
                numberOfEvaluationPeriods: 1
                minFailingPeriodsToAlert: 1
              }
            }
          ]
        }
      }
      {
        name: 'Azure Image Builder - Build Success'
        description: 'Sends an informational alert when a build succeeds on an image template for Azure Image Builder.'
        severity: 3
        evaluationFrequency: 'PT5M'
        windowSize: 'PT5M'
        criterias: {
          allOf: [
            {
              query: 'AzureDiagnostics\n| where ResourceProvider == "MICROSOFT.AUTOMATION"\n| where Category  == "JobStreams"\n| where ResultDescription has "Image Template build succeeded"'
              timeAggregation: 'Count'
              dimensions: [
                {
                  name: 'ResultDescription'
                  operator: 'Include'
                  values: [
                    '*'
                  ]
                }
              ]
              operator: 'GreaterThanOrEqual'
              threshold: 1
              failingPeriods: {
                numberOfEvaluationPeriods: 1
                minFailingPeriodsToAlert: 1
              }
            }
          ]
        }
      }
    ]
  : []

//-------------------------
// Custom RBAC Roles
//-------------------------
var varRoles = union(varVirtualNetworkJoinRole, varImageTemplateBuildAutomation, varImageTemplateContributorRole)

// Image template permissions are currently (1/6/23) not supported in Azure US Government
var varImageTemplateBuildAutomationName = 'Image Template Build Automation'
var varImageTemplateBuildAutomation = varAzureCloudName == 'AzureCloud'
  ? [
      {
        resourceGroup: varResourceGroupName
        name: varImageTemplateBuildAutomationName
        description: 'Allow Image Template build automation using a Managed Identity on an Automation Account.'
        actions: [
          'Microsoft.VirtualMachineImages/imageTemplates/run/action'
          'Microsoft.VirtualMachineImages/imageTemplates/read'
          'Microsoft.Compute/locations/publishers/artifacttypes/offers/skus/versions/read'
          'Microsoft.Compute/locations/publishers/artifacttypes/offers/skus/read'
          'Microsoft.Compute/locations/publishers/artifacttypes/offers/read'
          'Microsoft.Compute/locations/publishers/read'
        ]
        dataActions: []
      }
    ]
  : []

var varImageTemplateContributorRoleName = 'Image Template Contributor'
var varImageTemplateContributorRole = [
  {
    resourceGroup: varResourceGroupName
    name: varImageTemplateContributorRoleName
    description: 'Allow the creation and management of images'
    actions: [
      'Microsoft.Compute/galleries/read'
      'Microsoft.Compute/galleries/images/read'
      'Microsoft.Compute/galleries/images/versions/read'
      'Microsoft.Compute/galleries/images/versions/write'
      'Microsoft.Compute/images/read'
      'Microsoft.Compute/images/write'
      'Microsoft.Compute/images/delete'
    ]
    dataActions: []
  }
]

var varVirtualNetworkJoinRoleName = 'Virtual Network Join'
var varVirtualNetworkJoinRoleRGName = varVnetResourceGroupName
var varVirtualNetworkJoinRole = [
  {
    resourceGroup: varVirtualNetworkJoinRoleRGName
    name: varVirtualNetworkJoinRoleName
    description: 'Allow resources to join a subnet'
    actions: [
      'Microsoft.Network/virtualNetworks/read'
      'Microsoft.Network/virtualNetworks/subnets/read'
      'Microsoft.Network/virtualNetworks/subnets/join/action'
      'Microsoft.Network/virtualNetworks/peer/action'
    // Required to update the private link network policy
      'Microsoft.Network/virtualNetworks/write'
      'Microsoft.Network/networkSecurityGroups/join/action'
      'Microsoft.Network/routeTables/join/action' 
    ]
    dataActions: []
  }
]

//-------------------------
// Customization Steps
//-------------------------

var varScriptCustomizers = union(varPreConfigurationCustomizer, varSoftwareInstallationCustomizer, varDecryptCustomizer, varPostConfigurationCustomizer)
var varCustomizationSteps = union(varScriptCustomizers, varRemainingCustomizers)

// Customization step for pre configurations
var varPreConfigurationCustomizer = softwareInstallation ? [
  {
    type: 'PowerShell'
    name: 'Ensure-Dirs'
    runElevated: true
    runAsSystem: true
    inline: [
             'New-Item -ItemType Directory -Force -Path C:\\AIB'
             'New-Item -ItemType Directory -Force -Path C:\\management\\temp'
            ]
  }
  {
    type: 'PowerShell'
    name: 'InstallAzCopyFromBlob'
    inline: [
      'Write-Host "Installing AzCopy..."'
      'New-Item -ItemType Directory -Path "C:\\management" -Force'
      '$url = "https://aka.ms/downloadazcopy-v10-windows"'
      '$output = "C:\\management\\azcopy.zip"'
      'Invoke-WebRequest -Uri $url -OutFile $output'
      'Expand-Archive -Path $output -DestinationPath "C:\\management" -Force'
      '$azcopyPath = Get-ChildItem -Path "C:\\management" -Recurse -Filter "azcopy.exe" | Select-Object -First 1 -ExpandProperty FullName'
      'Copy-Item $azcopyPath "C:\\management\\azcopy.exe" -Force'
      '[System.Environment]::SetEnvironmentVariable("AZCOPY_AUTO_LOGIN_TYPE", "MSI")'
      'Write-Host "Environment variable set to authorize by using a user-assigned managed identity."'
      'Start-Sleep -Seconds 5'
      'Write-Host "UAMI: ${varIdentityResourceId}"'
      'Write-Host "Logging in to AzCopy..."'
      '& "C:\\management\\azcopy.exe" login --identity --identity-resource-id "${varIdentityResourceId}"'
      '& "C:\\management\\azcopy.exe" copy "https://${varStorageAccountName}.blob.core.windows.net/software" "C:\\AIB" --recursive'
      '$pathItems = Get-ChildItem -Path "C:\\AIB\\software" | Select-Object FullName'
      'foreach ($pathItem in $pathItems) { Write-Host "Found software item: $($pathItem.FullName)" }'
    ]
  }
  {
    type: 'PowerShell'
    name: 'InstallingLanguagePack'
    inline: [
      'dism /Online /Add-Package /PackagePath:"C:\\AIB\\software\\LanguagePack\\Microsoft-Windows-Client-Language-Pack_x64_fi-fi.cab" /NoRestart'
      'dism /Online /Add-Package /PackagePath:"C:\\AIB\\software\\LanguagePack\\Microsoft-Windows-LanguageFeatures-Basic-fi-fi-Package~31bf3856ad364e35~amd64~~.cab" /NoRestart'
    ]
  }
  {
    type: 'WindowsRestart'
    restartCheckCommand: 'Write-Host "Restarting post Language Pack Installation"'
    restartTimeout: '10m'
  }
  // Remove non-required Appx packages
  {
    name: 'RunRemoveAppxScript'
    type: 'PowerShell'
    runAsSystem: true
    runElevated: true
    validExitCodes: [0]
    inline: [
      'Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Azure/RDS-Templates/master/CustomImageTemplateScripts/CustomImageTemplateScripts_2024-03-27/RemoveAppxPackages.ps1" -OutFile "C:\\AIB\\RemoveAppxPackages.ps1"'
      'C:\\AIB\\RemoveAppxPackages.ps1 -AppxPackages @("Microsoft.Xbox.TCUI","Microsoft.XboxGamingOverlay","Microsoft.XboxIdentityProvider","Microsoft.XboxSpeechToTextOverlay","Microsoft.YourPhone","Microsoft.PowerAutomateDesktop","Microsoft.BingNews","Microsoft.BingSearch","Microsoft.BingWeather","Microsoft.OutlookForWindows","Windows.DevHome","WindowsFeedbackHub","Microsoft.MicrosoftSolitaireCollection","Microsoft.MicrosoftOfficeHub","Clipchamp.Clipchamp","Microsoft.GamingApp","Microsoft.ScreenSketch","Microsoft.Todos")'
    ]
  }
  {
    type: 'WindowsRestart'
    restartCheckCommand: 'Write-Host "Restarting post setting wide system language and removing Appx packages"'
    restartTimeout: '10m'
  }
] : []

// Customization step for software installation from storage account
var varSoftwareInstallationCustomizer = softwareInstallation ? [
  {
    type: 'PowerShell'
    name: 'Hyperdrive-Hyperspace-Installation'
    runElevated: true
    runAsSystem: true
    validExitCodes: [0, 3010, 16001]
    scriptUri: 'https://${varStorageAccountName}.blob.core.windows.net/scripts/hyperspaceInstaller.ps1'
  }
  {
    type: 'PowerShell'
    name: 'Sleep for a 2 minutes'
    runElevated: true
    runAsSystem: true
    inline: [
      'Write-Host "Post Hyperspace-Installation, 2 min sleep"'
      'Start-Sleep -Seconds 120'
    ]
  }  
  {
    type: 'PowerShell'
    name: 'Hyperspace-Updates'
    runElevated: true
    runAsSystem: true
    validExitCodes: [0, 3010]
    scriptUri: 'https://${varStorageAccountName}.blob.core.windows.net/scripts/hyperspaceUpdate.ps1'
  }
  {
    type: 'PowerShell'
    name: 'Sleep for a 2 minutes'
    runElevated: true
    runAsSystem: true
    inline: [
      'Write-Host "Post Hyperspace-Update, 2 min sleep"'
      'Start-Sleep -Seconds 120'
    ]
  }  
  {
    type: 'PowerShell'
    name: 'EpicStudio-Installation'
    runElevated: true
    runAsSystem: true
    validExitCodes: [0]
    scriptUri: 'https://${varStorageAccountName}.blob.core.windows.net/scripts/epicStudioInstaller.ps1'
  }
  {
    type: 'PowerShell'
    name: 'FileZilla-Installation'
    runElevated: true
    runAsSystem: true
    validExitCodes: [0]
    scriptUri: 'https://${varStorageAccountName}.blob.core.windows.net/scripts/fileZillaInstaller.ps1'
  }
  {
    type: 'PowerShell'
    name: 'Putty-Installation'
    runElevated: true
    runAsSystem: true
    inline: [
      'Write-Host "-------------------------------"'
      'Write-Host "PuTTY Installation"'
      'Write-Host "-------------------------------"'
      '$sourceFolder = "C:\\AIB\\software\\PuTTY"'
      '$targetFolder = "C:\\Program Files (x86)"'
      'Copy-Item -Path $sourceFolder -Destination $targetFolder -Recurse -Force'
      'Write-Host "PuTTY copied successfully"'
    ]
  }
  {
    type: 'PowerShell'
    name: 'DigiSignClient-Installation'
    runElevated: true
    runAsSystem: true
    validExitCodes: [0]
    scriptUri: 'https://${varStorageAccountName}.blob.core.windows.net/scripts/digiSignClientInstaller.ps1'
  }
] : []

// Customization step to decrypt the Epic Env Config file
var varDecryptCustomizer = softwareInstallation ? [
  {
    type: 'PowerShell'
    name: 'Decrypt-EpicEnvConfig'
    runElevated: true
    runAsSystem: true
    validExitCodes: [0]
    scriptUri: 'https://${varStorageAccountName}.blob.core.windows.net/scripts/decryptConfigFile.ps1'
  }
  {
    type: 'PowerShell'
    name: 'Decrypt-EpicComm'
    runElevated: true
    runAsSystem: true
    validExitCodes: [0]
    scriptUri: 'https://${varStorageAccountName}.blob.core.windows.net/scripts/decryptEpicCommFile.ps1'
  }
] : []

// Customization step for post configuration
var varPostConfigurationCustomizer = softwareInstallation ? [
   {
    type: 'PowerShell'
    name: 'StartupConfigScript'
    runElevated: true
    runAsSystem: true
    scriptUri: 'https://${varStorageAccountName}.blob.core.windows.net/scripts/createTaskScheduled.ps1'
    validExitCodes: [0]
  }
  {
    type: 'PowerShell'
    name: 'ImportCertificates'
    runElevated: true
    runAsSystem: true
    scriptUri: 'https://${varStorageAccountName}.blob.core.windows.net/scripts/importCertificates.ps1'
    validExitCodes: [0]
  }
] : []

// Customization steps for windows updates and restarts
var varRemainingCustomizers = [
  {
    type: 'WindowsRestart'
    restartCheckCommand: 'Write-Host "Restarting post script customizers"'
    restartTimeout: '10m'
  }
  {
    type: 'WindowsUpdate'
    searchCriteria: 'IsInstalled=0'
    filters: [
      'exclude:$_.Title -like \'*Preview*\''
      'include:$true'
    ]
    updateLimit: 40
  }
  {
    type: 'PowerShell'
    name: 'Sleep for 5 minutes'
    runElevated: true
    runAsSystem: true
    inline: [
      'Write-Host "Sleep for 5 min"'
      'Start-Sleep -Seconds 300'
    ]
  }
  {
    type: 'WindowsRestart'
    restartCheckCommand: 'Write-Host "restarting post Windows updates"'
    restartTimeout: '10m'
  }
  {
    type: 'PowerShell'
    name: 'Sleep for a min'
    runElevated: true
    runAsSystem: true
    inline: [
      'Write-Host "Sleep for a min"'
      'Start-Sleep -Seconds 60'
    ]
  }
  {
    type: 'WindowsRestart'
    restartTimeout: '10m'
  }
]

// =========== //
// Deployments //
// =========== //

// Telemetry Deployment.
resource telemetryDeployment 'Microsoft.Resources/deployments@2021-04-01' = if (enableTelemetry) {
  name: varTelemetryId
  location: deploymentLocation
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
    }
  }
}

// AVD Shared Services Resource Group.
module avdSharedResourcesRg '../../../avm/1.1.0/res/resources/resource-group/main.bicep' = {
  scope: subscription(sharedServicesSubId)
  name: 'RG-${time}'
  params: {
    name: varResourceGroupName
    location: deploymentLocation
    tags: enableResourceTags ? varCommonResourceTags : {}
  }
}

// Role definition deployment.
module roleDefinitions '../../../workload/bicep/modules/rbacRoles/roleDefinitionsSubscriptions.bicep' = [
  for i in range(0, length(varRoles)): {
    scope: subscription(sharedServicesSubId)
    name: 'Role-Definition-${i}-${time}'
    params: {
      subscriptionId: sharedServicesSubId
      description: varRoles[i].description
      roleName: varRoles[i].name
      actions: varRoles[i].actions
      dataActions: empty(varRoles[i].dataActions) ? [] : varRoles[i].dataActions
      assignableScopes: [
        '/subscriptions/${sharedServicesSubId}'
      ]
    }
  }
]

// Managed identity.
module userAssignedManagedIdentity '../../../avm/1.1.0/res/managed-identity/user-assigned-identity/main.bicep' = {
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  name: 'User-Assigned-Managed-Identity-${time}'
  params: {
    name: varUserAssignedManagedIdentityName
    location: deploymentLocation
    tags: enableResourceTags ? varCommonResourceTags : {}
  }
  dependsOn: [
    avdSharedResourcesRg
  ]
}

// Role assignments.
module roleAssignments '../../../avm/1.0.0/ptn/authorization/role-assignment/modules/resource-group.bicep' = [
  for i in range(0, length(varRoles)): {
    name: 'Role-Assignment-${i}-${time}'
    scope: resourceGroup(sharedServicesSubId, varRoles[i].resourceGroup)
    params: {
      roleDefinitionIdOrName: roleDefinitions[i].outputs.resourceId
      principalId: userAssignedManagedIdentity.outputs.principalId
      principalType: 'ServicePrincipal'
    }
  }
]

// Role assignment for Storage Account - Storage Blob Data Reader
module saRoleAssignment '../../../avm/1.0.0/ptn/authorization/resource-role-assignment/main.bicep' = {
  name: 'Role-Assignment-SA-${time}'
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  params: {
    roleDefinitionId: '/subscriptions/${sharedServicesSubId}/providers/Microsoft.Authorization/roleDefinitions/2a2b9908-6ea1-4ae2-8e65-a410df84e7d1' //Storage Blob Data Reader
    principalId: userAssignedManagedIdentity.outputs.principalId
    resourceId: storageAccount.outputs.resourceId
    principalType: 'ServicePrincipal'
  }
}

// Role assignment for AIB VM.
module vmRoleAssignment '../../../avm/1.0.0/ptn/authorization/role-assignment/modules/resource-group.bicep' = {
  name: 'Role-Assignment-VM-${time}'
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  params: {
    roleDefinitionIdOrName: '/subscriptions/${sharedServicesSubId}/providers/Microsoft.Authorization/roleDefinitions/f1a07417-d97a-45cb-824c-7a7467783830' //Managed Identity Operator
    principalId: userAssignedManagedIdentity.outputs.principalId
    principalType: 'ServicePrincipal'
  }
}

// Unique role assignment for Azure US Government since it does not support image template permissions
module roleAssignment_AzureUSGovernment '../../../avm/1.1.0/ptn/authorization/role-assignment/modules/resource-group.bicep' = if (varAzureCloudName != 'AzureCloud') {
  name: 'Role-Assignment-MAG-${time}'
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  params: {
    roleDefinitionIdOrName: 'Contributor'
    principalId: userAssignedManagedIdentity.outputs.principalId
    principalType: 'ServicePrincipal'
  }
}

// Storage Account.
module storageAccount '../../../avm/1.1.0/res/storage/storage-account/main.bicep' = {
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  name: 'Storage-Account-${time}'
  params: {
    name: varStorageAccountName
    location: deploymentLocation
    skuName: storageAccountSku
    kind: 'StorageV2'
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: false
    networkAcls: {
      defaultAction: 'Allow'        
      bypass: 'AzureServices'
      virtualNetworkRules: storageAccountNetworkRules    
    }
    managedIdentities: {
      userAssignedResourceIds: [
        userAssignedManagedIdentity.outputs.resourceId
      ]
    }
    blobServices: {
      containers: [
        {
          name: 'scripts'
          publicAccess: 'Blob'
        }
        {
          name: 'software'
          publicAccess: 'Container'
        }
      ]
      automaticSnapshotPolicyEnabled: true
      containerDeleteRetentionPolicyEnabled: true
      containerDeleteRetentionPolicyDays: 10
    }
    privateEndpoints: [
      {
        privateDnsZoneGroup: {
          privateDnsZoneGroupConfigs: [
            {
              privateDnsZoneResourceId: !empty(existingPrivateDnsZoneResourceId) ? '${existingPrivateDnsZoneResourceId}/privatelink.blob.core.windows.net' : ''
            }
          ]
        }
        name: 'pe-${varStorageAccountName}'
        service: 'blob'
        customNetworkInterfaceName: '${varStorageAccountName}-nic'
        subnetResourceId: !empty(existingVirtualNetworkResourceId) && !empty(existingSubnetName)
                          ? '${existingVirtualNetworkResourceId}/subnets/${existingSubnetName}'
                          : ''
      }
    ]
    tags: enableResourceTags ? varCommonResourceTags : {}
  }
  dependsOn: [
    avdSharedResourcesRg
  ]
}

// Compute Gallery.
module gallery '../../../avm/1.1.0/res/compute/gallery/main.bicep' = {
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  name: 'Compute-Gallery-${time}'
  params: {
    name: varImageGalleryName
    location: imageVersionPrimaryLocation
    description: 'Azure Virtual Desktops Images'
    tags: enableResourceTags ? varAIBTags : {}
  }
  dependsOn: [
    avdSharedResourcesRg
  ]
}

// Disables the network policy for the subnet
module deploymentScript '../../../workload/bicep/brownfield/customImageTemplatesPrerequisites/modules/networkPolicy.bicep' = {
  name: 'Network-Policy-${time}'
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  params: {
    deploymentScriptName: varDeploymentScriptName
    location: deploymentLocation
    subnetName: varSubnetName
    tags: enableResourceTags ? varCommonResourceTags : {}
    timestamp: time
    userAssignedIdentityResourceId: userAssignedManagedIdentity.outputs.resourceId
    virtualNetworkName: varVirtualNetworkName
    virtualNetworkResourceGroupName: varVnetResourceGroupName
  }
  dependsOn: [
    roleAssignments
  ]
}

// Image Definition.
module image '../../../avm/1.1.0/res/compute/gallery/image/main.bicep' = {
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  name: 'Image-Definition-${time}'
  params: {
    galleryName: varImageGalleryName
    name: varImageDefinitionName
    osState: 'Generalized'
    osType: 'Windows'
    identifier: {
      publisher: mpImagePublisher
      offer: mpImageOffer
      sku: mpImageSku
    }
    location: imageVersionPrimaryLocation
    hyperVGeneration: 'V2'
    isAcceleratedNetworkSupported: imageDefinitionAcceleratedNetworkSupported
    isHibernateSupported: imageDefinitionHibernateSupported
    securityType: imageDefinitionSecurityType
    tags: enableResourceTags ? varAIBTags : {}
  }
  dependsOn: [
    gallery
    avdSharedResourcesRg
  ]
}

// Image template.
module imageTemplate '../../../avm/1.1.0/res/virtual-machine-images/image-template/main.bicep' = {
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  name: 'Image-Template-${time}'
  params: {
    name: varImageTemplateName
    subnetResourceId: !empty(existingVirtualNetworkResourceId) && !empty(existingSubnetName)
      ? '${existingVirtualNetworkResourceId}/subnets/${existingSubnetName}'
      : ''
    managedIdentities: {
      userAssignedResourceIds: [
        userAssignedManagedIdentity.outputs.resourceId
      ]
    }
    vmUserAssignedIdentities: [
      userAssignedManagedIdentity.outputs.resourceId
    ]
    location: deploymentLocation
    distributions: [
      {
        type: 'SharedImage'
        replicationRegions: varImageReplicationRegions
        storageAccountType: imageVersionStorageAccountType
        sharedImageGalleryImageDefinitionResourceId: image.outputs.resourceId
      }
    ]
    roleAssignments: [
      {
        roleDefinitionIdOrName: '/subscriptions/${sharedServicesSubId}/providers/Microsoft.Authorization/roleDefinitions/ba92f5b4-2d11-453d-a403-e96b0029c9fe' //Storage Blob Data Contributor
        principalId: userAssignedManagedIdentity.outputs.principalId
        principalType: 'ServicePrincipal'
      }
    ]
    vmSize: vmSize
    autoRunState: 'Disabled' // Set to 'Enabled' to automatically start a build when the template is created
    stagingResourceGroupResourceId: 'subscriptions/${sharedServicesSubId}/resourceGroups/IT-${varResourceGroupName}-${time}'
    customizationSteps: varCustomizationSteps
    imageSource: {
      type: 'PlatformImage'
      publisher: mpImagePublisher
      offer: mpImageOffer
      sku: mpImageSku
      version: mpImageVersion
    }
    errorHandlingOnValidationError: 'cleanup'
    errorHandlingOnCustomizerError: 'cleanup'
    tags: enableResourceTags ? varAIBTags : {}
  }
  dependsOn: [
    storageAccount
    gallery
    avdSharedResourcesRg
    roleAssignments
    deploymentScript
  ]
}

// Log Analytics Workspace.
module workspace '../../../avm/1.1.0/res/operational-insights/workspace/main.bicep' = if (enableMonitoringAlerts && empty(existingLogAnalyticsWorkspaceResourceId)) {
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  name: 'Log-Analytics-Workspace-${time}'
  params: {
    location: deploymentLocation
    name: varLogAnalyticsWorkspaceName
    dataRetention: logAnalyticsWorkspaceDataRetention
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    tags: enableResourceTags ? varCommonResourceTags : {}
  }
  dependsOn: [
    avdSharedResourcesRg
  ]
}

// Automation account.
module automationAccount '../../../avm/1.1.0/res/automation/automation-account/main.bicep' = {
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  name: 'Automation-Account-${time}'
  params: {
    diagnosticSettings: enableMonitoringAlerts
      ? [
          {
            workspaceResourceId: empty(alertsDistributionGroup)
              ? ''
              : empty(existingLogAnalyticsWorkspaceResourceId)
                  ? workspace.outputs.resourceId
                  : existingLogAnalyticsWorkspaceResourceId
          }
        ]
      : []
    name: varAutomationAccountName
    jobSchedules: [
      {
        parameters: {
          ClientId: userAssignedManagedIdentity.outputs.clientId
          EnvironmentName: varAzureCloudName
          ImageOffer: mpImageOffer
          ImagePublisher: mpImagePublisher
          ImageSku: mpImageSku
          Location: deploymentLocation
          SubscriptionId: sharedServicesSubId
          TemplateName: imageTemplate.outputs.name
          TemplateResourceGroupName: varResourceGroupName
          TenantId: subscription().tenantId
        }
        runbookName: 'aib-build-automation'
        scheduleName: '${varImageTemplateName}-${time}'
      }
    ]
    location: deploymentLocation
    runbooks: [
      {
        name: 'aib-build-automation'
        description: 'When this runbook is triggered, last build date is checked on the AVD image template.  If a new marketplace image has been released since that date, a new build is initiated. If a build has never been initiated then it will be start one.'
        type: 'PowerShell'
        uri: 'https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/scripts/New-AzureImageBuilderBuild.ps1'
        version: '1.0.0.0'
      }
    ]
    schedules: [
      {
        name: '${varImageTemplateName}-${time}'
        frequency: buildSchedule == 'OneTime' ? 'OneTime' : 'Day'
        interval: buildSchedule == 'OneTime' ? 0 : 1
        starttime: dateTimeAdd(time, schedulerStartTime)
        varTimeZone: varTimeZone
        advancedSchedule: {} // required to prevent deployment failure
      }
    ]
    skuName: 'Free'
    tags: enableResourceTags ? varCommonResourceTags : {}
    managedIdentities: {
      systemAssigned: false
      userAssignedResourceIds: [
        userAssignedManagedIdentity.outputs.resourceId
      ]
    }
    privateEndpoints: [
      {
        privateDnsZoneGroup: {
          privateDnsZoneGroupConfigs: [ 
            { privateDnsZoneResourceId: !empty(existingPrivateDnsZoneResourceId) ? '${existingPrivateDnsZoneResourceId}/privatelink.azure-automation.net' : '' }
          ]
        }
        service: 'Webhook'
        subnetResourceId: !empty(existingVirtualNetworkResourceId) && !empty(existingSubnetName) ? '${existingVirtualNetworkResourceId}/subnets/${existingSubnetName}' : ''
      }
    ]
  }
  dependsOn: [
    avdSharedResourcesRg
    roleAssignments
  ]
}

// Automation accounts.
@batchSize(1)
module modules '../../../avm/1.1.0/res/automation/automation-account/module/main.bicep' = [
  for i in range(0, length(varModules)): {
    scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
    name: 'AA-Module-${i}-${time}'
    params: {
      name: varModules[i].name
      location: deploymentLocation
      automationAccountName: automationAccount.outputs.name
      uri: varModules[i].uri
      version: varModules[i].version
    }
  }
]

// Action groups.
module actionGroup '../../../avm/1.1.0/res/insights/action-group/main.bicep' = if (enableMonitoringAlerts) {
  scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
  name: 'Action-Group-${time}'
  params: {
    location: 'global'
    groupShortName: 'avd-email'
    name: varActionGroupName
    enabled: true
    emailReceivers: [ for email in alertsDistributionGroup: {
      name: replace(email, '@', '-') // unique name per receiver
      emailAddress: email
      useCommonAlertSchema: true
    }]
    tags: enableResourceTags ? varCommonResourceTags : {}
  }
  dependsOn: [
    avdSharedResourcesRg
  ]
}

// Schedules.
module scheduledQueryRules '../../../avm/1.1.0/res/insights/scheduled-query-rule/main.bicep' = [
  for i in range(0, length(varAlerts)): if (enableMonitoringAlerts) {
    scope: resourceGroup(sharedServicesSubId, varResourceGroupName)
    name: 'Scheduled-Query-Rule-${i}-${time}'
    params: {
      location: deploymentLocation
      name: varAlerts[i].name
      alertDescription: varAlerts[i].description
      enabled: true
      kind: 'LogAlert'
      autoMitigate: false
      skipQueryValidation: false
      targetResourceTypes: []
      roleAssignments: []
      scopes: empty(alertsDistributionGroup)
        ? []
        : empty(existingLogAnalyticsWorkspaceResourceId)
            ? [
                workspace.outputs.resourceId
              ]
            : [
                existingLogAnalyticsWorkspaceResourceId
              ]
      severity: varAlerts[i].severity
      evaluationFrequency: varAlerts[i].evaluationFrequency
      windowSize: varAlerts[i].windowSize
      actions: !empty(alertsDistributionGroup)
        ? [
            actionGroup.outputs.resourceId
          ]
        : []
      criterias: varAlerts[i].criterias
      tags: enableResourceTags ? varCommonResourceTags : {}
    }
    dependsOn: [
      avdSharedResourcesRg
    ]
  }
]
