pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'yourdockerhubusername/yourrepo'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'  // Set this in Jenkins > Credentials
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/yourusername/your-portfolio-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Build and push successful!'
        }
        failure {
            echo 'Something went wrong.'
        }
    }
}
