FROM bitnami/nginx:1.14
LABEL maintainer "Bitnami <containers@bitnami.com>"

## Install 'vim'
USER 0
RUN install_packages vim

## Modify NGINX config file to include my custom configuration
RUN sed -i -r "s#((\s+)include(\s+)mime.types;)#\1\n\2include\3\"custom/*.conf\";#g" /opt/bitnami/nginx/conf/nginx.conf
RUN ln -sf /custom /opt/bitnami/nginx/conf/custom
VOLUME /custom

## Modify the ports used by NGINX by default
ENV NGINX_HTTP_PORT_NUMBER=8181
EXPOSE 8181 8443

## Modify the default container user
USER 1002
