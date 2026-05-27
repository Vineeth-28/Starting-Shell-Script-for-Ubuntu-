#!/bin/bash

PORT=$1

kill -9 $(lsof -t -i:$PORT)

echo "Port $PORT killed"


##Usage:

##./kill-port.sh 8000