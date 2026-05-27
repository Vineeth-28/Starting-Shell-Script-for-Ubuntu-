#!/bin/bash

docker system prune -af
docker volume prune -f

echo "Docker cleanup completed"