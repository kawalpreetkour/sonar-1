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
        sh '''
        rm -rf .terraform
        rm -f terraform.lock.hcl
        terraform init -upgrade
        '''
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

stage('Install Ansible & Boto') {
    when {
        expression { return params.INSTALL_DEPENDENCIES == true }
    }
    steps {
        sh '''
        apt-get update
        apt-get install -y python3-pip
        pip3 install ansible boto boto3 botocore
        ansible-galaxy collection install amazon.aws
        '''
    }
}


        stage('Run Ansible Playbook') {
            steps {
                dir('ansible-role') {
                    sh '''
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                    ANSIBLE_CONFIG=ansible.cfg ansible-playbook SonarQube.yml
                    '''
                }
            }
        }
    }
}
