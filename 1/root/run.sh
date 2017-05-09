#!/bin/bash

echo "----"
echo "BITNAMI nginx container, source available at https://github.com/bitnami/bitnami-docker-nginx"
echo "This container is configured by NAMI an open source tool available at https://github.com/bitnami/nami"
echo "Join us on SLACK: http://slack.oss.bitnami.com
echo "----"

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

chown -R :daemon /opt/bitnami/nginx/html || true

# redirect nginx logs to stdout/stderr
ln -sf /dev/stdout /opt/bitnami/nginx/logs/access.log
ln -sf /dev/stderr /opt/bitnami/nginx/logs/error.log

info "Starting ${DAEMON}..."

${EXEC} ${ARGS} -g 'daemon off;'
