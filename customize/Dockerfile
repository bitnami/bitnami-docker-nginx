FROM bitnami/nginx:1.14
LABEL maintainer "Bitnami <containers@bitnami.com>"

## Install 'vim'
USER 0
RUN install_packages vim

## Modify 'worker_connections' on NGINX config file to '512'
RUN sed -i -r "s#(\s+)worker_connections(\s+)[0-9]+;#\1worker_connections\2512;#g" /opt/bitnami/nginx/conf/nginx.conf

## Modify the ports used by NGINX by default
ENV NGINX_HTTP_PORT_NUMBER=8181
EXPOSE 8181 8443

## Modify the default container user
USER 1002
