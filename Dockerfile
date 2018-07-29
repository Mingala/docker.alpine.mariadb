# base version targeted
ARG version_base=3.8
# Alpine base
FROM alpine:$version_base
LABEL maintainer="admin@qi2.info"

# app version targeted
ENV version_app=10.2.15
# Alpine setup
# install MariaDB Alpine package
RUN apk add --update-cache mariadb=${version_app}
