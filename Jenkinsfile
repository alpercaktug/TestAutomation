pipeline {
    agent any
    environment {
            PATH = "/usr/local/bin:$PATH:" // Include gem binaries directory in PATH
            GEM_HOME = "/Users/alpercaktug/.rvm/rubies/ruby-3.2.0/gems" // Install gems locally within the project directory

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
