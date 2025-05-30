param (

    [string]$SourceUser,

    [string]$SourceHost,

    [string]$DestinationUser,

    [string]$DestinationHosts,

    [string]$CsvFilePath,

    [string]$TargetPath

)
 
$ErrorActionPreference = "Stop"

$hosts = $DestinationHosts -split ','
 
foreach ($hostIp in $hosts) {

    try {

        Write-Host "➡️  Starting transfer from $SourceHost to $hostIp..."

        $scpCommand = "scp -o StrictHostKeyChecking=no $CsvFilePath ${DestinationUser}@${hostIp}:$TargetPath"

        $sshCommand = "ssh -o StrictHostKeyChecking=no ${SourceUser}@${SourceHost} `"$scpCommand`""
 
        Write-Host "Executing: $sshCommand"

        Invoke-Expression $sshCommand
 
        Write-Host "✅ Transfer to $hostIp completed."

    } catch {

        Write-Host "❌ Exception occurred while transferring to ${hostIp}: $_"

    }

}

 
destinationIps.each { target ->

    parallelSteps["Transfer to ${target}"] = {

        sh """

            echo ===== Transfer Start to ${target} =====

            pwsh -File ./migrate.ps1 `

                -SourceUser '${SOURCE_USER}' `

                -SourceHost '${SOURCE_HOST}' `

                -DestinationUser '${DESTINATION_USER}' `

                -DestinationHosts '${target}' `

                -CsvFilePath '${CSV_FILE_PATH}' `

                -TargetPath '${TARGET_PATH}'

        """

    }

}

 