#!/bin/bash

cat << EOF > ~/.regctl/config.json
{"hosts":{"$REGISTRY":{"user":"$REGISTRY_USERNAME","pass":"$REGISTRY_PASSWORD"}}}
EOF

set -eu

IFS=', ' read -r -a PREFIX <<< "$PREFIX"

checkprefix(){
    MATCHES=0
    for i in ${PREFIX[@]}; do
        if [[ $line == $i ]]; 
        then {
            MATCHES=1
        }
        fi
    done
    return $MATCHES
}

removetags() {
    echo removing $REGISTRY/$REGISTRY_REPO:$line
    regctl tag delete $REGISTRY/$REGISTRY_REPO:$line
}

regctl tag ls $REGISTRY/$REGISTRY_REPO | while read line ; do checkprefix && removetags; done

exit 0