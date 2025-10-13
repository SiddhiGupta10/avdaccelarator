# This script decodes a Base64 encoded XML file and saves it to a specified location.
# File is C:\Program Files (x86)\Epic\Foundations\EpicComm.env
Write-Host "-------------------------------"
Write-Host "Decrypt file EpicComm.env and move it to C:\Program Files (x86)\Epic\Foundations\EpicComm.env"
Write-Host "-------------------------------"

try{
    # Path to the file containing Base64 content
    $base64FilePath = "C:\AIB\software\LastConfigurations\EpicComm.env\EpicCommenv.txt"

    # Read the Base64 string from the file
    $base64String = Get-Content -Path $base64FilePath -Raw

    # Decode the Base64 string into bytes
    $decodedBytes = [System.Convert]::FromBase64String($base64String)

    # Save the decoded bytes to a new file
    $decodedFilePath = "C:\Program Files (x86)\Epic\Foundations\EpicComm.env"
    [System.IO.File]::WriteAllBytes($decodedFilePath, $decodedBytes)

    Write-Host "Decoded file saved to $decodedFilePath"

    Write-Host "File updated successfully."
} 
catch {
    Write-Host $_.Exception
    throw
}
