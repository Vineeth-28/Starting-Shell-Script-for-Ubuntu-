#!/bin/bash

DATE=$(date +%F)

tar -czvf backup-$DATE.tar.gz /home/ubuntu/app

echo "Backup completed"