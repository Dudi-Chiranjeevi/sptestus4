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
    Write-Host "Executing SCP from $SourceHost to $destination"
 
    $scpCommand = "scp -o StrictHostKeyChecking=no $CsvFilePath $destination"
    $escapedScpCommand = $scpCommand.Replace('"', '\"')
 
    $sshCommand = "ssh -o StrictHostKeyChecking=no ${SourceUser}@${SourceHost} `"$escapedScpCommand`""
    try {
        Invoke-Expression $sshCommand
        if ($LASTEXITCODE -ne 0) {
            Write-Host "❌ Transfer to $hostIp failed."
            exit 1
        } else {
            Write-Host "✅ Transfer to $hostIp successful."
        }
    } catch {
        Write-Host "❌ Exception occurred while transferring to $hostIp: $_"
        exit 1
    }
}