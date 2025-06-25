pipeline {
    agent any

    environment {
        TF_VAR_access_key       = credentials('AWS_ACCESS_KEY')
        TF_VAR_secret_key       = credentials('AWS_SECRET_KEY')
        TF_VAR_ansible_key_path = '/var/lib/jenkins/.ssh/ansiblekey.pem'
    }

    stages {
        stage('Clone Terraform Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/kawalpreetkour/sonarqube-infra.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}
