pipeline {
    agent any
     environment {
            PATH = "/usr/local/rvm/gems/ruby-3.2.0/bin:/usr/local/rvm/gems/ruby-3.2.0@global/bin:/usr/local/rvm/rubies/ruby-3.2.0/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin" // Add RVM bin directory to PATH
        }


    stages {
       stage('Initialize RVM') {
                   steps {
                       script {
                           sh '. /usr/local/rvm/scripts/rvm' // Use dot command to source RVM script
                       }
                   }
               }
        stage('Install dependencies') {
            steps {
                script {
                    sh 'ruby --version'
                    sh 'rvm @global do gem install bundler --no-document' // Install bundler gem
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
