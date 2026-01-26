UD 04. Caso práctico 02 - Creando imagen con APP ejemplo Docker en Node  
Elías Legidos 2ASIR

---

## PREPARANDO EL DOCKERFILE Y CREANDO LA IMAGEN

Una vez descargado y extraído el zip podemos crear dentro de la carpeta **app**, el archivo para levantar el docker que tenemos.  
En mi caso se llama **Dockerfile** y contendrá lo siguiente:

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY . .

RUN yarn install --production

CMD ["node", "src/index.js"]
```

---

Después, dentro de la carpeta ejecutamos el comando:

```bash
docker build -t sampledocker ./
```

---

## Ejecutar el contenedor

Para usar el docker podemos usarlo con el siguiente comando:

```bash
docker run -dp 3000:3000 sampledocker
```
