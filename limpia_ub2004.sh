#!/bin/sh
#borra lo que no sirve
apt -y --purge remove ubuntu-server cloud* snapd lxd* rsyslog policykit*
apt --purge autoremove

find /var/log -type f -regex ".*\.gz$" | xargs rm -Rf
find /var/log -type f -regex ".*\.[0-9]$" | xargs rm -Rf

# actualizar lo que hay 
apt update && apt -y upgrade

# vaciar el cache, una ultima vez
apt clean

#listo
echo "Barrido y limpio."
