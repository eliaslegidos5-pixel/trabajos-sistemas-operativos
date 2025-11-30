# Control de acceso a la interfaz de administración web de CUPS

**Autor:** Elías Legidos

Por defecto, sólo se puede acceder a la administración web de CUPS desde la máquina local y por parte de usuarios con derecho de administración. El objetivo de esta actividad es conocer las posibilidades de cambiar los permisos de acceso a CUPS tanto de máquinas remotas como usuarios.

---

## 1. Permitir que se pueda acceder a la interfaz web desde cualquier ordenador de la red

Para permitir que cualquier ordenador de la red pueda acceder a la interfaz web tenemos que hacer lo siguiente:

Entraríamos en:
```bash
/etc/cups/cupsd.conf
```

Y buscaríamos la línea:
```apache
<Location /admin>
Order allow,deny
</Location>
```

Para que cualquier persona de la red pueda acceder a la interfaz web deberemos poner lo siguiente:

```apache
<Location /admin>
Order allow,deny
Allow 10.0.2.0/24
</Location>
```

Siendo la IP de red la que pondríamos.





**Archivo de configuración:**

```apache
# Default authentication type, when authentication is required.
DefaultAuthType Basic

# Web interface setting
WebInterface Yes

# Timeout after cupsd exits if idle (applied only if cupsd on-demand)
IdleExitTimeout 60

# Restrict access to the server
<Location />
Order allow,deny
</Location>

# Restrict access to the admin pages
<Location /admin>
Order allow,deny
allow 10.0.2.0
</Location>
```

---

## 2. Habilitar la interfaz web sólo en modo local o desde una dirección IP concreta

Para ponerlo en modo local pondríamos `localhost` o la IP que queramos. En mi caso lo pondré en modo local.



**Archivo de configuración:**

```apache
# Default authentication type, when authentication is required.
DefaultAuthType Basic

# Web interface setting
WebInterface Yes

# Timeout after cupsd exits if idle (applied only if cupsd on-demand)
IdleExitTimeout 60

# Restrict access to the server
<Location />
Order allow,deny
</Location>

# Restrict access to the admin pages
<Location /admin>
Order allow,deny
Allow localhost
</Location>
```

---

## 3. Permitir acceder a toda la interfaz de administración al usuario pepet, al grupo de profesores sólo para la administración de trabajos de impresión y a cualquier usuario correctamente identificado para gestionar las impresoras

### Usuario pepet

Configuración para permitir acceso completo a la administración al usuario `pepet`:

```apache
<Location /admin>
AuthType Default
Require user pepet
Order allow,deny
Allow localhost
Allow all
</Location>
```

### Grupo profesores

Configuración para permitir al grupo `profesores` administrar solo los trabajos de impresión:

```apache
<Location /admin/jobs>
AuthType Default
Require user @profesores
Order allow,deny
Allow all
</Location>
```

### Usuario identificado

Configuración para permitir a cualquier usuario autenticado gestionar las impresoras:

```apache
<Location /printers>
AuthType Default
Require valid-user
Order allow,deny
Allow all
</Location>
```

---

## Configuración completa en el sistema



**Archivo completo de configuración con las tres reglas:**

```apache
# Configuración completa de permisos

# Usuario pepet - acceso completo a administración
<Location /admin>
AuthType Default
Require user pepet
Order allow,deny
Allow localhost
Allow all
</Location>

# Grupo profesores - solo trabajos de impresión
<Location /admin/jobs>
AuthType Default
Require user @profesores
Order allow,deny
Allow all
</Location>

# Usuarios autenticados - gestión de impresoras
<Location /printers>
AuthType Default
Require valid-user
Order allow,deny
Allow all
</Location>
