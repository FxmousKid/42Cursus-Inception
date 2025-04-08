#!/bin/sh
set -e

sed -i 's|MYSQL_DATABASE|'${MYSQL_DATABASE}'|g' /tmp/init.sql
sed -i 's|MYSQL_USER|'${MYSQL_USER}'|g' /tmp/init.sql
sed -i 's|MYSQL_PASSWORD|'${MYSQL_PASSWORD}'|g' /tmp/init.sql
sed -i 's|MYSQL_ROOT_PASSWORD|'${MYSQL_ROOT_PASSWORD}'|g' /tmp/init.sql

sed -i 's|MYSQL_PORT|'${MYSQL_PORT}'|g' /etc/mysql/my.cnf
sed -i 's|MYSQL_ADDRESS|'${MYSQL_ADDRESS}'|g' /etc/mysql/my.cnf

if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db
  echo "Running mysqld with init file..."
  exec mysqld --init-file="/tmp/init.sql" --skip-name-resolve
else
  echo "Database already exists. Starting normally..."
  exec mysqld --skip-name-resolve
fi

# exec "$@"
