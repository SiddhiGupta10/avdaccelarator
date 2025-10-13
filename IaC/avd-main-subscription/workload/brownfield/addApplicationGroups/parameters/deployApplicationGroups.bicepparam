using '../deploy.bicep'

param subscriptionId = 'bf71c834-f4b7-4e3e-b221-d4052b2aabe6'
param hostPoolResourceId = '/subscriptions/bf71c834-f4b7-4e3e-b221-d4052b2aabe6/resourcegroups/rg-avd-epc-tst-euw-005/providers/Microsoft.DesktopVirtualization/hostpools/avd-tst-epcts-euw-hostpool'
param workspaceResourceId = '/subscriptions/bf71c834-f4b7-4e3e-b221-d4052b2aabe6/resourcegroups/rg-avd-epc-tst-euw-005/providers/Microsoft.DesktopVirtualization/workspaces/avd-tst-epcts-euw-ws'
param workspaceFriendlyName = 'Tuotanto-tst'
param managementPlaneLocation = 'westeurope'
param serviceObjectsRgName = 'rg-avd-epc-tst-euw-005'
param applicationGroupNames = [
  'putty'
  'Edge'
  'hyperspace'
  'epicstudio'
  'Filezilla'
  'hyperdrive'
  'Apotti-jarjestelma'
  'Lukutilainen-Apotin-varajarjestelma'
  'Apotti-opas'
  'Apotti-tukiportaali'
  'PuTTY-SUP'
  'PuTTY-BLD'
  'PuTTY-KTST'
  'PuTTY-PRD'
  'PuTTY-RELBLD'
  'PuTTY-REL-CONV'
  'PuTTY-SRO'
  'PuTTY-Training'
  'Apotti-harjoitteluymparisto1'
  'Apotti-harjoitteluymparisto2'
  'Apotti-harjoitteluymparisto3'
  'Apotti-harjoitteluymparisto4'
  'Kotikoulutusace02'
  'Kotikoulutusace03'
  'Kotikoulutusace04'
  'Kotikoulutusace05'
  'Hyperdriveeko01'
  'Puttyeko'
]
param applications = [
  {
    name: 'Putty'
    appGroupName: 'putty'
    friendlyName: 'putty'
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
  {
    name: 'Hyperspace'
    friendlyName: 'Hyperspace'
    appGroupName: 'hyperspace'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperspace\\EpicDesktop.exe'
    iconPath: 'C:\\Program Files (x86)\\Epic\\Hyperspace\\EpicDesktop.exe'
    iconIndex: 0
    description: 'Hyperspace'
  }
  {
    name: 'EpicStudio'
    friendlyName: 'EpicStudio'
    appGroupName: 'epicstudio'
    filePath: 'C:\\Program Files (x86)\\EpicStudio\\EpicStudio.exe'
    iconPath: 'C:\\Program Files (x86)\\EpicStudio\\EpicStudio.exe'
    iconIndex: 0
    description: 'EpicStudio'
  }
  {
    name: 'FileZilla'
    friendlyName: 'FileZilla'
    appGroupName: 'Filezilla'
    filePath: 'C:\\Program Files\\FileZilla FTP Client\\filezilla.exe'
    iconPath: 'C:\\Program Files\\FileZilla FTP Client\\filezilla.exe'
    iconIndex: 0
    description: 'FileZilla'
  }
  {
    name: 'Hyperdrive'
    friendlyName: 'Hyperdrive'
    appGroupName: 'hyperdrive'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\100.2508.1.0\\Hyperdrive\\Hyperdrive.exe'
    iconPath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\100.2508.1.0\\Hyperdrive\\Hyperdrive.exe'
    iconIndex: 0
    description: 'Hyperdrive'
  }
  //Hyperdrive bat file apps
  {
    name: 'Apotti-jarjestelma'
    friendlyName: 'Apotti-järjestelmä'
    appGroupName: 'Apotti-jarjestelma'
    filePath: 'C:\\Sovellukset\\Hyperdrive\\Hyperdrive_PRD.bat'
    iconPath: 'C:\\Sovellukset\\Hyperdrive\\Apotti_jarjestelma.ico'
    iconIndex: 0
    description: 'Apotti-järjestelmä'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  {
    name: 'Lukutilainen-Apotin-varajarjestelma'
    friendlyName: 'Lukutilainen Apotin varajärjestelmä'
    appGroupName: 'Lukutilainen-Apotin-varajarjestelma'
    filePath: 'C:\\Sovellukset\\Hyperdrive\\Hyperdrive_RPT.bat'
    iconPath: 'C:\\Sovellukset\\Hyperdrive\\Lukutilainen_Apotin_varajarjestelma.ico'
    iconIndex: 0
    description: 'Lukutilainen Apotin varajärjestelmä'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  //Edge link apps
  {
    name: 'Apotti-opas'
    friendlyName: 'Apotti-opas'
    appGroupName: 'Apotti-opas'
    filePath: 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe'
    iconPath: 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe'
    commandLineArguments: 'https://apotti.my.uperform.com/#/?authMode=8d67ce24-6a9c-4e1f-88a4-e31f148f3b2d'
    commandLineSetting: 'Require'
    iconIndex: 0
    description: 'Apotti opas'
  }
  {
    name: 'Apotti-tukiportaali'
    friendlyName: 'Apotti-tukiportaali'
    appGroupName: 'Apotti-tukiportaali'
    filePath: 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe'
    iconPath: 'C:\\Sovellukset\\tukiportaali\\Apotti_tukiportaali.ico'
    commandLineArguments: 'https://aapo.service-now.com'
    commandLineSetting: 'Require'
    iconIndex: 0
    description: 'Apotti tukiportaali'
  }
  //Putty link app
  {
    name: 'PuTTY-SUP'
    friendlyName: 'PuTTY SUP'
    appGroupName: 'PuTTY-SUP'
    filePath: 'C:\\Sovellukset\\Putty\\PuttySUP.cmd'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'PuTTY SUP'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  {
    name: 'PuTTY-BLD'
    friendlyName: 'PuTTY BLD'
    appGroupName: 'PuTTY-BLD'
    filePath: 'C:\\Sovellukset\\Putty\\PuttyNonProd.cmd'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'PuTTY BLD'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  {
    name: 'PuTTY-KTST'
    friendlyName: 'PuTTY KTST'
    appGroupName: 'PuTTY-KTST'
    filePath: 'C:\\Sovellukset\\Putty\\PuttyKTST.cmd'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'PuTTY KTST'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  {
    name: 'PuTTY-PRD'
    friendlyName: 'PuTTY PRD'
    appGroupName: 'PuTTY-PRD'
    filePath: 'C:\\Sovellukset\\Putty\\PuttyPRD.cmd'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'PuTTY PRD'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  {
    name: 'PuTTY-RELBLD'
    friendlyName: 'PuTTY RELBLD'
    appGroupName: 'PuTTY-RELBLD'
    filePath: 'C:\\Sovellukset\\Putty\\PuttyRELBLD.cmd'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'PuTTY RELBLD'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  {
    name: 'PuTTY-REL-CONV'
    friendlyName: 'PuTTY REL CONV'
    appGroupName: 'PuTTY-REL-CONV'
    filePath: 'C:\\Sovellukset\\Putty\\PuttyREL.cmd'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'PuTTY REL-CONV'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  {
    name: 'PuTTY-SRO'
    friendlyName: 'PuTTY SRO'
    appGroupName: 'PuTTY-SRO'
    filePath: 'C:\\Sovellukset\\Putty\\PuttySRO.cmd'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'PuTTY SRO'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  {
    name: 'PuTTY-Training'
    friendlyName: 'PuTTY Training'
    appGroupName: 'PuTTY-Training'
    filePath: 'C:\\Sovellukset\\Putty\\PuttyTraining.cmd'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'PuTTY Training'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
  {
    name: 'Apotti-harjoitteluymparisto1'
    friendlyName: 'Apotti-harjoitteluympäristö1'
    appGroupName: 'Apotti-harjoitteluymparisto1'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconPath: 'C:\\Sovellukset\\Hyperspace\\Apotti_TRNPLY.ico'
    iconIndex: 0
    description: 'Apotti-harjoitteluymparisto1'
    commandLineArguments: 'env="TRNPLY01"'
    commandLineSetting: 'Require'
  }
  {
    name: 'Apotti-harjoitteluymparisto2'
    friendlyName: 'Apotti-harjoitteluympäristö2'
    appGroupName: 'Apotti-harjoitteluymparisto2'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconPath: 'C:\\Sovellukset\\Hyperspace\\Apotti_TRNPLY.ico'
    iconIndex: 0
    description: 'Apotti-harjoitteluymparisto2'
    commandLineArguments: 'env="TRNPLY02"'
    commandLineSetting: 'Require'
  }

  {
    name: 'Apotti-harjoitteluymparisto3'
    friendlyName: 'Apotti-harjoitteluympäristö3'
    appGroupName: 'Apotti-harjoitteluymparisto3'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconPath: 'C:\\Sovellukset\\Hyperspace\\Apotti_TRNPLY.ico'
    iconIndex: 0
    description: 'Apotti-harjoitteluymparisto2'
    commandLineArguments: 'env="TRNPLY03"'
    commandLineSetting: 'Require'
  }
  {
    name: 'Apotti-harjoitteluymparisto4'
    friendlyName: 'Apotti-harjoitteluympäristö4'
    appGroupName: 'Apotti-harjoitteluymparisto4'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconPath: 'C:\\Sovellukset\\Hyperspace\\Apotti_TRNPLY.ico'
    iconIndex: 0
    description: 'Apotti-harjoitteluymparisto4'
    commandLineArguments: 'env="TRNPLY04"'
    commandLineSetting: 'Require'
  }
  {
    name: 'Kotikoulutusace02'
    friendlyName: 'Kotikoulutus ACE02'
    appGroupName: 'Kotikoulutusace02'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconPath: 'C:\\Sovellukset\\Hyperspace\\Apotti_ACE.ico'
    iconIndex: 0
    description: 'Kotikoulutus ACE02'
    commandLineArguments: 'env="ACE02"'
    commandLineSetting: 'Require'
  }
  {
    name: 'Kotikoulutusace03'
    friendlyName: 'Kotikoulutus ACE03'
    appGroupName: 'Kotikoulutusace03'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconPath: 'C:\\Sovellukset\\Hyperspace\\Apotti_ACE.ico'
    iconIndex: 0
    description: 'Kotikoulutus ACE03'
    commandLineArguments: 'env="ACE03"'
    commandLineSetting: 'Require'
  }
  {
    name: 'Kotikoulutusace04'
    friendlyName: 'Kotikoulutus ACE04'
    appGroupName: 'Kotikoulutusace04'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconPath: 'C:\\Sovellukset\\Hyperspace\\Apotti_ACE.ico'
    iconIndex: 0
    description: 'Kotikoulutus ACE04'
    commandLineArguments: 'env="ACE04"'
    commandLineSetting: 'Require'
  }
  {
    name: 'Kotikoulutusace05'
    friendlyName: 'Kotikoulutus ACE05'
    appGroupName: 'Kotikoulutusace05'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconPath: 'C:\\Sovellukset\\Hyperspace\\Apotti_ACE.ico'
    iconIndex: 0
    description: 'Kotikoulutus ACE05'
    commandLineArguments: 'env="ACE05"'
    commandLineSetting: 'Require'
  }
  {
    name: 'Hyperdriveeko01'
    friendlyName: 'Hyperdrive EKO01'
    appGroupName: 'Hyperdriveeko01'
    filePath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconPath: 'C:\\Program Files (x86)\\Epic\\Hyperdrive\\VersionIndependent\\Hyperspace.exe'
    iconIndex: 0
    description: 'Hyperdrive EKO01'
    commandLineArguments: 'env="EKO01"'
    commandLineSetting: 'Require'
  }
  {
    name: 'Puttyeko'
    friendlyName: 'PuTTY EKO'
    appGroupName: 'Puttyeko'
    filePath: 'C:\\Sovellukset\\Putty\\PuttyEKO.cmd'
    iconPath: 'C:\\Program Files (x86)\\PuTTY\\putty.exe'
    iconIndex: 0
    description: 'PuTTY EKO'
    commandLineSetting: 'DoNotAllow'
    commandLineArguments: null
  }
]
param applicationGroupAssignments = [
  {
    appGroupName: 'putty'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '598ace24-22f6-41a5-9fcd-b1fe50b8e693'
    principalType: 'Group'
  }
  {
    appGroupName: 'Edge'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'ecd23b42-b249-48b0-92ec-02dcccc99f68'
    principalType: 'Group'
  }
  {
    appGroupName: 'hyperspace'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '38a3739b-1e6e-4960-a03c-0b583862e43d'
    principalType: 'Group'
  }
  {
    appGroupName: 'epicstudio'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '5cc453e7-ed8d-4bf4-8f12-28e09549d507'
    principalType: 'Group'
  }
  {
    appGroupName: 'Filezilla'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '11321a82-c527-45bf-9148-afc210d9a502'
    principalType: 'Group'
  }
  {
    appGroupName: 'hyperdrive'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '2e7f4c42-619b-47f9-a73c-6297039621aa'
    principalType: 'Group'
  }
  {
    appGroupName: 'Apotti-jarjestelma'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '4c6bfa76-53b8-42eb-b1ab-5d0e72c9e177'
    principalType: 'Group'
  }
  {
    appGroupName: 'Lukutilainen-Apotin-varajarjestelma'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '43f199a7-61af-4e99-906d-28643091e0be'
    principalType: 'Group'
  }
  {
    appGroupName: 'Apotti-opas'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '536cfa6d-886f-4c50-9c7d-8ba2b2804ecf'
    principalType: 'Group'
  }
  {
    appGroupName: 'Apotti-tukiportaali'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'efbb83bc-49ea-498f-a7e7-4d59339a03a9'
    principalType: 'Group'
  }

  {
    appGroupName: 'PuTTY-SUP'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    //Same as putty bld - need to fix later
    principalId: '0797e083-bce5-497d-8a12-dbc6b44a3f6b'
    principalType: 'Group'
  }
  {
    appGroupName: 'PuTTY-BLD'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '0797e083-bce5-497d-8a12-dbc6b44a3f6b'
    principalType: 'Group'
  }
  {
    appGroupName: 'PuTTY-KTST'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'd69782df-020f-426a-8ba7-df420960a652'
    principalType: 'Group'
  }
  {
    appGroupName: 'PuTTY-PRD'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '5fd709f8-60d3-4dfd-9f53-8eacd0503641'
    principalType: 'Group'
  }
  {
    appGroupName: 'PuTTY-RELBLD'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'df447ae3-0239-49a8-923e-243d96f976fe'
    principalType: 'Group'
  }
  {
    appGroupName: 'PuTTY-REL-CONV'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '4465bc32-79fe-4abb-ae08-828347e60354'
    principalType: 'Group'
  }
  {
    appGroupName: 'PuTTY-SRO'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'c0cba605-0791-4896-b068-4f26a8abc793'
    principalType: 'Group'
  }
  {
    appGroupName: 'PuTTY-Training'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'd1a2e164-269f-4fe1-b1e7-c4bf4aeed979'
    principalType: 'Group'
  }
  {
    appGroupName: 'Apotti-harjoitteluymparisto1'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '7c66d07f-72ec-4fa3-90ae-5a134828a814' 
    principalType: 'Group'
  }
  {
    appGroupName: 'Apotti-harjoitteluymparisto2'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'bdae9661-886a-40e8-9acc-94ef04150365' 
    principalType: 'Group'
  }
  {
    appGroupName: 'Apotti-harjoitteluymparisto3'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'fb042793-90b9-4bcf-8d66-5500f2413e95' 
    principalType: 'Group'
  }
  {
    appGroupName: 'Apotti-harjoitteluymparisto4'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '72ea96de-672c-441f-a524-796b153d5228' 
    principalType: 'Group'
  }
  {
    appGroupName: 'Kotikoulutusace02'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'bfe01c2d-47db-4e6b-b6ab-cf1d7077ef9d' 
    principalType: 'Group'
  }
  {
    appGroupName: 'Kotikoulutusace03'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '0c494484-ccc5-461a-86b5-01f0660e1cce' 
    principalType: 'Group'
  }
  {
    appGroupName: 'Kotikoulutusace04'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'ce4d6406-9815-4d1e-917b-dbfefa5ebaf0' 
    principalType: 'Group'
  }
  {
    appGroupName: 'Kotikoulutusace05'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'c5f82101-ccd1-4922-be15-11fdff4cfef5' 
    principalType: 'Group'
  }
  {
    appGroupName: 'Hyperdriveeko01'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: '7c13508c-f066-4544-8fcf-5b399803d4e2' 
    principalType: 'Group'
  }
  {
    appGroupName: 'Puttyeko'
    roleDefinitionIdOrName: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
    principalId: 'c1b5540f-0868-4a70-b1e6-eb63dad2626c' 
    principalType: 'Group'
  }
]
