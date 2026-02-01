# UD06 – Caso Práctico 05: Bot de Telegram con Whisper AI

## Elias Legidos 2ASIR

---



## 2. Requisitos previos

Antes de comenzar, es necesario disponer de:

- Docker instalado y funcionando
- Docker Compose operativo
- Cuenta de Telegram
- Conocimientos básicos de uso de terminal
- Acceso a Internet

---

## 3. Creación del bot de Telegram

### 3.1 Creación del bot con BotFather

El primer paso consiste en crear un bot de Telegram. Para ello:

1. Abrir Telegram e iniciar una conversación con **@BotFather**.
2. Ejecutar el comando:
   ```
   /newbot
   ```
3. Asignar un nombre al bot.
4. Asignar un nombre de usuario (debe terminar en `bot`).
5. Guardar el **TOKEN** proporcionado, ya que será necesario más adelante.

---

### 3.2 Obtención de IDs de usuarios o grupos

Para controlar quién puede usar el bot, es necesario obtener los IDs de los usuarios o grupos autorizados.

Pasos a seguir:

1. Iniciar una conversación con **@RawDataBot**.
2. Enviar o reenviar un mensaje del usuario del que se quiere obtener el ID.
3. Copiar el valor del campo `message.from.id`.

Tipos de ID:
- Usuarios: `123456789`
- Grupos: `-123456789`

---

## 4. Preparación del entorno

### 4.1 Descarga del repositorio

Se descarga el repositorio del bot con el siguiente comando:

```bash
git clone https://github.com/sergarb1/telegram-bot-whisper-cpp
```

Si el repositorio se proporciona en formato `.zip`, simplemente se descomprime.

---

### 4.2 Configuración del archivo .env

Dentro del directorio del proyecto se edita el archivo `.env` y se configuran los siguientes parámetros:

- `TELEGRAM_BOT_TOKEN`: Token generado por BotFather.
- `ALLOWED_CHAT_IDS`: IDs de usuarios o grupos separados por comas.
  - Se puede usar `*` para permitir el acceso a todos.
- `WHISPER_MODEL`: Modelo a utilizar (tiny, base, small, medium, large).
  - Se recomienda usar como máximo `small`.
- `AUDIO_LANGUAGE`: Idioma del audio (auto para detección automática).

---

## 5. Puesta en marcha del bot

Una vez configurado todo, se ejecuta el siguiente comando para levantar el servicio:

```bash
docker compose up --build -d
```

Docker descargará las imágenes necesarias y el bot quedará funcionando en segundo plano.

---

## 6. Uso del bot

Para utilizar el bot:

- Enviar una nota de voz o archivo de audio directamente al bot desde un usuario autorizado.
- Enviar una nota de voz en un grupo donde el bot esté añadido y tenga permisos de lectura.

En el caso de los grupos, la transcripción será visible para todos los miembros.

---



- Docker Docs: https://docs.docker.com/
- Docker Compose Docs: https://docs.docker.com/compose/
- Repositorio Whisper CPP: https://github.com/ggerganov/whisper.cpp
- Bot de Telegram Whisper: https://github.com/sergarb1/telegram-bot-whisper-cpp
