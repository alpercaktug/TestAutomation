pipeline {
    agent any
    environment {
            PATH = "usr/local/rvm/gems/ruby-3.2.0/bin:/usr/local/rvm/gems/ruby-3.2.0@global/bin:/usr/local/rvm/rubies/ruby-3.2.0/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
                   }
    stages {
        stage('Install dependencies') {
            steps {
                script {
                    sh 'ruby --version'
                    sh 'bundle install'

                }
            }
        }
        stage('Execute Tests') {
            steps {
                sh 'rake run TAGS=${TAG} PLATFORM=browserstack'
            }
        }

        stage('Generate Report') {
            steps {
            script {
                    allure([
                            includeProperties: false,
                            jdk: '',
                            properties: [],
                            reportBuildPolicy: 'ALWAYS',
                            results: [[path: 'allure-result']]
                    ])
            }
            }
        }

    }
}
