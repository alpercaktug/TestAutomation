pipeline {
    agent any
    environment {
        OWNER = 'alpercaktug'          // Replace with your GitHub username
        REPO = 'TestAutomation'                 // Replace with your repository name
        WORKFLOW_FILENAME = 'ruby.yml' // Replace with your workflow file name
        BRANCH = 'main'                         // Replace with your target branch
        TAGS = '@test'                          // Set default or parameterized TAGS
        ENVIRONMENT = 'prod'                    // Set default or parameterized ENV
        PLATFORM = 'browserstack'               // Set default or parameterized PLATFORM
    }
    stages {
        stage('Trigger GitHub Actions Workflow') {
            steps {
                // test
                // test
                withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_TOKEN')]) {
                    sh '''
                    curl -X POST \
                      -H "Accept: application/vnd.github+json" \
                      -H "Authorization: token $GITHUB_TOKEN" \
                      https://api.github.com/repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_FILENAME/dispatches \
                      -d '{
                        "ref":"'$BRANCH'",
                        "inputs":{
                          "TAGS":"'$TAGS'",
                          "ENV":"'$ENVIRONMENT'",
                          "PLATFORM":"'$PLATFORM'"
                        }
                      }'
                    '''
                }
            }
        }
    }
}
