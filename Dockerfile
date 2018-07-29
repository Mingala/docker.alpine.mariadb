# base version targeted
ARG version_base=3.8
# Alpine base
FROM alpine:$version_base
LABEL maintainer="admin@qi2.info"

USER root:root
# app version targeted
ENV version_app=10.2.15
# Alpine setup
# install MariaDB Alpine package
RUN apk add --update-cache mariadb~${version_app} mariadb-client~${version_app}

# setup MariaDB
# server config file (to map) /etc/mysql/server/my.cnf
# database directory (to map) /var/lib/mysql/
ENV MYSQL_HOME=/etc/mysql/server
ENV MYSQL_TCP_PORT=3306
# server default config, accessed via ENV MYSQL_HOME
COPY server/my.cnf ${MYSQL_HOME}/my.cnf
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-auth-anonymous-user

# run MariaDB
# extra config file (to map) /etc/mysql/extra/my.cnf
VOLUME ["/var/lib/mysql"]
# ports
EXPOSE ${MYSQL_TCP_PORT}/tcp
# extra running config, accessed via --defaults-extra-file (to map)
COPY extra/my.cnf /etc/mysql/extra/my.cnf
ENTRYPOINT ["/usr/bin/mysqld_safe"]
CMD ["--defaults-extra-file=/etc/mysql/extra/my.cnf --user=mysql --datadir=/var/lib/mysql"]
