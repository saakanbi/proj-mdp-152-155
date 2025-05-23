pipeline {
    agent any

    tools {
<<<<<<< HEAD
        maven 'Maven 3.9.3' // Make sure Jenkins is configured with this Maven version
=======
        maven 'Maven 3.9.3'
>>>>>>> f0d1cd1d593958fd869a3d2535dfc5da8946d052
    }

    environment {
        DOCKER_IMAGE = 'wole9548/calculator-app'
<<<<<<< HEAD
        DOCKER_CREDENTIALS_ID = 'docker-hub-creds'      // Docker Hub username/password credential
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-prod'   // Secret file credential with kubeconfig
    }

    triggers {
        pollSCM('H/2 * * * *') // Poll Git every 2 minutes for changes
    }

    stages {
        stage('Clone Repository') {
=======
        DOCKER_CREDENTIALS_ID = 'docker-hub-creds'
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-prod'
    }

    stages {
        stage('Clone Repo') {
>>>>>>> f0d1cd1d593958fd869a3d2535dfc5da8946d052
            steps {
                git branch: 'project-3', url: 'https://github.com/saakanbi/proj-mdp-152-155.git'
            }
        }

<<<<<<< HEAD
        stage('Build WAR with Maven') {
=======
        stage('Build with Maven') {
>>>>>>> f0d1cd1d593958fd869a3d2535dfc5da8946d052
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
<<<<<<< HEAD
                    docker.build("${DOCKER_IMAGE}:${BUILD_ID}")
=======
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
>>>>>>> f0d1cd1d593958fd869a3d2535dfc5da8946d052
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
<<<<<<< HEAD
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image("${DOCKER_IMAGE}:${BUILD_ID}").push()
                        docker.image("${DOCKER_IMAGE}:${BUILD_ID}").tag("latest")
                        docker.image("${DOCKER_IMAGE}:latest").push()
=======
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push()
>>>>>>> f0d1cd1d593958fd869a3d2535dfc5da8946d052
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
<<<<<<< HEAD
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG_FILE')]) {
                    withEnv(["KUBECONFIG=${KUBECONFIG_FILE}"]) {
                        sh '''
                            echo "🛠 Deploying to Kubernetes Cluster..."
                            kubectl apply -f k8s/deployment.yaml
                            kubectl apply -f k8s/service.yaml
                            kubectl rollout status deployment/calculator-app
                        '''
                    }
=======
                withCredentials([file(credentialsId: "${KUBECONFIG_CREDENTIALS_ID}", variable: 'KUBECONFIG')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG
                        sed -i "s|IMAGE_PLACEHOLDER|${DOCKER_IMAGE}:${BUILD_ID}|" k8s/deployment.yaml
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                    '''
>>>>>>> f0d1cd1d593958fd869a3d2535dfc5da8946d052
                }
            }
        }
    }

    post {
        success {
<<<<<<< HEAD
            echo "✅ Build and deployment completed successfully."
        }
        failure {
            echo "❌ Build or deployment failed. Check the pipeline logs for details."
=======
            echo "✅ Build and Deployment Successful! Image: ${DOCKER_IMAGE}:${BUILD_ID}"
        }
        failure {
            echo "❌ Build or Deployment Failed. Check logs for details."
>>>>>>> f0d1cd1d593958fd869a3d2535dfc5da8946d052
        }
    }
}
