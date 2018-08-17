#!/bin/ash
# setup MariaDB if no mysql database found
if [ ! -d "$MYSQL_DATABASE/mysql" ]; then
	/usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-auth-anonymous-user
fi
# run mysql database
echo "INFO: start MariaDB with extra config file in $MYSQL_DATABASE"
/usr/bin/mysqld_safe --defaults-extra-file=/etc/mysql/extra/my.cnf --user=mysql --datadir=$MYSQL_DATABASE &
