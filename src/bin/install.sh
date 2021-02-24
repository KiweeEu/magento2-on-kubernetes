#!/bin/bash
trap exit ERR

while ! nc -z $DB_HOST 3306;
do
  echo "Waiting for database...";
  sleep 1;
done;
echo "Database found";

rm app/etc/env.php

php bin/magento setup:config:set \
    --no-interaction \
    --skip-db-validation \
    --db-host=$DB_HOST \
    --db-name=$DB_NAME \
    --db-user=$DB_USER \
    --db-password=$DB_PASS \
    --backend-frontname=$ADMIN_URI \
    --key=$KEY

yes | php bin/magento setup:install \
    --admin-user=$ADMIN_USER \
    --admin-password=$ADMIN_PASSWORD \
    --admin-firstname=$ADMIN_FIRSTNAME \
    --admin-lastname=$ADMIN_LASTNAME \
    --admin-email=$ADMIN_EMAIL

php bin/magento cache:flush
