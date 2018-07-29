# base version targeted
ARG version_base=3.8
# Alpine base
FROM alpine:$version_base
LABEL maintainer="admin@qi2.info"

# app version targeted
ENV version_app=10.2.15
# Alpine setup
# install MariaDB Alpine package
RUN apk add --update-cache mariadb~${version_app} mariadb-client~${version_app}

# setup MariaDB
USER mysql:mysql
ENV MYSQL_ROOT_PASSWORD=ToBeChanged
ENV MYSQL_HOME=/etc/mysql/server
ENV MYSQL_TCP_PORT=3306
RUN 

# run MariaDB
# server config file (to map) /etc/mysql/server/my.cnf
# extra config file (to map) /etc/mysql/extra/my.cnf
# database directory (to map) /var/lib/mysql/
VOLUME ["/var/lib/mysql"]
USER mysql:mysql
# ports
EXPOSE ${MYSQL_TCP_PORT}/tcp
ENTRYPOINT ["/usr/bin/murmurd", "-fg", "-v"]
CMD ["-ini", "/etc/murmur.ini"]
