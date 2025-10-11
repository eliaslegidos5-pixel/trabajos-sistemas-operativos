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

