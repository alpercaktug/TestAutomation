pipeline {
    agent any
    environment {
        PATH = "/usr/share/rvm/gems/ruby-3.2.2/bin:/usr/share/rvm/gems/ruby-3.2.2@global/bin:/usr/share/rvm/rubies/ruby-3.2.2/bin:/usr/share/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
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
                        sh 'rake run TAGS="${TAG}" ENV="${ENV}"'
                        // sh 'cucumber --tags ${TAG}'
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
    } // End of stages
    post {
        success {
            script {
                githubPRAddLabels labelProperty: labels('success')
            }
        }
        failure {
            script {
                githubPRAddLabels labelProperty: labels('failure')
            }
        }
    }
} // End of pipeline

