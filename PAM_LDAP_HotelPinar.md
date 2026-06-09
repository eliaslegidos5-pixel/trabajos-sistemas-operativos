# Configuración de Usuarios y Accesos (PAM/LDAP Linux)
## Proyecto Intermodular ASIR 2025/2026 — HotelPinar

---

## 1. Introducción

El presente documento describe la planificación e implementación del sistema de gestión centralizada de usuarios y control de accesos basado en PAM/LDAP para la cadena hotelera HotelPinar. El sistema ha sido desplegado sobre una máquina virtual Kali Linux (IP: 10.2.10.3) alojada en el entorno de virtualización Proxmox del centro educativo, dentro de la subred 10.2.10.0/24 asignada al proyecto.

El objetivo principal es disponer de un controlador de dominio LDAP centralizado que gestione la autenticación de los empleados y huéspedes de los tres hoteles de la cadena, el control de horarios laborales, el registro de entradas y salidas, y el control de permisos por rol.

---

## 2. Planificación

### 2.1 Objetivos del sistema

- Autenticación centralizada de empleados para acceso a la red administrativa (S2) y a la aplicación web corporativa (S7).
- Autenticación de usuarios HotSpot (huéspedes) a través de RADIUS integrado con LDAP (S1).
- Control de horario laboral mediante PAM: restricción de acceso fuera del horario permitido.
- Registro automático de entradas y salidas de cada empleado en un fichero de log.
- Gestión centralizada de usuarios: creación, eliminación y modificación de cuentas desde un único punto.
- Control de permisos por rol: empleados, gestores, administradores y usuarios de hotspot.

### 2.2 Tecnologías utilizadas

| Tecnología | Función |
|---|---|
| OpenLDAP (slapd) | Servidor LDAP, actúa como controlador de dominio |
| phpLDAPadmin | Interfaz web de administración del directorio |
| PAM | Módulo de autenticación del sistema Linux |
| pam_time | Restricción de acceso por horario |
| pam_exec | Ejecución de scripts en eventos de sesión |
| Apache2 + PHP | Servidor web para alojar phpLDAPadmin |

### 2.3 Infraestructura

| Parámetro | Valor |
|---|---|
| Plataforma de virtualización | Proxmox VE 9.1.5 |
| VM | Kali Linux (ID 100) |
| IP del servidor LDAP | 10.2.10.3 |
| Subred del proyecto | 10.2.10.0/24 |
| Dominio LDAP | dc=hotelpinar,dc=local |
| DN de administrador | cn=admin,dc=hotelpinar,dc=local |

### 2.4 Estructura del directorio LDAP

```
dc=hotelpinar,dc=local
│
├── ou=usuarios
│     ├── uid=jdirector    (gestor, hotel1)
│     ├── uid=mrecepcion   (empleado, hotel1)
│     ├── uid=huesped001   (hotspot, hotel1)
│     ├── uid=jdirector2   (gestor, hotel2)
│     ├── uid=mrecepcion2  (empleado, hotel2)
│     ├── uid=huesped002   (hotspot, hotel2)
│     ├── uid=jdirector3   (gestor, hotel3)
│     ├── uid=mrecepcion3  (empleado, hotel3)
│     └── uid=huesped003   (hotspot, hotel3)
│
├── ou=grupos
│     ├── cn=empleados  (gidNumber: 2001)
│     ├── cn=gestores   (gidNumber: 2002)
│     ├── cn=hotspot    (gidNumber: 2003)
│     └── cn=admin      (gidNumber: 2004)
│
└── ou=hoteles
      ├── ou=hotel1
      ├── ou=hotel2
      └── ou=hotel3
```

---

## 3. Implementación

### 3.1 Instalación de OpenLDAP

Se ha instalado el servidor OpenLDAP en la VM Kali mediante:

```bash
sudo apt update
sudo apt install slapd ldap-utils -y
```

