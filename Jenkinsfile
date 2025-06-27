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

        // ... other Terraform stages ...

        stage('Run Ansible Playbook') {
            environment {
                PATH = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/ubuntu/.local/bin"
                ANSIBLE_CONFIG = "${env.WORKSPACE}/ansible-role/ansible.cfg"
            }
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

        stage('Output ALB DNS') {
            steps {
                sh 'terraform output alb_dns_name'
            }
        }
    }
}
