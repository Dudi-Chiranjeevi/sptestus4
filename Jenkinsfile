pipeline {
    agent any

    environment {
        GIT_REPO    = 'https://github.com/SudhakarJinuka/test_case4.git'
        BRANCH      = 'main'

        SOURCE_USER = 'sjinuka'
        SOURCE_HOST = '10.128.0.29'

        DEST_USER   = 'sjinuka'
        DEST_HOST   = '10.128.0.28'
        DEST_PATH   = '/home/sjinuka/'

        FILE_NAME   = '/home/sjinuka/sample_data3.csv'
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                git branch: "${BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Transfer CSV File from Source VM to Destination VM') {
            steps {
                sh '''
                pwsh -Command "& {
                    ./migrate_copy.ps1 `
                        -SourceUser \\"${SOURCE_USER}\\" `
                        -SourceHost \\"${SOURCE_HOST}\\" `
                        -DestinationUser \\"${DEST_USER}\\" `
                        -DestinationHost \\"${DEST_HOST}\\" `
                        -CsvFilePath \\"${FILE_NAME}\\" `
                        -TargetPath \\"${DEST_PATH}\\"
                }"
                '''
            }
        }
    }
}