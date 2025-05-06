pipeline {
    agent any

    environment {
        // Define Docker Image and Docker Hub repository
        DOCKER_IMAGE = 'your-dockerhub-username/your-portfolio'  // Update with your Docker Hub username/repo
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials-id' // Jenkins Docker Hub credentials ID
        GIT_REPO = 'https://github.com/vtakantinithinkumarreddy/portfolio.git' // GitHub repository URL
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository from GitHub
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Ensure Docker commands are used correctly in a docker context
                    docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                        // Build the Docker image using NGINX to serve static files
                        docker.build("${DOCKER_IMAGE}:latest", "-f Dockerfile .")
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub after building it
                    docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
        success {
            echo 'Docker image built and pushed to Docker Hub successfully.'
        }
        failure {
            echo 'An error occurred during the pipeline execution.'
        }
    }
}
