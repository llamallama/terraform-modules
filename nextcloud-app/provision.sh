#!/bin/bash
set -e

NEXTCLOUD_URL="${1}"
DOMAIN_NAME="${2}"
EFS_MOUNT_TARGET="${3}"

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

# Set up EFS
NFS_OPTIONS="nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev"
EFS_MOUNT_POINT=/mnt/efs
mkdir "${EFS_MOUNT_POINT}"
mount -t nfs4 -o "${NFS_OPTIONS}" "${EFS_MOUNT_TARGET}:/" "${EFS_MOUNT_POINT}" >> /home/ec2-user/echo.res
cp -p /etc/fstab /etc/fstab.back-$(date +%F)
echo -e "${EFS_MOUNT_TARGET}:/              ${EFS_MOUNT_POINT}                nfs4            ${NFS_OPTIONS}            0               0" | tee -a /etc/fstab

#if [[ ! -f /var/www/html/deadspace ]]
#then
#  sudo dd if=/dev/zero of=/var/www/html/deadspace bs=1M count=3096 status=progress
#  chmod 600 /var/www/html/deadspace
#fi

if [[ ! -d "${EFS_MOUNT_POINT}/nextcloud" ]]
then
  mkdir -p "${EFS_MOUNT_POINT}"/nextcloud/{data,apps2}
  chown -R apache:apache "${EFS_MOUNT_POINT}/nextcloud"
  chmod 770 "${EFS_MOUNT_POINT}"/nextcloud/data
fi

# Install nextcloud
wget "${NEXTCLOUD_URL}" -O /nextcloud.tar.bz2
tar -h -x -f /nextcloud.tar.bz2 -C /var/www/html/
rm -f /nextcloud.tar.bz2
ln -s "${EFS_MOUNT_POINT}"/nextcloud/apps2 /var/www/html/nextcloud/apps2
ln -s "${EFS_MOUNT_POINT}"/nextcloud/data /var/www/html/nextcloud/data
touch /var/www/html/nextcloud/data/.ocdata

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
aws s3 cp s3://cloud.pipetogrep.org/staging/config/config.php /var/www/html/nextcloud/config/
chown apache:apache /var/www/html/nextcloud/config/config.php
chmod 640 /var/www/html/nextcloud/config/config.php

# Cleaning up
rm -rf /tmp/configs

service httpd start

# Hack to keep apache running when started from Terraform
sleep 1
