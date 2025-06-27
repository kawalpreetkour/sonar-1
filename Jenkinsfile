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

        stage('Run Ansible Playbook') {
            steps {
                dir('ansible-role') {
                    sh '''
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

                    echo "✅ Checking Ansible Inventory:"
                    ansible-inventory -i aws_ec2.yaml --graph

                    echo "✅ Pinging Hosts:"
                    ansible -i aws_ec2.yaml tag_sonarqube_sonarqube -m ping || true

                    echo "🚀 Running Playbook:"
                    ansible-playbook -i aws_ec2.yaml SonarQube.yml
                    '''
                }
            }
        }
    }
}
