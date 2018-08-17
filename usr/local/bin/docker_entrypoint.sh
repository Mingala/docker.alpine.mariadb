#!/bin/bash
# setup MariaDB if no mysql database found
if [ ! -f "$MYSQL_DATABASE/my.sql" ]; then
	echo "INFO: setup MariaDB in $MYSQL_DATABASE"
	/usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-auth-anonymous-user
	echo "WARN: MariaDB root user created without password"
	echo "WARN: change it using SQL client: ALTER USER root IDENTIFIED BY 'something'"
fi
# run mysql database
echo "INFO: start MariaDB with extra config file in $MYSQL_DATABASE"
/usr/bin/mysqld_safe --defaults-extra-file=/etc/mysql/extra/my.cnf --user=mysql --datadir=$MYSQL_DATABASE
