---
title: "Requisitos del laboratorio de ciberseguridad"
description: "Preparación y requisitos antes de instalar las herramientas del laboratorio."
date: 2026-10-18
categories: [Laboratorios]
tags: [laboratorios, requisitos, docker]
serie: laboratorio-ciberseguridad
orden: 0
---

> **Serie Laboratorio de ciberseguridad - Manual 00/06:** [Ver el indice completo]({{ '/manuales/' | relative_url }})

{% raw %}
## Entorno de referencia

- Host: Windows 11 Pro, PowerShell 5.1.
- Ubuntu: WSL2 `Ubuntu-24.04` (usuario local configurable).
- Docker Desktop: motor con integración WSL2 habilitada; Compose v2 (`docker compose`).
- Arquitectura: x86_64/amd64; 15 GiB de RAM disponibles en el WSL del laboratorio de referencia.
- Software base: Git, curl, OpenSSL, tar, make según plataforma.

**Nota:** los comandos de instalación son orientativos para una instalación nueva; no se ejecutan automáticamente sobre tu laboratorio existente.

## 1. Windows: comprobar WSL2

Abre PowerShell:

```powershell
wsl --status
wsl -l -v
```

Resultado esperado: `Ubuntu-24.04` con versión `2`. Si WSL no está instalado, sigue [Microsoft Learn — instalación WSL](https://learn.microsoft.com/windows/wsl/install), reinicia cuando sea necesario y prepara Ubuntu 24.04.

## 2. Docker Desktop

Instala Docker Desktop desde su sitio oficial, habilita el motor WSL2 e integra la distribución Ubuntu 24.04 desde la configuración de Docker Desktop.

Comprueba desde Windows:

```powershell
wsl -d Ubuntu-24.04 -- docker version
wsl -d Ubuntu-24.04 -- docker compose version
```

Y dentro de Ubuntu:

```bash
whoami
uname -m
docker info --format '{{.ServerVersion}}'
docker compose version
```

No sigas si `docker info` falla. Comprueba que Docker Desktop esté abierto y que Ubuntu tenga integración WSL habilitada.

## 3. Dependencias de utilidades en Ubuntu

```bash
sudo apt update
sudo apt install -y git curl ca-certificates openssl make tar
```

> No instales un segundo Docker Engine dentro de Ubuntu si ya dependes del motor de Docker Desktop y la integración WSL2 funciona. Evita conflictos de sockets/daemons.

## 4. Estructura de trabajo

```bash
mkdir -p "$HOME/tools/caldera" "$HOME/tools/bloodhound" "$HOME/labs/adaptix-c2"
```

Las carpetas reflejan la organización del laboratorio; ajusta `$HOME` sin codificar nombres personales en scripts públicos.

## 5. Seguridad antes de la instalación

1. Usa puertos administrativos ligados a `127.0.0.1`.
2. Separa redes y datos de cada herramienta. Para Adaptix, utiliza una red Docker `internal: true` y no publiques directamente el servidor.
3. No subas credenciales, `profile.yaml`, `.env` reales, bases de datos, certificados privados ni archivos de evaluación a GitHub.
4. Registra versión, commit, SHA-256 de binarios descargados, nombre del contenedor y salida de validación.
5. Haz pruebas de conectividad desde **Windows y Ubuntu**; que Docker publique un puerto no garantiza que el servicio siga activo.
6. Evita `docker compose down -v`, `docker system prune --volumes` y comandos destructivos sobre un laboratorio con datos.

## 6. Chequeo rápido de puertos desde Windows

```powershell
Test-NetConnection 127.0.0.1 -Port 8888
Test-NetConnection 127.0.0.1 -Port 8080
Test-NetConnection 127.0.0.1 -Port 4321
```

`TcpTestSucceeded : True` demuestra conexión TCP, pero **no** valida autenticación ni certificado TLS.

## Referencias

- [Microsoft Learn — WSL](https://learn.microsoft.com/windows/wsl/)
- [Docker — WSL2 backend](https://docs.docker.com/desktop/features/wsl/)

{% endraw %}
