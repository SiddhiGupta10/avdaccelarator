using '../deploy.bicep'
param automationAccountName = 'aa-avd-tst-euw-002'
param runbookName  = 'runbk-avd-tst-euw-001'
param userAssignedManagedIdentityName = 'id-avd-epc-tst-sec-005'
param runbookScriptUrl = 'https://stavdshdtstsec007.blob.core.windows.net/scripts/restartSessionHosts.ps1'
param hostPoolResourceGroup = 'rg-avd-epc-tst-euw-005'
param hostPoolName = 'avd-tst-epc-weu-hostpool'
param sessionHostResourceGroup  = 'rg-avd-epc-tst-sec-007'
param servicesSubId = 'bf71c834-f4b7-4e3e-b221-d4052b2aabe6' //subcr-avd-tst-001
param privateDnsZoneId = '/subscriptions/f48119b4-1d9e-4757-af90-f3c99d22876a/resourceGroups/rg-net-tst-sec-002/providers/Microsoft.Network/privateDnsZones/privatelink.azure-automation.net'
param subnetResourceId ='/subscriptions/bf71c834-f4b7-4e3e-b221-d4052b2aabe6/resourceGroups/rg-avd-epcint-tst-sec-009/providers/Microsoft.Network/virtualNetworks/vnet-avd-tst-sec-002/subnets/snet-avd-tst-sec-002'
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
    message: 'Apotti-järjestelmän ajastettu uudelleen käynnistys. Tallenna työsi ja sulje Apotti-järjestelmä. Apotti yhteytesi on muodostunut koneeseen, joka uudelleen käynnistetään 15 minuutin kuluttua. Voit jatkaa työskentelyä avaamalla Apotti-järjestelmän uudelleen, jolloin yhteytesi muodostuu toiseen koneeseen.'
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
    message: 'Apotti-järjestelmän ajastettu uudelleen käynnistys. Tallenna työsi ja sulje Apotti-järjestelmä. Apotti yhteytesi on muodostunut koneeseen, joka uudelleen käynnistetään 15 minuutin kuluttua. Voit jatkaa työskentelyä avaamalla Apotti-järjestelmän uudelleen, jolloin yhteytesi muodostuu toiseen koneeseen.'
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
