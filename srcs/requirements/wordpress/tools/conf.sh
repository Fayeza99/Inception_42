#!/bin/bash

WP_DIR="/var/www/html"

if [[ -z "$WP_URL" || -z "$DB_NAME" || -z "$DB_USER" || -z "$DB_PASSWORD" || -z "$WP_TITLE" || -z "$WP_ADMIN_NAME" || -z "$WP_ADMIN_PASS" || -z "$WP_ADMIN_EMAIL" || -z "$WP_USER_NAME" || -z "$WP_USER_EMAIL" || -z "$WP_USER_PASS" ]]; then
  echo "One or more required environment variables are not set. Exiting..."
  exit 1
fi

cd "$WP_DIR" || { echo "Directory $WP_DIR not found"; exit 1; }

echo "Cleaning up the directory..."
rm -rf * || { echo "Failed to clean up directory"; exit 1; }

echo "Downloading WordPress..."
wp core download --allow-root || { echo "Failed to download WordPress"; exit 1; }

echo "Creating WordPress configuration..."
wp config create --force \
				--url="${WP_URL}" \
				--dbname="${DB_NAME}" \
				--dbuser="${DB_USER}" \
				--dbpass="${DB_PASSWORD}" \
				--dbhost="mariadb:3306" \
				--force || { echo "Failed to create configuration"; exit 1; }

echo "Installing WordPress..."
wp core install --url="${WP_URL}" \
				--title="${WP_TITLE}" \
				--admin_user="${WP_ADMIN_NAME}" \
				--admin_password="${WP_ADMIN_PASS}" \
				--admin_email="${WP_ADMIN_EMAIL}" \
				--skip-email || { echo "Failed to install WordPress"; exit 1; }

echo "Creating additional WordPress user..."
wp user create "${WP_USER_NAME}" \
				"${WP_USER_EMAIL}" \
				--user_pass="${WP_USER_PASS}"

echo "Starting PHP-FPM..."
php-fpm7.3 -F || { echo "Failed to start PHP-FPM"; exit 1; }
