#!/bin/bash

set -e

# Install dependencies
yum install -y httpd71 \
               php71 \
               php71-gd \
               php71-mbstring \
               php71-mysqlnd \
               php71-intl \
               php71-mcrypt \
               php71-apcu

# Install nextcloud
cd /var/www/html/
wget '${nextcloud_url}' -O nextcloud.tar.bz2
tar xf nextcloud.tar.bz2
rm -f nextcloud.tar.bz2

# Set Permissions
chown -R apache:apache /var/www/html/nextcloud

# Enable services (should happen last)
chkconfig httpd on
service httpd start
