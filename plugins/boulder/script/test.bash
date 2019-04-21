#!/bin/bash

plugins/weather/script/wait-for-pods.bash iofog app=boulder-demo
PORT=12672
HOSTS=$(cat conf/agents.conf)
for HOST in "${HOSTS[@]}"
do
    curl http://"${HOST##*@}":"$PORT" --connect-timeout 10
done