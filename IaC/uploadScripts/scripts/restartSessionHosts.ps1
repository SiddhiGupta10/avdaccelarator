
# This script restarts and drains session hosts which are associated of specified host pool, as per schedulers.

param(
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $true)]
    [string]$TenantId,

    [Parameter(Mandatory = $true)]
    [string]$ClientId,

    [Parameter(Mandatory = $true)]
    [string]$HostPoolResourceGroup,

    [Parameter(Mandatory = $true)]
    [string]$SessionHostResourceGroup,

    [Parameter(Mandatory = $true)]
    [string]$HostPoolName,

    [Parameter(Mandatory = $true)]
    [ValidateSet("Phase1-Drain","Phase1-Reboot","Phase2-Drain","Phase2-Reboot","Reboot-Alert","Phase-Shutdown","Phase-Start")]
    [string]$Action = "Phase1-Drain",

    [Parameter(Mandatory = $false)]
    [ValidateSet("Phase1","Phase2","All","")]
    [string]$PhaseName,

    [Parameter(Mandatory = $false)]
    [string]$Message
)

# Import Modules
Import-Module -Name 'Az.Accounts','Az.Compute','Az.DesktopVirtualization'
Write-Output "Imported the required modules."

# Connect to Azure using the Managed Identity
Connect-AzAccount -Subscription $SubscriptionId -Tenant $TenantId -Identity -AccountId $ClientId | Out-Null
Write-Output "Connected to Azure."

# Get all session hosts in the host pool
$sessionHosts = Get-AzWvdSessionHost -ResourceGroupName $HostPoolResourceGroup -HostPoolName $HostPoolName

# Split into two halves
$half = [math]::Ceiling($sessionHosts.Count / 2)
$phase1Hosts = $sessionHosts | Select-Object -First $half
$phase2Hosts = $sessionHosts | Select-Object -Skip $half

switch ($Action) {
    "Phase1-Drain" {
        foreach ($hostvm in $phase1Hosts) {
            Write-Output "Phase1-Drain: Putting $($hostvm.Name) in drain mode..."
            $vmName = ($hostvm.Name -split "/")[-1]
            Update-AzWvdSessionHost -ResourceGroupName $HostPoolResourceGroup -HostPoolName $HostPoolName -Name $vmName -AllowNewSession:$false
        }
    }
    "Phase1-Reboot" {
        foreach ($hostvm in $phase1Hosts) {
            $vmName = ($hostvm.Name -split "/")[-1]
            Write-Output "Phase1-Reboot: Restarting VM $vmName..."
            Restart-AzVM -ResourceGroupName $SessionHostResourceGroup -Name $vmName -NoWait
            Write-Output "Re-enabling sessions for $($hostvm.Name)..."
            Update-AzWvdSessionHost -ResourceGroupName $HostPoolResourceGroup -HostPoolName $HostPoolName -Name $vmName -AllowNewSession:$true
        }
    }
    "Phase2-Drain" {
        foreach ($hostvm in $phase2Hosts) {
            Write-Output "Phase2-Drain: Putting $($hostvm.Name) in drain mode..."
            $vmName = ($hostvm.Name -split "/")[-1]
            Update-AzWvdSessionHost -ResourceGroupName $HostPoolResourceGroup -HostPoolName $HostPoolName -Name $vmName -AllowNewSession:$false
        }
    }
    "Phase2-Reboot" {
        foreach ($hostvm in $phase2Hosts) {
            $vmName = ($hostvm.Name -split "/")[-1]
            Write-Output "Phase2-Reboot: Restarting VM $vmName..."
            Restart-AzVM -ResourceGroupName $SessionHostResourceGroup -Name $vmName -NoWait
            Write-Output "Re-enabling sessions for $($hostvm.Name)..."
            Update-AzWvdSessionHost -ResourceGroupName $HostPoolResourceGroup -HostPoolName $HostPoolName -Name $vmName -AllowNewSession:$true
        }
    }
    "Reboot-Alert" {
        $rebootPhase = if ($PhaseName -eq "Phase1") { $phase1Hosts } elseif ($PhaseName -eq "Phase2") { $phase2Hosts } else { $sessionHosts }
        $rebootHosts = $rebootPhase | ConvertFrom-Json
        Write-Output "Sending reboot alert to hosts in phase: $PhaseName"
        foreach ($hosts in $rebootHosts) {
            $vmName = ($hosts.name -split "/")[-1]
            # Get active user sessions on the host
            $sessions = Get-AzWvdUserSession -ResourceGroupName $HostPoolResourceGroup -HostPoolName $HostPoolName -SessionHostName $vmName
            foreach ($session in $sessions) {
                # Extract numeric session ID (last path segment)
                $sessionId = [int]($session.Id -split "/")[-1]
                Write-Host "Host: $vmName  |  Session ID: $sessionId"

                # Send warning message
                Send-AzWvdUserSessionMessage `
                    -ResourceGroupName $HostPoolResourceGroup `
                    -HostPoolName $HostPoolName `
                    -SessionHostName $vmName `
                    -UserSessionId $sessionId `
                    -MessageTitle "⚠️ Reboot Warning" `
                    -MessageBody $Message
            }
        }
    }
    "Phase-Shutdown" {
        foreach ($hosts in $sessionHosts) {
            $vmName = ($hosts.Name -split "/")[-1]
            Write-Output "Shutting down VM $vmName..."
            Stop-AzVM -ResourceGroupName $SessionHostResourceGroup -Name $vmName -NoWait -Force
        }
    }
    "Phase-Start" {
        foreach ($hosts in $sessionHosts) {
            $vmName = ($hosts.Name -split "/")[-1]
            Write-Output "Starting VM $vmName..."
            Start-AzVM -ResourceGroupName $SessionHostResourceGroup -Name $vmName -NoWait
        }
    }
}
