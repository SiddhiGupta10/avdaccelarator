# This script installs Epic Studio.

Write-Host "-------------------------------"
Write-Host "Epic Studio Installation"
Write-Host "-------------------------------"

$softwareFolder = "C:\AIB\software"
$studioBasePath = Join-Path $softwareFolder "\EpicStudio"
$studioMSI = "Epic November 2024 EpicStudio.msi"
$studioUpdatePath = Join-Path $studioBasePath 'CP_005_RA-2237 Epic Nov2024 CP-5 21.03.2025'
$studioUpdateExe = "InstallMSP.exe"
$studioMSP = "Epic_November_2024_EpicStudio_RA-2237_Epic_Nov2024_CP-5_21032025.msp"
$studioSettings = Join-Path $studioBasePath "Settings_ALL"
$studioInstallDir = Join-Path $softwareFolder "\EpicStudio"
$studioLog = "C:\management\temp\EpicStudio_install.log"

try{ 
    Write-Host "[INFO] Installing Epic Studio base package..."
    $ESprocess = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$studioBasePath\$studioMSI`" /qn /norestart /log `"$studioLog`"" -Wait -NoNewWindow -PassThru
    $ESexitCode = $ESprocess.ExitCode
    Write-Host "ES Install exit code: $ESexitCode"

    Write-Host "[INFO] Applying Epic Studio cumulative update..."
    $ESCUprocess = Start-Process -FilePath "$studioUpdatePath\$studioUpdateExe" -ArgumentList "/ICP `"$studioUpdatePath\$studioMSP`" /lec+ `"$studioLog`" /qn /s" -WorkingDirectory $studioUpdatePath -Wait -NoNewWindow -PassThru
    $ESCUexitCode = $ESCUprocess.ExitCode
    Write-Host "ES Update exit code: $ESCUexitCode"

    Write-Host "[INFO] Copying Epic Studio settings..."
    Copy-Item -Path "$studioSettings\*" -Destination $studioInstallDir -Recurse -Force
}
catch {
    Write-Host $_.Exception
    throw
}


