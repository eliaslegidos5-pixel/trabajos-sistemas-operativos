# UD 03. Caso práctico 03  
## Accediendo a interfaz gráfica con NoVNC

**Autor:** Elías Legidos  
**Curso:** 2ASIR

---


Para este caso práctico, simplemente creamos un contenedor a partir de la imagen descrita en https://github.com/theasp/docker-novnc, la cual tiene todo listo para funcionar. La lanzaremos con el siguiente comando:
```
 docker run --rm -it -p 8080:8080 theasp/novnc 
```
