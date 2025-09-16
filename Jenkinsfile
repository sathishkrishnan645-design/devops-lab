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
                dir('sample-app') {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Upload to JFrog Artifactory') {
            steps {
                dir('sample-app') {
                    withCredentials([usernamePassword(
                        credentialsId: 'artifactory-credentials',   // Create this credential in Jenkins
                        usernameVariable: 'ART_USER',
                        passwordVariable: 'ART_PASS'
                    )]) {
                        sh '''
                            curl -u $ART_USER:$ART_PASS \
                                 -T target/sample-app-1.0-SNAPSHOT.jar \
                                 "http://43.204.153.178/artifactory/maven-release-local/com/devops/lab/sample-app/1.0-SNAPSHOT/sample-app-1.0-SNAPSHOT.jar"
                        '''
                        echo "✅ Uploaded artifact to Artifactory"
                    }
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

