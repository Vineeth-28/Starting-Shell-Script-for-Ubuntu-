#!/bin/bash

git add .

git commit -m "$1"

git push origin main


##Usage:

##./push.sh "updated backend"