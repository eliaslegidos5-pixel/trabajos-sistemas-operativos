# Cambio de opciones de impresora

**Autor:** Elías Legidos 2ASIR

El objetivo de esta actividad es realizar cambios en la configuración de las opciones de impresión, tanto en trabajos concretos como dejando los cambios como configuración por defecto.

---

## 1. Imprimir desde consola un archivo de imagen en papel de tamaño A5 apaisado

Para imprimir la imagen en papel A5 que queremos, tendremos que poner este comando:

```bash
lp -d PDF -o media=A5 -o orientation-requested=4 imagen.jpg
```

### Explicación de los parámetros:

- **`imagen.jpg`**: La imagen que queremos imprimir
- **`-d PDF`**: Impresora a usar
- **`-o media=A5`**: Tamaño de papel A5
- **`-o orientation-requested=4`**: Orientación apaisado (landscape)

---

## 2. Que todos los usuarios de la máquina tengan como opciones predeterminadas tamaño de papel A4 con margen izquierdo de una pulgada

Para poner el tamaño predeterminado A4, usamos:

```bash
sudo lpadmin -p PDF -o media=A4 -o page-left=72
```

### Notas importantes:

- En CUPS, **1 pulgada = 72 puntos**, por eso `page-left=72`
- Esto actualiza la configuración por defecto de la impresora para **todos los usuarios del sistema local**

---

## 3. Que todos los clientes de la red tengan la impresora configurada para una resolución de 150 puntos por pulgada

Usaríamos el siguiente comando:

```bash
sudo lpadmin -p PDF -o printer-resolution=150dpi
```

### Explicación:

Esto modifica la opción por defecto para la impresora publicada por CUPS, por lo que **todos los equipos que la usen a través del servidor** recibirán esta resolución en su configuración.

---

## Resumen de comandos

| Tarea | Comando | Alcance |
|-------|---------|---------|
| Imprimir imagen A5 apaisado | `lp -d PDF -o media=A5 -o orientation-requested=4 imagen.jpg` | Trabajo individual |
| Configurar A4 con margen izquierdo | `sudo lpadmin -p PDF -o media=A4 -o page-left=72` | Usuarios locales (predeterminado) |
| Configurar resolución 150dpi | `sudo lpadmin -p PDF -o printer-resolution=150dpi` | Clientes de red (predeterminado) |

---


**Fecha:** 30/11/2025

