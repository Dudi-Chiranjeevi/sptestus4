# param (
#     [string]$SourceUser,
#     [string]$SourceHost,
#     [string]$DestinationUser, 
#     [string]$DestinationHost, 
#     [string]$CsvFilePath,
#     [string]$TargetPath
# )

# # Log into source VM and list currently logged-in users
# $logUsersCommand = "ssh -o StrictHostKeyChecking=no $SourceUser@$SourceHost who"
# Write-Host "Logging into source VM to list current users..."
# Invoke-Expression $logUsersCommand

# # Compose the SCP command
# $scpCommand = "scp -o StrictHostKeyChecking=no $CsvFilePath ${DestinationUser}@${DestinationHost}:$TargetPath"

# # Escape the inner command for SSH
# $escapedScpCommand = $scpCommand.Replace('"', '\"')
# $sshCommand = "ssh -o StrictHostKeyChecking=no ${SourceUser}@${SourceHost} `"$escapedScpCommand`""

# Write-Host "Executing remote SCP via SSH..."
# Invoke-Expression $sshCommand


param (
    [string]$SourceUser,
    [string]$SourceHost,
    [string]$DestinationUser,
    [string]$DestinationHost,
    [string]$CsvFilePath,
    [string]$TargetPath
)

# Log into source VM and list currently logged-in users
Write-Host "Logging into source VM ($SourceUser@$SourceHost) to list current users..."
try {
    # Run 'who' on source host via ssh and capture output
    $logUsersCommand = "who"
    $loggedUsers = ssh -o StrictHostKeyChecking=no "$SourceUser@$SourceHost" $logUsersCommand
    Write-Host "Current logged-in users on source VM:"
    Write-Host $loggedUsers
} catch {
    Write-Error "Failed to log users on source VM: $_"
    exit 1
}

# Compose the SCP command to run remotely on source VM
$scpCommand = "scp -o StrictHostKeyChecking=no `"$CsvFilePath`" ${DestinationUser}@${DestinationHost}:`"$TargetPath`""

Write-Host "Executing remote SCP on source VM..."
try {
    # Execute SCP command on source VM
    ssh -o StrictHostKeyChecking=no "$SourceUser@$SourceHost" $scpCommand
    Write-Host "SCP transfer completed successfully."
} catch {
    Write-Error "Failed SCP transfer: $_"
    exit 1
}
