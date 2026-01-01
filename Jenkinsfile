pipeline {
  agent any
  environment {
    AWS_REGION = 'us-east-1'
    ECR_URI = '263751300182.dkr.ecr.us-east-1.amazonaws.com/my-devops'
  }
  stages {
    stage('Build with Maven') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }
    stage('Docker Build & Push') {
      steps {
        sh '''
          aws ecr get-login-password --region $AWS_REGION | \
          docker login --username AWS --password-stdin $ECR_URI
          docker build -t my-devops:latest .
          docker tag my-devops:latest $ECR_URI:latest
          docker push $ECR_URI:latest
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
