#!/bin/bash
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

cat includes/banner
source includes/versions
source includes/functions.sh

installtask environment
returnwait "System environment" "Package installation"
