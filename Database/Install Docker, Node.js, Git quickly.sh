#!/bin/bash

sudo apt update -y

sudo apt install docker.io git curl -y

sudo systemctl start docker
sudo systemctl enable docker

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

sudo apt install nodejs -y

echo "Server setup completed"