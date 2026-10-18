---
title: "Operación y diagnóstico del laboratorio"
description: "Comprobación del estado de los contenedores, conexiones y servicios locales."
date: 2026-10-18
categories: [Laboratorios]
tags: [docker, operacion, diagnostico]
serie: laboratorio-ciberseguridad
orden: 5
---

> **Serie Laboratorio de ciberseguridad - Manual 05/06:** [Ver el indice completo]({{ '/manuales/' | relative_url }})

{% raw %}
## Servicios y puertos

| Servicio | Interfaz local | Contenedor de referencia |
|---|---|---|
| MITRE CALDERA | `http://127.0.0.1:8888` | `caldera-lab` |
| BloodHound CE | `http://127.0.0.1:8080` | `bloodhound-bloodhound-1` |
| AdaptixC2 (administración) | `https://localhost:4321` | `adaptix-server-runtime` + `adaptix-admin-proxy` |

Los puertos anteriores deben restringirse a localhost. Comprueba siempre la configuración real de tus contenedores.

## 1. Estado general desde PowerShell

```powershell
wsl -d Ubuntu-24.04 -- docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
Test-NetConnection 127.0.0.1 -Port 8888
Test-NetConnection 127.0.0.1 -Port 8080
Test-NetConnection 127.0.0.1 -Port 4321
```

Una respuesta TCP exitosa no garantiza que la web esté sana, las credenciales funcionen o el certificado TLS sea confiable.

## 2. Inicio de contenedores existentes

Para CALDERA:

```powershell
wsl -d Ubuntu-24.04 -- docker start caldera-lab
```

Para BloodHound, ajusta el nombre real de Neo4j (`neo4j` o `bloodhound-graph-db-1`):

```powershell
wsl -d Ubuntu-24.04 -- docker start bloodhound-app-db-1
wsl -d Ubuntu-24.04 -- docker start neo4j
# Verifica el estado de salud de ambas bases antes de continuar.
wsl -d Ubuntu-24.04 -- docker ps
wsl -d Ubuntu-24.04 -- docker start bloodhound-bloodhound-1
```

Para Adaptix:

```powershell
wsl -d Ubuntu-24.04 -- docker start adaptix-server-runtime
wsl -d Ubuntu-24.04 -- docker start adaptix-admin-proxy
```

Los comandos `docker start` **no instalan** servicios. Para instalación inicial, sigue los manuales individuales.

## 3. Lanzador interactivo Windows

Copia `scripts/Iniciar-Lab-Ciberseguridad.ps1` y `scripts/Iniciar-Laboratorio.bat` en la misma carpeta. Edita `$Distro`, `$Lab` y `$AdaptixClient` si difieren.

Doble clic en `Iniciar-Laboratorio.bat` o desde PowerShell:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File '.\Iniciar-Lab-Ciberseguridad.ps1'
```

Menú: CALDERA, BloodHound, Adaptix, todos, estado/puertos, abrir GUI Adaptix y salir. El menú respeta instancias ya activas y reconoce el nombre `neo4j` o `bloodhound-graph-db-1` cuando existe. Si tu despliegue usa otro nombre, personaliza `$Lab` y la detección.

## 4. Diagnóstico: HAProxy detenido

Síntoma observado:

```text
adaptix-admin-proxy  Exited (255)
Test-NetConnection 127.0.0.1 -Port 4321 -> False
```

Diagnóstico y recuperación mínima:

```powershell
wsl -d Ubuntu-24.04 -- docker logs --tail 100 adaptix-admin-proxy
wsl -d Ubuntu-24.04 -- docker start adaptix-admin-proxy
wsl -d Ubuntu-24.04 -- docker ps --filter 'name=adaptix-admin-proxy'
Test-NetConnection 127.0.0.1 -Port 4321
```

En el laboratorio funcionó el reinicio **solo del proxy**. No alteres las redes Docker ni otros contenedores al resolver este caso.

## 5. TLS Adaptix

```powershell
$cert = '\\wsl.localhost\Ubuntu-24.04\home\<usuario>\labs\adaptix-c2\config\tls\server.rsa.crt'
Test-Path $cert
curl.exe --cacert $cert -sS -o NUL -w 'HTTP %{http_code}\n' https://localhost:4321/endpoint
$LASTEXITCODE
```

Salida comprobada: HTTP 404, código de salida 0, validación del certificado correcta. Un GET 404 es compatible con servidor operativo; no representa una sesión autenticada.

## 6. Respaldo y mantenimiento

Antes de actualizar:

1. Registra `docker ps -a` y `docker image ls`.
2. Identifica **los volúmenes reales** con `docker inspect <contenedor>`.
3. Respalda datos persistentes y configuraciones privadas **fuera del repositorio**. Para bases PostgreSQL/Neo4j utiliza procesos de respaldo consistentes con las versiones realmente instaladas.
4. Conserva los archivos Compose personalizados auditados en un almacén privado.
5. Actualiza una plataforma a la vez; verifica los logs y la UI antes de avanzar.

Evita ejecutar sin evaluación:

```text
docker compose down -v
docker system prune --volumes
make docker-clean-all
```

## 7. Checklist de aceptación

- [ ] Las tres plataformas responden solo desde las interfaces previstas.
- [ ] PostgreSQL y Neo4j reportan estado saludable cuando aplica.
- [ ] El servidor Adaptix no tiene puertos publicados directamente.
- [ ] HAProxy publica únicamente `127.0.0.1:4321`.
- [ ] Adaptix TLS se valida con el certificado correcto (sin `--insecure`).
- [ ] AdaptixClient abre la ventana `Connect`.
- [ ] No hay contraseñas, perfiles privados ni claves en GitHub.

{% endraw %}
