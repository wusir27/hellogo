#!/bin/sh

exec /opt/hellogo/bin/tcpserver "$@"


#if [ "$(echo $1 | head -c 1)" != "-" ]; then
#  exec "$@"
#else
#  exec /opt/hellogo/bin/tcpserver "$@"
#fi