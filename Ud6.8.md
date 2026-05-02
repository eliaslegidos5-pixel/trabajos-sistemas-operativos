# UD 06.08 - Caso práctico 06 - Despliegue de Stable Diffusion

**Elías Legidos -- 2º ASIR**

Lo primero de todo descomprimimos en una carpeta el archivo `.zip`.



Después de probar varias veces no he podido acceder ya que la práctica
es muy antigua y no está actualizada, además de que necesito de 20 a 30 GB en el ordenador y no tengo espacio
pero tendríamos que hacer lo siguiente:

## PASO 1 — Clonar el repositorio



``` 
cd C:\Users\Elias\wisper_ai
git clone https://github.com/AbdBarho/stable-diffusion-webui-docker.git
```

PASO 2 — Entrar en la carpeta

``` 
cd stable-diffusion-webui-docker
```

PASO 3 — Descargar todo lo necesario

``` 
docker compose --profile download up --build
```

Esto tardará bastante, descarga los modelos de IA. Espera a que termine completamente.


PASO 4 — Arrancar la interfaz


``` 
docker compose --profile auto-cpu up --build
```


PASO 5 — Comprobar que funciona

Abre el navegador y ve a:

``` 
http://localhost:7860
```

Deberías ver la interfaz de Stable Diffusion donde puedes escribir texto y generar imágenes.
