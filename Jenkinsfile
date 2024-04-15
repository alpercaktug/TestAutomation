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
        stage('Update GitHub Pull Request Status') {
            steps {
            post {
                            success {
                                script {
                                    updateGitHubPRLabel("success")
                                }
                            }
                            failure {
                                script {
                                    updateGitHubPRLabel("failure")
                                }
                            }
        }

    }
    def updateGitHubPRLabel(String status) {
         // GitHub credentials
         withCredentials([usernamePassword(credentialsId: 'github-credentials', usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_TOKEN')]) {
             def apiUrl = "https://api.github.com/repos/owner/repo/issues/${env.CHANGE_ID}/labels"
             def payload = [
                 labels: [status]
             ]
             def response = httpRequest(
                 acceptType: 'APPLICATION_JSON',
                 contentType: 'APPLICATION_JSON',
                 httpMode: 'POST',
                 url: apiUrl,
                 authentication: 'BASIC',
                 username: env.GITHUB_USERNAME,
                 password: env.GITHUB_TOKEN,
                 requestBody: groovy.json.JsonOutput.toJson(payload)
             )
             if (response.status != 200) {
                 error "Failed to update label on GitHub PR: ${response.status} - ${response.content}"
             }
         }
     }
}


