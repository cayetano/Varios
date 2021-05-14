#!/bin/bash -e

# Prueba de concepto 
# Busqueda de IP y notificacion por CallMeBot


# set -x
#create .lastscan if not exist
[ ! -f .lastscan ] && touch .lastscan
#search network
printf "======== IP Registradas "
cat .lastscan | wc -l
echo ++++++++ Buscando
arp-scan -xl --retry=8 --ignoredups|cut -f1 > .uactualscan
printf "======== Encontradas "
cat .uactualscan | wc -l 
#prepare files
sort .uactualscan > .sactualscan
uniq .sactualscan > .actualscan
rm .uactualscan .sactualscan
#insert ingnore
if [ -f /opt/arpscan/ignore.ip ]; then 
    cat /opt/arpscan/ignore.ip >> .actualscan
    cat /opt/arpscan/ignore.ip >> .lastscan
fi
echo -------- Comparando
[ -f .out ] && rm .out
touch .out
sed -i 's/$/,/' .actualscan
#locate aditions diff not work
while read ip
do 
 grep -F "$ip" .lastscan > /dev/null || printf $ip >>.out
done < .actualscan
[ -s .out ] && echo !!!!!!!! Alerting $out || echo ++++++++ No Alert
if [ -f /opt/arpscan/telegram.id ]; then
   . /opt/arpscan/telegram.id
   out=$(cat .out)
   url=$(echo "http://api.callmebot.com/text.php?source=web&user=@$id&text=Detectados:$out")
   [ -s .out ] && curl "$url" 
   cp .actualscan .lastscan
else
   echo "Falta configurar el fichero /opt/arpscan/telegram.id"
fi
