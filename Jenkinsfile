pipeline {
    agent any
     environment {
        PATH = "/usr/share/rvm/gems/ruby-3.2.0/bin:/usr/share/rvm/gems/ruby-3.2.0@global/bin:/usr/share/rvm/rubies/ruby-3.2.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/share/rvm/bin"
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
