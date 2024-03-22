pipeline {
    agent any
     environment {
        PATH = "/usr/share/rvm/gems/ruby-3.2.0/bin:/usr/share/rvm/gems/ruby-3.2.0@global/bin:/usr/share/rvm/rubies/ruby-3.2.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/share/rvm/bin"
        }
    stages {
        stage('Install dependencies') {
            steps {
                script {

                                    // Use the correct ruby and gemset
                sh 'rvm use "ruby@gemset"'
                                    // Set "fail on error" in bash
                sh 'set -e'
                                    // Do any setup
                                    // e.g. possibly do 'rake db:migrate db:test:prepare' here
                sh 'bundle install'
                                    // Finally, run your tests
                // sh 'rake'


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
