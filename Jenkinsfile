pipeline {
  agent any
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