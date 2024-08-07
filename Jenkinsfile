pipeline {
    agent any

    environment {
        // Define Docker Hub credentials ID
        DOCKERHUB_CREDENTIALS = 'dockerhub'
        // Define Docker image details
        DOCKER_IMAGE = 'bharath1808/myhtml'
        // Define Docker container name
        CONTAINER_NAME = 'mycontainer'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from Git repository
                git branch: 'main', url: 'https://github.com/bharathreddyvupperpally/cicd.git'
            }
        }

        stage('Build') {
            steps {
                // Build Docker image
                script {
                    docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push') {
            steps {
                // Push Docker image to Docker Hub
                script {
                    docker.withRegistry('', 'dockerhub') {
                        docker.image('bharath1808/myhtml:6').push()
                    }
                }
            }
        }

        stage('Pull') {
            steps {
                // Pull Docker image from Docker Hub
                script {
                   docker.withRegistry('', 'dockerhub') {
                        docker.image('bharath1808/myhtml:6').pull()
                }
            }
          }
        }
        stage('Run') {
            steps {
                // Run Docker container
               script {
                    docker.withRegistry('', 'dockerhub') {
                        docker.image('bharath1808/myhtml:6').run('-d -p 8084:80 --name mycontainer')
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline successfully completed!'
        }
        failure {
            echo 'Pipeline failed :('
        }
        always {
            script {
                sh "docker stop mycontainer || true"
                sh "docker rm mycontainer || true"
                sh "docker rmi bharath1808/myhtml:6 || true"
            }
        }
    }
}
