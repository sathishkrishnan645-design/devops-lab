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
                dir('sample-app') {   // 👈 run inside sample-app where pom.xml is located
                    sh 'mvn clean package'
                }
            }
        }

        stage('Upload to JFrog Artifactory') {
            steps {
                dir('sample-app') {   // 👈 upload built JAR from sample-app/target
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

