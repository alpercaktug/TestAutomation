pipeline {
    agent any
     environment {
            PATH = "/usr/local/rvm/bin:$PATH" // Add RVM bin directory to PATH
        }
        stages {
            stage('Initialize RVM') {
                steps {
                    script {
                        sh 'source /usr/local/rvm/scripts/rvm' // Source RVM script to initialize it
                    }
                }
            }
            }
    stages {
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
