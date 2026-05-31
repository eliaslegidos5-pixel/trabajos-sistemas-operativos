# UD 05.05 - tmpfs MySQL

## Comando para lanzar el contenedor CON tmpfs

```bash
docker run -d --rm --name mysqltmpfs -p 3306:3306 \
  -v $(pwd)/dump.sql:/docker-entrypoint-initdb.d/dump.sql \
  --tmpfs /var/lib/mysql \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=TRUE \
  -e MYSQL_USER=cefireuser \
  -e MYSQL_PASSWORD=cefirepass \
  mysql:5.6
```

## Entrar al contenedor
```bash
docker exec -it mysqltmpfs bash
```

## Acceder a MySQL
```bash
mysql -u root
```

## Prueba de funcionamiento
```sql
USE test;
SHOW TABLES;
SELECT * FROM posts;
```
