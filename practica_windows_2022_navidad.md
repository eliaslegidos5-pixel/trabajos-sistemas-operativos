**Autor:** Elías Legidos  
**Curso:** 2º ASIR

Se trata de un proyecto guiado, donde se completa una serie de tareas. Es esencial completar las unidades en orden. Cada unidad requiere recursos y configuración de unidades anteriores para funcionar correctamente.

---

## Instalar Windows Server 2022 en una máquina virtual

Descargaremos la ISO y la pondremos en VirtualBox, una vez tengamos la máquina la iniciamos.

Una vez estemos dentro para instalar la ISO nos instalamos la **Standart Evaluation (experiencia de escritorio)**.

Le damos a **instalación personalizada** e instalamos el sistema operativo en el único disco que tenemos que ahora mismo está vacío, una vez instalado, se reiniciará.

Una vez reiniciado ponemos la configuración de contraseña y nombre del equipo.

Iniciamos sesión.

Una vez iniciada la sesión cambiamos la configuración de red.

En el menú Inicio, abra el Administrador del servidor, seleccione **Servidor local** y, a continuación, **Nombre del equipo**.  
Esto abrirá el cuadro de diálogo Propiedades del sistema.  
En la página Nombre del equipo seleccione **Cambiar** y le ponemos de nombre **TAILWIND-DC1**, para que los cambios se apliquen habrá que reiniciar el equipo.

Una vez reiniciado, en el administrador del servidor agregamos **roles y características** y agregamos **servicios de dominio en Active Directory**.

Una vez agregado, le damos a **promover este servidor a controlador de dominio**.

Una vez dentro agregamos un nuevo bosque y ponemos nombre de dominio raíz **tailwindtraders.internal**, en las siguientes pestañas le damos a siguiente hasta llegar al final y le damos a **instalar**.

Una vez se reinicie veremos que ya estamos dentro del dominio e iniciamos sesión con la cuenta de administrador.

---

## Crear un servidor miembro del dominio de Windows Server

Lo primero que necesitaremos para continuar con la práctica anterior es otro Windows Server 2022 a parte del que ya teníamos con anterioridad. Así que replicaremos los pasos anteriores hasta tener el sistema operativo listo para usar.

Ya dentro del equipo, cambiaremos la configuración de red.

Cambiamos el nombre del equipo, aunque esta vez se llamará **TAILWIND-MBR1**.

Una vez cambiado el nombre le damos a **cambios de dominio o nombre del equipo** y ponemos que somos miembros del dominio **TAILWINDTRADERS**.  
Una vez pongamos usuario y contraseña ya estaremos dentro. Después reiniciaremos.

---

## Instalar los Servicios de dominio de Active Directory (AD DS) y promover a Controlador de dominio

Dentro de la máquina que hemos unido al dominio, entramos con la cuenta de administrador del dominio y desde el administrador del servidor, en **roles y características**, agregamos servicios de dominio de Active Directory.

Una vez instalado promovemos el servidor como controlador de dominio y lo agregamos a un controlador de dominio existente, le ponemos la contraseña y le damos a siguiente hasta instalar. Una vez instalado reiniciaremos.

Una vez reiniciado abrimos **Usuarios y equipos de Active Directory**:

1. Seleccione **Todas las tareas** → **Maestros de operaciones**  
2. En la pestaña **RID**, seleccione **Cambiar**, pulse **Sí** y **Aceptar**  
3. Haga clic en **Cerrar**

Una vez hecho eso abrimos el Windows donde estamos como controladores de dominio, es decir, el primero, y en **Herramientas** añadiremos un nuevo **sitio** al cual le añadiremos una **subred**.

---

## Crear unidades organizativas

En el Windows controlador de dominio, abra **Usuarios y equipos de Active Directory**:

- Clic derecho en el dominio **tailwindtraders.internal**
- Seleccione **Nuevo → Unidad organizativa**
- Crear:
  - Sydney
  - Melbourne
  - Brisbane

---

## Crear usuarios

En la misma máquina, en **Usuarios y equipos de Active Directory**, hacemos clic en **OU Sydney**, le damos a **Nuevo → Usuario** y le ponemos nombre y contraseña.  
Antes de añadir el usuario configuramos que la fecha de vencimiento sea el **1 de enero de 2030**.

Ahora en las otras unidades organizativas crearemos sus correspondientes usuarios con contraseña.

---

## Crear grupo administradores en Sydney

En la misma máquina, clic derecho en **Sydney** → **Nuevo → Grupo**  
Creamos el grupo **Sydney Administrators** de tipo **Universal** y agregamos el usuario de Sydney al grupo.

---

## Configurar un usuario como Usuario Protegido

En Sydney, agregamos el usuario creado al grupo **Protected Users**.

---

## Delegar permisos de seguridad a una OU

En **TAILWIND-DC1**:

- Abrir Usuarios y equipos de Active Directory
- Clic derecho en la OU **Sydney** → **Delegar control**
- Agregar **Sydney Administrators**
- Delegar:
  - Restablecer contraseñas
  - Forzar cambio de contraseña en el próximo inicio de sesión

---

## Configurar el atributo de ciudad para un usuario

En **TAILWIND-DC1**:

- Seleccionar la OU **Sydney**
- Clic derecho en el usuario **SydneyContractor** → **Propiedades**
- En la pestaña **Dirección**, configurar **Ciudad: Sydney**
- Aceptar

---

## Deshabilitar y restablecer usuarios

Deshabilitar el usuario contratista de **Melbourne**.

Restablecer la contraseña del usuario **Brisbane Contractor**.

---

## Configurar la política de contraseñas del dominio

En **TAILWIND-DC1**:

- Abrir **Administración de políticas de grupo**
- Editar la **Política de dominio predeterminada**
- Configurar **Longitud mínima de contraseña: 14 caracteres**
- Guardar y cerrar

---

## Configurar una política de contraseñas de grano fino

Desde el **Centro administrativo de Active Directory**:

- Crear política **Domain Admin Password Policy**
- Precedencia: 1
- Longitud mínima: 16 caracteres
- Aplicar a **Domain Admins**

---

## Habilitar la papelera de reciclaje de Active Directory

Desde el Centro administrativo de Active Directory:

- Seleccionar **Tailwindtraders (local)**
- Habilitar papelera de reciclaje
- Aceptar advertencias

---

## Restringir la autenticación NTLM

En la **Política de controlador de dominio predeterminada**:

- Seguridad de red: Restringir NTLM
- Configurar como **Denegar todo**
- Confirmar cambios

---

## Auditoría de la gestión de cuentas de usuario en Sídney

- Crear GPO **SydneyOUPolicy**
- Auditar gestión de cuentas de usuario
- Marcar **Éxito y Fracaso**

---

## Denegar el inicio de sesión como servicio

En **SydneyOUPolicy**:

- Denegar inicio de sesión como servicio
- Agregar grupo **Administradores de Sydney**

---
