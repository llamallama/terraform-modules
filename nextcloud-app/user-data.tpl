#!/bin/bash
set -e

DOMAIN_NAME='${domain_name}'
EFS_MOUNT_TARGET='${efs_mount_target}'
ENVIRONMENT='${environment}'
CONFIG_BUCKET='${config_bucket}'

# Set up EFS
NFS_OPTIONS="nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev"
EFS_MOUNT_POINT=/mnt/efs

mount -t nfs4 -o "$NFS_OPTIONS" "$EFS_MOUNT_TARGET:/" "$EFS_MOUNT_POINT" >> /home/ec2-user/echo.res
cp -p /etc/fstab /etc/fstab.back-$(date +%F)
echo -e "$EFS_MOUNT_TARGET:/              $EFS_MOUNT_POINT                nfs4            $NFS_OPTIONS            0               0" | tee -a /etc/fstab

#if [[ ! -f /var/www/html/deadspace ]]
#then
#  sudo dd if=/dev/zero of=/var/www/html/deadspace bs=1M count=3096 status=progress
#  chmod 600 /var/www/html/deadspace
#fi

if [[ ! -d "$EFS_MOUNT_POINT/nextcloud" ]]
then
  mkdir -p "$EFS_MOUNT_POINT"/nextcloud/{data,apps2}
  chown -R apache:apache "$EFS_MOUNT_POINT/nextcloud"
  chmod 770 "$EFS_MOUNT_POINT"/nextcloud/data
fi

# Set up Nextcloud vhost
sed -i "s/SERVERNAME/$DOMAIN_NAME/g" /etc/httpd/vhosts.d/nextcloud.conf

# Set up Nextcloud
aws s3 cp s3://$CONFIG_BUCKET/$ENVIRONMENT/config/config.php /var/www/html/nextcloud/config/
chown apache:apache /var/www/html/nextcloud/config/config.php
chmod 640 /var/www/html/nextcloud/config/config.php
