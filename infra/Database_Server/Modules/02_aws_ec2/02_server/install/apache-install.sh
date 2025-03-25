#! /bin/bash
cd /home/ubuntu
sudo apt update -y
sudo apt install python3 python3-pip -y
git clone https://github.com/VuPlayBoizz/REST_API.git
sleep 50
sudo chown -R ubuntu:ubuntu REST_API/
cd REST_API/Code
sudo apt install python3-venv
# python3 -m venv venv
# source venv/bin/activate
# pip install -r requirements.txt

