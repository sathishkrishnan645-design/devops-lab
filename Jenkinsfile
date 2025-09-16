pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'JDK17'
    }

    environment {
        ARTIFACTORY_USER = credentials('admin')   // Add this in Jenkins credentials
        ARTIFACTORY_PASSWORD = credentials('password')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sathishkrishnan645-design/devops-lab.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQubeServer') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Upload to JFrog Artifactory') {
            steps {
                sh '''
                  curl -u $ARTIFACTORY_USER:$ARTIFACTORY_PASSWORD \
                  -T target/sample-app-1.0-SNAPSHOT.jar \
                  "http://43.204.153.178:8082/artifactory/libs-release-local/com/devops/lab/sample-app/1.0-SNAPSHOT/sample-app-1.0-SNAPSHOT.jar"
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}

