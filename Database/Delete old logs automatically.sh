#!/bin/bash

find /var/log -type f -name "*.log" -delete

echo "Logs cleaned"