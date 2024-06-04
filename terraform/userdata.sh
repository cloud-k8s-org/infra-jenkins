#!/bin/bash

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

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

sudo systemctl restart caddy

sudo systemctl restart jenkins