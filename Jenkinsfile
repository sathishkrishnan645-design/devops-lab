pipeline {
    agent any

    tools {
        maven 'Maven3'   // Make sure Maven3 is configured in Jenkins Global Tool Config
        jdk 'JDK17'      // Make sure JDK17 is configured in Jenkins Global Tool Config
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

        stage('Upload to JFrog Artifactory') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'artifactory-credentials', usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD')]) {
                    sh '''
                      echo "Uploading artifact to JFrog..."
                      curl -u $ARTIFACTORY_USER:$ARTIFACTORY_PASSWORD \
                      -T target/sample-app-1.0-SNAPSHOT.jar \
                      "http://43.204.153.178:8082/artifactory/libs-release-local/com/devops/lab/sample-app/1.0-SNAPSHOT/sample-app-1.0-SNAPSHOT.jar"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline executed successfully and artifact uploaded to JFrog!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}

