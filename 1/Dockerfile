FROM bitnami/minideb-extras:jessie-r14
MAINTAINER Bitnami <containers@bitnami.com>

LABEL io.k8s.kompose="https://raw.githubusercontent.com/sebgoa/bitnami-docker-nginx/master/kubernetes.yml"

ENV BITNAMI_APP_NAME="nginx" \
    BITNAMI_IMAGE_VERSION="1.12.0-r1" \
    NGINX_HTTPS_PORT="443" \
    NGINX_HTTP_PORT="80" \
    PATH="/opt/bitnami/nginx/sbin:$PATH"

RUN install_packages libc6 libpcre3 libssl1.0.0 zlib1g && \
    bitnami-pkg unpack nginx-1.12.0-0 --checksum ff53d1268b5856952a896974b64f22db83e05a3d20e3fb7451253c29f91e6297

# make it compatible with standard locations
RUN mkdir -p /usr/share/nginx && \
    mkdir -p /bitnami/nginx && \
    ln -sf /opt/bitnami/nginx/html/ /usr/share/nginx && \
    ln -sf /bitnami/nginx/ /etc/nginx

# Setup directories and permissions in Docker and not nami for openshift privileges
# need bit more investigation and cleanup
RUN chown -R :daemon /opt/bitnami/nginx/html || true && \
    ln -sf /dev/stdout /opt/bitnami/nginx/logs/access.log && \
    ln -sf /dev/stderr /opt/bitnami/nginx/logs/error.log && \
    mkdir -p /bitnami/nginx/conf && \
    mkdir -p /opt/bitnami/nginx/tmp && \
    chmod 777 -R /bitnami/nginx && \
    chmod 777 -R /opt/bitnami/nginx && \
    chmod 777 /var

COPY rootfs /

# non standard port for Openshift privileges
EXPOSE 8080 8443

# single entrypoint via tini
ENTRYPOINT ["/usr/local/bin/tini", "--", "/run.sh"]
