#!/bin/bash

PORT=12672
HOSTS=$(cat conf/agents.conf)
for HOST in "${HOSTS[@]}"
do
    curl http://"${HOST##*@}":"$PORT" --connect-timeout 10
done