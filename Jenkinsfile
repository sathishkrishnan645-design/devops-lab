pipeline {
    agent any

    tools {
        jdk 'JDK17'          // JDK name configured in Jenkins
        maven 'Maven3'       // Maven name configured in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-credentials',
                    url: 'https://github.com/sathishkrishnan645-design/devops-lab.git'
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
                    sh """
                        curl -u admin:password \
                          -T target/sample-app-1.0-SNAPSHOT.jar \
                          http://43.204.153.178/artifactory/libs-release-local/com/devops/lab/sample-app/1.0-SNAPSHOT/sample-app-1.0-SNAPSHOT.jar
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}

