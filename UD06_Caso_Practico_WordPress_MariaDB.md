# UD 06 – Caso práctico 01  
## WordPress + MariaDB con Docker Compose

**Autor:** Elías Legidos  
**Curso:** 2º ASIR  

---

## 1. Fichero `docker-compose.yml`

A continuación se muestra el archivo `docker-compose.yml` corregido y funcional:

```yaml
version: "3.9"

services:
  db:
    image: mariadb:10.11.2
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MARIADB_ROOT_PASSWORD: somewordpress
      MARIADB_DATABASE: wordpress
      MARIADB_USER: wordpress
      MARIADB_PASSWORD: wordpress

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress

volumes:
  db_data:
```

---

## 2. Paso 1: Poniendo en marcha el sistema

Para levantar los contenedores ejecutamos:

```bash
docker compose up -d
```

Para detener el sistema:

```bash
docker compose down
```

Y para volver a iniciarlo:

```bash
docker compose up -d
```

Docker reutilizará las imágenes ya descargadas, acelerando el arranque del sistema.
