pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')
        ANSIBLE_KEY            = credentials('ansiblekey.pem')   
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
                sh '''
                terraform plan \
                -var="access_key=$AWS_ACCESS_KEY_ID" \
                -var="secret_key=$AWS_SECRET_ACCESS_KEY" \
                -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        // ✅ New stage to run Ansible
        stage('Run Ansible to Setup SonarQube') {
            steps {
                sh '''
                mkdir -p ~/.ssh
                echo "$ANSIBLE_KEY" > ~/.ssh/ansiblekey.pem
                chmod 400 ~/.ssh/ansiblekey.pem

                cd ansible-role
                ansible-playbook -i aws_ec2.yaml SonarQube.yml
                '''
            }
        }
    }
}
