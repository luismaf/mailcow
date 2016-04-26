#!/bin/bash
service dovecot stop
service postfix stop
service jetty stop
service jetty8 stop
service apache2 stop
service nginx stop
source install.sh