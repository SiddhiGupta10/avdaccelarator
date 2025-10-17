using '../deploy.bicep'
param automationAccountName = 'aa-avd-tst-001'
param runbookName  = 'runbk-avd-tst-001'
param userAssignedManagedIdentityName = 'id-avd-tst-001'
param runbookScriptUrl = 'https://<storage-account>.blob.core.windows.net/scripts/restartSessionHosts.ps1'
param hostPoolResourceGroup = 'rg-avd-hp-tst-001'
param hostPoolName = 'avd-tst-epc-weu-hostpool'
param sessionHostResourceGroup  = 'rg-avd-vm-tst-001'
param servicesSubId = '<subscription-id>'
param privateDnsZoneId = '/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/privateDnsZones/privatelink.wvd.microsoft.com'
param subnetResourceId ='/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/virtualNetworks/<subnet-vnet>/subnets/<subnet-name>'
param jobScheduleDetails = [
  {
    action: 'Phase1-Drain'
    scheduleName: 'sched-phase1-drain'
    phaseName: ''
    message: ''
  }
  {
    action: 'Reboot-Alert'
    scheduleName: 'sched-phase1-alert'
    phaseName: 'Phase1'
    message: 'Reboot starts in 15 minutes. Please save your work and close the system.'
  }
  {
    action: 'Phase1-Reboot'
    scheduleName: 'sched-phase1-reboot'
    phaseName: ''
    message: ''
  }
  {
    action: 'Phase2-Drain'
    scheduleName: 'sched-phase2-drain'
    phaseName: ''
    message: ''
  }
  {
    action: 'Reboot-Alert'
    scheduleName: 'sched-phase2-alert'
    phaseName: 'Phase2'
    message: 'Reboot starts in 15 minutes. Please save your work and close the system.'
  }
  {
    action: 'Phase2-Reboot'
    scheduleName: 'sched-phase2-reboot'
    phaseName: ''
    message: ''
  }
]
param schedules = [
  {
    name: 'sched-phase1-drain'
    frequency: 'Week'
    interval: 1
    starttime: '2025-10-11T14:00:00+03:00' //2 PM Finland time Saturday
    timeZone: 'FLE Standard Time'
    description: '2PM drain 50% VMs every Saturday Finland time'
    advancedSchedule: {
      weekDays: ['Saturday']
    }
  }
  {
    name: 'sched-phase1-alert'
    frequency: 'Week'
    interval: 1
    starttime: '2025-10-11T20:45:00+03:00' //8:45 PM Finland time Saturday
    timeZone: 'FLE Standard Time'
    description: '8:45PM broadcast message every Saturday Finland time'
    advancedSchedule: {
      weekDays: ['Saturday']
    }
  }
  {
    name: 'sched-phase1-reboot'
    frequency: 'Week'
    interval: 1
    startTime: '2025-10-11T21:00:00+03:00' //9 PM Finland time Saturday
    timeZone: 'FLE Standard Time'
    description: '9:00 PM restart 50% drained VMs every Saturday Finland time'
    advancedSchedule: {
      weekDays: ['Saturday']
    }
  }
  {
    name: 'sched-phase2-drain'
    frequency: 'Week'
    interval: 1
    starttime: '2025-10-11T21:05:00+03:00' //9:05 PM Finland time Saturday
    timeZone: 'FLE Standard Time'
    description: '9:05 PM drain 50% VMs every Saturday Finland time'
    advancedSchedule: {
      weekDays: ['Saturday']
    }
  }
  {
    name: 'sched-phase2-alert'
    frequency: 'Week'
    interval: 1
    starttime: '2025-10-12T03:45:00+03:00' //3:45 AM Finland time Sunday
    timeZone: 'FLE Standard Time'
    description: '3:45AM broadcast message every Sunday Finland time'
    advancedSchedule: {
      weekDays: ['Sunday']
    }
  }
  {
    name: 'sched-phase2-reboot'
    frequency: 'Week'
    interval: 1
    starttime: '2025-10-12T04:00:00+03:00' //4 AM Finland time Sunday
    timeZone: 'FLE Standard Time'
    description: '4:00 AM restart 50% drained VMs every Sunday Finland time'
    advancedSchedule: {
      weekDays: ['Sunday']
    }
  }
]
