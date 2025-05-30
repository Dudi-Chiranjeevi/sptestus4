pipeline {

    agent any
 
    environment {

        GIT_REPO    = 'https://github.com/Dudi-Chiranjeevi/sptestus4.git' 

        BRANCH      = 'main'
 
        SOURCE_USER = 'cdudi'

        SOURCE_HOST = '10.128.0.29'
 
        DEST_USER_1   = 'cdudi'

        DEST_HOST_1   = '10.128.0.28'

        DEST_PATH_1   = '/home/cdudi/'
 
        DEST_USER_2   = 'cdudi'

        DEST_HOST_2   = '10.128.0.24'   // example second target VM IP

        DEST_PATH_2   = '/home/cdudi/'
 
        FILE_NAME   = '/home/cdudi/sfile.csv'

    }
 
    stages {

        stage('Clone GitHub Repo') {

            steps {

                git branch: "${BRANCH}", url: "${GIT_REPO}"

            }

        }
 
        stage('Transfer CSV File from Source VM to Multiple Target VMs') {

            parallel {

                stage('Transfer to Target VM 1') {

                    steps {

                        pwsh """

                            ./migrate.ps1 `

                                -SourceUser '${SOURCE_USER}' `

                                -SourceHost '${SOURCE_HOST}' `

                                -DestinationUser '${DEST_USER_1}' `

                                -DestinationHost '${DEST_HOST_1}' `

                                -CsvFilePath '${FILE_NAME}' `

                                -TargetPath '${DEST_PATH_1}'

                        """

                    }

                }
 
                stage('Transfer to Target VM 2') {

                    steps {

                        pwsh """

                            ./migrate.ps1 `

                                -SourceUser '${SOURCE_USER}' `

                                -SourceHost '${SOURCE_HOST}' `

                                -DestinationUser '${DEST_USER_2}' `

                                -DestinationHost '${DEST_HOST_2}' `

                                -CsvFilePath '${FILE_NAME}' `

                                -TargetPath '${DEST_PATH_2}'

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
