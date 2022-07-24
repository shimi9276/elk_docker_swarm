#! /bin/bash

sudo apt-get update 

sudo apt install docker.io -y  && sudo apt install docker-compose -y

sudo groupadd docker

sudo usermod -aG docker $USER

sudo sysctl -w vm.max_map_count=262144

echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf > /dev/null

sudo mkdir -p -m 777  /usr/share/logstash/config  && sudo cp logstash.conf /usr/share/logstash/config

