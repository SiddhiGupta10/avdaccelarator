# This script installs the DigiSign Client and configures the necessary components.

Write-Host "-------------------------------"
Write-Host "DigiSign Client Installation"
Write-Host "-------------------------------"

$softwareFolder   = "C:\AIB\software"
$digiSignFolder   = Join-Path $softwareFolder "DigiSignClient"
$installer        = Join-Path $digiSignFolder "DigiSignClient_for_dvv_4.3.4(8933).exe"
$installLog       = "C:\management\temp\digisigninstall.log"
$digiSignProgPath = "C:\Program Files\Fujitsu\mPollux DigiSign Client"
$infFile          = Join-Path $digiSignProgPath "dsminidrv.inf"

try {
    # Ensure DigiSign subdirectory exists
    if (!(Test-Path $digiSignFolder)) {
        throw "DigiSign folder not found: $digiSignFolder"
    }

    # Ensure installer exists
    if (!(Test-Path $installer)) {
        throw "Installer not found: $installer"
    }

    # Ensure temp folder exists
    if (!(Test-Path (Split-Path $installLog))) {
        New-Item -Path (Split-Path $installLog) -ItemType Directory -Force | Out-Null
    }

    Write-Host "Starting DigiSign Client installation..."

    # 1. Run DigiSign installer silently with log
    Start-Process -FilePath $installer `
                  -ArgumentList "/VERYSILENT /NORESTART /LOG=$installLog" `
                  -Wait -NoNewWindow

    Write-Host "Installer executed. Log: $installLog"

    # 2. Install driver from INF file
    if (!(Test-Path $infFile)) {
        throw "INF file not found: $infFile"
    }

Start-Process -FilePath "RUNDLL32.EXE" `
    -ArgumentList "SETUPAPI.DLL,InstallHinfSection DSMinidrv64_Install.NT 128 $infFile" `
    -Wait -NoNewWindow


    Write-Host "Driver installed from $infFile"

    # 3. Registry configuration
    $regPath = "HKLM:\SOFTWARE\Fujitsu\DigiSign Client"
    if (!(Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    Set-ItemProperty -Path $regPath -Name "scsSignerEnabled" -Value 0 -Force
    Set-ItemProperty -Path $regPath -Name "SmartCardSNCache" -Value 3 -Force
    Set-ItemProperty -Path $regPath -Name "excludeReader" -Value "*Windows Hello*||*YubiKey*||*UICC*" -Force

    Write-Host "Registry keys applied under $regPath"

    # 4. Configure Smart Card service to start automatically
    Start-Process -FilePath "sc.exe" -ArgumentList "config SCardSvr start=auto" -Wait -NoNewWindow

    # 5. Start required services
    $services = @("CertPropSvc", "SCardSvr")
    foreach ($svc in $services) {
        try {
            Start-Service -Name $svc -ErrorAction Stop
            Write-Host "Service $svc started successfully."
        }
        catch {
            Write-Warning "Could not start service $svc $($_.Exception.Message)"
        }
    }

    Write-Host "DigiSign Client installation completed successfully."
}
catch {
    Write-Host "Installation failed: $($_.Exception.Message)"
    throw
}
