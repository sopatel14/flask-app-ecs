pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building the Docker image...'
                sh 'docker build -t flask-sample-app:latest .'
            }
        }

        stage('Test') {
            steps {
                echo 'Starting container for health check (host:5000 -> container:80)...'
                sh '''
                  # remove previous test container if exists
                  docker rm -f testapp 2>/dev/null || true

                  # run app mapping host 5000 -> container 80 (app listens on 80)
                  docker run -d --name testapp -p 5000:80 flask-sample-app:latest

                  # give app more time to start
                  sleep 10

                  # do healthcheck; print logs and fail if curl fails
                  if ! curl -f http://localhost:5000 ; then
                    echo "Health check failed. Dumping container logs:"
                    docker logs testapp || true
                    docker rm -f testapp || true
                    exit 1
                  fi

                  # cleanup test container
                  docker rm -f testapp || true
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application on host port 8082 (8082 -> container 80)...'
                sh '''
                  # remove any previous deployed container
                  docker rm -f flaskapp 2>/dev/null || true

                  # run deployed container mapping host 8082 -> container 80
                  docker run -d --name flaskapp -p 8082:80 flask-sample-app:latest

                  # list containers to confirm
                  docker ps -a
                '''
            }
        }
    }

    post {
        always {
            echo 'Post: show docker ps'
            sh 'docker ps -a'
        }
    }
}
