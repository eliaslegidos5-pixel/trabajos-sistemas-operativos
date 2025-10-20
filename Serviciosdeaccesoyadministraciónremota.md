# Servicios de acceso y administración remota mediante Ssh

## 1. Abre el cliente y el servidor e instala el servicio de ssh
```
Sudo apt update 
sudo apt install openssh-server

```

## 2. una vez instalado comprobamos que se haya instalado correctamente

```
sudo systemctl status ssh
```

## 3.Una vez configurada la red comprobamos que se pueda hacer ping de una maquina a otra , en mi caso una ip es la 10.2.1.13 y la otra la 10.2.1.14 , habrá que poner una máquina en DHCP y la otra en estática.
```
Ping 10.2.1.14
```

## 4. Conectaríamos vía SSH hacía la máquina que tiene el ssh 
```
Ssh Elias@10.2.1.13 
```

## 5. Una vez pongamos la Clave del usuario remoto ya estaremos dentro
```

* contraseña

Conexión con el servidor
```




# Servicios de acceso y administración remota mediante Telnet

## 1. Instalar y configurar Telnet Server en la máquina
```
sudo apt install xinetd telnetd
```

## 2. Creamos un archivo de configuración para el servicio Telnet
```
sudo nano /etc/xinetd.d/telnet
```

## 3. Dentro del fichero ponemos el siguiente texto
```
service telnet
{
    disable         = no
    flags           = REUSE
    socket_type     = stream
    wait            = no
    user            = root
    server          = /usr/sbin/in.telnetd
    log_on_failure  += USERID
}
```

## 4. Comprobar que funciona correctamente el servicio
```
sudo systemctl status xinetd
```

## 5. Una vez comprobado que esta instalado nos conectaremos mediante el puerto 389 ya que el 23 no funciona bien.
```
Telnet 10.2.1.14 389
```


