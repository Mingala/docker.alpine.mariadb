# versions targeted
ARG ver_alpine = 3.8
ARG ver_mariadb = 10.2.15
# Alpine base
FROM alpine:$ver_alpine
LABEL maintainer="admin@qi2.info"
# Alpine setup
# install MariaDB Alpine package
RUN apk add --update-cache mariadb=$ver_mariadb
