Caso practico 01 - Practica de
comandos en contendor Docker.pdf
Elías Legidos 2 ASIR

Crearemos un contenedor con la imagen base “ubuntu”. Además, al crearlo, dejaremos lista una 
“shell” para instalar los programas pertinentes. Esto podemos hacerlo con la orden: 

docker run -it --name ejercicio ubuntu /bin/bash 

Los alumnos podrán salir de la “shell” con el comando “exit”, lo cual parará el contenedor. Para 
volver a acceder, podrán re-arrancarlo con el comando: 

docker start -ai ejercicio 



después hariamos el  ejercicio1

finalmente realizaríamos el script propuesto por el profesor 
