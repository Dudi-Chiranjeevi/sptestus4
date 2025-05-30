param (
    [string]$SourceUser,
    [string]$SourceHost,
    [string]$DestinationUser, 
    [string]$DestinationHost, 
    [string]$CsvFilePath,
    [string]$TargetPath
)

# Log into source VM and list currently logged-in users
$logUsersCommand = "ssh -o StrictHostKeyChecking=no $SourceUser@$SourceHost who"
Write-Host "Logging into source VM to list current users..."
Invoke-Expression $logUsersCommand

# Compose the SCP command
$scpCommand = "scp -o StrictHostKeyChecking=no $CsvFilePath ${DestinationUser}@${DestinationHost}:$TargetPath"

# Escape the inner command for SSH
$escapedScpCommand = $scpCommand.Replace('"', '\"')
$sshCommand = "ssh -o StrictHostKeyChecking=no ${SourceUser}@${SourceHost} `"$escapedScpCommand`""

Write-Host "Executing remote SCP via SSH..."
Invoke-Expression $sshCommand


