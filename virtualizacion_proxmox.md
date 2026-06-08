Instalación de sistema operativo en Proxmox

1. El entorno de trabajo
El servidor Proxmox está montado en una computadora física dedicada en casa de mi compañero Pablo. Para administrarlo y meter los sistemas, nos conectamos a la interfaz web de forma remota usando su dirección del servidor.

2. Subir la imagen de Kali
Entramos al almacenamiento local de Proxmox y subimos el archivo ISO que íbamos a usar: kali-linux-2025.4-installer-amd64.iso. Con esto ya disponible en el sistema, pudimos empezar a configurar la máquina virtual desde el botón "Crear VM" arriba a la derecha.

3. Configuración del hardware
A la máquina virtual le dimos la ID 100 y la llamamos kali. En la pestaña de Hardware le asignamos la configuración ideal para que vaya fluida:
- Procesador: 4 núcleos en total (repartidos en 2 sockets y 2 núcleos por socket).
- Memoria RAM: 2.00 GiB de RAM.
- Disco duro: Le creamos un disco de 50 GB en el almacenamiento Disco_MV usando el controlador VirtIO SCSI.
- Red: Mapeada al puente vmbr0 con un dispositivo VirtIO para tener internet directo desde el router.

4. Instalación del sistema operativo
En el lector de CD virtual de la máquina dejamos puesta la ISO de Kali que subimos al principio. Arrancamos la máquina virtual por primera vez, abrimos la consola web de Proxmox y seguimos el asistente gráfico de instalación configurando el usuario, la contraseña y dejando que use esos 50 GB de disco asignados.

5. Detalles finales
De momento, la máquina ya arranca y funciona perfectamente en el nodo de Proxmox. Como detalle pendiente, en las opciones de la máquina dejamos desactivado el QEMU Guest Agent, por lo que Proxmox no muestra directamente la IP interna de la máquina en el resumen, pero para usarla con la consola funciona de diez.


<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/593576c1-da38-4c48-b352-cd1bb0f49987" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8bd77714-db7a-4db9-b90e-dad26988c152" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5d3fc691-7663-4260-86e1-a37e645540e7" />

