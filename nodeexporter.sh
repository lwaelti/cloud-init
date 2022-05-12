#!/bin/bash

wget https://github.com/prometheus/node_exporter/releases/download/v*/node_exporter-*.*-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
cd node_exporter-*.*-amd64
./node_exporter

chown root:staff node_exporter

cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Prometheus node exporter
After=local-fs.target network-online.target network.target
Wants=local-fs.target network-online.target network.target
[Service]
Type=simple
ExecStartPre=-/sbin/iptables -I INPUT 1 -p tcp --dport 9100 -s 127.0.0.1 -j ACCEPT
ExecStartPre=-/sbin/iptables -I INPUT 3 -p tcp --dport 9100 -j DROP
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target
EOF

systemctl enable node_exporter.service
systemctl start node_exporter.service

echo "SUCCESS! Installation succeeded!"