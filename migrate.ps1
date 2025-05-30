param (
    [string]$SourceUser,
    [string]$SourceHost,
    [string]$DestinationUser,
    [string]$DestinationHosts,
    [string]$CsvFilePath,
    [string]$TargetPath
)
 
$hosts = $DestinationHosts -split ','
 
foreach ($hostIp in $hosts) {
    $destination = "$DestinationUser@${hostIp}:${TargetPath}"
    $scpCommand = "scp -o StrictHostKeyChecking=no $CsvFilePath $destination"
    $escapedScpCommand = $scpCommand.Replace('"', '\"')
    $sshCommand = "ssh -o StrictHostKeyChecking=no ${SourceUser}@${SourceHost} `"$escapedScpCommand`""
 
    Write-Host "Executing SCP from $SourceHost to $hostIp..."
    Invoke-Expression $sshCommand
 
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Transfer to $hostIp failed."
        exit 1
    }
}
 
Write-Host "✅ All transfers completed successfully."