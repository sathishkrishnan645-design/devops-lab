pipeline {
    agent any
    environment {
        ARTIFACTORY_URL = 'http://43.204.153.178/artifactory/libs-release-local/simple-webapp.war'
    }
    stages {
        stage('Checkout Source') {
            steps {
                git branch: 'main', url: 'https://github.com/sathishkrishnan645-design/devops-lab.git'
            }
        }

        stage('Download Sample WAR') {
            steps {
                sh 'wget -O simple-webapp.war https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war'
            }
        }

        stage('Push WAR to Artifactory (Optional)') {
            steps {
                sh """
                curl -u admin:password -T simple-webapp.war ${ARTIFACTORY_URL}
                """
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                sh 'ansible-playbook -i ansible/hosts ansible/deploy_simple_webapp.yml'
            }
        }

        stage('Monitor & Logs Integration') {
            steps {
                echo 'Trigger Prometheus Alert / Log Splunk Event Collector (Placeholder)'
                // Example curl call:
                // curl -X POST http://splunk-server:8088/services/collector -H "Authorization: Splunk <token>" -d '{"event": "Deployment Successful"}'
            }
        }

        stage('Verify Deployment') {
            steps {
                echo 'Access app at http://3.111.164.150:8081/simple-webapp'
            }
        }
    }
}

