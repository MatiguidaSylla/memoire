FROM wordpress:php8.2-fpm-alpine

# Install system dependencies (remplacer mysql-client par mariadb-connector-c)
RUN apk add --no-cache \
    bash \
    curl \
    less \
    mariadb-client \
    vim \
    && rm -rf /var/cache/apk/*

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache

# Install Redis extension
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del .build-deps

# Configure PHP OpCache
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

# Copy custom PHP configuration
COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set working directory
WORKDIR /var/www/html

# Copy custom entrypoint
COPY docker-entrypoint.sh /usr/local/bin/custom-entrypoint.sh
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

ENTRYPOINT ["custom-entrypoint.sh"]
CMD ["php-fpm"]
