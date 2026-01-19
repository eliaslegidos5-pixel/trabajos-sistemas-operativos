# UD 03. Caso práctico 01  
## Creando imagen Ubuntu con nano

**Autor:** Elías Legidos  
**Curso:** 2ASIR

---

## PREPARANDO EL DOCKERFILE Y CREANDO LA IMAGEN

Crearemos el siguiente “Dockerfile”:

```

#Imagen base ubuntu
FROM ubuntu
# Actualizamos lista de paquetes e instalamos nano (-y para no
preguntar)
# Las últimas líneas son para hacer la imagen más ligera
RUN apt update && apt install -y nano && apt purge --auto-remove && apt
clean && rm -rf /var/lib/apt/lists/*
# Establecemos como comando por defecto de la imagen /bin/bash
CMD /bin/bash

```
El funcionamiento del propio “Dockerfile” está definido por sus propios comentarios. Una vez
preparado, crearemos la imagen con:

```
docker build -t ubuntunano ./
```
Con esa línea indicamos que creamos la imagen “ubuntunano” basándose en el fichero
“Dockerfile” del directorio actual.

---

Con el siguiente comando, podremos crear un contenedor con esta imagen, acceder a una shell
dentro del contenedor y comprobar que el programa “nano” está instalado, ejecutando el editor
con “nano prueba.txt” o similar

```
docker run -it ubuntunano
```







