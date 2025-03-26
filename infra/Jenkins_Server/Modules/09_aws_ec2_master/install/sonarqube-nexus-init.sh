#!/bin/bash

echo "🔄 Cập nhật hệ thống..."
sudo apt update -y && sudo apt upgrade -y

echo "🐳 Cài đặt Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu

#############################
# 📦 Cài đặt Nexus
#############################
echo ""
echo "📦 Bắt đầu cài đặt Nexus Repository Manager..."

echo "📂 Tạo thư mục volume cho Nexus..."
sudo mkdir -p /tools/nexus/data
sudo chown -R 200:200 /tools/nexus

echo "🐳 Kéo và chạy container Nexus..."
sudo docker pull sonatype/nexus3

sudo docker run -d --name nexus \
  --restart=always \
  -p 8081:8081 \
  -v /tools/nexus/data:/nexus-data \
  sonatype/nexus3

echo "⏳ Đợi vài giây để Nexus khởi động..."
sleep 20

echo "✅ Kiểm tra trạng thái container Nexus..."
sudo docker ps -a | grep nexus
echo "🚀 Nexus Repository Manager đang chạy trên cổng 8081!"

#############################
# 🔍 Cài đặt SonarQube
#############################
echo ""
echo "🔍 Bắt đầu cài đặt SonarQube Community Edition..."

echo "📂 Tạo thư mục volume cho SonarQube..."
sudo mkdir -p /tools/sonarqube/data
sudo mkdir -p /tools/sonarqube/logs
sudo mkdir -p /tools/sonarqube/extensions
sudo chown -R 1000:0 /tools/sonarqube

echo "🐳 Kéo và chạy container SonarQube..."
sudo docker pull sonarqube:community

sudo docker run -d --name sonarqube \
  --restart=always \
  -p 9000:9000 \
  -v /tools/sonarqube/data:/opt/sonarqube/data \
  -v /tools/sonarqube/logs:/opt/sonarqube/logs \
  -v /tools/sonarqube/extensions:/opt/sonarqube/extensions \
  sonarqube:community

echo "⏳ Đợi vài giây để SonarQube khởi động..."
sleep 20

echo "✅ Kiểm tra trạng thái container SonarQube..."
sudo docker ps -a | grep sonarqube
echo "🚀 SonarQube Community đang chạy trên cổng 9000!"

echo ""
echo "🎉 Hoàn tất cài đặt Nexus và SonarQube!"
