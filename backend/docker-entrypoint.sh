#!/bin/bash
set -e

echo " Starting WordPress Backend..."

# Extract host from WORDPRESS_DB_HOST (remove port if present)
DB_HOST_ONLY=$(echo ${WORDPRESS_DB_HOST} | cut -d':' -f1)

# Wait for MySQL to be ready (disable SSL)
echo " Waiting for MySQL to be ready..."
until mysql -h"${DB_HOST_ONLY}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" --ssl=0 -e "SELECT 1" >/dev/null 2>&1; do
    echo "   MySQL is unavailable - sleeping"
    sleep 2
done

echo " MySQL is up and running!"

# Set proper permissions
echo " Setting permissions..."
chown -R www-data:www-data /var/www/html

echo "Backend is ready!"

# Execute the original WordPress docker-entrypoint
exec docker-entrypoint.sh "$@"
