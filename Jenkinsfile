pipeline {
    agent any
    environment {
        IMAGE_NAME = 'your-dockerhub-username/portfolio'
        TAG = 'latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch:'main', url:'https://github.com/your-username/your-repo.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerimage = docker.build("${IMAGE_NAME}:${TAG}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script{
                    docker.withRegistry("https://index.docker.io/v1/",'docker-creds'){
                        dockerimage.push();
                }
            }
        }
    }

    post {
        success {
            echo "Docker image pushed successfully: ${IMAGE_NAME}:${TAG}"
        }
    }
}
