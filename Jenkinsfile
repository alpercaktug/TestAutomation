pipeline {
    agent any
    environment {
            PATH = "/usr/local/bin:$PATH:/Users/alpercaktug/.rvm/rubies/ruby-3.2.0" // Include gem binaries directory in PATH
        }
    stages {
        stage('Install dependencies') {
            steps {
                script {
                    sh 'gem install bundler cucumber page-object allure-cucumber --user-install'
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
