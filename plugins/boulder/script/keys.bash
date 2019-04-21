#!/usr/bin/env bash

input="./conf/agents.conf"
while IFS='' read -r var || [[ -n "$var" ]];
do
    host="$(cut -d'@' -f1 <<<"$var")"
    if [[ "$host" == "nvidia" ]]; then
        cat ./conf/id_ecdsa.pub | sshpass -p baidnncam ssh ${var} "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
    fi
done < "$input"