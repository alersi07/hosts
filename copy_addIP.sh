#!/bin/bash

cat /etc/hosts | while read ip name rest
do
    if [[ "$ip" == "" || "$ip" =~ ^# ]]; then
        continue
    fi
    addIP=$(nslookup "$name" 2>/dev/null | awk '/^Address:/ { if(s) print $2; s=1 }')
    if [[ "$addIP" != "" && "$addIP" != "$ip" ]]; then
        echo "Bogus IP for $name in /etc/hosts!"
    fi
done 
