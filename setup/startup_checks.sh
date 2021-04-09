#!/bin/bash

#Check for an invalid ProxSpace path
if ! (echo "$PWD" | grep -Eq  ^[a-zA-Z0-9\/\._\-]+$) ; then
    echo "Error: Install path contains special characters!"
	sleep infinity 
fi

#Using git to download ProxSpace will cause an installation error
if [ -d "$PWD/.git" ]; then
    echo "Error: Do not use Git to download ProxSpace!"
    sleep infinity 
fi