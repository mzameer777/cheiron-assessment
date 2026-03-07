#!/bin/bash

# Update and install Docker
apt-get update -y
apt-get install -y docker.io docker-compose-v2 awscli curl
systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Authenticate to ECR
aws ecr get-login-password --region ${aws_region} | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com

# Create docker-compose file
mkdir -p /home/ubuntu/app
cat > /home/ubuntu/app/docker-compose.yml <<'COMPOSE'
version: "3.8"

services:
  service-a:
    image: ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com/service-a:latest
    container_name: service-a
    ports:
      - "8080:5000"
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s

  service-b:
    image: ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com/service-b:latest
    container_name: service-b
    ports:
      - "8081:5001"
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5001/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s
COMPOSE

chown -R ubuntu:ubuntu /home/ubuntu/app

# Pull images and start services
cd /home/ubuntu/app
docker compose pull
docker compose up -d
