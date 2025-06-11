pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/sagarmalasiii/Jenkins_ec2_deploy', branch: 'main'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                
                sh 'terraform apply --auto-approve'
            }
        }
    }

    post {
        success {
            echo '✅ ASG deployment successful!'
        }
        failure {
            echo '❌ Deployment failed.'
        }
    }
}
