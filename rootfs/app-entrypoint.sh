#!/bin/bash
set -e

if [[ "$1" == "harpoon" && "$2" == "start" ]]; then
  status=`harpoon inspect $BITNAMI_APP_NAME`
  if [[ "$status" == *'"lifecycle": "unpacked"'* ]]; then
    harpoon initialize $BITNAMI_APP_NAME
  fi
fi

# HACKS
mkdir -p /bitnami/$BITNAMI_APP_NAME
if [ ! -d /bitnami/$BITNAMI_APP_NAME/conf ]; then
  mkdir -p /opt/bitnami/$BITNAMI_APP_NAME/conf/vhosts
  cp -a /opt/bitnami/$BITNAMI_APP_NAME/conf /bitnami/$BITNAMI_APP_NAME/conf
fi
rm -rf /opt/bitnami/$BITNAMI_APP_NAME/conf
ln -sf /bitnami/$BITNAMI_APP_NAME/conf /opt/bitnami/$BITNAMI_APP_NAME/conf

chown $BITNAMI_APP_USER: /bitnami/$BITNAMI_APP_NAME || true

exec /entrypoint.sh "$@"
