# UD 03. Caso práctico 03  
## Accediendo a interfaz gráfica con NoVNC

**Autor:** Elías Legidos  
**Curso:** 2ASIR

---


Para este caso práctico, simplemente creamos un contenedor a partir de la imagen descrita en https://github.com/theasp/docker-novnc, la cual tiene todo listo para funcionar. La lanzaremos con el siguiente comando:
```
 docker run --rm -it -p 8080:8080 theasp/novnc 
```

Abriendo un navegador a la siguiente URL http://localhost:8080/vnc.html se nos cargará un cliente NoVNC (Cliente VNC en HTML5 y Javascript). Simplemente, conectaremos con dicho cliente y en nuestro navegador veremos una interfaz gráfica dentro de nuestro contenedor. 

Una vez hecho podremos ver que nos ha aparecido una interfaz gráfica .
