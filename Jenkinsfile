pipeline {
    agent any

    environment {
        // Define Docker Hub credentials ID
        DOCKERHUB_CREDENTIALS = 'dockerhub'
        // Define Docker image details
        DOCKER_IMAGE = 'swetha328/myhtmlapp'
        // Define Docker container name
        CONTAINER_NAME = 'mycontainer'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from Git repository
                git branch: 'main', url: 'https://github.com/swethacse20/cicd.git'
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
                        docker.image('swetha328/myhtmlapp:1').push('1')
                    }
                }
            }
        }

        stage('Pull') {
            steps {
                // Pull Docker image from Docker Hub
                script {
                   docker.withRegistry('', 'dockerhub') {
                        docker.image('swetha328/myhtmlapp:1').pull()
                }
            }
          }
        }
        stage('Run') {
            steps {
                // Run Docker container
               script {
                    docker.withRegistry('', 'dockerhub') {
                        docker.image('swetha328/myhtmlapp:1').run('-d -p 8080:80 --name mycontainer')
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
                sh "docker rmi swetha328/myhtmlapp:1 || true"
            }
        }
    }
}
