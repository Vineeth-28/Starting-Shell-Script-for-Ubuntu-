# Starting-Shell-Script-for-Ubuntu-

#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "[-] Please run as root (use sudo)."
  exit 1
fi

echo "[+] Starting essential server setup..."

# 1. Update and Upgrade System
echo "[+] Updating package list and upgrading system..."
apt update -y && apt upgrade -y

# 2. Set Timezone (e.g., Asia/Kolkata)
echo "[+] Setting timezone to Asia/Kolkata..."
timedatectl set-timezone Asia/Kolkata

# 3. Install Essential CLI Utilities
echo "[+] Installing essential utilities..."
apt install -y \
    curl \
    wget \
    git \
    unzip \
    zip \
    ufw \
    htop \
    tree \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    gnupg2

# 4. Install AWS CLI v2
echo "[+] Installing AWS CLI v2..."
curl "https://amazonaws.com" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip

# 5. Install Docker (Community Edition)
echo "[+] Installing Docker..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://docker.com | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://docker.com \
"$(. /etc/apt/release-codename 2>/dev/null || echo ubuntu)" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update -y
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl start docker
systemctl enable docker

# 6. Basic Firewall Configuration (UFW)
echo "[+] Configuring basic UFW firewall rules..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable

echo "[+] Setup complete! Please log out and log back in to apply all group changes."
