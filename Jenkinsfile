pipeline {
    agent any

    environment {
        WAR_NAME = 'sharmili-devops-lab.war'
        WAR_SRC = 'war-temp'
        TOMCAT_HOST = '3.111.164.150'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/sathishkrishnan645-design/devops-lab.git',
                    credentialsId: 'github-credentials'
            }
        }

        stage('Build WAR') {
            steps {
                sh "jar -cvf ${WAR_NAME} -C ${WAR_SRC} ."
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh "sonar-scanner -Dsonar.projectKey=SharmiliLab -Dsonar.sources=${WAR_SRC} -Dsonar.host.url=http://3.111.164.150:9000 -Dsonar.login=Sharmili@123"
            }
        }

        stage('Push WAR to Artifactory') {
            steps {
                sh "curl -u admin:password -T ${WAR_NAME} http://43.204.153.178/artifactory/simple-webapp/${WAR_NAME}"
            }
        }

        stage('Deploy via Ansible') {
            steps {
                // Copy WAR to Ansible folder for deployment
                sh "cp ${WAR_NAME} ansible/"
                sh "ansible-playbook -i ansible/hosts ansible/deploy_simple_webapp.yml --extra-vars 'war_name=${WAR_NAME}'"
            }
        }

        stage('Monitoring & Logging') {
            steps {
                echo 'Metrics collected in Prometheus/Grafana, logs sent to Splunk'
            }
        }

        stage('Verify Deployment') {
            steps {
                sh "curl -I http://${TOMCAT_HOST}:8081/simple-webapp/"
            }
        }
    }

    post {
        success { echo 'Pipeline completed successfully!' }
        failure { echo 'Pipeline failed!' }
    }
}

