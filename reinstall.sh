#!/bin/bash
service dovecot stop
service postfix stop
service apache2 stop
service nginx stop
source install.sh