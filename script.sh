#!/bin/bash
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

cat <<'EOF'>/home/dockerroot/prometheus.yml
global:
  scrape_interval:     10s
  evaluation_interval: 10s
rule_files:
  # - "first.rule"
  # - "second.rule"
scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets: ['localhost:9090']
EOF

sudo docker run -d -p 9090:9090 -v /home/dockerroot/prometheus.yml:/etc/prometheus/prometheus.yml --name=prometheus prom/prometheus
#sudo docker run -d --name prometheus-container -e TZ=CET -p 30090:9090 ubuntu/prometheus:2.33-22.04_beta
sudo docker run -d --name grafana-container -e TZ=CET -p 3000:3000 grafana/grafana-oss