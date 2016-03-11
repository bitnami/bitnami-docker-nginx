FROM gcr.io/stacksmith-images/ubuntu:14.04
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=nginx \
    BITNAMI_APP_USER=daemon \
    BITNAMI_APP_VERSION=1.9.10-0 \
    NGINX_PACKAGE_SHA256="15565d06b18c2e3710fc08e579ddb3d0e39aa663264a0f7404f0743cb4cdb58d"

ENV BITNAMI_APP_DIR=/opt/bitnami/$BITNAMI_APP_NAME \
    BITNAMI_APP_VOL_PREFIX=/bitnami/$BITNAMI_APP_NAME

ENV PATH=$BITNAMI_APP_DIR/sbin:/opt/bitnami/common/bin:$PATH

RUN bitnami-pkg unpack $BITNAMI_APP_NAME-$BITNAMI_APP_VERSION

# these symlinks should be setup by harpoon at unpack
RUN mkdir -p $BITNAMI_APP_VOL_PREFIX && \
    ln -s $BITNAMI_APP_DIR/html /app && \
    ln -s $BITNAMI_APP_DIR/conf $BITNAMI_APP_VOL_PREFIX/conf && \
    ln -s $BITNAMI_APP_DIR/logs $BITNAMI_APP_VOL_PREFIX/logs

COPY rootfs/ /

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
CMD ["harpoon", "start", "--foreground", "nginx"]
