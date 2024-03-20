pipeline {
    agent any
    environment {
        PATH = "/usr/local/bin:$PATH" // Ensure necessary binaries are in PATH
        GEM_HOME = "${workspace}/gems" // Install gems locally within the project directory
    }
    stages {
        stage('Install dependencies') {
            steps {
                script {
                    sh 'gem install bundler cucumber page-object allure-cucumber --user-install'
                    sh 'bundle install --path ${workspace}/gems'
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
