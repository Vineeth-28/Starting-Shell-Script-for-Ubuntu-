# Create the docker group (usually already exists)
sudo groupadd docker

# Add the ubuntu user to the docker group
sudo usermod -aG docker ubuntu

# Apply the new group changes immediately
newgrp docker
