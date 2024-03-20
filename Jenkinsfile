pipeline {
    agent any
    environment {
            PATH = "/Users/alpercaktug/.rvm/gems/ruby-3.2.0/bin:/Users/alpercaktug/.rvm/gems/ruby-3.2.0@global/bin:/Users/alpercaktug/.rvm/rubies/ruby-3.2.0/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/alpercaktug/.rvm/bin" // Include gem binaries directory in PATH
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
        stage('Test') {
            steps {
                sh 'rake run TAGS=${TAG} PLATFORM=browserstack'
            }
        }

        stage('reports') {
            steps {
            script {
                    allure([
                            includeProperties: false,
                            jdk: '',
                            properties: [],
                            reportBuildPolicy: 'ALWAYS',
                            results: [[path: 'target/allure-report/allure-result']]
                    ])
            }
            }
        }

    }
}
