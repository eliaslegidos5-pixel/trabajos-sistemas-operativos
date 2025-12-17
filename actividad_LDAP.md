# Ejercicio información LDAP  
**Elías Legidos – 2º ASIR**

---

## Planificación de la fusión de directorios LDAP

Es el proceso de preparar y organizar la unión de dos o más directorios LDAP (por ejemplo, dos servidores con usuarios distintos) en uno solo.

### Sirve para:
- Unificar usuarios y grupos de diferentes sistemas  
- Evitar duplicados de cuentas  
- Mantener permisos y datos correctos  
- Reducir errores durante la migración  

Esta es la parte más importante del proceso, ya que es la que evita la pérdida de datos.

---

## Creación de un archivo LDIF

Un archivo **LDIF (LDAP Data Interchange Format)** es un archivo de texto que describe datos de un directorio LDAP.

### Sirve para:
- Añadir usuarios, grupos u otras entradas al LDAP  
- Importar datos desde otro servidor  
- Crear estructuras organizativas (ou)  
- Automatizar la carga de información  

Se usa normalmente con comandos como **`ldapadd`**, que sirve para añadir entradas, aunque también se pueden usar otros comandos para modificar o borrar dichas entradas.

---

## Archivo LDIF para modificar datos

Es un archivo LDIF especial que no crea entradas nuevas, sino que modifica las que ya existen.

### Sirve para:
- Cambiar correos electrónicos  
- Actualizar contraseñas  
- Añadir o eliminar atributos  
- Corregir errores sin borrar usuarios  

Se aplica con el comando **`ldapmodify`**.
