# Comunicació de processos: senyals de teclat i valors de retornç

L’objectiu d’aquesta activitat és conèixer dues maneres de comunicar-se amb els processos: els senyals de teclat Ctrl+C i Ctrl+Z i els valors de retorn.

Per fer aquesta tasca es demana engegar un procés (per exemple, l’ordre yes) i enviar-li senyals mitjançant la combinació de tecles Ctrl+C i Ctrl+Z. Posteriorment cal analitzar quins han estat aquests senyals veient el valor de retorn del procés.

Primer arranquem el procés yes i l’aturem amb la combinació Ctrl+C:
```
 yes
^C
```

Immediatament comprovem el valor que ens retorna el procés en rebre el senyal. El valor de retorn es guarda a la variable representada pel símbol d’interrogació (?)
```
echo $?
130
```

Si restem 128 a aquest valor de retorn obtenim el codi d’aquest senyal. En aquest cas el senyal 2 correspon a SIGINT. Fem el mateix amb Ctrl+Z:

```
yes

[1]+ detenido  yes
127
```

# Comunicació de processos amb l'ordre kill i captura de senyals

L’objectiu d’aquesta activitat és practicar l’enviament de senyals amb l’ordre kill i veure com es pot capturar un senyal per efectuar una acció diferent a la inicialment programada.

Per fer aquesta tasca es considera l’script Bash següent, que podem anomenar trap.sh:

```
#!/bin/bash
#trap.sh Script per capturar senyals
 
trap "echo procés $$ ignora el senyal" SIGTSTP SIGINT
 
N=0
while true
do
((N++))
if [ $N -gt 200000 ];then
exit 1
fi
done
exit 0
```

Després li doném permissos d'execució per poder utilitzar l'escript.
```
sudo chmod 777 trap.sh
```

Amb aquesta línia de codi, quan el procés rep un senyal de teclat SIGTSTP (Ctrl+Z) o SIGINT (Ctrl+C) és capturat i presenta el missatge següent:
```
# ./trap.sh
^C procés 6033 ignora el senyal
^Z procés 6033 ignora el senyal
````

Per aturar aquest procés ja no podem fer res en aquesta consola. N’hem d’obrir una altra i enviar un senyal al procés mitjançant kill o killall:
```
killall trap.sh
```

# Gestió del nivell d'execució

L’objectiu d’aquesta activitat és conèixer el funcionament dels nivells d’execució de Linux Debian, com es configuren i quins directoris i arxius hi estan involucrats.

Habitualment en la instal·lació bàsica de Debian els nivells d’execució 2, 3 i 4 són iguals i el nivell per defecte és el 2. Per fer aquesta tasca es demanen les accions administratives següents:

- Configurar un nivell d’execució 3 perquè no tingui actiu el servei Apache.
- Aquest nivell serà el nivell per defecte en arrancar el sistema.

Finalment es demana esbrinar com es configura un nivell per defecte en un Linux que tingui un sistema d’arrancada basat en upstart (com ara Ubuntu).

Encara que habitualment és així, primer ens assegurem que el nivell 2 i el 3 d’execució són iguals:

```
rm /etc/rc3.d/*
# cp -d /etc/rc2.d/* /etc/rc3.d
```

(NOTA: L’opció -d còpia els enllaços simbòlics com a tals.)

Si volem que el servei Apache quedi deshabilitat, en entrar al nivell 3 només cal canviar la S inicial per una K en el nom de l’enllaç simbòlic que apunta a l’script de control d’Apache:
```
 mv /etc/rc3.d/S18apache2 /etc/rc3.d/K18apache2

peró no ni ha en aquest moment cap servei apache instalat.
```
Es pot comprovar fàcilment que en el nivell 2 des de el navegador s’obté resposta a localhost i que en canvi en el nivell 3 no:


# Directori /etc/proc

L’objectiu d’aquesta activitat és conèixer les característiques i els arxius d’informació que es troben al directori virtual /proc.

Per fer aquesta tasca es demanen les activitats següents:

Obrir un navegador en l’entorn gràfic i esbrinar el PID que li correspon.
Trobar informació d’aquest procés en el directori /proc corresponent.

Amb l’ordre
```
ps aux
```

localitzo ràpidament el procés del navegador (PID 3674), en aquest cas Firefox, i puc obtenir-ne més detalls amb:

```
F S   UID     PID    PPID  C PRI  NI ADDR SZ WCHAN  TTY        TIME CMD

4 S  1000    3674    3444  0  80   0 - 58146 do_pol ?          0:00 /bin/firefox

````

Amb el número de PID puc cercar el directori d’informació d’aquest procés a /proc/3674:
```
ls -m /proc/3674

arch_status, attr, autogroup, auxv, cgroup, clear_refs, cmdline, comm,

coredump_filter, cpu_resctrl_groups, cpuset, cwd, environ, exe, fd, fdinfo,

gid_map, io, ksm_merging_pages, ksm_stat, latency, limits, loginuid, map_files,

maps, mem, mountinfo, mounts, mountstats, net, ns, numa_maps, oom_adj,

oom_score, oom_score_adj, pagemap, patch_state, personality, projid_map, root,

sched, schedstat, sessionid, setgroups, smaps, smaps_rollup, stack, stat, statm,

status, syscall, task, timens_offsets, timers, timerslack_ns, uid_map, wchan

```

Aquí hi ha tota la informació del procés

```
cat /proc/3674/status

Name:	FirefoxState

Umask:	0002

State:	S (sleeping)

Tgid:	3674

Ngid:	0

Pid:	3674

PPid:	3444

TracerPid:	0

Uid:	1000	1000	1000	1000

Gid:	1000	1000	1000	1000

FDSize:	128

Groups:	4 24 27 30 46 122 135 136 1000 

NStgid:	3674

NSpid:	3674

NSpgid:	2501

NSsid:	2501

Kthread:	0

VmPeak:	  232584 kB

VmSize:	  232568 kB

VmLck:	       0 kB

VmPin:	       0 kB

VmHWM:	   50304 kB

VmRSS:	   49792 kB

RssAnon:	    9600 kB

RssFile:	   39936 kB

RssShmem:	     256 kB

VmData:	   16280 kB

VmStk:	     136 kB

VmExe:	     648 kB

VmLib:	  138040 kB

VmPTE:	     356 kB

VmSwap:	       0 kB

HugetlbPages:	       0 kB

CoreDumping:	0

THP_enabled:	1

untag_mask:	0xffffffffffffffff

Threads:	6

SigQ:	0/7563

SigPnd:	0000000000000000

ShdPnd:	0000000000000000

SigBlk:	0000000000000000

SigIgn:	0000000000011002

SigCgt:	0000000f40000ef8

CapInh:	0000000000000000

CapPrm:	0000000000000000

CapEff:	0000000000000000

CapBnd:	000001ffffffffff

CapAmb:	0000000000000000

NoNewPrivs:	1

Seccomp:	2

Seccomp_filters:	3

Speculation_Store_Bypass:	vulnerable

SpeculationIndirectBranch:	always enabled

Cpus_allowed:	3

Cpus_allowed_list:	0-1

Mems_allowed:	00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001

Mems_allowed_list:	0

voluntary_ctxt_switches:	33

nonvoluntary_ctxt_switches:	35

x86_Thread_features:	

x86_Thread_features_locked:

```


