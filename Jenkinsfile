pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "✅ Building project..."
                sh 'ls -l'
            }
        }
        stage('Test') {
            steps {
                echo "🧪 Running tests..."
                sh 'echo All tests passed!'
            }
        }
        stage('Deploy') {
            steps {
                echo "🚀 Deploying application..."
            }
        }
    }
}

