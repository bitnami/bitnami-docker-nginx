# Customizing Bitnami NGINX Docker Image

The Bitnami NGINX Docker image is designed to be extended so it can be used as the base image for your custom web applications.

## Understand how the image works

The Bitnami NGINX Docker image is built using a Dockerfile with the structure below:

```Dockerfile
FROM bitnami/minideb-extras-base
...
# Install required system packages and dependencies
RUN install_packages xxx yyy zzz
RUN . ./libcomponent.sh && component_unpack "nginx" "a.b.c-0"
...
COPY rootfs /
RUN /prepare.sh
...
ENV BITNAMI_APP_NAME="nginx" ...
EXPOSE 8080 8443
VOLUME /app
VOLUME /certs
WORKDIR /app
USER 1001
...
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/run.sh" ]
```

We can identify several sections within the Dockerfile:

- A section where all the required components are installed.
- A section where all the components are statically configured.
- A section where the env. variables, the ports to be exposed, the working directory and the user are defined.
  - Note that once the user is set to 1001, unprivileged commands cannot be executed anymore.
- A section where the entrypoint and command used to start the service are declared.
  - Take into account these actions are not executed until the container is started.

## Extending the Bitnami NGINX Docker Image

Before extending this image, please note there are certain configuration settings you can modify using the original image:

- Settings that can be adapted using environment variables. For instance, you can change the port used by NGINX for HTTP setting the environment variable `NGINX_HTTP_PORT_NUMBER`.
- [Adding custom virtual hosts](../#adding-custom-virtual-hosts).
- [Replacing the 'nginx.conf' file](../#full-configuration).
- [Using custom SSL certificates](../#using-custom-ssl-certificates).

If your desired customizations cannot be covered using the methods mentioned above, extend the image. To do so, create your own image using a Dockerfile with the format below:


```Dockerfile
FROM bitnami/nginx

## Put your customizations below
...
```

An example is provided on this folder where the image is customized by:

- Install `vim` editor.
- Extending the configuration.
- Modifying the ports used by NGINX.
- Modifying the container user.

Try the example by running the commands below:

```bash
# Clone this repository
$ git clone https://github.com/bitnami/bitnami-docker-nginx.git
$ cd bitnami-docker-nginx/customize
# Generate self-signed certificates
$ mkdir certs
$ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certs/server.key -out ./certs/server.crt
# Start the containers
$ docker-compose up -d
```

> NOTE: On this example, other features already offered by the Bitnami NGINX container such using custom SSL certificates or [mount a static website](../#hosting-a-static-website) are used too.
