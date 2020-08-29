#!/bin/bash

VERSION=$1

if [ -z "$VERSION" ]
then
    VERSION=`cat default_version`
fi

git clone git@github.com:KT-dreams/IaC.git
git clone git@github.com:KT-dreams/Backend.git

mkdir data
sudo chmod 664 data
sudo docker run -p 8000:8000 -v `pwd`/data:/data/ -d \
  amazon/dynamodb-local -jar DynamoDBLocal.jar \
  -sharedDb -dbPath /data

mv Backend/.example.env Backend/.env

BASE_PATH=`pwd`

cd IaC
. scripts/install.sh

cd Terraform/AWS/dynamodb-local/eu-central-1/hacker_game && \
terragrunt apply -auto-approve

aws ecr get-login-password --region eu-central-1 | \
  sudo docker login --username AWS --password-stdin \
  358547536439.dkr.ecr.eu-central-1.amazonaws.com 

sudo docker run -p 7000:8000 -v $BASE_PATH/Backend:/app -it \
358547536439.dkr.ecr.eu-central-1.amazonaws.com/hacker-game:$VERSION
