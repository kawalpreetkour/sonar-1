# Add Ansible SSH Key
cat <<"EOF" > /home/ubuntu/ansiblekey.pem
${ansible_key}
EOF

chmod 400 /home/ubuntu/ansiblekey.pem
chown ubuntu:ubuntu /home/ubuntu/ansiblekey.pem
