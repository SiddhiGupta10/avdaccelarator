# This script updates Hyperspace software.

Write-Host "-------------------------------"
Write-Host "HyperSpace Update"
Write-Host "-------------------------------"

# Variables
$softwareFolder = "C:\AIB\software"
$hyperspaceDir = Join-Path $softwareFolder "\Hyperspace\November 2024"
$updateDir = "$hyperspaceDir\CP_007_RA-2268 Epic Nov2024 CP-7 16.05.2025"
$updateExe = "$updateDir\InstallMSP.exe"
$updateMSP = "$updateDir\Epic_November_2024_Hyperspace_RA-2268_Epic_Nov2024_CP-7_16052025.msp"
$updateLog = "C:\management\temp\HS_Update.log"
$vbsScript = "$updateDir\InstallMSP.vbs"

try{ 
    Write-Host "[INFO] Applying HyperSpace cumulative update..."
    $HSUprocess = Start-Process -FilePath "cscript.exe" -ArgumentList "`"$vbsScript`" `"$updateExe`" /ICP `"$updateMSP`" /lec+ `"$updateLog`" /qb /s" -WorkingDirectory $updateDir -Wait -NoNewWindow -PassThru
    $HSUexitCode = $HSUprocess.ExitCode
    Write-Host "Update exit code: $HSUexitCode"
    
}
catch {
    Write-Host $_.Exception
    throw
}
