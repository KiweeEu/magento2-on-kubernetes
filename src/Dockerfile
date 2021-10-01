FROM php:7.4-fpm as base

ENV COMPOSER_HOME=/tmp/composer
ENV APCU_VERSION=5.1.18

RUN apt-get update && apt-get install -y --no-install-recommends gnupg \
    netcat \
    sudo \
    libicu-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libsodium-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    rsync \
    unzip \
    ;

RUN pecl install apcu-${APCU_VERSION}

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

FROM base as build

RUN curl https://files.magerun.net/n98-magerun2.phar -o /usr/local/bin/magerun \
    && chmod 755 /usr/local/bin/magerun

USER www-data
WORKDIR /var/www/html

ARG COMPOSER_AUTH

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY --chown=www-data composer.json composer.json
COPY --chown=www-data composer.lock composer.lock

RUN php -d memory_limit=2G $(which composer) install --no-progress --no-dev

COPY --chown=www-data app/etc/config.php app/etc/config.php

COPY --chown=www-data bin bin

FROM build as app

ENV MAGE_MODE=production
RUN php -d memory_limit=2G bin/magento setup:di:compile
RUN composer dump-autoload --optimize --apcu
RUN php -d memory_limit=2G bin/magento setup:static-content:deploy -f
RUN rm -rf /var/www/html/var/cache
RUN rm -rf /var/www/html/var/page_cache
RUN rm -rf /var/www/html/var/session

COPY --chown=www-data app/etc/env.docker.php app/etc/env.php
