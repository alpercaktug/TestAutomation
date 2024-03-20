pipeline {
    agent any
    environment {
        PATH = "/usr/local/bin:$PATH" // Ensure necessary binaries are in PATH
    }
    stages {
        stage('Install dependencies') {
            steps {
                script {
                    sh 'gem install bundler cucumber page-object allure-cucumber'
                    sh 'bundle install'
                }
            }
        }
        stage('version') {
            steps {
                sh 'ruby --version'
            }
        }
        stage('hello') {
            steps {
                sh 'rake run TAGS=@booking-engine PLATFORM=browserstack'
            }
        }
    }
}