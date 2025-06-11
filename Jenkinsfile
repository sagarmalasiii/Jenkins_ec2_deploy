pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/sagarmalasiii/Jenkins_ec2_deploy.git', branch: 'main'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws_access_key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws_secret_key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh 'terraform init'
                }
            }
        }
        stage('Debug env vars') {
    steps {
        withCredentials([
            string(credentialsId: 'aws_access_key', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws_secret_key', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
            sh '''
            echo "AWS_ACCESS_KEY_ID length: ${#AWS_ACCESS_KEY_ID}"
            echo "AWS_SECRET_ACCESS_KEY length: ${#AWS_SECRET_ACCESS_KEY}"
            '''
        }
    }
}
stage('AWS CLI test') {
    steps {
        withCredentials([
            string(credentialsId: 'aws_access_key', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws_secret_key', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
            sh 'aws sts get-caller-identity'
        }
    }
}



        stage('Terraform Plan') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws_access_key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws_secret_key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws_access_key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws_secret_key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    input message: "Approve EC2 deployment?"
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo '✅ EC2 deployed successfully!'
        }
        failure {
            echo '❌ Deployment failed.'
        }
    }
}
