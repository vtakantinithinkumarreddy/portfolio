pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/your-node-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials-id'
        SSH_CREDENTIALS_ID = 'ssh-key-for-test-server'
        TEST_SERVER = 'user@test-server-ip'
        GIT_REPO = 'git@github.com:vtakantinithinkumarreddy/portfolio.git'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'git@github.com:vtakantinithinkumarreddy/portfolio.git',
                        credentialsId: 'github-ssh'
                    ]]
                ])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS_ID}", url: '']) {
                    script {
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }

        stage('Deploy on Test Server') {
            steps {
                sshagent (credentials: ["${SSH_CREDENTIALS_ID}"]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${TEST_SERVER} << 'EOF'
                    docker pull ${DOCKER_IMAGE}:latest
                    docker stop node-app || true
                    docker rm node-app || true
                    docker run -d --name node-app -p 3000:3000 ${DOCKER_IMAGE}:latest
                    EOF
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
