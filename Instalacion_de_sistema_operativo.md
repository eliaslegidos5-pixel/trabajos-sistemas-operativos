# Instalación de sistema operativo

## 1. Lo que necesitas
Para empezar, te hace falta un pendrive vacío de mínimo 8 GB y bajarte la ISO de Kali Linux desde su web oficial. También descárgate un programa que se llama Rufus (para Windows) o BalenaEtcher. Obviamente, necesitas la computadora nueva donde vas a meter el sistema.

## 2. Preparar el USB
Mete el pendrive en tu computadora actual y abre Rufus o BalenaEtcher. Selecciona el archivo ISO de Kali que descargaste y dale a empezar para que se grabe en el USB. Ojo, esto va a borrar todo lo que tengas en ese pendrive, así que asegúrate de que no haya nada importante.

## 3. Configurar la computadora
Apaga la computadora nueva y conéctale el USB. Enciéndela y dale varias veces a la tecla para entrar a la BIOS (suele ser F2, F12 o Supr). Una vez dentro, busca la opción "Secure Boot" y desactívala, y luego cambia el orden de arranque para que la máquina inicie desde el USB y no desde el disco duro. Guarda los cambios y reinicia.

## 4. Instalación paso a paso
Cuando encienda, elige la opción "Graphical Install". A partir de ahí, el asistente te irá guiando: elige el idioma español, ponle un nombre a la máquina y créate un usuario con su contraseña. Cuando te pregunte por el disco, elige "Utilizar todo el disco" (como es nueva, no hay peligro de borrar nada) y dale a siguiente a todo lo que venga por defecto hasta que termine de instalarse.

## 5. Primer inicio y actualizar
Cuando termine, te dirá que saques el USB y que reinicies. La computadora encenderá ya con Kali Linux y te pedirá el usuario y contraseña que creaste antes. Para terminar, abre una terminal y escribe `sudo apt update && sudo apt full-upgrade -y` para dejar el sistema al día con las últimas actualizaciones.
