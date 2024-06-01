#!/bin/bash

sudo apt-get install -y nginx certbot python3-certbot-nginx

sudo ufw allow 'Nginx Full'
sudo rm /etc/nginx/sites-enabled/default

cat <<EOF > /etc/nginx/sites-available/jenkins
server {
  listen 80;
  server_name ${JENKINS_DOMAIN_NAME};

  location / {
    proxy_pass http://localhost:8080;
    proxy_set_header   Host \$host;
    proxy_set_header   X-Real-IP \$remote_addr;
    proxy_set_header   X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Proto \$scheme;
  }
}
EOF

sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
sudo systemctl restart nginx

# Obtain SSL certificate
# Use --staging flag for testing to avoid rate limits
sudo certbot --nginx -d ${JENKINS_DOMAIN_NAME} --non-interactive --agree-tos --email ${CERTBOT_EMAIL} --redirect

sudo systemctl restart jenkins
sudo systemctl status jenkins