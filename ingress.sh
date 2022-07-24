#! /bin/bash

yes | sudo docker network rm ingress 

sleep 1

sudo docker network create --driver overlay --ingress --subnet=10.255.255.0/24 ingress

sudo systemctl restart docker