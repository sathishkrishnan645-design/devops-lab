pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sathishkrishnan645-design/devops-lab.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t my-python-app:latest ./project'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop old container if running
                    sh 'docker rm -f my-python-container || true'
                    
                    // Run new container
                    sh 'docker run -d --name my-python-container -p 5000:5000 my-python-app:latest'
                }
            }
        }
    }
}

