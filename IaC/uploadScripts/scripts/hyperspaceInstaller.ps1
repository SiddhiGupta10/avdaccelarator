# This script installs Hyperspace software.

# Variables
$softwareFolder = "C:\AIB\software"

# Validating whether software folder exists
if (-not (Test-Path $softwareFolder)) {
    Write-Host "Software folder not found"
    exit 1
}

# -------------------------
# HyperDrive Installation
# -------------------------
Write-Host "-------------------------------"
Write-Host "HyperDrive Installation"
Write-Host "-------------------------------"

$hyperdriveDir = Join-Path $softwareFolder "\Hyperdrive\Epic Hyperdrive Setup 100.2508.1"
$hyperdriveCmd = "Install_Hyperdrive_AVD_Apotti_BLD_PRD.cmd"
$HDprocess = Start-Process -FilePath "$env:ComSpec" -ArgumentList "/c `"$hyperdriveDir\$hyperdriveCmd`"" -WorkingDirectory $hyperdriveDir  -Wait -PassThru
$HDexitCode = $HDprocess.ExitCode
Write-Host "HD Install exit code: $HDexitCode"

# Get installed version
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Hyperdrive"
$version = (Get-ItemProperty -Path $regPath -Name DisplayVersion -ErrorAction SilentlyContinue).DisplayVersion

if (-not $version) {
    Write-Error "[ERROR] HyperDrive version not found."
    exit 1
}

# Run EnsureCertificates.exe
$certGenPath = "C:\Program Files (x86)\Epic\Hyperdrive\$version\Bin\Core\win-x86\EnsureCertificates.exe"
$hostname = $env:COMPUTERNAME
$tempFile = "C:\management\temp\$hostname@APOTTI.FI.epk"
$newCertFile = "C:\management\temp\$($hostname.ToLower())@APOTTI.FI.epk"

if (Test-Path $certGenPath) {
    Write-Host "[INFO] Generating certificate..."
    & $certGenPath > $tempFile
    Rename-Item -Path $tempFile -NewName (Split-Path $newCertFile -Leaf) -Force
    Write-Host "[SUCCESS] Certificate saved as $newCertFile"
}
else {
    Write-Error "[ERROR] EnsureCertificates.exe not found."
    exit 1
}

# -------------------------
# HyperSpace Installation
# -------------------------
Write-Host "-------------------------------"
Write-Host "HyperSpace Installation"
Write-Host "-------------------------------"
 
$hyperspaceDir = Join-Path $softwareFolder "\Hyperspace\November 2024"
$baseInstaller = "$hyperspaceDir\AI_Epic_Nov24\Epic November 2024 Hyperspace.msi"
$baseLog   = "C:\management\temp\HS_Install.log"

try {
    Write-Host "[INFO] Installing HyperSpace base..."
    $HSIprocess = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$baseInstaller`" /qn /norestart /log `"$baseLog`"" -Wait -NoNewWindow -PassThru
	$HSIexitCode = $HSIprocess.ExitCode
    Write-Host "Install exit code: $HSIexitCode"

    # ARIEL DEBUG: Show hyperspace base install log if not Success (0)
    if ($HSIexitCode -ne 0) {
        Write-Host "[DEBUG] --- HyperSpace Base Install Log Start ------------------------"
        Get-Content -Path $baseLog -Tail 100 | ForEach-Object { Write-Host $_ }
        Write-Host "[DEBUG] --- HyperSpace Base Install Log End --------------------------"
    } else {
        Write-Host "[WARN] Log file not found at $baseLog"
    }
}
catch {
    Write-Host $_.Exception
    throw
}
