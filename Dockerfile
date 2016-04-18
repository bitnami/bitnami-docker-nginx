FROM gcr.io/stacksmith-images/ubuntu:14.04-r05
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=nginx \
    BITNAMI_APP_CHECKSUM=15565d06b18c2e3710fc08e579ddb3d0e39aa663264a0f7404f0743cb4cdb58d \
    BITNAMI_APP_VERSION=1.9.10-0 \
    BITNAMI_APP_USER=daemon

# Install application
RUN bitnami-pkg unpack $BITNAMI_APP_NAME-$BITNAMI_APP_VERSION --checksum $BITNAMI_APP_CHECKSUM
ENV PATH=/opt/bitnami/$BITNAMI_APP_NAME/sbin:/opt/bitnami/$BITNAMI_APP_NAME/bin:$PATH

# Setting entry point
COPY rootfs/ /
ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["harpoon", "start", "--foreground", "nginx"]

# Exposing ports
EXPOSE 80 443
