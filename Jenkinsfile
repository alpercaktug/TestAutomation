pipeline {
    agent any
    environment {
            PATH = "/Users/alpercaktug/.rvm/rubies/ruby-3.2.0/share/man/man1/ruby.1" // Include gem binaries directory in PATH
        }
    stages {
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
