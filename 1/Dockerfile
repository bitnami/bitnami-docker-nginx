FROM bitnami/minideb-extras:jessie-r14
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME="nginx" \
    BITNAMI_IMAGE_VERSION="1.12.0-r1" \
    NGINX_HTTPS_PORT="8443" \
    NGINX_HTTP_PORT="8080" \
    PATH="/opt/bitnami/nginx/sbin:$PATH"

# Install required system packages and dependencies
RUN install_packages libc6 libpcre3 libssl1.0.0 zlib1g

RUN HOME= bitnami-pkg unpack nginx-1.12.0-0 --checksum ff53d1268b5856952a896974b64f22db83e05a3d20e3fb7451253c29f91e6297 && \
  mkdir /bitnami && chmod -R g+rwX /.nami /opt/bitnami/nginx /bitnami

RUN ln -sf /dev/stdout /opt/bitnami/nginx/logs/access.log
RUN ln -sf /dev/stderr /opt/bitnami/nginx/logs/error.log
RUN ln -sf /opt/bitnami/nginx/html /app

COPY rootfs /

# Drop privileges
USER 1001

EXPOSE 8080 8443

WORKDIR /app
ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
