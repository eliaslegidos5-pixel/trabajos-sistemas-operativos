# UD06 – Caso Práctico 04: Whisper AI y Web Whisper

## Elias Legidos 2ASIR

---

## 1. Introducción

En esta práctica se va a trabajar con **Whisper AI**, una herramienta desarrollada por OpenAI que permite convertir audio en texto de forma automática. Whisper destaca por su alta precisión y por poder ejecutarse de forma local mediante contenedores Docker.

Además, se utilizará **Whisper Web**, que es una aplicación web que ofrece una interfaz gráfica sencilla para enviar audios y obtener su transcripción utilizando Whisper AI como motor principal.

El objetivo de esta práctica es desplegar Whisper AI y Whisper Web usando **Docker Compose**, siguiendo un enfoque práctico y sencillo.

---

## 2. Requisitos previos

Antes de comenzar con la práctica es necesario contar con los siguientes requisitos:

- Sistema operativo con Docker instalado
- Docker Compose operativo
- Conexión a Internet
- Conocimientos básicos de uso de terminal y Docker

---

## 3. Preparación del entorno

### 3.1 Clonado del repositorio

El primer paso consiste en obtener los archivos necesarios del proyecto Whisper Web. Para ello, se clona el repositorio oficial con el siguiente comando:

```bash
git clone https://codeberg.org/pluja/web-whisper
```

En el caso de que el repositorio ya esté descargado en formato `.zip`, simplemente se descomprime en el directorio de trabajo.

---

### 3.2 Configuración de Docker Compose

Una vez dentro del directorio del proyecto, se copia el archivo de ejemplo de Docker Compose y se renombra:

```bash
cp example.docker-compose.yml docker-compose.yml
```

Este archivo será el encargado de definir los contenedores necesarios para ejecutar Whisper AI y Whisper Web.

---

### 3.3 Configuración del archivo .env

A continuación, se copia el archivo de variables de entorno de ejemplo:

```bash
cp example.env .env
```

El archivo `.env` contiene la configuración básica del servicio. Para esta práctica no es necesario modificar los valores por defecto, ya que permiten un funcionamiento correcto del sistema.

---

## 4. Puesta en marcha del servicio

Con todos los archivos configurados correctamente, se procede a levantar los contenedores utilizando Docker Compose:

```bash
docker compose up --build -d
```

Este comando descargará las imágenes necesarias, construirá los contenedores y los ejecutará en segundo plano.

El proceso puede tardar varios minutos la primera vez.

---

## 5. Acceso a Whisper Web

Una vez finalizada la ejecución del comando anterior, el servicio quedará accesible desde el navegador web.

La URL de acceso es:

```
http://localhost:3000
```

Desde esta interfaz web se pueden subir archivos de audio y obtener su transcripción a texto de forma automática.

---

## 6. Comprobación del funcionamiento

Para comprobar que todo funciona correctamente:

1. Acceder a la URL indicada.
2. Subir un archivo de audio compatible.
3. Esperar a que Whisper AI procese el audio.
4. Verificar que el texto transcrito se muestra correctamente en pantalla.

---

## 7. Conclusión

Con esta práctica se ha aprendido a desplegar un servicio completo utilizando Docker Compose, integrando Whisper AI con una interfaz web funcional. Esta solución permite realizar transcripciones de audio a texto de forma local y eficiente, sin depender de servicios externos.

---

## 8. Bibliografía

- Docker Docs: https://docs.docker.com/
- Docker Compose Docs: https://docs.docker.com/compose/
- Repositorio Whisper Web: https://codeberg.org/pluja/web-whisper
