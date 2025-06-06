pipeline {

    agent any
 
    parameters {

        string(name: 'SOURCE_USER', defaultValue: 'cdudi', description: 'Source VM username')

        string(name: 'SOURCE_HOST', defaultValue: '10.128.0.29', description: 'Source VM IP')

        string(name: 'DEST_USER', defaultValue: 'cdudi', description: 'Destination username')

        choice(name: 'DEST_HOST', choices: ['ALL', '10.128.0.24', '10.128.0.28'], description: 'Target host IP or "ALL" for all')

        string(name: 'DEST_PATH', defaultValue: '/home/cdudi/', description: 'Target path on remote hosts')

        string(name: 'FILE_NAME', defaultValue: '/home/cdudi/sfile.csv', description: 'File path on source VM')

    }
 
    environment {

        LOG_DIR = 'logs'

        ALL_HOSTS = '10.128.0.24,10.128.0.28'

    }
 
    stages {

        stage('Prepare Logs') {

            steps {

                sh 'mkdir -p logs'

            }

        }
 
        stage('Parallel SCP from Source to Destinations') {

            steps {

                script {

                    def targetHosts = (params.DEST_HOST == 'ALL') ? env.ALL_HOSTS.split(',') : [params.DEST_HOST]

                    def parallelSteps = [:]
 
                    for (host in targetHosts) {

                        def cleanHost = host.trim()

                        parallelSteps["Transfer to ${cleanHost}"] = {

                            sh """

                                echo "===== Transfer Start to ${cleanHost} =====" >> logs/transfer_${cleanHost}.log

                                pwsh -File ./migrate.sh `

                                    -SourceUser '${params.SOURCE_USER}' `

                                    -SourceHost '${params.SOURCE_HOST}' `

                                    -DestinationUser '${params.DEST_USER}' `

                                    -DestinationHosts '${cleanHost}' `

                                    -CsvFilePath '${params.FILE_NAME}' `

                                    -TargetPath '${params.DEST_PATH}' >> logs/transfer_${cleanHost}.log 2>&1

                                echo "===== Transfer End to ${cleanHost} =====" >> logs/transfer_${cleanHost}.log

                            """

                        }

                    }
 
                    parallel parallelSteps

                }

            }

        }

    }
 
    post {

        always {

            archiveArtifacts artifacts: 'logs/*.log', fingerprint: true

            emailext(

                subject: "${currentBuild.currentResult}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",

                body: """<p>Job Status: ${currentBuild.currentResult}</p>
<p>Job: ${env.JOB_NAME}<br/>

Build Number: ${env.BUILD_NUMBER}<br/>
<a href='${env.BUILD_URL}'>View Build</a></p>""",

                to: 'chiranjeevigen@gmail.com',

                from: 'chiranjeevidudi3005@gmail.com',

                attachmentsPattern: 'logs/*.log'

            )

        }

    }

}

 


// pipeline {

//     agent any
 
//     parameters {

//         string(name: 'SOURCE_USER', defaultValue: 'cdudi', description: 'Username of source VM')

//         string(name: 'SOURCE_HOST', defaultValue: '10.128.0.29', description: 'Source VM IP')
 
//         choice(name: 'DEST_HOST', choices: ['ALL', '10.128.0.24', '10.128.0.28'], description: 'Single target or ALL')

//         string(name: 'DEST_USER', defaultValue: 'cdudi', description: 'Username on target VMs')

//         string(name: 'DEST_PATH', defaultValue: '/home/cdudi/', description: 'Target path')

//         string(name: 'FILE_NAME', defaultValue: '/home/cdudi/sfile.csv', description: 'File path on source VM')

//     }
 
//     environment {

//         ALL_HOSTS = '10.128.0.24,10.128.0.28'

//     }
 
//     stages {

//         stage('Checkout GitHub Repo') {

//             steps {

//                 git branch: 'main', url: 'https://github.com/Dudi-Chiranjeevi/sptestus4.git'

//             }

//         }
 
//         stage('Parallel SCP from Source to Destinations') {

//             steps {

//                 script {

//                     def targetHosts = (params.DEST_HOST.trim() == 'ALL') 

//                                       ? env.ALL_HOSTS.split(',') 

//                                       : [params.DEST_HOST.trim()]
 
//                     def parallelSteps = [:]
 
//                     for (host in targetHosts) {

//                         def cleanHost = host.trim()

//                         parallelSteps["Transfer to ${cleanHost}"] = {

//                             pwsh """

//                                 mkdir -p logs

//                                 echo "===== Transfer Start to ${cleanHost} =====" >> logs/transfer_${cleanHost}.log

//                                 ./migrate.ps1 `

//                                       -SourceUser "${params.SOURCE_USER}" `

//                                       -SourceHost "${params.SOURCE_HOST}" `

//                                       -DestinationUser "${params.DEST_USER}" `

//                                       -DestinationHosts "${cleanHost}" `

//                                       -CsvFilePath "${params.FILE_NAME}" `

//                                       -TargetPath "${params.DEST_PATH}" >> logs/transfer_${cleanHost}.log 2>&1

//                                 echo "===== Transfer End to ${cleanHost} =====" >> logs/transfer_${cleanHost}.log

//                             """

//                         }

//                     }
 
//                     parallel parallelSteps

//                 }

//             }

//         }

//     }
 
//     post {

//         always {

//             archiveArtifacts artifacts: 'logs/*.log', fingerprint: true
 
//             emailext(

//                 subject: "${currentBuild.currentResult}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",

//                 body: """<p>Job ${currentBuild.currentResult}</p>
// <p>Job: ${env.JOB_NAME}<br/>

// Build Number: ${env.BUILD_NUMBER}<br/>
// <a href='${env.BUILD_URL}'>View Build</a></p>""",

//                 to: 'chiranjeevigen@gmail.com',

//                 from: 'chiranjeevidudi3005@gmail.com',

//                 attachmentsPattern: 'logs/*.log'

//             )

//         }

//     }

// }

 

 
 
 

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
