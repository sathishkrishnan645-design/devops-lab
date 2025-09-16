pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'JDK17'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sathishkrishnan645-design/devops-lab.git'
            }
        }

        stage('Build') {
            steps {
                dir('sample-app') {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Upload to JFrog Artifactory') {
            environment {
                ARTIFACTORY_URL = "http://43.204.153.178/artifactory"
                ARTIFACTORY_REPO = "maven-release-local"
            }
            steps {
                dir('sample-app') {
                    sh '''
                      curl -u $ARTIFACTORY_USER:$ARTIFACTORY_PASSWORD \
                        -T target/sample-app-1.0-SNAPSHOT.jar \
                        "$ARTIFACTORY_URL/$ARTIFACTORY_REPO/com/devops/lab/sample-app/1.0-SNAPSHOT/sample-app-1.0-SNAPSHOT.jar"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline executed successfully and artifact uploaded to Artifactory!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}

