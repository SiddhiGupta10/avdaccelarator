metadata name = 'AVD LZA management plane'
metadata description = 'This module deploys AVD workspace, host pool, application group scaling plan'
metadata owner = 'Azure/avdaccelerator'

targetScope = 'subscription'

// ========== //
// Parameters //
// ========== //
@sys.description('Location where to deploy AVD management plane.')
param managementPlaneLocation string

@sys.description('AVD workload subscription ID, multiple subscriptions scenario.')
param subscriptionId string

@sys.description('AVD Resource Group Name for the service objects.')
param serviceObjectsRgName string

@sys.description('AVD Application group for the session hosts.')
param applicationGroupNames array = []

@sys.description('AVD Applications for the session hosts.')
param applications array = []

@sys.description('AVD Role Assignments.')
param applicationGroupAssignments array = []

@sys.description('AVD workspace resource ID.')
param workspaceResourceId string

@sys.description('AVD Host Pool resource ID.')
param hostPoolResourceId string

@sys.description('workspace friendly name.')
param workspaceFriendlyName string

@sys.description('Do not modify, used to set unique value for resource deployment.')
param time string = utcNow()


// =========== //
// Deployments//
// =========== //

// Call on the hotspool
resource hostPoolGet 'Microsoft.DesktopVirtualization/hostPools@2023-09-05' existing = {
  name: last(split(hostPoolResourceId, '/'))
  scope: resourceGroup(split(hostPoolResourceId, '/')[4])
}

// Application groups.
module applicationGroups '../../../../../avm/1.0.0/res/desktop-virtualization/application-group/main.bicep' = [for applicationGroup in applicationGroupNames: {
  scope: resourceGroup('${subscriptionId}', '${serviceObjectsRgName}')
  name: '${applicationGroup}-${time}'
  params: {
    name: applicationGroup
    friendlyName: applicationGroup
    location: managementPlaneLocation
    applicationGroupType: 'RemoteApp'
    hostpoolName: hostPoolGet.name
    tags: hostPoolGet.tags
    applications: filter(applications, app => app.appGroupName == applicationGroup)
    roleAssignments: filter(applicationGroupAssignments, role => role.appGroupName == applicationGroup)

  }
}]

// Call existing workspace
resource workSpaceGet 'Microsoft.DesktopVirtualization/workspaces@2023-09-05' existing = {
  name: last(split(workspaceResourceId, '/'))
  scope: resourceGroup(split(workspaceResourceId, '/')[4])
}

// Workspace.
module workSpace '../../../../../avm/1.0.0/res/desktop-virtualization/workspace/main.bicep' = {
  scope: resourceGroup('${subscriptionId}', '${serviceObjectsRgName}')
  name: 'Workspace-${time}'
  params: {
      name: workSpaceGet.name
      friendlyName: empty(workspaceFriendlyName) ? workSpaceGet.properties.friendlyName : workspaceFriendlyName
      location: managementPlaneLocation
      applicationGroupReferences: [for i in range(0, length(applicationGroupNames)): applicationGroups[i].outputs.resourceId]
      tags: workSpaceGet.tags
      publicNetworkAccess: workSpaceGet.properties.publicNetworkAccess
  }
}

