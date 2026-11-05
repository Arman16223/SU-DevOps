pipeline {
    agent any

    environment {
        IMAGE_NAME = 'library-management-platform'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv .venv-ci
                    .venv-ci/bin/pip install --no-cache-dir -r requirements.txt
                '''
            }
        }

        stage('Code Quality') {
            steps {
                sh '.venv-ci/bin/flake8 app database tests run.py'
            }
        }

        stage('Run Tests') {
            steps {
                sh '.venv-ci/bin/pytest -q'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_TOKEN'
                )]) {
                    sh '''
                        set -eu
                        IMAGE="$DOCKER_USER/$IMAGE_NAME"
                        docker build -t "$IMAGE:$BUILD_NUMBER" -t "$IMAGE:latest" .
                        echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push "$IMAGE:$BUILD_NUMBER"
                        docker push "$IMAGE:latest"
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_TOKEN'
                )]) {
                    sh '''
                        set -eu
                        IMAGE="$DOCKER_USER/$IMAGE_NAME"
                        kubectl set image deployment/smart-library library-app="$IMAGE:$BUILD_NUMBER"
                        kubectl rollout status deployment/smart-library --timeout=180s
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get deployments,pods,services'
            }
        }
    }

    post {
        success {
            echo 'CI/CD pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the failed stage logs.'
        }
        always {
            sh 'docker logout >/dev/null 2>&1 || true'
        }
    }
}
