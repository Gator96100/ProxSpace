#!/bin/bash

#Check for an invalid ProxSpace path
if ! (echo "$PWD" | grep -Eq  ^[a-zA-Z0-9\/\._\-]+$) ; then
    echo "Error: Install path contains special characters!"
	sleep infinity 
fi
