#!/bin/bash
set -e

echo " Starting WordPress Backend..."

# Wait for MySQL to be ready
echo " Waiting for MySQL to be ready..."
until mariadb -hdb -uwordpress -pwordpress_secure_123 --skip-ssl -e "SELECT 1" &> /dev/null; do
    echo "   MySQL is unavailable - sleeping"
    sleep 2
done

echo " MySQL is up and running!"

# Set proper permissions
echo " Setting permissions..."
chown -R www-data:www-data /var/www/html

echo " Backend is ready!"

# Execute the original WordPress docker-entrypoint
exec docker-entrypoint.sh "$@"
