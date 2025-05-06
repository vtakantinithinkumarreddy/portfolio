pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-docker-image-name'
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_USERNAME = credentials('docker-hub-username')
        DOCKER_PASSWORD = credentials('docker-hub-password')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Log into Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials-id', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY"
                    }
                    // Push the Docker image to Docker Hub
                    sh "docker push $DOCKER_IMAGE"
                }
            }
        }
    }
}
