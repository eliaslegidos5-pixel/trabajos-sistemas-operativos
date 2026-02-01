# UD 06.04 - Caso práctico 02 - Django con Docker Compose

## Elias Legidos – 2º ASIR

---

## 1. Preparación del entorno

Se crea un directorio para el proyecto y se accede a él:

```bash
mkdir django-docker
cd django-docker
```

---

## 2. Creación del Dockerfile

Se crea el archivo `Dockerfile` con el siguiente contenido:

```dockerfile
FROM python:3

ENV PYTHONUNBUFFERED=1

WORKDIR /code

COPY requirements.txt /code/

RUN pip install -r requirements.txt
```

Este Dockerfile crea una imagen basada en Python 3 e instala las dependencias necesarias para Django.

---

## 3. Archivo requirements.txt

Se crea el archivo `requirements.txt`:

```txt
Django>=3.0,<4.0
psycopg2-binary>=2.8
```

---

## 4. Archivo docker-compose.yml

Se crea el archivo `docker-compose.yml`:

```yaml
version: "3.9"

services:
  db:
    image: postgres
    volumes:
      - ./datos/db:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=postgres
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres

  web:
    build: .
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - ./codigo:/code
    ports:
      - "8000:8000"
    depends_on:
      - db
```

---

## 5. Construcción y arranque de los contenedores

Se construyen las imágenes:

```bash
docker compose build
```

Se levantan los servicios en segundo plano:

```bash
docker compose up -d
```

---

## 6. Creación del proyecto Django

Se crea el proyecto Django dentro del contenedor:

```bash
docker compose run web django-admin startproject ejemplodjango .
```

El proyecto queda almacenado en el directorio `./codigo`.

---

## 7. Reinicio del sistema

Se reinician los contenedores para que Django pueda arrancar correctamente:

```bash
docker compose down
docker compose up -d
```

---

## 8. Configuración de permisos

Se ajustan los permisos de los archivos creados:

```bash
sudo chown -R $USER:$USER ./codigo
```

---

## 9. Configuración de PostgreSQL en Django

Se edita el archivo `codigo/ejemplodjango/settings.py` y se sustituye la configuración de SQLite por PostgreSQL:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': 'postgres',
        'HOST': 'db',
        'PORT': 5432,
    }
}
```

---

## 10. Reinicio final

Se reinicia nuevamente el sistema para aplicar los cambios:

```bash
docker compose down
docker compose up -d
```

---

## 11. Comprobación

Se accede desde el navegador a la siguiente dirección:

```
http://localhost:8000
```

Si aparece la página de bienvenida de Django, la práctica se ha realizado correctamente.

---

## 12. Conclusión

Se ha desplegado una aplicación Django conectada a una base de datos PostgreSQL utilizando Docker Compose, asegurando la persistencia tanto del código como de la base de datos mediante volúmenes.
