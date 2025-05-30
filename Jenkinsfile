// pipeline {
//     agent any

//     environment {
//         GIT_REPO    = 'https://github.com/Dudi-Chiranjeevi/sptestus4.git'
//         BRANCH      = 'main'

//         SOURCE_USER = 'cdudi'
//         SOURCE_HOST = '10.128.0.29'

//         DEST_USER   = 'cdudi'
//         DEST_HOST   = '10.128.0.28'
//         DEST_PATH   = '/home/cdudi/'

//         FILE_NAME   = '/home/cdudi/sfile.csv'
//     }

//     stages {
//         stage('Clone GitHub Repo') {
//             steps {
//                 git branch: "${BRANCH}", url: "${GIT_REPO}"
//             }
//         }

//         stage('Transfer CSV File from Source VM to Destination VM') {
//             steps {
//                 sh '''
//                 pwsh -Command "& {
//                     ./migrate.ps1 `
//                         -SourceUser \\"${SOURCE_USER}\\" `
//                         -SourceHost \\"${SOURCE_HOST}\\" `
//                         -DestinationUser \\"${DEST_USER}\\" `
//                         -DestinationHost \\"${DEST_HOST}\\" `
//                         -CsvFilePath \\"${FILE_NAME}\\" `
//                         -TargetPath \\"${DEST_PATH}\\"
//                 }"
//                 '''
//             }
//         }
//     }
// }

pipeline {
    agent any

    environment {
        GIT_REPO    = 'https://github.com/Dudi-Chiranjeevi/sptestus4.git' 
        BRANCH      = 'main'

        SOURCE_USER = 'cdudi'
        SOURCE_HOST = '10.128.0.29'

        DEST_USER   = 'cdudi'
        DEST_HOST   = '10.128.0.28'
        DEST_PATH   = '/home/cdudi/'

        FILE_NAME   = '/home/cdudi/sfile.csv'
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                git branch: "${BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Transfer CSV File from Source VM to Destination VM') {
            steps {
                pwsh """
                    ./migrate.ps1 `
                                -SourceUser '${SOURCE_USER}' `
                                -SourceHost '${SOURCE_HOST}' `
                                -DestinationUser '${DEST_USER}' `
                                -DestinationHost '${DEST_HOST}' `
                                -CsvFilePath '${FILE_NAME}' `
                                -TargetPath '${DEST_PATH}'
                """
            }
        }
    }
}
