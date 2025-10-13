# Install Microsoft Graph if not already installed
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph)) {
    Install-Module Microsoft.Graph -Scope CurrentUser -Force
}
Import-Module Microsoft.Graph.groups
Install-Module Microsoft.Graph.Authentication

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Group.ReadWrite.All"

# Input CSV path
$csvPath = "./avd-groups.csv"
$logPath = "./import-log.csv"

# Initialize log
"DisplayName,Status,Message" | Out-File -FilePath $logPath -Encoding UTF8

# Read CSV
$groups = Import-Csv -Path $csvPath

foreach ($group in $groups) {
    try {
        # Create group
        $createdGroup = New-MgGroup -DisplayName $group.DisplayName `
                                    -GroupTypes @($group.GroupTypes)

        Write-Host "Created group: $($group.DisplayName)" -ForegroundColor Green
        "$($group.DisplayName),Success,Group created" | Out-File -FilePath $logPath -Append -Encoding UTF8

        # Add owners if specified
        if ($group.Owners) {
            $ownerList = $group.Owners -split ";"
            foreach ($ownerUPN in $ownerList) {
                $owner = Get-MgUser -UserPrincipalName $ownerUPN.Trim()
                if ($owner) {
                    Add-MgGroupOwnerByRef -GroupId $createdGroup.Id -RefUri "https://graph.microsoft.com/v1.0/directoryObjects/$($owner.Id)"
                    Write-Host "Added owner: $ownerUPN" -ForegroundColor Cyan
                }
            }
        }

    } catch {
        Write-Host "Failed to create group: $($group.DisplayName). Error: $_" -ForegroundColor Red
        "$($group.DisplayName),Failed,$($_.Exception.Message)" | Out-File -FilePath $logPath -Append -Encoding UTF8
    }
}
