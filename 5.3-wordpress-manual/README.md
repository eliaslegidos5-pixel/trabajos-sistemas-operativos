# UD 05.03 - WordPress + MariaDB con Docker (sin Compose)

## Paso 1 - Crear la red
```bash
docker network create redwp
```

## Paso 2 - Crear contenedor MariaDB
```bash
docker run --name mariadb \
  --network redwp \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wordpress \
  -e MYSQL_PASSWORD=wordpress \
  -d mariadb:10.11
```

## Paso 3 - Crear contenedor WordPress
```bash
docker run --name nuestrowp \
  --network redwp \
  -p 8080:80 \
  -d wordpress
```

## Paso 4 - Acceder en el navegador
```
http://localhost:8080
```
