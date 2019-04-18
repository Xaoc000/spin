#!/usr/bin/env bash

NAME=$1
IMAGE_NAME=$2
IMAGE_TAG=$3
USER_ID=$4

iofog-controller catalog add  --name "${NAME}" --arm-image ${IMAGE_NAME}:${IMAGE_TAG} --registry-id 1 --user-id ${USER_ID} --category "some-category"
