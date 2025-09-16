pipeline {
    agent any

    tools {
        maven 'Maven3'   // Configure Maven in Jenkins Global Tool Config
        jdk 'JDK17'      // Configure JDK in Jenkins Global Tool Config
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
                    sh '''
                        curl -u admin:password \
                        -T target/sample-app-1.0-SNAPSHOT.jar \
                        "http://43.204.153.178/artifactory/example-repo-local/com/devops/lab/sample-app/1.0-SNAPSHOT/sample-app-1.0-SNAPSHOT.jar"
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

