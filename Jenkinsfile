pipeline {

    agent any
 
    environment {

        GIT_REPO    = 'https://github.com/Dudi-Chiranjeevi/sptestus4.git' 

        BRANCH      = 'main'
 
        SOURCE_USER = 'cdudi'

        SOURCE_HOST = '10.128.0.29'
 
        DEST_USER   = 'cdudi'  // Same user for all destination VMs

        DEST_PATH   = '/home/cdudi/'

        FILE_NAME   = '/home/cdudi/sfile.csv'

    }
 
    stages {

        stage('Clone GitHub Repo') {

            steps {

                git branch: "${BRANCH}", url: "${GIT_REPO}"

            }

        }
 
        stage('Transfer CSV File to Multiple Destination VMs') {

            parallel {

                stage('Transfer to 10.128.0.28') {

                    steps {

                        pwsh """

                            ./migrate.ps1 `

                                        -SourceUser '${SOURCE_USER}' `

                                        -SourceHost '${SOURCE_HOST}' `

                                        -DestinationUser '${DEST_USER}' `

                                        -DestinationHost '10.128.0.28' `

                                        -CsvFilePath '${FILE_NAME}' `

                                        -TargetPath '${DEST_PATH}'

                        """

                    }

                }
 
                stage('Transfer to 10.128.0.24') {

                    steps {

                        pwsh """

                            ./migrate.ps1 `

                                        -SourceUser '${SOURCE_USER}' `

                                        -SourceHost '${SOURCE_HOST}' `

                                        -DestinationUser '${DEST_USER}' `

                                        -DestinationHost '10.128.0.24' `

                                        -CsvFilePath '${FILE_NAME}' `

                                        -TargetPath '${DEST_PATH}'

                        """

                    }

                }

            }

        }

    }

}

 
 

// worked code for single vm
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
//                 pwsh """
//                     ./migrate.ps1 `
//                                 -SourceUser '${SOURCE_USER}' `
//                                 -SourceHost '${SOURCE_HOST}' `
//                                 -DestinationUser '${DEST_USER}' `
//                                 -DestinationHost '${DEST_HOST}' `
//                                 -CsvFilePath '${FILE_NAME}' `
//                                 -TargetPath '${DEST_PATH}'
//                 """
//             }
//         }
//     }
// }