A continuación se ha reconfigurado el dominio base del servidor LDAP:

```bash
sudo dpkg-reconfigure slapd
```

Parámetros aplicados durante la reconfiguración:

| Parámetro | Valor |
|---|---|
| DNS domain name | hotelpinar.local |
| Organization name | HotelPinar |
| Database backend | MDB |
| Eliminar BD al purgar | No |

### 3.2 Instalación de phpLDAPadmin

Para facilitar la administración visual del directorio se ha instalado phpLDAPadmin junto con Apache2:

```bash
sudo apt install phpldapadmin apache2 -y
```

Se ha modificado `/etc/phpldapadmin/config.php` con los siguientes valores:

```php
$servers->setValue('server','name','Hotelpinar LDAP');
$servers->setValue('server','host','127.0.0.1');
$servers->setValue('server','base',array('dc=hotelpinar,dc=local'));
```

La interfaz web es accesible desde la propia VM Kali en: `http://127.0.0.1/phpldapadmin`

### 3.3 Creación de la estructura base del directorio

Se ha creado el fichero `~/estructura_hotelpinar.ldif` con la definición de todas las OUs y grupos:

```ldif
dn: ou=usuarios,dc=hotelpinar,dc=local
objectClass: organizationalUnit
ou: usuarios

dn: ou=grupos,dc=hotelpinar,dc=local
objectClass: organizationalUnit
ou: grupos

dn: ou=hoteles,dc=hotelpinar,dc=local
objectClass: organizationalUnit
ou: hoteles

dn: ou=hotel1,ou=hoteles,dc=hotelpinar,dc=local
objectClass: organizationalUnit
ou: hotel1

dn: ou=hotel2,ou=hoteles,dc=hotelpinar,dc=local
objectClass: organizationalUnit
ou: hotel2

dn: ou=hotel3,ou=hoteles,dc=hotelpinar,dc=local
objectClass: organizationalUnit
ou: hotel3

dn: cn=empleados,ou=grupos,dc=hotelpinar,dc=local
objectClass: posixGroup
cn: empleados
gidNumber: 2001

dn: cn=gestores,ou=grupos,dc=hotelpinar,dc=local
objectClass: posixGroup
cn: gestores
gidNumber: 2002

dn: cn=hotspot,ou=grupos,dc=hotelpinar,dc=local
objectClass: posixGroup
cn: hotspot
gidNumber: 2003

dn: cn=admin,ou=grupos,dc=hotelpinar,dc=local
objectClass: posixGroup
cn: admin
gidNumber: 2004
```

Aplicado mediante:

```bash
ldapadd -x -D "cn=admin,dc=hotelpinar,dc=local" -W -f ~/estructura_hotelpinar.ldif
```

### 3.4 Creación de usuarios

Se han creado usuarios representativos para los tres hoteles. Para cada hotel se han definido tres tipos: gestor, empleado de recepción y huésped de HotSpot.

Los ficheros LDIF utilizados:

- `~/usuarios_hotel1.ldif` — jdirector, mrecepcion, huesped001
- `~/usuarios_hotel2.ldif` — jdirector2, mrecepcion2, huesped002
- `~/usuarios_hotel3.ldif` — jdirector3, mrecepcion3, huesped003

Los ficheros de hotel2 y hotel3 se generaron a partir del de hotel1 con `sed`:

```bash
sed 's/hotel1/hotel2/g; s/jdirector/jdirector2/g; s/mrecepcion/mrecepcion2/g; \
s/huesped001/huesped002/g; s/3001/3007/g; s/3002/3008/g; s/4001/4002/g' \
~/usuarios_hotel1.ldif > ~/usuarios_hotel2.ldif
```

Atributos definidos en cada usuario:

