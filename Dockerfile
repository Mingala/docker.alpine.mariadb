FROM alpine:latest
LABEL maintainer="admin@qi2.info"

# Alpine setup
# install latest MariaDB Alpine package
RUN apk add --update-cache mariadb
