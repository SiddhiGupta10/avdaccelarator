# This scripts installs FileZilla

Write-Host "-------------------------------"
Write-Host "FileZilla Installation"
Write-Host "-------------------------------"

$softwareFolder = "C:\AIB\software"
$filezillaInstaller = Join-Path $softwareFolder "FileZilla\FileZilla_3.69.1_win64-setup.exe"

try {
    Write-Host "[INFO] Installing FileZilla..."
    Start-Process -FilePath $filezillaInstaller -ArgumentList "/S" -Wait -NoNewWindow 
    Write-Host "[SUCCESS] FileZilla installed."
}
catch {
    Write-Host $_.Exception
    throw
}