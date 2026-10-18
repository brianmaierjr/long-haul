# CyberSec | Research & Labs — Blog de NoTrustedX

Plantilla de blog técnico Jekyll + GitHub Pages en español, responsive y con modo claro/oscuro, artículos Markdown, etiquetas, archivo con buscador local y RSS.

**Destino:** `https://github.com/NoTrustedx/notrustedx.github.io`

**URL prevista:** `https://notrustedx.github.io/`

> El repositorio de destino ya existe y contiene otra plantilla (Long Haul). NO subas este proyecto directamente a `master` sin revisar los cambios. La publicación segura se hace en rama separada y por Pull Request.

## Publicar desde Windows (PowerShell)

1. Descomprime este ZIP en una carpeta (por ejemplo, `C:\CyberSec_Blog_NoTrustedx`).
2. Instala Git for Windows y configura tu identidad Git si es la primera vez: `git config --global user.name "NoTrustedX"` y `git config --global user.email "tu-email-publico-o-noreply"` (elige tú el email real/noreply).
3. Abre PowerShell dentro de la carpeta descomprimida.
4. Ejecuta `powershell.exe -NoProfile -File .\scripts\Validar-Blog.ps1`.
5. Ejecuta `powershell.exe -NoProfile -File .\scripts\Publicar-Blog-GitHub.ps1`.
6. Autoriza la autenticación GitHub si Git Credential Manager la solicita.
7. Abre el enlace de comparación impreso por el script; crea el Pull Request y revisa diferencias.
8. Si deseas reemplazar Long Haul, integra el PR a `master`; revisa `Settings → Pages` para publicar desde `master` y `/(root)`.
9. Comprueba el despliegue en `Actions` y en `https://notrustedx.github.io/`.

La rama de trabajo propuesta se crea **sin sobrescribir master**. El script NO hace merge automático.

## Archivos del blog

- `_config.yml`: identidad y configuración de Jekyll.
- `_posts/`: artículos en Markdown.
- `_layouts/`, `_includes/`: estructura de páginas.
- `index.html`, `articulos.html`, `temas.html`, `sobre-mi.md`: secciones.
- `assets/`: CSS, JavaScript e iconos.
- `scripts/Validar-Blog.ps1`: validación de estructura.
- `scripts/Publicar-Blog-GitHub.ps1`: prepara una rama y la sube para revisión.
- `DEPLOY.md`: lista de despliegue y recomendaciones.

## Publicar artículos

Crea un archivo `_posts/AAAA-MM-DD-titulo.md` con YAML Front Matter, por ejemplo:

```markdown
---
layout: post
title: "Mi primer laboratorio"
date: 2026-10-18 09:00:00 -0400
categories: [Laboratorios]
tags: [docker, seguridad]
---

Contenido del tutorial en Markdown.
```

Las tres publicaciones iniciales están identificadas como **demostraciones**. Personalízalas y verifica que no contienen información confidencial antes de usarlas como portafolio.

## Fuente

[GitHub Docs: configuración de GitHub Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).
