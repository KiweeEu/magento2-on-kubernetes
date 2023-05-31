#!/bin/bash
set -xe

export INSTALL_MAGENTO=1

# https://github.com/magento/magento2/issues/34566
mv app/etc/config.php app/etc/config.php.bak

yes | php bin/magento setup:install \
    --no-interaction \
    --skip-db-validation \
    --backend-frontname=$ADMIN_URI \
    --key=$KEY \
    --admin-user=$ADMIN_USER \
    --admin-password=$ADMIN_PASSWORD \
    --admin-firstname=$ADMIN_FIRSTNAME \
    --admin-lastname=$ADMIN_LASTNAME \
    --admin-email=$ADMIN_EMAIL

mv app/etc/config.php.bak app/etc/config.php

php bin/magento setup:db:status || php bin/magento setup:upgrade --keep-generated
php bin/magento app:config:status || php bin/magento app:config:import
