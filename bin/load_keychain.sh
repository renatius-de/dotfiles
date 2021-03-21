#!/bin/bash

if ! $(which keychain > /dev/null 2>&1); then
    echo "please install keychain"
    exit 1
fi

declare -a ssh_keys_pub=( ~/.ssh/*.pub )
declare -a ssh_keys

j=0
for i in "${ssh_keys_pub[@]}"; do
    ssh_keys[$j]=$(basename ${i%%.pub})
    ((j++))
done

keychain --clear --timeout 10080  "${ssh_keys[@]}" F91E87BC

# vim: foldmethod=marker textwidth=80 filetype=sh
