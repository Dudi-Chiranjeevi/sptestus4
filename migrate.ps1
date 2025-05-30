param (Add commentMore actions
    [string]$SourceUser = "sjinuka",
    [string]$SourceHost = "10.128.0.29",
    [string]$DestinationUser = "sjinuka", 
    [string]$DestinationHost = "10.128.0.28", 
    [string]$CsvFilePath = "/home/sjinuka/Sample_data1.csv",
    [string]$TargetPath = "/home/sjinuka/"
)
 
# Compose SSH command to run SCP from source to destination
$scpCommand = "scp -o StrictHostKeyChecking=no $CsvFilePath ${DestinationUser}@${DestinationHost}:$TargetPath"
$sshCommand = "ssh ${SourceUser}@${SourceHost} '$scpCommand'"
 
# Execute from Jenkins
Write-Host "Executing remote SCP via SSH..."
Invoke-Expression $sshCommand