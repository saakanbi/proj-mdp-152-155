pipeline {
    agent any

    tools {
        maven 'Maven 3.9.3' // Make sure Jenkins is configured with this Maven version
    }

    environment {
        DOCKER_IMAGE = 'wole9548/calculator-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-creds'      // Docker Hub username/password credential
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-prod'   // Secret file credential with kubeconfig
    }

    triggers {
        pollSCM('H/2 * * * *') // Poll Git every 2 minutes for changes
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'project-3', url: 'https://github.com/saakanbi/proj-mdp-152-155.git'
            }
        }

        stage('Build WAR with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image("${DOCKER_IMAGE}:${BUILD_ID}").push()
                        docker.image("${DOCKER_IMAGE}:${BUILD_ID}").tag("latest")
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG_FILE')]) {
                    withEnv(["KUBECONFIG=${KUBECONFIG_FILE}"]) {
                        sh '''
                            echo "🛠 Deploying to Kubernetes Cluster..."
                            kubectl apply -f k8s/deployment.yaml
                            kubectl apply -f k8s/service.yaml
                            kubectl rollout status deployment/calculator-app
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment completed successfully."
        }
        failure {
            echo "❌ Build or deployment failed. Check the pipeline logs for details."
        }
    }
}
