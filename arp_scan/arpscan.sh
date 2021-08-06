#!/bin/bash -e

# Prueba de concepto 
# Busqueda de MAC y notificacion por CallMeBot
# set -x
#create .lastscan if not exist
[ ! -f .lastscan ] && touch .lastscan
#search network
printf "======== MAC Registradas "
cat .lastscan | wc -l
echo ++++++++ Buscando
arp-scan -xl --retry=8 --ignoredups > .scan
cat .scan |cut -f2 > .uactualscan
#| sed "s/://g" > .uactualscan
printf "======== Encontradas "
cat .uactualscan | wc -l 
#prepare files
sort .uactualscan > .sactualscan
uniq .sactualscan > .actualscan
rm .uactualscan .sactualscan
#insert ingnore
if [ -f /opt/arpscan/ignore.mac ]; then 
    cat /opt/arpscan/ignore.mac >> .actualscan
    cat /opt/arpscan/ignore.mac >> .lastscan
fi
echo -------- Comparando
[ -f .out ] && rm .out
touch .out

#locate aditions diff not work
while read mac
do 
 grep -F "$mac" .lastscan > /dev/null || grep $mac .scan |cut -f1,2,3| xargs printf "%s+"  >>.out
done < .actualscan
[ -s .out ] && echo !!!!!!!! Alerting $out || echo ++++++++ No Alert
if [ -f /opt/arpscan/telegram.id ]; then
   . /opt/arpscan/telegram.id
   out=$(cat .out|sed 's/ /+/g')
   url=$(echo "http://api.callmebot.com/text.php?user=@$id&text=Detectados:$out")
   echo $url
   [ -s .out ] && curl $url
   cp .actualscan .lastscan
else
   echo "Falta configurar el fichero /opt/arpscan/telegram.id"
fi
# rm .scan
