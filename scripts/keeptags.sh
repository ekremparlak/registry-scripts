#!/bin/bash

cat << EOF > ~/.regctl/config.json
{"hosts":{"$REGISTRY":{"user":"$REGISTRY_USER","pass":"$REGISTRY_PASSWORD"}}}
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
    echo removing $REGISTRY/$REPO:$line
    regctl tag delete $REGISTRY/$REPO:$line
}

regctl tag ls $REGISTRY/$REPO | while read line ; do checkprefix && removetags; done

exit 0