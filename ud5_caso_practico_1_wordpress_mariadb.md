UD 05. Caso práctico 01 - Wordpress + MariaDB

Elías Legidos 2ASIR

PASO 1: CREANDO LA RED

El primer paso a dar en este caso práctico, es crear la red que
compartirán los contenedores que creemos, a la que llamaremos "redwp".
La podemos crear con el comando:

docker network create redwp

![](Pictures/100000000000078000000438122FE2DF710300D7.png){width="13.21cm"
height="6.641cm"}

PASO 2: CREANDO CONTENEDOR MARIADB

![](Pictures/100000000000078000000438FC85CAE515F34A25.png){width="15.007cm"
height="7.939cm"}

PASO 3: CREANDO CONTENEDOR CON WORDPRESS

creamos el contenedor wordpress con

docker run \--name nuestrowp \--network redwp -p 8080:80 -d wordpress

![](Pictures/100000000000078000000438B48E2EB05AA571AF.png){width="12.462cm"
height="6.473cm"}

PASO 4: INSTALANDO WORDPRESS

Una vez hecho , accedemos al localhost por el puerto 8080 e instalamos
el wordpress.

![](Pictures/100000000000078000000438E51C0D8BFDE882E2.png){width="17.634cm"
height="9.033cm"}
