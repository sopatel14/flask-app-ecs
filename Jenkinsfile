pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building the Flask application...'
                sh 'docker build -t flask-sample-app:latest .'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'docker run -d --name testapp -p 5000:5000 flask-sample-app:latest'
                sh 'sleep 5'
                sh 'curl -f http://localhost:5000 || exit 1'
                sh 'docker stop testapp && docker rm testapp'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying container on port 8081 host system...'
                sh 'docker run -d -p 8081:5000 --name flaskapp flask-sample-app:latest || echo "Container may already exist"'
            }
        }
    }

    post {
        always {
            echo 'Listing running containers...'
            sh 'docker ps -a'
        }
    }
}
