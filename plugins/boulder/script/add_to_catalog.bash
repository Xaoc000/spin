#!/usr/bin/env bash

set -e

USER_ID=$1

BOULDER=$(iofog-controller catalog add  --name "BoulderAI" --arm-image edgeworx/boulderai:latest --registry-id 1 --user-id ${USER_ID} --category "some-category" | grep "id" | awk '{print $2}')
export BOULDER ${BOULDER}

WEB=$(iofog-controller catalog add  --name "WebService" --arm-image edgeworx/webservice:latest --registry-id 1 --user-id ${USER_ID} --category "some-category" | grep "id" | awk '{print $2}')
export WEB ${WEB}

CATALOG_IDS=( ${BOULDER} ${WEB} )