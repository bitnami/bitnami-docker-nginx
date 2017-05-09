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

RUN mkdir -p /usr/share/nginx && \
    mkdir -p /bitnami/nginx && \
    ln -sf /opt/bitnami/nginx/html/ /usr/share/nginx && \
    ln -sf /bitnami/nginx/ /etc/nginx

COPY root /

EXPOSE 80 443
ENTRYPOINT ["/usr/local/bin/tini", "--", "/run.sh"]
