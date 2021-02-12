#!/usr/bin/env bash
# https://stackoverflow.com/questions/3069163/how-to-serialize-and-deserialize-command-line-arguments-to-from-string

n=$#;
for ((i=0; i<$n; ++i)); do
    if [ -z "$1" ]; then
        echo 1
    else
        printf '%s' "$1" | base64 -w 0
        echo
    fi
    shift
done | tr '\n' '_'
echo -n "0"
