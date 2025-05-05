pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def app = docker.build("vtakantinithinkumarreddy/portfolio")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials-id') {
                        def app = docker.image("vtakantinithinkumarreddy/portfolio")
                        app.push("latest")
                    }
                }
            }
        }
    }

    post {
        failure {
            echo "Something went wrong in the pipeline."
        }
    }
}
