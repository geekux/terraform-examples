#!/bin/bash

# update OS
yum -y update

# install packages
%{ for package in packages ~}
yum -y install ${package}
%{ endfor ~}

# start services
%{ for service in services ~}
systemctl enable ${service}
systemctl start ${service}
%{ endfor ~}
