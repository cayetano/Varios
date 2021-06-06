#!/bin/sh

# Fuera logs
logs=`find /var/log -type f`
for i in $logs
do
> $i
done

# desinstalar lo que no me hace falta y borrar carpetas vacias

apt -y --purge  remove lxd* snapd apport ufw apparmor byobu \
    command-not-found dictionaries-common  ed info iw landscape* \
    pastebinit popularity-contest usbutils wamerican lxcfs cloud* \
    open-vm* alsa* open-iscsi policykit* unattended* 
rm -rf /etc/cloud/
rm -rf /var/lib/cloud/
rm -rf /root/snap
# Quital lo que queda pendiente
apt -y --purge autoremove

# Borrar el cache
apt-get clean && apt-get autoclean


# panginas Man
rm -rf /usr/share/man/?? 
rm -rf /usr/share/man/??_*

# por si hay logs antoguos
find /var/log -type f -regex ".*\.gz$" | xargs rm -Rf
find /var/log -type f -regex ".*\.[0-9]$" | xargs rm -Rf

#no debe, pero por si hay kernels antiguos
dpkg-query -l|grep linux-im*

apt-get purge $(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | head -n -1) --assume-yes

# Hay que asegurarse que el el ultimo est'a completo
apt-get install linux-headers-`uname -r|cut -d'-' -f3`-`uname -r|cut -d'-' -f4`


# actualizar lo que hay 
apt update && apt -y upgrade

# vaciar el cache, una ultima vez
apt clean

#listo
echo "Barrido y limpio."
