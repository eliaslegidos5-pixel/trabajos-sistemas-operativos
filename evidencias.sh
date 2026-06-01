#!/bin/bash

# Script para generar evidencias de autoría automáticamente
# Uso: bash evidencias.sh > entrega.md

echo "# Informe de Ejecución - Práctica Docker"
echo "Alumno: Elías Legidos - NIA: 10797613"
echo "Fecha: $(date)"

echo "## 1. Código Fuente"
echo "### Dockerfile / Compose"
echo '```yaml'
cat docker-compose.yml 2>/dev/null || cat Dockerfile
echo '```'

echo "## 2. Estado del Sistema (Proof of Life)"
echo "### Contenedores en ejecución"
echo '```text'
docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
echo '```'

echo "### Redes y Volúmenes"
echo '```text'
docker network ls
docker volume ls
echo '```'

echo "### Logs de ejecución (últimas 10 líneas)"
echo '```text'
docker logs --tail 10 $(docker ps -q | head -n 1)
echo '```'
