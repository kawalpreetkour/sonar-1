#!/bin/bash

set -e

# Update and install dependencies
apt update -y
apt install -y openjdk-17-jdk postgresql postgresql-contrib wget unzip gnupg2

# Configure PostgreSQL
sudo -u postgres psql -c "CREATE USER sonar WITH PASSWORD '${sonar_password}';"
sudo -u postgres psql -c "CREATE DATABASE sonarqube OWNER sonar;"

# Download and install SonarQube
cd /opt
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-25.6.0.109173.zip
unzip sonarqube-25.6.0.109173.zip
mv sonarqube-25.6.0.109173 sonarqube

# Create SonarQube user and set permissions
groupadd sonar
useradd -d /opt/sonarqube -g sonar sonar
chown -R sonar:sonar /opt/sonarqube

# Configure sonar.properties
cd /opt/sonarqube/conf
sed -i 's/^#sonar.jdbc.username=.*/sonar.jdbc.username=sonar/' sonar.properties
sed -i 's|^#sonar.jdbc.password=.*|sonar.jdbc.password=${sonar_password}|' sonar.properties
sed -i 's|^#sonar.jdbc.url=.*|sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube|' sonar.properties

# Create systemd service for SonarQube
cat <<EOF > /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable sonarqube
systemctl start sonarqube




