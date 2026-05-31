# UD 04.04 - Node App con Docker

## Pasos para desplegar

### 1. Clonar la app de ejemplo oficial de Docker
```bash
git clone https://github.com/docker/getting-started-app.git
cd getting-started-app
```

### 2. Copiar el Dockerfile de este repositorio dentro de la carpeta
(ya está incluido en este repo)

### 3. Construir la imagen
```bash
docker build -t sampledocker ./
```

### 4. Ejecutar el contenedor
```bash
docker run -dp 3000:3000 sampledocker
```

### 5. Acceder en el navegador
```
http://localhost:3000
```
