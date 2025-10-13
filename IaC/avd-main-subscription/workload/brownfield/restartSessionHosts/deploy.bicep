targetScope = 'subscription'

@description('Location for all resources')
param location string = 'swedencentral'

@description('Automation Account name')
param automationAccountName string = 'avd-maintenance-auto'

@description('Runbook name')
param runbookName string = 'avd-maintenance-runbook'

@description('Public URL to the runbook script (PS1 in repo or storage)')
param runbookScriptUrl string = ''

@description('Time to start the one-time schedule. Format: yyyy-MM-ddTHH:mm:ssZ')
param time string = utcNow()

@description('Custom name for User Assigned Identity.')
param userAssignedManagedIdentityName string = ''

@description('Resource Group containing the AVD Host Pool')
param hostPoolResourceGroup string = ''

@description('AVD Host Pool name')
param hostPoolName string = ''

@description('Runbook schedules')
param schedules array = []

@description('Runbook job schedule details')
param jobScheduleDetails array = []

@description('Resource Group containing the Session Host VMs')
param sessionHostResourceGroup string = ''

@description('Subscription ID where the AVD resources are deployed. If empty, current subscription is used.')
param servicesSubId string = ''

@description('Private DNS Zone connection resource ID for the Automation Account private endpoint.')
param privateDnsZoneId string = ''

@description('Subnet resource Id for automation account private endpoint.')
param subnetResourceId string = ''

// =========== //
// Variables   //
// =========== //

var varServicesSubId = empty(servicesSubId) ? subscription().subscriptionId : servicesSubId
var varModules = [
  {
    name: 'Az.Accounts'
    uri: 'https://www.powershellgallery.com/api/v2/package'
    version: '5.3.0'
  }
  {
    name: 'Az.DesktopVirtualization'
    uri: 'https://www.powershellgallery.com/api/v2/package'
    version: '5.4.1'
  }
  {
    name: 'Az.Compute'
    uri: 'https://www.powershellgallery.com/api/v2/package'
    version: '10.3.0'
  }
]

// =========== //
// Deployments //
// =========== //

// Managed identity.
module userAssignedManagedIdentity '../../../../../../avm/1.1.0/res/managed-identity/user-assigned-identity/main.bicep' = {
  scope: resourceGroup(varServicesSubId, hostPoolResourceGroup)
  name: 'User-Assigned-Managed-Identity-${time}'
  params: {
    name: userAssignedManagedIdentityName
    location: location
  }
}

// Role assignments.
module dvRoleAssignment '../../../../../../avm/1.0.0/ptn/authorization/role-assignment/modules/resource-group.bicep' = {
  name: 'Role-Assignment-DV-${time}'
  scope: resourceGroup(varServicesSubId, hostPoolResourceGroup)
  params: {
    roleDefinitionIdOrName: '/subscriptions/${servicesSubId}/providers/Microsoft.Authorization/roleDefinitions/082f0a83-3be5-4ba1-904c-961cca79b387' // Desktop Virtualization Contributor
    principalId: userAssignedManagedIdentity.outputs.principalId
    principalType: 'ServicePrincipal'
  }
}

module vmRoleAssignment '../../../../../../avm/1.0.0/ptn/authorization/role-assignment/modules/resource-group.bicep' = {
  name: 'Role-Assignment-VM-${time}'
  scope: resourceGroup(varServicesSubId, sessionHostResourceGroup)
  params: {
    roleDefinitionIdOrName: '/subscriptions/${varServicesSubId}/providers/Microsoft.Authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c' // Virtual Machine Contributor
    principalId: userAssignedManagedIdentity.outputs.principalId
    principalType: 'ServicePrincipal'
  }
}

// Automation account.
module automationAccount '../../../../../../avm/1.1.0/res/automation/automation-account/main.bicep' = {
  scope: resourceGroup(varServicesSubId, hostPoolResourceGroup)
  name: 'Automation-Account-${time}'
  params: {
    name: automationAccountName
    location: location
    runbooks: [
      {
        name: runbookName
        description: 'When this runbook is triggered, session hosts part of hostpool are restarted.'
        type: 'PowerShell'
        logVerbose: true
        logProgress: true
        uri: runbookScriptUrl
        version: '1.0.0.0'
      }
    ]
    jobSchedules: [
      for i in range(0, length(jobScheduleDetails)): {
        parameters: {
          SubscriptionId: varServicesSubId
          TenantId: subscription().tenantId
          ClientId: userAssignedManagedIdentity.outputs.clientId
          HostPoolResourceGroup: hostPoolResourceGroup
          SessionHostResourceGroup: sessionHostResourceGroup
          HostPoolName: hostPoolName
          Action: jobScheduleDetails[i].action
          PhaseName: jobScheduleDetails[i].phaseName
          Message: jobScheduleDetails[i].message
        }
        runbookName: runbookName
        scheduleName: jobScheduleDetails[i].scheduleName
      }
    ]
    schedules: empty(schedules) ? [] : schedules
    skuName: 'Free'
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
            { privateDnsZoneResourceId: privateDnsZoneId }
          ]
        }
        service: 'Webhook'
        subnetResourceId: subnetResourceId
      }
    ]
  }
}

// Automation accounts.
@batchSize(1)
module modules '../../../../../../avm/1.1.0/res/automation/automation-account/module/main.bicep' = [
  for i in range(0, length(varModules)): {
    scope: resourceGroup(varServicesSubId, hostPoolResourceGroup)
    name: 'AA-Module-${i}-${time}'
    params: {
      name: varModules[i].name
      location: location
      automationAccountName: automationAccount.outputs.name
      uri: varModules[i].uri
      version: varModules[i].version
    }
  }
]

