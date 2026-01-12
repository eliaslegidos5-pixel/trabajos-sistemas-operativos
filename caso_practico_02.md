# UD 03. Caso práctico 02  
## Instalando LAMP + WordPress en un contenedor

**Autor:** Elías Legidos  
**Curso:** 2ASIR

---

## Creación del contenedor

Crearemos un contenedor con la imagen base **Ubuntu** (versión `22.10`), al que llamaremos **LAMP**, exponiendo el puerto 80 del contenedor en el puerto 8080 de nuestro sistema.  
Además, al crearlo, dejaremos lista una *shell* para instalar los programas pertinentes.

```bash
docker run -it -p 8080:80 --name LAMP ubuntu:22.10 /bin/bash
```

En nuestro caso, el contenedor ya está creado, así que lo iniciamos.

---

## Actualización e instalación de paquetes

En primer lugar, actualizamos la lista de paquetes del repositorio:

```bash
apt update
```

Tras ello, instalamos los paquetes necesarios para LAMP + WordPress:

```bash
apt install wordpress php libapache2-mod-php mariadb-server php-mysql
```

---

## Inicio de Apache

Lanzamos el servicio Apache:

```bash
service apache2 start
```

Con esto ya tenemos todo el software instalado.  
Podemos hacer una pequeña prueba accediendo desde nuestra máquina:

```
http://localhost:8080
```

---

## Instalación de un editor de texto

Antes que nada, podemos instalar un editor de texto en modo consola.  
Por ejemplo, **nano**:

```bash
apt install nano
```

---

## Configuración de Apache para WordPress

Una vez instalado el editor, procedemos a editar la configuración de Apache para trabajar con WordPress.

Creamos el fichero de configuración del sitio:

```
/etc/apache2/sites-available/wordpress.conf
```

> El documento original no especifica el contenido exacto del fichero.

Después, cargamos el sitio, habilitamos *URL rewriting* y recargamos Apache:

```bash
a2ensite wordpress
a2enmod rewrite
service apache2 restart
```

---

## Configuración de MariaDB

Al abrir MariaDB se nos pedirá realizar una configuración inicial.  
Tras indicar la contraseña de **root**, ejecutamos los siguientes comandos.

Creamamos la base de datos:

```sql
CREATE DATABASE wordpress;
```

Creamos el usuario `wordpress` con contraseña `MiPass-2023` y le damos permisos totales:

```sql
CREATE USER 'wordpress'@'%' IDENTIFIED BY 'MiPass-2023';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' WITH GRANT OPTION;
```

Propagamos los privilegios:

```sql
FLUSH PRIVILEGES;
```

---

## Configuración de WordPress

Editamos el fichero de configuración de WordPress:

```
/etc/wordpress/config-localhost.php
```

> El contenido exacto no se especifica en el documento original.

---

## Comprobación final

Para comprobar que todo ha funcionado correctamente, paramos y arrancamos de nuevo el contenedor:

```bash
docker stop LAMP
docker start LAMP
```

Accedemos finalmente a:

```
http://localhost:8080/blog
```
