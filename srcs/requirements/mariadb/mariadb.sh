#!/bin/bash

# Start the MariaDB service
service mysql start

# Wait for MariaDB to fully start
sleep 5

# Create the database if it does not exist
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"


# Create the user if it does not exist and grant privileges
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${MYSQL_USER}'@'%';"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# Stop the MariaDB service
service mysql stop

# Start MariaDB in safe mode with the specified configurations
exec mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'

