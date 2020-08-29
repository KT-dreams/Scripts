#!/bin/bash

sudo docker kill `cat dynamodb_container_id`
sudo docker rm `cat dynamodb_container_id`

rm dynamodb_container_id
