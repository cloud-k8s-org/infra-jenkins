#!/bin/bash

sudo usermod -a -G docker jenkins

cat <<EOF > /etc/jenkins.env
    DOCKER_USERNAME=${DOCKER_USERNAME}
    DOCKER_PASSWORD=${DOCKER_PASSWORD}
    JENKINS_USERNAME=${JENKINS_USERNAME}
    JENKINS_PASSWORD=${JENKINS_PASSWORD}
    GIT_USERNAME=${GIT_USERNAME}
    GIT_PASSWORD=${GIT_PASSWORD}
EOF

sudo rm /etc/caddy/Caddyfile

cat <<EOF > /etc/caddy/Caddyfile
{
    acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
}
${JENKINS_DOMAIN_NAME} {
  reverse_proxy localhost:8080 {
    header_up Host {host}
    header_up X-Real-IP {remote}
    header_up X-Forwarded-For {remote}
    header_up X-Forwarded-Proto {scheme}
  }
}
EOF

sudo mkdir -p /var/lib/jenkins/init.groovy.d
sudo mkdir -p /var/lib/jenkins/dsl_scripts

sudo cp -r /home/ubuntu/jenkins_init/. /var/lib/jenkins/init.groovy.d/
sudo cp -r /home/ubuntu/jenkins_dsl/. /var/lib/jenkins/dsl_scripts/

sudo systemctl enable jenkins

sudo systemctl restart caddy

sudo systemctl restart jenkins