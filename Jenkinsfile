pipeline {
    agent any
    environment {
        PATH = "/usr/local/bin:$PATH:/Users/alpercaktug/.gem/ruby/2.6.0/bin" // Include gem binaries directory in PATH
    }
    stages {
        stage('Install dependencies') {
            steps {
                script {
                    sh 'gem install bundler -v 2.2.28 --user-install' // Install compatible Bundler version
                    sh 'gem install cucumber-tag-expressions -v 5.0.6'
                    sh 'gem install cucumber page-object allure-cucumber --user-install'
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
