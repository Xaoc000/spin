#!/usr/bin/env bash

SCRIPT=plugins/iofog/script
ANSIBLE=iofog/ansible/scripts

function add() {
    add_boulder=$(curl -X POST \
                  http://${controller_ip}:51121/api/v3/catalog/microservices \
                  -H 'Authorization: ${auth_token}' \
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
                }')

    add_web=$(curl -X POST \
                  http://${controller_ip}:51121/api/v3/catalog/microservices \
                  -H 'Authorization: ${auth_token}' \
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
                }')
}

controller_ip=$("$SCRIPT"/wait-for-lb.bash iofog controller)
"$SCRIPT"/wait-for-pods.bash kube-system
add
