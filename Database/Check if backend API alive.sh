#!/bin/bash

STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000)

if [ $STATUS -eq 200 ]
then
  echo "API Healthy"
else
  echo "API Down"
fi