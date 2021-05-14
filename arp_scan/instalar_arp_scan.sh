apt update
apt -y install arp-scan curl
cp mac-vendor.txt /usr/share/arp-scan/mac-vendor.txt
mkdir -p  /opt/arpscan
cp arpscan.sh /opt/arpscan/arpscan.sh
sed -i '/\/opt\/arpscan/d' /etc/crontab
echo "*/5 * * * * root /opt/arpscan/arpscan.sh" >> /etc/crontab
