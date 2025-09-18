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


Encara que posem un número molt alt, en aquest cas 30, la prioritat nice queda a 19 (prioritat mínima). Comprovem ara la prioritat general:

<ins> El proceso es diferente a partir de aquí porque esta parte la he hecho en mi casas y no en clase , por lo cual el proceso no será el mismo  </ins>
```
F   UID     PID    PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND

0  1000    3107    2341  20   0 491260 52456 do_pol Ssl  ?          0:01 /usr/li
```

Ara farem servir la utilitat top per donar al procés la prioritat màxima. Arranquem la utilitat interactiva:

```




    PID USUARIO   PR  NI    VIRT    RES    SHR S  %CPU  %MEM     HORA+ ORDEN    

   2498 elias     20   0 4574348 375656 134012 S   7,3  18,6   0:31.50 gnome-s+ 

   3107 elias     20   0  492740  53084  40396 S   2,0   2,6   0:02.59 gnome-t+ 

    870 mysql     20   0 1783944  14884  10752 S   1,0   0,7   0:14.44 mysqld   

     16 root      20   0       0      0      0 S   0,3   0,0   0:01.63 ksoftir+ 

   1813 root      20   0  284092   2048   1920 S   0,3   0,1   0:00.49 VBoxDRM+ 

   2741 elias     20   0  314924   8192   7424 S   0,3   0,4   0:00.07 gsd-hou+ 

   3042 elias     20   0  221480   3356   2944 S   0,3   0,2   0:01.95 VBoxCli+ 

   3526 root      20   0 1923816  42148  25088 S   0,3   2,1   0:13.20 snapd    

      1 root      20   0  168044  13128   8264 S   0,0   0,7   0:04.75 systemd  

      2 root      20   0       0      0      0 S   0,0   0,0   0:00.02 kthreadd 

      3 root      20   0       0      0      0 S   0,0   0,0   0:00.00 pool_wo+ 

      4 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 kworker+ 

      5 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 kworker+ 

      6 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 kworker+ 

      7 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 kworker+ 

      8 root      20   0       0      0      0 I   0,0   0,0   0:01.74 kworker+ 

      9 root      20   0       0      0      0 I   0,0   0,0   0:00.48 kworker+
```

Ara ja veiem el nostre procés amb prioritat mínima (número nice més positiu). La prioritat es canvia amb la lletra r (renice), tot indicant primer el PID del procés:

```
3107 (process ID) prioridad anterior 0, nueva prioridad 10

```


I després el nou valor nice:

```
nice -n 10 sleep 1000
```





