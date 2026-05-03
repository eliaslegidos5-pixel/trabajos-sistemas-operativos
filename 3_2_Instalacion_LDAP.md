# Instalación, configuración y mantenimiento del servicio de directorio

**Elías Legidos 2ASIR**

---

### PASO 1 — Instalar OpenLDAP en Debian

```bash
sudo apt-get update
sudo apt-get install slapd ldap-utils
```

Una vez se esté instalando nos pedirá una contraseña.

---

### PASO 2 — Reconfigurar slapd con el dominio correcto

```bash
sudo dpkg-reconfigure slapd
```

Nos hará varias preguntas, las cuales tenemos que responder así:

- ¿Omitir configuración? → No
- Nombre DNS: serveisbcn.com
- Nombre organización: serveisbcn
- Contraseña: la que pusiste antes
- Motor de base de datos: MDB
- ¿Eliminar base de datos al purgar? → No
- ¿Mover base de datos antigua? → Sí

---

### PASO 3 — Verificar que funciona

```bash
sudo systemctl status slapd
```

---

### PASO 4 — Configurar ppolicy

```bash
nano ppolicy_module.ldif
```

Y pegaremos esto:

```ldif
dn: cn=module,cn=config
objectClass: olcModuleList
cn: module
olcModulePath: /usr/lib/ldap
olcModuleLoad: ppolicy.la
```

```bash
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f ppolicy_module.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/ppolicy.schema
```

---

### PASO 5 — Crear el archivo LDIF con la estructura

```bash
nano estructura.ldif
```

Y dentro pondremos todo esto:

```ldif
# Unidades organizativas Barcelona
dn: ou=Barcelona,dc=serveisbcn,dc=com
objectClass: organizationalUnit
ou: Barcelona

dn: ou=Personal,ou=Barcelona,dc=serveisbcn,dc=com
objectClass: organizationalUnit
ou: Personal

dn: ou=Equipamiento,ou=Barcelona,dc=serveisbcn,dc=com
objectClass: organizationalUnit
ou: Equipamiento

# Unidades organizativas Sabadell
dn: ou=Sabadell,dc=serveisbcn,dc=com
objectClass: organizationalUnit
ou: Sabadell

dn: ou=Personal,ou=Sabadell,dc=serveisbcn,dc=com
objectClass: organizationalUnit
ou: Personal

dn: ou=Equipamiento,ou=Sabadell,dc=serveisbcn,dc=com
objectClass: organizationalUnit
ou: Equipamiento

# Empleado Barcelona
dn: cn=Joan Garcia,ou=Personal,ou=Barcelona,dc=serveisbcn,dc=com
objectClass: inetOrgPerson
cn: Joan Garcia
sn: Garcia
givenName: Joan
title: Técnico
telephoneNumber: 931234567
mail: jgarcia@serveisbcn.com
l: Barcelona

# Equipo Barcelona
dn: cn=PC-BCN-01,ou=Equipamiento,ou=Barcelona,dc=serveisbcn,dc=com
objectClass: device
cn: PC-BCN-01
serialNumber: SN123456
owner: cn=Joan Garcia,ou=Personal,ou=Barcelona,dc=serveisbcn,dc=com
l: Barcelona
description: Ordenador de sobremesa

# Empleado Sabadell
dn: cn=Maria Lopez,ou=Personal,ou=Sabadell,dc=serveisbcn,dc=com
objectClass: inetOrgPerson
cn: Maria Lopez
sn: Lopez
givenName: Maria
title: Administrativa
telephoneNumber: 937654321
mail: mlopez@serveisbcn.com
l: Sabadell

# Equipo Sabadell
dn: cn=PC-SAB-01,ou=Equipamiento,ou=Sabadell,dc=serveisbcn,dc=com
objectClass: device
cn: PC-SAB-01
serialNumber: SN654321
owner: cn=Maria Lopez,ou=Personal,ou=Sabadell,dc=serveisbcn,dc=com
l: Sabadell
description: Portátil
```

---

### PASO 6 — Añadir la estructura al directorio

```bash
ldapadd -x -D "cn=admin,dc=serveisbcn,dc=com" -W -f estructura.ldif
```

Y pondremos la contraseña que pusimos en la configuración.

---

### PASO 8 — Buscar usuarios con teléfono

```bash
ldapsearch -x -b "dc=serveisbcn,dc=com" "(objectClass=inetOrgPerson)" cn telephoneNumber
```

---

### PASO 9 — Buscar equipos

```bash
ldapsearch -x -b "dc=serveisbcn,dc=com" "(objectClass=device)" cn
```
