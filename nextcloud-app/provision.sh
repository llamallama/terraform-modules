#!/bin/bash
set -e

nextcloud_url="${1}"

# Install dependencies
yum install -y httpd71 \
               php71 \
               php71-gd \
               php71-mbstring \
               php71-mysqlnd \
               php71-intl \
               php71-mcrypt \
               php71-opcache \
               php71-apcu

# Install nextcloud
cd /var/www/html/
wget "${nextcloud_url}" -O nextcloud.tar.bz2
tar xf nextcloud.tar.bz2
rm -f nextcloud.tar.bz2

# Set Permissions
chown -R apache:apache /var/www/html/nextcloud

# Enable services (should happen last)
chkconfig httpd on

echo "Setting up configs"
chown -R root:root /tmp/configs
find /tmp/configs -type f -exec chmod 644 {} \+
find /tmp/configs -type d -exec chmod 755 {} \+
rsync -av /tmp/configs/etc/ /etc/

cp -f /tmp/configs/nextcloud/config.php /var/www/html/nextcloud/config/
chown apache:apache /var/www/html/nextcloud/config/config.php
chmod 640 /var/www/html/nextcloud/config/config.php

echo "Starting services"
service httpd start

# Hack to keep apache running
sleep 1