# UD 05. Caso práctico 01 - Wordpress + MariaDB

# Elías Legidos 2ASIR

## PASO 1: CREANDO LA RED

El primer paso a dar en este caso práctico, es crear la red que
compartirán los contenedores que creemos, a la que llamaremos "redwp".
La podemos crear con el comando:
```
docker network create redwp
```


## PASO 2: CREANDO CONTENEDOR MARIADB

creamos el docker con el comando de la practica 

## PASO 3: CREANDO CONTENEDOR CON WORDPRESS

creamos el contenedor wordpress con
```
docker run \--name nuestrowp \--network redwp -p 8080:80 -d wordpress
```


## PASO 4: INSTALANDO WORDPRESS

Una vez hecho , accedemos al localhost por el puerto 8080 e instalamos
el wordpress.


