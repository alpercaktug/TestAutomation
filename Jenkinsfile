pipeline {
    agent any
    environment {
            PATH = "/usr/local/rvm/gems/ruby-3.2.0/bin:/usr/local/rvm/gems/ruby-3.2.0@global/bin:/usr/local/rvm/rubies/ruby-3.2.0/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin" // Include gem binaries directory in PATH
                   }
    stages {
        stage('Install dependencies') {
            steps {
                script {
                    sh 'ruby --version'
                    sh 'gem install cucumber'
                    sh 'gem install page-object'
                    sh 'gem install allure-cucumber'
                    sh 'bundle install'
                }
            }
        }
       stage('Execute Tests') {
                   steps {
                       script {
                           try {
                               sh 'cucumber --tags ${TAG}'
                           } catch (Exception e) {
                               currentBuild.result = 'UNSTABLE' // Mark the build as unstable if tests fail
                               echo "Tests failed but continuing the pipeline."
                           }
                       }
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
