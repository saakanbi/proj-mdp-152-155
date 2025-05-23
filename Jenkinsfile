pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'wole9548/calculator-app:5'  // Replace with the correct tag
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-prod'
    }

    stages {
        stage('Pull Docker Image') {
            steps {
                echo "✅ Skipping build. Pulling image: ${DOCKER_IMAGE}"
                sh "docker pull ${DOCKER_IMAGE}"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: "${KUBECONFIG_CREDENTIALS_ID}", variable: 'KUBECONFIG')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful!"
        }
        failure {
            echo "❌ Deployment failed. Check logs for details."
        }
    }
}
