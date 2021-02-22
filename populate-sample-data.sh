#!/bin/bash

# CHANGEME: Set Magento auth keys
/opt/bitnami/php/bin/composer global config http-basic.repo.magento.com 422c23a27daaca0a66ab85b1cf40e158 9676923b1ad710001cb808aeece2c5c8
cp /.composer/auth.json /opt/bitnami/magento/
sed -i 's/memory_limit = .*/memory_limit = 4G/' /opt/bitnami/php/etc/php.ini

cd /bin

# Deploy sample data

magento sampledata:deploy

# Upgrade database
magento setup:upgrade

cd /bitnami/magento/
rm -rf var/cache/* var/page_cache/* 
chmod 777 -R var
chmod 777 -R generated
chmod 777 -R app/etc
php bin/magento setup:di:compile;