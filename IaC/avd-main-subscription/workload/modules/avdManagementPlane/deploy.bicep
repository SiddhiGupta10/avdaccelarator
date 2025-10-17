// ========== //
// Parameters //
// ========== //
@sys.description('Location where to deploy AVD management plane.')
param location string

@sys.description('AVD Host Pool Name')
param hostPoolName string

@sys.description('AVD workspace name.')
param workSpaceName string

@sys.description('AVD host pool load balacing type.')
param hostPoolLoadBalancerType string

@sys.description('Optional. AVD host pool type.')
param hostPoolType string

@sys.description('Optional. The type of preferred application group type.')
param preferredAppGroupType string 

@sys.description('Subnet resource ID for private endpoint')
param SubnetId string

@sys.description('The ResourceID of the AVD Private DNS Zone for Connection. (privatelink.wvd.azure.com)')
param avdVnetPrivateDnsZoneConnectionResourceId string

@sys.description('The ResourceID of the AVD Private DNS Zone for Discovery. (privatelink-global.wvd.azure.com)')
param avdVnetPrivateDnsZoneDiscoveryResourceId string

@sys.description('AVD host pool Custom RDP properties.')
param hostPoolRdpProperties string

@sys.description('AVD deploy scaling plan.')
param deployScalingPlan bool

@sys.description('AVD scaling plan name')
param scalingPlanName string

@sys.description('AVD scaling plan schedules')
param scalingPlanSchedules array

@sys.description('AVD workload subscription ID, multiple subscriptions scenario.')
param subscriptionId string

@sys.description('AVD Resource Group Name for the service objects.')
param serviceObjectsRgName string

@sys.description('Do not modify, used to set unique value for resource deployment.')
param time string = utcNow()

@sys.description('Resource ID of keyvault that will contain host pool registration token.')
param keyVaultResourceId string

// =========== //
// Deployments//
// =========== //

// Hostpool creation.
module hostPool '../../../../../avm/1.0.0/res/desktop-virtualization/host-pool/main.bicep' = {
  scope: resourceGroup('${subscriptionId}', '${serviceObjectsRgName}')
  name: 'HostPool-${time}'
  params: {
    name: hostPoolName
    friendlyName: hostPoolName
    hostPoolType: hostPoolType
    location: location
    loadBalancerType: hostPoolLoadBalancerType
    preferredAppGroupType: preferredAppGroupType
    publicNetworkAccess: 'EnabledForClientsOnly'
    keyVaultResourceId: keyVaultResourceId
    privateEndpoints: [
      {
        name: 'pe-${hostPoolName}'
        subnetResourceId: SubnetId
        service: 'connection'
        customNetworkInterfaceName: 'nic-pe-${hostPoolName}'
        privateDnsZoneResourceIds: [
          avdVnetPrivateDnsZoneConnectionResourceId
        ]
      }
    ]
    customRdpProperty: hostPoolRdpProperties
  }
}

// Workspace.
module workspace '../../../../../avm/1.0.0/res/desktop-virtualization/workspace/main.bicep' = {
  scope: resourceGroup('${subscriptionId}', '${serviceObjectsRgName}')
  name: 'Workspace-${time}'
  params: {
    name: workSpaceName
    location: location
  }
}

// Scaling plan.
module scalingPlan '../../../../../avm/1.0.0/res/desktop-virtualization/scaling-plan/main.bicep' =  if (deployScalingPlan)  {
  name: 'Scaling-Plan-${scalingPlanName}'
  params: {
      name:scalingPlanName
      location: location
      hostPoolType: hostPoolType
      schedules: scalingPlanSchedules
      timeZone: 'FLE Standard Time'
      hostPoolReferences: [
        {
        hostPoolArmPath: hostPool.outputs.resourceId
        scalingPlanEnabled: true
        }
      ]
  }
  dependsOn: [
    workspace
  ]
}

// =========== //
// Outputs //
// =========== //
output hostPoolResourceId string = hostPool.outputs.resourceId
