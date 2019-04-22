#!/usr/bin/env bash

"$SCRIPT"/wait-for-pods.bash kube-system iofog

SCRIPT=plugins/iofog/script
ANSIBLE=iofog/ansible/scripts

function add() {
    curl -X POST \
      http://${controller_ip}:51121/api/v3/catalog/microservices \
      -H 'Authorization: ${TOKEN}' \
      -H 'Content-Type: application/json' \
      -d '{
      "name": "iofog-video",
      "category": "some-category",
      "images": [
        {
          "containerImage": "edgeworx/iofog-video:latest",
          "fogTypeId": 1
        },
        {
          "containerImage": "edgeworx/iofog-video:latest",
          "fogTypeId": 2
        }
      ],
    "registryId": 1
    }'

    curl -X POST \
      http://${controller_ip}:51121/api/v3/catalog/microservices \
      -H 'Authorization: ${TOKEN}' \
      -H 'Content-Type: application/json' \
      -d '{
      "name": "iofog-web",
      "category": "some-category",
      "images": [
        {
          "containerImage": "edgeworx/iofog-video-web:latest",
          "fogTypeId": 1
        },
        {
          "containerImage": "edgeworx/iofog-video-web:latest",
          "fogTypeId": 2
        }
      ],
    "registryId": 1
    }'
}

controller_ip=$("$SCRIPT"/wait-for-lb.bash iofog controller)

# Get Auth Token
#AUTH_RESULT=$(curl --request POST \
#--url http://"${controller_ip}":51121/api/v3/user/login \
#--header 'Content-Type: application/json' \
#--data '{"email":"user@domain.com","password":"#Bugs4Fun"}')
#echo "$AUTH_RESULT"

AUTH_RESULT=$(curl -X POST \
  http://${controller_ip}:51121/api/v3/user/login \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 42dc323d-6b73-5d43-577c-2c02028e35d2' \
  -d '{
  "email": "user@domain.com",
  "password": "#Bugs4Fun"
}')

echo $AUTH_RESULT

TOKEN=$(echo $AUTH_RESULT | jq -r .accessToken)

echo $FLOW

add
