pipeline {
    agent any
    environment {
             GEM_HOME = "/usr/local/rvm/gems/ruby-3.2.0"
                GEM_PATH = "/usr/local/rvm/gems/ruby-3.2.0:/usr/local/rvm/gems/ruby-3.2.0@global"
                PATH = "$PATH:$GEM_HOME/bin:$GEM_PATH/bin:/usr/local/rvm/rubies/ruby-3.2.0/bin:/usr/local/rvm/bin"
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
