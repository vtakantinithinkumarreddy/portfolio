pipeline {
    agent any

    environment {
        IMAGE_NAME = 'nithin175/portfolio'
        TAG = 'latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/vtakantinithinkumarreddy/portfolio.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-creds') {
                        dockerImage.push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built and pushed successfully.'
        }
        failure {
            echo 'Something went wrong in the pipeline.'
        }
    }
}
