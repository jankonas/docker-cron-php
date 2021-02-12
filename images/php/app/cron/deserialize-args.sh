#!/usr/bin/env bash
# https://stackoverflow.com/questions/3069163/how-to-serialize-and-deserialize-command-line-arguments-to-from-string

if [ -z "$1" ]; then
    echo "Usage: deserialize data [optional arguments]"
    echo "Example: \"deserialize cXFx_d3d3_0 eee rrr\""
    echo "    will execute \"eee rrr qqq www\""
    exit 1;
fi

DATA="$1"; shift

i=0

for A in ${DATA//_/' '}; do
    if [ "$A" == "0" ]; then 
    break;
    fi              
    if [ "$A" == "1" ]; then 
    A=""
    fi              
    ARR[i++]=`base64 -d <<< "$A"`
done
exec "$@" "${ARR[@]}"
