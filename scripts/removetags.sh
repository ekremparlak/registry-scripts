#!/bin/bash

cat << EOF > ~/.regctl/config.json
{"hosts":{"$REGISTRY":{"user":"$REGISTRY_USER","pass":"$REGISTRY_PASSWORD"}}}
EOF

set -eu

IFS=', ' read -r -a PREFIX <<< "$PREFIX"

checkprefix(){
    for i in ${PREFIX[@]}; do
        if [[ $line == $i ]]; 
        then {
            removetags
            return 0
        }
        fi
    done
    return 0
}

removetags() {
    echo removing $REGISTRY/$REGISTRY_REPO:$line
    regctl tag delete $REGISTRY/$REGISTRY_REPO:$line
}

regctl tag ls $REGISTRY/$REGISTRY_REPO | while read line ; do checkprefix; done

exit 0