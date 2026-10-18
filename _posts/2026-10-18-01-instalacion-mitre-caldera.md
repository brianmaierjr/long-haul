---
title: "Instalación de MITRE CALDERA 5.3.0"
description: "Instalación base de MITRE CALDERA con Ubuntu y Docker."
date: 2026-10-18
categories: [Laboratorios]
tags: [caldera, docker, ubuntu]
serie: laboratorio-ciberseguridad
orden: 1
---

> **Serie Laboratorio de ciberseguridad - Manual 01/06:** [Ver el indice completo]({{ '/manuales/' | relative_url }})

{% raw %}
## Objetivo

Documentar una instalación reproducible **de referencia** de CALDERA 5.3.0 en Ubuntu 24.04/WSL2 mediante Docker, accesible desde Windows solo por `127.0.0.1:8888`.

**Instalación validada previamente en el laboratorio:** tag `5.3.0`, commit `b24f6e7a99cab19cbf417009bda9b9c6c81abc31`, contenedor `caldera-lab`, acceso local `8888`. En el laboratorio se utilizó un Compose **personalizado y endurecido** (usuario `1000:1000`, filesystem read-only, capacidades reducidas, montajes específicos). Ese Compose privado **no está incluido**, por lo que los comandos aquí propuestos son una instalación base que debes endurecer antes de operar.

## 1. Comprobaciones

```bash
docker info --format '{{.ServerVersion}}'
docker compose version
git --version
```

No continúes ante errores.

## 2. Descargar la versión de referencia

```bash
mkdir -p "$HOME/tools/caldera"
cd "$HOME/tools/caldera"
git clone --recursive --branch 5.3.0 https://github.com/mitre/caldera.git source
cd source
git submodule update --init --recursive
git describe --tags --always
git rev-parse HEAD
```

**Validación:** `git describe` debe mostrar `5.3.0` o una descripción equivalente. Si el commit no coincide con el de referencia, anota la diferencia y revisa el repositorio; no fuerces cambios a ciegas.

## 3. Construir la imagen oficial

Desde `~/tools/caldera/source`:

```bash
docker build --build-arg WIN_BUILD=true -t caldera-lab:5.3.0 .
docker image inspect caldera-lab:5.3.0 --format '{{.Id}}'
```

La guía oficial de la versión 5.3.0 contempla Docker y un parámetro `WIN_BUILD`. El Dockerfile/argumentos pueden cambiar en otras versiones.

## 4. Crear contenedor base solo para laboratorio local

> **Atención:** este paso es un ejemplo independiente para una instalación **nueva**. No lo ejecutes si ya existe el contenedor `caldera-lab`; no reemplaza el Compose endurecido del laboratorio de referencia ni garantiza persistencia al recrear el contenedor.

```bash
docker ps -a --filter 'name=^/caldera-lab$'
```

Solo si el nombre está libre:

```bash
docker run -d \
  --name caldera-lab \
  --publish 127.0.0.1:8888:8888 \
  --restart unless-stopped \
  caldera-lab:5.3.0 --build
```

Para una instalación persistente y endurecida, prepara un Compose con volúmenes/montajes revisados para tu versión **antes** de usarlo en trabajos reales; la carpeta de configuración y las bases de datos no deben publicarse. El despliegue endurecido de referencia también utiliza volúmenes separados para configuraciones, datos y componentes de la interfaz.

## 5. Comprobar el contenedor

```bash
docker ps --filter name=caldera-lab
docker logs --tail 80 caldera-lab
docker inspect caldera-lab --format '{{json .HostConfig.PortBindings}}'
```

Desde Windows:

```powershell
Test-NetConnection 127.0.0.1 -Port 8888
```

Interfaz prevista: <http://localhost:8888>.

En la primera ejecución, CALDERA puede generar `conf/local.yml`; consulta las credenciales **dentro del entorno privado** y cámbialas según tu política. No guardes ese archivo ni su contenido en el repositorio público.

## 6. Reinicio y verificación posteriores

```bash
docker start caldera-lab
docker ps --filter name=caldera-lab
docker logs --tail 50 caldera-lab
```

Para terminar de manera controlada:

```bash
docker stop caldera-lab
```

**No uses** `docker rm`, `docker compose down -v` o limpieza de volúmenes sin copia y aprobación.

## 7. Diagnóstico

- Puerto 8888 no responde: confirma `docker ps`, logs y vinculación a loopback.
- Interfaz incompleta: verifica que el build inicial de frontend concluyó; la opción `--build` de CALDERA v5 es relevante para la primera ejecución.
- Despliegue endurecido falla por permisos: coteja UID/GID con propiedad de montajes y permisos del sistema de archivos.
- El contenedor responde en Ubuntu pero no desde Windows: revisa Docker Desktop, WSL2 y publicaciones de puertos.
- No publiques 7010/7011/7012 ni otros contactos del agente en una guía de uso solo administrativo; requieren reglas y alcance específicos.

## Fuente oficial

- [MITRE CALDERA v5.3.0 — Installing](https://caldera.readthedocs.io/en/v5.3.0/Installing-Caldera.html)

{% endraw %}
