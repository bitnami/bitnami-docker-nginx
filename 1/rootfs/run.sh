#!/bin/bash

echo "----"
echo "BITNAMI nginx container, source available at https://github.com/bitnami/bitnami-docker-nginx"
echo "This container is configured by NAMI an open source tool available at https://github.com/bitnami/nami"
echo "Join us on SLACK: http://slack.oss.bitnami.com"
echo "----"

# keeping this remove the functions and helpers sourcing
# pretty message
RESET='\033[0m'
GREEN='\033[38;5;2m'

log() {
  echo -e "${RESET}${@}" >&2
}

info() {
  log "${GREEN}INFO ${RESET} ==> ${@}"
}

DAEMON=nginx
EXEC=$(which $DAEMON)
ARGS=

nami initialize nginx --inputs-file=/nginx-inputs.json
info "Starting nginx... "

# able to modify config and then build container, otherwise config gets overwritten
# need to check proper use of volumes

cp /nginx.conf /opt/bitnami/nginx/conf/nginx.conf

info "Starting ${DAEMON}..."

# daemon off moved to config
${EXEC} ${ARGS}
