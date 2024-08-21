pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = 'hitikyala/dev'
        DOCKER_PROD_REPO = 'hitikyala/prod'
        IMAGE_TAG = "latest"
        GIT_REPO = 'https://github.com/Hitikyala/devops-build.git'
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull the latest code from the repository
                git branch: "dev", url: "https://github.com/Hitikyala/devops-build"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                    docker build -t ${DOCKER_DEV_REPO}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    docker login -u $DOCKER_USER -p $DOCKER_PASS
                    docker push ${DOCKER_DEV_REPO}:${IMAGE_TAG}
                    """
                  }  
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                script {
                    sh './deploy.sh'
                   }
                }
            }
	}

    post {
        always {
            sh 'docker system prune -f'
        }
    }
}
