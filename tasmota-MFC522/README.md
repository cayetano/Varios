# Tasmota para RC522

El RC522 es un lector de rfid y miflare sencillo y barato.


En este repositorio hay varias imágines basadas en la version9.5 de tasmota, pero compiladas especificamente para soportar este lector.

Hay 2 "sabores":
- una version� minima, con un soporte minimo de sensores
- una versió extendida, con soporte para muchos tipos de sensores, incluyendo infrarrojos y RF-433 entre otros

Se incluyen imágenes pensadas en ayudar al cableado

Básicamente hay que conectar los terminales : 
- SDA  -> RC522 cs
- SCK  -> SPI CLK
- MOSI -> SPI MOSI
- MISO -> SPI MISO
- GND  -> GND
- RST  -> RC522 RST
- 3v3  -> 3v3

Se incluye un fichero "template" con una configuración que podría simplificar la instalacion, ya que corresponde con las imágenes que se encuentran en el repositorio.

