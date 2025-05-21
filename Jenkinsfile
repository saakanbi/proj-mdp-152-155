pipeline {
    agent any

    tools {
        maven 'Maven 3.9.3'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'project-1', url: 'https://github.com/saakanbi/proj-mdp-152-155.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("calculator-app:${env.BUILD_ID}")
                }
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker rm -f calculator || true'
                sh 'docker run -d --name calculator -p 8080:8080 calculator-app:${BUILD_ID}'
            }
        }
    }

    post {
        always {
            echo "Build completed. You can access your app at http://44.202.69.28:8080/calculator"
        }
        failure {
            echo "Build failed. Check console logs for details."
        }
    }
}
// This Jenkinsfile is designed to build a Java application using Maven, create a Docker image, and run the container.
// It includes stages for cloning the repository, building the application, creating the Docker image, and running the container.
// The pipeline is set to run on any available agent and uses Maven 3.9.3 as the build tool.
// The post section provides feedback on the build status and includes a link to access the application once it's running.
// Make sure to replace <EC2_PUBLIC_IP> with the actual public IP address of your EC2 instance.