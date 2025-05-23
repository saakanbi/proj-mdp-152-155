pipeline {
    agent any

    tools {
        maven 'Maven 3.9.3'
    }

    environment {
        DOCKER_IMAGE = 'wole9548/calculator-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-creds'
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-prod'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'project-3', url: 'https://github.com/saakanbi/proj-mdp-152-155.git'
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

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: "${KUBECONFIG_CREDENTIALS_ID}", variable: 'KUBECONFIG')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG
                        sed -i "s|IMAGE_PLACEHOLDER|${DOCKER_IMAGE}:${BUILD_ID}|" k8s/deployment.yaml
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and Deployment Successful! Image: ${DOCKER_IMAGE}:${BUILD_ID}"
        }
        failure {
            echo "❌ Build or Deployment Failed. Check logs for details."
        }
    }
}
