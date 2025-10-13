# This script imports certificates.

Write-Host "-------------------------------"
Write-Host "Import Certificates"
Write-Host "-------------------------------"

# ================================
# CONFIGURATION
# ================================

try {
    # Automatically get the folder where this script is running
    $certFolderPath = "C:\AIB\software\LastConfigurations\ImportCertificates\"

    # List of certificates and their target stores
    $certs = @(
        @{ Name = "ApottiDCRoot.cer";               Store = "Cert:\LocalMachine\Root" },
        @{ Name = "ApottiDCIssuingCA.cer";          Store = "Cert:\LocalMachine\CA" },
        @{ Name = "ApottiDCIssuingCAG2.cer";        Store = "Cert:\LocalMachine\CA" },
        @{ Name = "Apotti_CMP_Root-Issuing_CA.cer"; Store = "Cert:\LocalMachine\Root" }
    )
} catch{
    Write-Error "Failed configuration '$certName': $_"
    throw
}

# ================================
# MAIN SCRIPT
# ================================

foreach ($cert in $certs) {
    $certName = $cert.Name
    $certStore = $cert.Store
    $certPath = Join-Path -Path $certFolderPath -ChildPath $certName

    try {
        if (-Not (Test-Path -Path $certPath)) {
            throw "Certificate file not found: $certPath"
        }

        Write-Host "`nImporting '$certName' from '$certPath' into '$certStore'..."
        Import-Certificate -FilePath $certPath -CertStoreLocation $certStore | Out-Null
        Write-Host "Successfully imported '$certName' into $certStore"
    }
    catch {
        Write-Error "Failed to process '$certName': $_"
        exit 1
    }
}
