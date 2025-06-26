pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')
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



        stage('Setup SSH Key') {
            steps {
                withCredentials([sshUserPrivateKey(
                    credentialsId: 'ansiblekey.pem',
                    keyFileVariable: 'KEYFILE',
                    usernameVariable: 'SSH_USER'
                )]) {
                    sh '''
                        mkdir -p ~/.ssh
                        cp $KEYFILE ~/.ssh/ansiblekey.pem
                        chmod 777 ~/.ssh/ansiblekey.pem
                        echo "Host *" > ~/.ssh/config
                        echo "    StrictHostKeyChecking no" >> ~/.ssh/config
                    '''
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                    cd ansible-role
                    ansible-playbook -i aws_ec2.yaml SonarQube.yml
                '''
            }
        }
    }
}
