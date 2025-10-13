# This script applies a task in Task Scheduler to run a PowerShell script at system startup.

Write-Host "-------------------------------"
Write-Host "Task Scheduled for Epic Configuration Script"
Write-Host "-------------------------------"

try {
    # === Variables ===
    $TaskName   = "Startup_Repair-HyperdriveRegistration_script"
    $ScriptOriginPath = "C:\AIB\software\LastConfigurations\StartupConfigScript\Repair-HyperdriveRegistration.ps1"
    $ScriptPath = "C:\management\epicRepairTaskScheduled\Repair-HyperdriveRegistration.ps1"

    # Check if origin script exists
    if (-not (Test-Path $ScriptOriginPath)) {
        Write-Error "Script file not found at: $ScriptPath"
        exit 1
    }

    # Ensure destination directory exists
    $destDir = Split-Path -Path $ScriptPath -Parent
    if (!(Test-Path $destDir)) {
        New-Item -Path $destDir -ItemType Directory -Force | Out-Null
    }

    # Copy the script
    Copy-Item -Path $ScriptOriginPath -Destination $ScriptPath -Force

    Write-Host "Script copied to $ScriptPath successfully."

    # === Define action, trigger, and principal ===
    $action    = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$ScriptPath`""
    $trigger   = New-ScheduledTaskTrigger -AtStartup
    $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

    # === Register scheduled task ===
    Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Principal $principal -Force

    Write-Host "Scheduled task '$TaskName' created successfully to run at system startup."
}
catch {
    Write-Error "Error creating scheduled task: $($_.Exception.Message)"
    throw
}
