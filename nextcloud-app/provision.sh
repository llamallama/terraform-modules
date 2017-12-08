#!/bin/bash
set -e

NEXTCLOUD_URL="${1}"
DOMAIN_NAME="${2}"

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
wget "${NEXTCLOUD_URL}" -O nextcloud.tar.bz2
tar xf nextcloud.tar.bz2
rm -f nextcloud.tar.bz2

# Set Permissions
chown -R apache:apache /var/www/html/nextcloud

# Enable services (should happen last)
chkconfig httpd on

# Set up Nextcloud vhost
sed -i "s/SERVERNAME/${DOMAIN_NAME}/g" \
  /tmp/configs/etc/httpd/vhosts.d/nextcloud.conf

# Copy configs
chown -R root:root /tmp/configs
find /tmp/configs -type f -exec chmod 644 {} \+
find /tmp/configs -type d -exec chmod 755 {} \+
rsync -av /tmp/configs/etc/ /etc/

# Set up Nextcloud
cp -f /tmp/configs/nextcloud/config.php /var/www/html/nextcloud/config/
chown apache:apache /var/www/html/nextcloud/config/config.php
chmod 640 /var/www/html/nextcloud/config/config.php

# Cleaning up
rm -rf /tmp/configs

service httpd start

# Hack to keep apache running when started from Terraform
sleep 1
