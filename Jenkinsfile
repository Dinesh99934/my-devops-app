pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO   = '263751300182.dkr.ecr.us-east-1.amazonaws.com/my-devops'
        BUILD_TAG  = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Build with Maven') {
            steps { sh 'mvn clean package -DskipTests' }
        }
        stage('Docker Build & Push') {
            steps {
                sh '''
                  aws ecr get-login-password --region $AWS_REGION | \
                  docker login --username AWS --password-stdin $ECR_REPO
                  docker build -t my-app:$BUILD_TAG .
                  docker tag my-app:$BUILD_TAG $ECR_REPO:$BUILD_TAG
                  docker push $ECR_REPO:$BUILD_TAG
                '''
            }
        }
        stage('Deploy with Ansible') {
            steps {
                sh 'ansible-playbook ansible/deploy.yml'
            }
        }
    }
}
