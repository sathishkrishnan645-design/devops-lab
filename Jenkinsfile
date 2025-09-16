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
                    sh 'mvn clean compile'
                }
            }
        }

        stage('Test') {
            steps {
                dir('sample-app') {
                    sh 'mvn test'
                }
            }
        }

        stage('Package') {
            steps {
                dir('sample-app') {
                    sh 'mvn package'
                }
            }
        }

        stage('Upload to JFrog Artifactory') {
            steps {
                dir('sample-app') {
                    sh '''
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
            echo '✅ Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}