| Atributo | Descripción |
|---|---|
| objectClass | inetOrgPerson, posixAccount, shadowAccount |
| uid, cn, sn, givenName, mail | Datos personales |
| uidNumber, gidNumber | Identificadores numéricos |
| homeDirectory | Directorio home del usuario |
| loginShell | /bin/bash (empleados) o /bin/false (huéspedes) |
| userPassword | Hash SSHA generado con slappasswd |
| description | hotel, horario y rol del usuario |

Aplicado con:

```bash
ldapadd -x -D "cn=admin,dc=hotelpinar,dc=local" -W -f ~/usuarios_hotelX.ldif
```

### 3.5 Control de horario laboral con PAM

Se han añadido las siguientes reglas al fichero `/etc/security/time.conf`:

```
# HotelPinar - Control de horarios
login;*;@empleados;Al0700-2000
sshd;*;@empleados;Al0700-2000
login;*;@gestores;MoTuWeThFr0600-2200
sshd;*;@gestores;MoTuWeThFr0600-2200
```

El módulo se ha activado en `/etc/pam.d/common-account`:

```
account required pam_time.so
```

### 3.6 Registro de entradas y salidas

Script creado en `/usr/local/bin/registro_horario.sh`:

```bash
#!/bin/bash
LOGFILE="/var/log/hotelpinar/horarios.log"
FECHA=$(date '+%Y-%m-%d %H:%M:%S')
USUARIO=$PAM_USER
TIPO=$PAM_TYPE

if [ "$TIPO" = "open_session" ]; then
    echo "$FECHA | ENTRADA | $USUARIO" >> $LOGFILE
elif [ "$TIPO" = "close_session" ]; then
    echo "$FECHA | SALIDA  | $USUARIO" >> $LOGFILE
fi
```

Registrado en `/etc/pam.d/common-session`:

```
session required pam_exec.so /usr/local/bin/registro_horario.sh
session required pam_mkhomedir.so skel=/etc/skel umask=077
```

Ejemplo del log generado:

```
2026-06-09 09:03:21 | ENTRADA | mrecepcion
2026-06-09 17:01:45 | SALIDA  | mrecepcion
```

### 3.7 Persistencia de servicios

Para que los servicios arranquen automáticamente tras un reinicio:

```bash
sudo systemctl enable slapd
sudo systemctl enable apache2
```

---

## 4. Integración con otros subsistemas del proyecto

| Subsistema | Integración con LDAP |
|---|---|
| S1 — HotSpot | Los usuarios del grupo `cn=hotspot` se autentican vía FreeRADIUS consultando LDAP |
| S2 — Red Administrativa | Solo los grupos `cn=empleados` y `cn=gestores` acceden a la VLAN administrativa |
| S5 — Bases de Datos | La BD de autenticación HotSpot referencia el directorio LDAP como fuente de usuarios |
| S6 — Seguridad | PAM controla acceso por horario y grupo como primera línea de control lógico |
| S7 — Web Corporativa | La web autentica contra LDAP y muestra contenido según rol (empleado/gestor) |

Cuando se dispongan de las VMs cliente de cada hotel, se completará la configuración PAM+LDAP instalando `libpam-ldap`, `libnss-ldap` y `nslcd`, apuntando al servidor `10.2.10.3`.

---

## 5. Conclusión

Se ha implementado correctamente un servidor OpenLDAP centralizado en la VM Kali Linux (10.2.10.3) dentro del entorno Proxmox del proyecto. El directorio dispone de una estructura organizativa completa con OUs por hotel, grupos de acceso por rol y usuarios representativos para los tres hoteles de la cadena HotelPinar.

El sistema PAM ha sido configurado para controlar el horario de acceso de empleados y gestores, y el script de registro permite auditar las entradas y salidas de cada usuario. Todos los servicios están habilitados para iniciarse automáticamente con el sistema.

Queda pendiente la integración con las VMs cliente de cada hotel (Parte 5) y la conexión con FreeRADIUS para la autenticación del HotSpot, que se completarán en fases posteriores del proyecto.
