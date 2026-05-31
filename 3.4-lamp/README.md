# UD 03.04 - LAMP + WordPress en contenedor

## Despliegue

### 1. Construir la imagen
```bash
docker build -t lamp-wordpress ./
```

### 2. Ejecutar el contenedor
```bash
docker run -d -p 8080:80 --name LAMP lamp-wordpress
```

### 3. Acceder en el navegador
```
http://localhost:8080/blog
```
