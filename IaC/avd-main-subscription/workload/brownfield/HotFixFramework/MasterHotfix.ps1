param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ManifestUri
)

$tempPath     = "C:\management\hotfixes"
$registryBase = "HKLM:\Software\Apotti"

# Ensure working folder
if (-not (Test-Path $tempPath)) { New-Item -Path $tempPath -ItemType Directory -Force | Out-Null }

# Fetch + parse manifest (automatic JSON conversion)
try {
    $hotfixes = Invoke-RestMethod -Uri $manifestUri -Method GET -ErrorAction Stop
} catch {
    throw "Failed to download or parse manifest from $manifestUri : $($_.Exception.Message)"
}

foreach ($hf in $hotfixes) {
    if (-not $hf.Id -or -not $hf.Uri -or -not $hf.Checksum) {
        Write-Warning "Skipping malformed entry: $( $hf | Out-String )"
        continue
    }

    $regKey = Join-Path $registryBase $hf.Id

    if (Test-Path $regKey) {
        Write-Output "$($hf.Id) already applied. Skipping."
        continue
    }

    $localScript = Join-Path $tempPath "$($hf.Id).ps1"
    Write-Verbose "Downloading $($hf.Id) from $($hf.Uri) to $localScript"
    try {
        Invoke-WebRequest -Uri $hf.Uri -OutFile $localScript -ErrorAction Stop
    } catch {
        Write-Error "Failed downloading $($hf.Id): $($_.Exception.Message)"
        continue
    }

    # Checksum validation
    try {
        $actual = Get-FileHash $localScript -Algorithm SHA256
    } catch {
        Write-Error "Cannot hash ${localScript}: $($_.Exception.Message)"
        continue
    }

    if ($actual.Hash -ne $hf.Checksum) {
        Write-Error "Checksum mismatch for $($hf.Id). Expected $($hf.Checksum) got $($actual.Hash). Deleting script."
        Remove-Item -Path $localScript -ErrorAction SilentlyContinue
        continue
    }

    try {
        & $localScript
        $exit = $LASTEXITCODE
    } catch {
        Write-Error "Execution error in $($hf.Id): $($_.Exception.Message)"
        continue
    }

    if ($exit -ne 0) {
        Write-Error "$($hf.Id) script returned exit code $exit"
        continue
    }

    # Mark applied
    New-Item -Path $registryBase -Name $hf.Id -Force | Out-Null
    Set-ItemProperty -Path $regKey -Name "Applied" -Value 1 -Force
    Set-ItemProperty -Path $regKey -Name "Checksum" -Value $hf.Checksum -Force
    Set-ItemProperty -Path $regKey -Name "AppliedTimestampUtc" -Value ([DateTime]::UtcNow.ToString("o")) -Force

    Write-Output "$($hf.Id) applied successfully."
}