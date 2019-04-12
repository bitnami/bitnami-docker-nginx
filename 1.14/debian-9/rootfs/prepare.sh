#!/bin/bash

# shellcheck disable=SC1091

# Load libraries
. /libfs.sh
. /libnginx.sh

# Load NGINX environment variables
eval "$(nginx_env)"

# Ensure non-root user has write permissions on a set of directories
for dir in "/bitnami" "$NGINX_VOLUME" "${NGINX_CONFDIR}/conf.d/server_blocks" "${NGINX_CONFDIR}/bitnami" "$NGINX_BASEDIR" "$NGINX_TMPDIR"; do
    ensure_dir_exists "$dir"
done
chmod -R g+rwX "$NGINX_VOLUME" "$NGINX_CONFDIR" "$NGINX_TMPDIR"
# Create NGINX default configuration
nginx_default_config
# Unset HTTP_PROXY header to protect vs HTTPPOXY vulnerability
nginx_patch_httpoxy_vulnerability
# Prepare directories for users to mount its static files and certificates
nginx_prepare_directories
# Redirect all logging to stdout/stderr
ln -sf /dev/stdout "$NGINX_LOGDIR/access.log"
ln -sf /dev/stderr "$NGINX_LOGDIR/error.log"
