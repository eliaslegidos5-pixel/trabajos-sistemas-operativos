# Instalación, gestión y configuración de la impresora virtual PDF

**Autor:** Elías Legidos 2ASIR

El objetivo de esta actividad es instalar la impresora virtual de documentos PDF y familiarizarse con los archivos y aplicaciones implicados en la configuración de impresoras en el entorno CUPS.

---

## 1. Instalar en CUPS la impresora virtual de documentos PDF

Para en cups la impresora virtual tenemos que poner el la linea de comandos estos comandos:

```bash
sudo apt update
sudo apt install cups-pdf
```



---

## 2. Comprobar mediante línea de comandos, aplicación gráfica e interfaz web de que la impresora está correctamente dada de alta en el sistema

### Mediante la línea de comandos

El comando sería:

```bash
lpstat -p
lpstat -d
```



### Aplicación Gráfica

Preparada



### Interfaz web

Interfaz web sería en:

```
http://localhost:631
```

**Impresoras**
- Buscar impresoras:
- Nombre cola: PDF
- Descripción: PDF
- Marca: -
- Estado: Preparada



---

## 3. Visualizar el archivo que contiene las impresoras locales

El archivo que queremos entrar está dentro de la dirección:

```
/usr/share/ppd/cups-pdf/
```

Dentro de ahí hay 2 archivos: 1 el de configuración y otro el que buscamos.



---

## 4. Visualizar el archivo PPD que contiene la configuración de la impresora PDF

En la ruta anterior que hemos puesto, abrimos el archivo ppd:




## 5. Imprimir cualquier documento con esta impresora con aplicación gráfica y con línea de comandos y comprobar su resultado

### Desde aplicación gráfica

Para imprimir desde dentro de una aplicación, en nuestro caso abriremos el LibreOffice dentro de la máquina virtual, escribiremos algo y le daremos a archivo e imprimir.



### Desde línea de comandos

Para imprimir desde línea de comandos ejecutaremos el comando:

```bash
lp -d CUPS-PDF prueba.txt
```

Y veremos el resultado en:

```bash
ls ~/PDF
```


---

## 6. Averiguar consultando Internet cómo cambiar el directorio por defecto al que la impresora PDF envía los trabajos de impresión

Para cambiar la carpeta donde se almacenan los PDFs generados por CUPS-PDF:

### Paso 1: Editar el archivo de configuración

Edita como root el archivo de configuración, normalmente:

```bash
sudo nano /etc/cups/cups-pdf.conf
```

### Paso 2: Buscar la línea Out

Busca la línea que empieza con `Out`. Por defecto suele decir algo como:

```
Out ${HOME}/PDF
```

Esta línea indica que los PDFs se generan en la carpeta PDF del usuario.

### Paso 3: Modificar la ruta

Modifica esa línea para indicar la carpeta que desees, por ejemplo:

```
Out ${HOME}/Documentos/PDFs
```

O cualquier otra ruta absoluta o relativa a tu usuario, según prefieras.

### Paso 4: Guardar los cambios

Guarda los cambios y cierra el editor.

### Paso 5: Reiniciar el servicio CUPS

Reinicia el servicio CUPS para que la nueva configuración tenga efecto:

```bash
sudo systemctl restart cups
```

---
### Paso 6:
 Guarda los cambios y cierra el editor.
 Reinicia el servicio CUPS para que la nueva configuración tenga efecto:
```
   sudo systemctl restart cups
```
