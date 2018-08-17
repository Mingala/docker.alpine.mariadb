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

# setup MariaDB environment
# server config file (bind mount file at Docker run) /etc/mysql/server/my.cnf
# extra config file (bind mount file at Docker run) /etc/mysql/extra/my.cnf
# databases folder (bind mount folder at Docker run) /var/lib/mysql/
ENV MYSQL_DATABASE=/var/lib/mysql
# ports
ENV MYSQL_TCP_PORT=3306
# server default config, accessed via ENV MYSQL_HOME
ENV MYSQL_HOME=/etc/mysql/server
COPY etc/mysql/server/my.cnf ${MYSQL_HOME}/my.cnf
# extra running config, accessed via --defaults-extra-file
COPY etc/mysql/extra/my.cnf /etc/mysql/extra/my.cnf

# entrypoint bash
COPY usr/local/bin/docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod u+x /usr/local/bin/docker_entrypoint.sh
# setup MariaDB if no mysql database found
# run MariaDB with extra config
EXPOSE ${MYSQL_TCP_PORT}/tcp
ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
