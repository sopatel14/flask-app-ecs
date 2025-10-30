pipeline {
    agent any  // This means the pipeline can run on any available Jenkins agent (machine)

    stages {   // The pipeline is divided into multiple stages

        stage('Clone Code') {   // Stage 1: Download the code from GitHub
            steps {
                echo 'Cloning repository...'
                // 'git' command will pull the code from GitHub main branch
                git branch: 'main', url: 'https://github.com/sopatel14/flask-app-ecs.git'
            }
        }

        stage('Build Docker Image') {   // Stage 2: Build Docker image using Dockerfile
            steps {
                echo 'Building Docker image...'
                // The following command builds a Docker image named "flask-app"
                sh 'docker build -t flask-app .'
            }
        }

        stage('Run Container') {   // Stage 3: Run the app inside a Docker container
            steps {
                echo 'Running container...'
                sh '''
                # Stop and remove old container if it already exists
                docker stop flask-container || true
                docker rm flask-container || true

                # Run new container from the image we just built
                # -d = detached mode (run in background)
                # -p 5000:80 = map port 5000 of host to port 80 inside container
                # --name = give container a name "flask-container"
                docker run -d -p 5000:80 --name flask-container flask-app
                '''
            }
        }

        stage('Test App') {   // Stage 4: Check if app is running properly
            steps {
                echo 'Testing application...'
                sh '''
                # Wait a few seconds for the app to start
                sleep 5

                # Use curl to check if the app responds on localhost:5000
                # -f = fail if HTTP status is not 200
                # If test fails, exit with code 1 (to mark build as failed)
                curl -f http://localhost:5000 || exit 1
                '''
            }
        }
    }
}
