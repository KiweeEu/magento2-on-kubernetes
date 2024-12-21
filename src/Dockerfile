FROM php:8.2.27-fpm@sha256:95daac6a2a785926b677973a2ef26b61d9d3c248ff33eaf857b71780bceea7ca as base

ENV COMPOSER_HOME=/tmp/composer

RUN apt-get update && apt-get install -y --no-install-recommends gnupg \
    nginx \
    netcat-openbsd \
    libicu-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libsodium-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    rsync \
    supervisor \
    unzip \
    ;

RUN pecl install apcu-5.1.22

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j "$(nproc)" \
    bcmath \
    gd \
    intl \
    mysqli \
    opcache \
    pdo_mysql \
    sockets \
    soap \
    xsl \
    zip \
    ;

RUN docker-php-ext-enable apcu

RUN echo "memory_limit=1G" >> /usr/local/etc/php/conf.d/zz-memory-limit-php.ini
RUN echo "apc.enable=1" >> /usr/local/etc/php/conf.d/zz-apcu.ini
RUN echo "apc.enable_cli=1" >> /usr/local/etc/php/conf.d/zz-apcu.ini
RUN echo "opcache.memory_consumption=512MB" >> /usr/local/etc/php/conf.d/zz-opcache.conf
RUN echo "opcache.max_accelerated_files=60000" >> /usr/local/etc/php/conf.d/zz-opcache.conf
RUN echo "opcache.consistency_checks=0" >> /usr/local/etc/php/conf.d/zz-opcache.conf
RUN echo "opcache.validate_timestamps=0" >> /usr/local/etc/php/conf.d/zz-opcache.conf
RUN echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/zz-opcache.conf

RUN echo "[www]" >> /usr/local/etc/php-fpm.d/zz-status.conf
RUN echo "; Expose PHP-FPM status" >> /usr/local/etc/php-fpm.d/zz-status.conf
RUN echo "pm.status_listen=9001" >> /usr/local/etc/php-fpm.d/zz-status.conf
RUN echo "pm.status_path=/status" >> /usr/local/etc/php-fpm.d/zz-status.conf

RUN mkdir -p /var/lib/nginx/{body,fastcgi} && \
    chown -R www-data:www-data /var/lib/nginx

RUN touch /run/nginx.pid && \
    chown www-data:www-data /run/nginx.pid

FROM base as build

COPY etc/supervisord.conf /etc/supervisor/supervisord.conf
COPY etc/nginx /etc/nginx

RUN curl https://files.magerun.net/n98-magerun2.phar -o /usr/local/bin/magerun \
    && chmod 755 /usr/local/bin/magerun

RUN mkdir -p /var/log/supervisor \
    && chown www-data:www-data /var/log/supervisor

USER www-data
WORKDIR /var/www/html

ARG COMPOSER_AUTH

COPY --from=composer:2.8.4@sha256:e4d7757e0c7ae48d9ddc65c07215ce602cbdcc909dc0dd8e30626ffd865fc968 /usr/bin/composer /usr/bin/composer

COPY --chown=www-data composer.json composer.json
COPY --chown=www-data composer.lock composer.lock

RUN composer check-platform-reqs --lock && \
    composer validate && \
    composer install \
        --no-interaction \
        --no-progress \
        --no-autoloader  \
        --no-dev

COPY --chown=www-data app/etc/config.php app/etc/config.php

COPY --chown=www-data bin bin
COPY bin/entrypoint.sh /usr/local/bin/docker-php-entrypoint

COPY setup/performance-toolkit/profiles/ce/mok.xml setup/performance-toolkit/profiles/ce/mok.xml

EXPOSE 8080

FROM build as dev

USER root
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" && \
    sed -i -E 's/^variables_order = ".*"$/variables_order = "EGPCS"/' $PHP_INI_DIR/php.ini && \
    sed -i -E 's/^session.cookie_samesite = ".*"$/session.cookie_samesite = "Strict"/' $PHP_INI_DIR/php.ini

USER www-data

RUN composer install \
    --no-interaction \
    --no-progress

COPY --chown=www-data app/etc/env.docker.php app/etc/env.php

FROM build as app

USER root
RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
    sed -i -E 's/^variables_order = ".*"$/variables_order = "EGPCS"/' $PHP_INI_DIR/php.ini && \
    sed -i -E 's/^session.cookie_samesite = ".*"$/session.cookie_samesite = "Strict"/' $PHP_INI_DIR/php.ini

USER www-data

ENV MAGE_MODE=production

RUN composer dump-autoload \
        --optimize \
        --apcu

RUN php -d memory_limit=2G bin/magento setup:di:compile
RUN php -d memory_limit=2G bin/magento setup:static-content:deploy -f
RUN rm -rf /var/www/html/var/cache
RUN rm -rf /var/www/html/var/page_cache
RUN rm -rf /var/www/html/var/session

COPY --chown=www-data app/etc/env.docker.php app/etc/env.php
