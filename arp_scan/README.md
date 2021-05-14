# ARPSCAN.sh

Script pensado para entornos tipor raspbian, ubuntu y debian, fácilmente adaptable a otros.

## Requisito: 
Tener una cuenta de telegram y enlazado con el servicio de CallMeBot ( gracias por un trabajo enorme )


## Incluye
+ install Instala lo necesario 
+ coloca todo en /opt/arpscan
+ prepara una tarea de cron cada 5 minutos.

## Instalación
Lanzar el script _instalar_arp_scan.sh_ desde la carpeta descargada. 

## Configuracion

*Fichero : /opt/arpscan/telegram.id*
Es -CRITICO- tiene el formato
>id=xxxxxxx
donde "xxxxxx" es el id del usuario de telegram ligado a CallMeBot
 

*Fichero ignore.ip*

IP que pueden "aparecer y desaparecer" y que no serán reportadas

El formato es simple: una bajo la otra, por ejemplo:
>192.168.0.1 

>192.168.168.2 

