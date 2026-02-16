# UD 06.08 - Caso práctico 06 - Despliegue de Stable Diffusion

**Elías Legidos -- 2º ASIR**

Lo primero de todo descomprimimos en una carpeta el archivo `.zip`.

------------------------------------------------------------------------

Después de probar varias veces no he podido acceder ya que la práctica
es muy antigua y no está actualizada, pero tendríamos que hacer lo
siguiente:

## Pasos a seguir

1.  Acceder a la carpeta que acabo de descomprimir del repositorio de
    Stable Diffusion.

2.  Abrir la terminal de comandos y meterme dentro de esa carpeta.

3.  Lanzar el primer comando para empezar a descargar los modelos de IA:

``` bash
docker compose --profile download up --build
```

4.  Cuando termine la descarga, ejecutar el comando para activar la
    interfaz web:

``` bash
docker compose --profile auto-cpu up --build
```

5.  Esperar hasta que aparezca en la terminal un mensaje indicando que
    el servidor ya está listo.

6.  Entrar en el navegador y acceder a:

```{=html}
<!-- -->
```
    127.0.0.1:7860

7.  Escribir una descripción (prompt) y esperar a que la IA genere una
    imagen.
