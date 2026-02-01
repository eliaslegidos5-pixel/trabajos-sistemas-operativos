# UD 06.05 - Caso práctico 03 - Proxy Nginx y balanceo escalado con Docker Compose

## Elias Legidos – 2º ASIR

---

## 1. Introducción

En este caso práctico se implementa un sistema de balanceo de carga utilizando Docker Compose.
El punto de entrada será un proxy Nginx y las peticiones serán atendidas por varios servidores
Apache con PHP, que se podrán escalar dinámicamente.

---

## 2. Estructura del proyecto

La estructura de directorios utilizada es la siguiente:

```
.
- apache
   - Dockerfile
    - index.php
   -nginxproxy
    - nginx.conf
   -docker-compose.yml
```

---

## 3. Servidor Apache + PHP

### 3.1 Dockerfile de Apache

Dentro del directorio `apache` se crea el archivo `Dockerfile`:

```dockerfile
FROM php:7.2-apache

COPY index.php /var/www/html/
```

Este Dockerfile crea una imagen con Apache y PHP y copia el archivo `index.php` al directorio
por defecto del servidor web.

---

### 3.2 Archivo index.php

Se crea el archivo `index.php` en el mismo directorio:

```php
<html>
<body>
<h1>
Servido por: Servidor con IP <?php echo $_SERVER['SERVER_ADDR']; ?>
y hostname <?php echo gethostname(); ?>
</h1>
</body>
</html>
```

Este archivo muestra la IP y el hostname del contenedor que sirve la petición.

---

## 4. Configuración del proxy Nginx

Dentro del directorio `nginxproxy` se crea el archivo `nginx.conf`:

```nginx
user nginx;

events {
    worker_connections 1000;
}

http {
    server {
        listen 4000;

        location / {
            proxy_pass http://apache:80;
        }
    }
}
```

Nginx escuchará en el puerto 4000 y redirigirá las peticiones al servicio `apache`, que Docker
Compose balanceará automáticamente.

---

## 5. Archivo docker-compose.yml

En el directorio raíz del proyecto se crea el archivo `docker-compose.yml`:

```yaml
version: "3.9"

services:
  apache:
    build: ./apache
    restart: always
    ports:
      - "80"

  nginxproxy:
    image: nginx:latest
    volumes:
      - ./nginxproxy/nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - apache
    ports:
      - "4000:4000"
```

Este archivo define dos servicios:
- Apache, que puede escalarse en múltiples contenedores.
- Nginx, que actúa como proxy y punto de entrada al sistema.

---

## 6. Puesta en marcha del sistema

Se inicia el sistema completo con el siguiente comando:

```bash
docker compose up -d
```

Una vez iniciado, se puede acceder al sistema desde el navegador en:

```
http://localhost:4000
```

Al recargar la página, inicialmente se mostrará siempre el mismo servidor, ya que solo existe
un contenedor Apache.

---

## 7. Escalado de los servidores Apache

Para aumentar el número de servidores Apache, se utiliza el comando:

```bash
docker compose up -d --scale apache=4
```

Este comando crea un total de cuatro contenedores Apache.

Al recargar varias veces la página en `http://localhost:4000`, se puede observar que cambian
la IP y el hostname, lo que indica que Nginx está repartiendo las peticiones entre los distintos
contenedores mediante balanceo de carga tipo round robin.

---

## 8. Conclusión

Se ha implementado un sistema de proxy inverso con Nginx y balanceo de carga utilizando Docker
Compose, demostrando el escalado horizontal de servicios Apache de forma sencilla y eficiente.
