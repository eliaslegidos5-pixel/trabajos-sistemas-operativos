# UD 05.05 - Caso práctico 03 - Acelerando juegos de prueba con tmpfs

**Elias Legidos 2ASIR**

## 1. Ejecución de los contenedores

En primer paso, una vez tengamos el `dump.sql`, ejecutaríamos este comando para ejecutar el contenedor **sin tmpfs**:

```bash
docker run -d --rm --name mysqlsintmpfs -p 3306:3306 \
  -v C:\Users\elias\dump.sql:/docker-entrypoint-initdb.d/dump.sql \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=TRUE \
  -e MYSQL_USER=cefireuser \
  -e MYSQL_PASSWORD=cefirepass \
  mysql:5.6


## 2. Entrar al contenedor
```
docker exec -it mysqlsintmpfs bash
```


##3. Acceder a MySQL
```
mysql -u root
```

##4. Prueba de funcionamiento
```
USE test;
SHOW TABLES;
SELECT * FROM posts;
```
