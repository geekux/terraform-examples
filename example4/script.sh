#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install nginx
yum -y update
yum -y install httpd

# make sure nginx is started
systemctl enable httpd
systemctl start httpd

