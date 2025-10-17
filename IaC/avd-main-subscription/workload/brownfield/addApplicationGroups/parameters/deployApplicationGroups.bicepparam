using '../deploy.bicep'

param subscriptionId = '<subscription-id>'
param hostPoolResourceId = '/subscriptions/<subscription-id>/resourcegroups/<rg-name>/providers/Microsoft.DesktopVirtualization/hostpools/<hostpool-name>'
param workspaceResourceId = '/subscriptions/<subscription-id>/resourcegroups/<rg-name>/providers/Microsoft.DesktopVirtualization/workspaces/<workspace-name>'
param workspaceFriendlyName = '<workspace-friendly-name>'
param managementPlaneLocation = 'eastus'
param serviceObjectsRgName = 'rg-avd-hp-tst-001'
param applicationGroupNames = [
  'Putty'
  'Edge'
]
param applications = [
  {
    name: 'Putty'
    appGroupName: 'Putty'
    friendlyName: 'Putty'
    filePath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'Putty'
  }
  {
    name: 'Microsoft Edge'
    friendlyName: 'Microsoft Edge'
    appGroupName: 'Edge'
    filePath: 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe'
    iconPath: 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe'
    iconIndex: 0
    description: 'Microsoft Edge'
  }
]
param applicationGroupAssignments = [
  {
    appGroupName: 'Putty'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63' //Desktop Virtualization User
    principalId: '<principal-id>'
    principalType: 'Group'
  }
  {
    appGroupName: 'Edge'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63' //Desktop Virtualization User
    principalId: '<principal-id>'
    principalType: 'Group'
  }
]
