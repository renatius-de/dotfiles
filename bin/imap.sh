#!/bin/bash

if [ $# -ne 3 ]; then
    echo "usage: ${0} fromhost tohost passwordfile"
    exit 1
fi

if [ -r ${3} ]; then
    echo "passwordfile must be readable by user"
    exit 2
fi

while read user1 password1 user2 password2; do
    imapsync --subscribe --usecache --syncinternaldates --tmpdir /var/tmp --timeout 30 \
        --host1 ${1} --user1 "${user1}" --password1 "${password1}" --authmech1 PLAIN --ssl1 --delete --expunge1 \
        --host2 ${2} --user2 "${user2}" --password2 "${password2}" --authmech2 PLAIN --ssl2 --delete2duplicates
    sync
done  < ${3}
