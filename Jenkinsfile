pipeline {
    agent any

    environment {
        // Ensure Jenkins can find the JDK
        PATH = "/usr/lib/jvm/java-17-openjdk/bin:${env.PATH}"
        WAR_NAME = "sharmili-devops-lab.war"
        ARTIFACTORY_URL = "http://43.204.153.178/artifactory/libs-release-local"
        ARTIFACTORY_CRED = "admin:password"
        ANSIBLE_INVENTORY = "ansible/hosts"
        ANSIBLE_PLAYBOOK = "ansible/deploy_simple_webapp.yml"
    }

    tools {
        jdk "Java17"  // Make sure JDK is configured in Jenkins Global Tools
    }

    stages {

        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build WAR') {
            steps {
                script {
                    echo "Building WAR from war-temp..."
                    sh "jar -cvf ${WAR_NAME} -C war-temp ."
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // Placeholder: SonarQube analysis
                    echo "SonarQube stage skipped or add your scanner command here"
                }
            }
        }

        stage('Push WAR to Artifactory') {
            steps {
                script {
                    echo "Uploading WAR to Artifactory..."
                    sh "curl -u ${ARTIFACTORY_CRED} -T ${WAR_NAME} ${ARTIFACTORY_URL}/${WAR_NAME} || echo 'Artifactory upload failed (check permissions)'"
                }
            }
        }

        stage('Deploy via Ansible') {
            steps {
                script {
                    echo "Deploying WAR to Tomcat via Ansible..."
                    sh "ansible-playbook -i ${ANSIBLE_INVENTORY} ${ANSIBLE_PLAYBOOK} --extra-vars \"war_name=${WAR_NAME}\""
                }
            }
        }

        stage('Monitoring & Logging') {
            steps {
                script {
                    echo "Monitoring & Logging stage: integrate Prometheus/Grafana/Splunk"
                    // Add Prometheus, Grafana, or Splunk integration here
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    echo "Verifying deployment..."
                    sh "curl -I http://3.111.164.150:8081/simple-webapp/"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}

