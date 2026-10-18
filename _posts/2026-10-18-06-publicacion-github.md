---
title: "PublicaciÃ³n segura de documentaciÃ³n en GitHub"
description: "OrganizaciÃ³n de manuales y buenas prÃ¡cticas antes de hacer pÃºblica la documentaciÃ³n."
date: 2026-10-18
categories: [Documentacion]
tags: [github, git, documentacion]
serie: laboratorio-ciberseguridad
orden: 6
---

> **Serie Laboratorio de ciberseguridad - Manual 06/06:** [Ver el indice completo]({{ '/manuales/' | relative_url }})

{% raw %}
## 1. Revisar antes de publicar

Este paquete contiene **documentación, un menú PowerShell y un BAT**. No incluye herramientas compiladas, datos de clientes, contraseñas, certificados privados ni configuraciones particulares del laboratorio.

No añadas al repositorio:

- `profile.yaml`, `conf/local.yml`, `.env` con valores reales.
- Claves privadas (`*.key`, `*.pem`), certificados de entornos privados, bases de datos y backups.
- Logs con tokens, hashes, credenciales o direcciones internas sensibles.
- Ejecutables de AdaptixClient o binarios compilados de herramientas de terceros sin estudiar su licencia.
- Capturas con identidades, direcciones de producción o datos de terceros.

El `.gitignore` reduce el riesgo, **pero no reemplaza una revisión**: hay que examinar también el historial de commits.

## 2. Verificar estructura

```text
Laboratorio-Ciberseguridad-GitHub/
  README.md
  .gitignore
  SECURITY.md
  docs/
    00-REQUISITOS.md
    01-MITRE-CALDERA.md
    02-BLOODHOUND-CE.md
    03-ADAPTIXC2-SERVIDOR.md
    04-ADAPTIXCLIENT-WINDOWS.md
    05-OPERACION-Y-DIAGNOSTICO.md
    06-PUBLICACION-GITHUB.md
  scripts/
    Iniciar-Lab-Ciberseguridad.ps1
    Iniciar-Laboratorio.bat
```

## 3. Crear repositorio local

Desde PowerShell en la carpeta del paquete:

```powershell
git init
git branch -M main
git status --short
git add README.md .gitignore SECURITY.md docs scripts
git diff --cached --stat
git diff --cached --check
git commit -m 'docs: guias de instalacion y operacion de laboratorio WSL2 Docker'
```

Antes del commit, revisa el contenido de archivos agregados con `git diff --cached` para comprobar que no hay secretos. La revisión automatizada de texto no sustituye una inspección manual.

## 4. Conectar un repositorio GitHub **creado por ti**

En GitHub crea un repositorio vacío (sin README inicial), y copia **tu URL real**. Luego:

```powershell
git remote add origin https://github.com/TU_USUARIO/TU_REPOSITORIO.git
git push -u origin main
```

No pegues una URL de ejemplo literalmente. Requiere autenticación GitHub según tu configuración.

## 5. Buenas prácticas

- Cita las fuentes oficiales y verifica licencias al incluir material upstream.
- Mantén cada guía versionada y anota cuándo se comprobó un comando.
- No uses descripciones como «instalación 100 % reproducible» si faltan Compose personalizados.
- Documenta cambios de seguridad mediante issues/PR sin revelar configuraciones privadas.
- Mantén un repositorio **privado** si decides versionar parámetros de infraestructura sensible.
- Si se publica un secreto por error, revócalo/rota la clave de inmediato; borrar el archivo del último commit no elimina necesariamente su historial.

## Sugerencia de descripción del repositorio

**Guías técnicas en español para desplegar y administrar MITRE CALDERA, BloodHound Community Edition y AdaptixC2 en Windows 11, WSL2 Ubuntu 24.04 y Docker, con enfoque en aislamiento, verificación y operación segura.**

{% endraw %}
