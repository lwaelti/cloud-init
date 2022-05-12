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
  # - "first.rules"
  # - "second.rules"
scrape_configs:
  - job_name: nodeexporter01
    static_configs:
      - targets: ['192.168.66.237:9100']
  - job_name: nodeexporter02
    static_configs:
      - targets: ['192.168.66.231:9100']
  - job_name: nodeexporter03
    static_configs:
      - targets: ['192.168.66.234']
EOF

sudo docker run -d -p 9090:9090 -v /home/dockerroot/prometheus.yml:/etc/prometheus/prometheus.yml --name=prometheus prom/prometheus

sudo docker run -d --name grafana-container -e TZ=CET -p 3000:3000 grafana/grafana-oss