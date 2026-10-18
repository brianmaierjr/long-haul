---
title: "Instalación de BloodHound Community Edition"
description: "Despliegue de BloodHound CE con Docker y comprobaciones iniciales."
date: 2026-10-18
categories: [Laboratorios]
tags: [bloodhound, docker, active-directory]
serie: laboratorio-ciberseguridad
orden: 2
---

> **Serie Laboratorio de ciberseguridad - Manual 02/06:** [Ver el indice completo]({{ '/manuales/' | relative_url }})

{% raw %}
## Objetivo

Instalar BloodHound CE mediante **BloodHound CLI (BH-CLI) v0.2.1** con Docker Compose en Ubuntu 24.04/WSL2.

**Laboratorio de referencia:** interfaz en `http://127.0.0.1:8080`, PostgreSQL y Neo4j sanos. Se utilizaron nombres como `bloodhound-bloodhound-1`, `bloodhound-app-db-1` y, según el Compose/recreación, `neo4j` o `bloodhound-graph-db-1`. **Los nombres reales deben consultarse**; no fijes el nombre de Neo4j sin inspección.

## 1. Requisitos

Según el quickstart oficial, referencia mínima de **8 GiB RAM, 4 núcleos y 10 GiB libres**; con Docker Desktop activo. Confirma:

```bash
docker compose version
docker info --format '{{.ServerVersion}}'
uname -m
```

## 2. Descargar BH-CLI v0.2.1 (amd64)

```bash
mkdir -p "$HOME/tools/bloodhound"
cd "$HOME/tools/bloodhound"
curl -fL -o bloodhound-cli-linux-amd64.tar.gz \
  https://github.com/SpecterOps/bloodhound-cli/releases/download/v0.2.1/bloodhound-cli-linux-amd64.tar.gz
```

Validación de integridad **para este artefacto exacto** (SHA-256 publicado para v0.2.1):

```bash
echo '2f932d8174f3ed69adf38a8ae94fa58f56d92fadecae8e240f767bb88d449983  bloodhound-cli-linux-amd64.tar.gz' | sha256sum -c -
```

Si la validación falla: no ejecutes el binario; descarga de nuevo y contrasta con los hashes de la versión en GitHub.

Descomprime y examina:

```bash
tar -xzf bloodhound-cli-linux-amd64.tar.gz
ls -la
```

La distribución puede entregar un archivo llamado `bloodhound-cli` (o requerir moverlo desde la carpeta extraída). Verifica antes de continuar:

```bash
./bloodhound-cli help
```

## 3. Instalar los componentes

En un entorno **nuevo**, con Docker corriendo:

```bash
cd "$HOME/tools/bloodhound"
./bloodhound-cli install
```

BH-CLI gestiona la descarga de imágenes y genera una configuración Docker Compose. **No repitas `install` en un laboratorio existente** sin revisar el impacto. La instalación genera una contraseña administrativa inicial: guárdala en un gestor de secretos privado, nunca en GitHub ni en los logs publicados.

La configuración de referencia suele encontrarse en:

```bash
ls -l "$HOME/.config/bloodhound/docker-compose.yml"
```

La ruta puede variar según la versión/sistema; usa la ubicación mostrada por BH-CLI.

## 4. Verificar servicios

```bash
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep -E 'bloodhound|neo4j|NAMES'
```

Comprueba que se ejecuten:

1. Aplicación BloodHound.
2. Base de datos PostgreSQL.
3. Base de datos de grafo Neo4j (si el backend configurado es Neo4j).

Confirma en la salida los estados `healthy` donde haya `HEALTHCHECK`.

Desde Windows:

```powershell
Test-NetConnection 127.0.0.1 -Port 8080
```

Interfaz: <http://localhost:8080/ui/login>. Usuario inicial indicado por la documentación oficial: `admin`; la contraseña **es aleatoria** y debe cambiarse al primer ingreso.

## 5. Volver a iniciar una instalación existente

Primero revisa nombres:

```bash
docker ps -a --format 'table {{.Names}}\t{{.Status}}'
```

Si los nombres coinciden con la referencia, inicia PostgreSQL y Neo4j antes de la aplicación:

```bash
docker start bloodhound-app-db-1
# Sustituye por el nombre real visto en docker ps -a:
docker start neo4j
# Espera a que las bases de datos reporten estado saludable:
docker ps --format 'table {{.Names}}\t{{.Status}}'
docker start bloodhound-bloodhound-1
```

Si tu Neo4j se llama `bloodhound-graph-db-1`, utiliza ese nombre. Los nombres no son universales.

## 6. Diagnóstico y operación segura

```bash
docker logs --tail 80 bloodhound-bloodhound-1
docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
```

- Si la aplicación se inicia antes que las bases, espera a `healthy` y reevalúa logs.
- Un estado `Exited (137)` puede indicar falta de memoria durante el análisis inicial; la guía oficial advierte de ello.
- Confirma que la UI esté vinculada a `127.0.0.1`, no a todas las interfaces.
- Una base de datos Neo4j con `7474`/`7687` publicado es **otra superficie**: restringe accesos y revisa si necesitas esos puertos desde Windows.
- Antes de cambiar imágenes, crea copias de seguridad de los volúmenes y anota las versiones.

## Fuentes oficiales

- [Quickstart BloodHound CE](https://bloodhound.specterops.io/get-started/quickstart/community-edition-quickstart)
- [GitHub BH-CLI](https://github.com/SpecterOps/bloodhound-cli)
- [BH-CLI v0.2.1 (release)](https://github.com/SpecterOps/bloodhound-cli/releases/tag/v0.2.1)

{% endraw %}
