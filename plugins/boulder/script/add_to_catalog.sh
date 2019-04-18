#!/usr/bin/env bash

USER_ID=$1

iofog-controller catalog add  --name "BoulderAI" --arm-image edgeworx/boulderai:latest --registry-id 1 --user-id ${USER_ID} --category "some-category"

iofog-controller catalog add  --name "WebService" --arm-image edgeworx/webservice:latest --registry-id 1 --user-id ${USER_ID} --category "some-category"