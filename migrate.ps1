param (Add commentMore actions
    [string]$SourceUser,
    [string]$SourceHost,
    [string]$DestinationUser, 
    [string]$DestinationHost, 
    [string]$CsvFilePath,
    [string]$TargetPath
)
 
# Compose SSH command to run SCP from source to destination
$scpCommand = "scp -o StrictHostKeyChecking=no $CsvFilePath ${DestinationUser}@${DestinationHost}:$TargetPath"
$sshCommand = "ssh ${SourceUser}@${SourceHost} '$scpCommand'"
 
# Execute from Jenkins
Write-Host "Executing remote SCP via SSH..."
Invoke-Expression $sshCommand