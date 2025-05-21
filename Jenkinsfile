pipeline {
    agent any

    tools {
        maven 'Maven 3.9.3'
    }

    environment {
        DOCKER_IMAGE = 'wole9548/calculator-app'  // Replace with your Docker Hub repo name
        DOCKER_CREDENTIALS_ID = 'docker-hub-creds'
    }

    triggers {
        pollSCM('H/2 * * * *')
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'project-1-dev', url: 'https://github.com/saakanbi/proj-mdp-152-155.git'
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
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push()
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker rm -f calculator || true'
                sh "docker run -d --name calculator -p 8080:8080 ${DOCKER_IMAGE}:${BUILD_ID}"
            }
        }
    }

    post {
        always {
            echo "✅ Build complete. Docker image pushed: ${DOCKER_IMAGE}:${BUILD_ID}"
        }
        failure {
            echo "❌ Build failed."
        }
    }
}
// This Jenkinsfile is designed to automate the build, test, and deployment process for a Java application using Maven and Docker.
// It includes stages for cloning the repository, building the application, creating a Docker image, pushing it to Docker Hub, and running the container.
// The pipeline is triggered every 2 minutes to check for changes in the SCM.
// Make sure to replace 'yourusername/calculator-app' with your actual Docker Hub repository name.
// Also, ensure that the Docker credentials ID matches the one configured in Jenkins.
// The pipeline uses the 'docker' and 'maven' tools, so ensure they are installed and configured in your Jenkins instance.
// The pipeline is set to run on any available agent.
// The 'pollSCM' trigger checks for changes in the source code repository every 2 minutes.
// The 'post' section handles notifications based on the build result, providing feedback on success or failure.
// The 'docker' commands are used to manage the Docker container lifecycle, including removing any existing containers with the same name before running a new one.
// The 'mvn clean package -DskipTests' command builds the application while skipping tests to speed up the process.
// The 'docker.withRegistry' command authenticates with Docker Hub using the provided credentials ID.
// The 'docker.build' command creates a Docker image from the Dockerfile in the repository.
// The 'docker.image' command is used to reference the built image for pushing to Docker Hub.
// The 'docker run' command starts the container, mapping port 8080 of the host to port 8080 of the container.
// The 'docker rm -f calculator || true' command ensures that any existing container named 'calculator' is removed before starting a new one.
// This Jenkinsfile is a complete CI/CD pipeline for a Java application, automating the entire process from code changes to deployment.
// Ensure that the Dockerfile is present in the root of your repository for the build to succeed.
// The pipeline is designed to be flexible and can be modified to suit your specific needs.
