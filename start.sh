#!/bin/sh
# tshock startup script
set -e
#copy plugins over
[ "$(ls -A /plugins)" ] && cp -f /plugins/* /tshock/ServerPlugins
ls -lA
exec mono --server --gc=sgen -O=all TerrariaServer.exe -configpath /config -worldpath /world -logpath /logs "$@"