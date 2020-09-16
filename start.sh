#!/bin/bash

VERSION=$1

if [ -z "$VERSION" ]
then
    VERSION=`cat default_version`
fi

sudo docker run -p 8000:8000 -v `pwd`/data:/data/ -d \
  > dynamodb_container_id amazon/dynamodb-local -jar DynamoDBLocal.jar \
  -sharedDb -dbPath /data

aws ecr get-login-password --region eu-central-1 | \
  sudo docker login --username AWS --password-stdin \
  358547536439.dkr.ecr.eu-central-1.amazonaws.com 

sudo docker run -p 7000:8000 -v `pwd`/Backend:/app -it \
358547536439.dkr.ecr.eu-central-1.amazonaws.com/hacker-game:$VERSION
