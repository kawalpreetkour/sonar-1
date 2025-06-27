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
