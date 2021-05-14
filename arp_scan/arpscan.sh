[ ! -f .lastscan ] && touch .lastscan
arp-scan -xl --retry=8 --ignoredups|cut -f1 > .uactualscan
[ -f ignore.ip ] && cat ignore.ip >> .uactualscan
sort .uactualscan > .sactualscan
uniq .sactualscan > .actualscan
rm .uactualscan .sactualscan
diff .actualscan .lastscan |grep '<' |cut -b 2-20 >.out
name_list=""
while read name
do 
  if [[ -z $name_list ]]; then
      name_list="$name"
   else
      name_list="$name_list,$name"
   fi
done < .out
url=$(echo "http://api.callmebot.com/text.php?source=web&user=@esfacilhacerlo&text=Detectados:$name_list")
[ ! -s .out ] && wget $url
cp .actualscan .lastscan
