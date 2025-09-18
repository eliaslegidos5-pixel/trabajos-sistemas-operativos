# PRIORIDAD Y MONITORIZACIÓN DE LOS PROCESOS


Una vegada engegada l’aplicació gedit obrim una consola de text per poder efectuar les diferents ordres administratives.

Si fem una ordre ps genèrica només veurem els processos de la nostra sessió. Si fem servir les opcions aux podrem veure gairebé tots els processos:
```
elilegs+   95824  0.0  0.4 1283542112 70920 ?    Sl   09:38   0:00 /opt/google/chrome/chrome --type=renderer -
```
Aquestes opcions ens donen un llarg llistat poc pràctic, però ens ajuden a localitzar el procés en qüestió que té un PID=2213 en aquest cas. Ara podem aplicar el paràmetre estil BSD (l)ong, que ens permet presentar informació ampliada, i el paràmetre estil Unix -p, que permet limitar la informació a un procés concret.

```
F   UID     PID    PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
1 1219636248 95824 17012 20   0 1283583704 202780 futex_ Sl ?       0:06 /opt/google/chrome/chrome --type=rend
```

Veiem que la prioritat general (PRI) és 20 i la prioritat d’usuari nice (NI) està a 0. Baixem ara al mínim la prioritat nice:



```
elilegser@PC762:~$ renice 30 95824
95824 (process ID) prioridad anterior 0, nueva prioridad 19

```
