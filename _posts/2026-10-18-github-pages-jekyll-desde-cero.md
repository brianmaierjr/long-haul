---
title: "Cómo publicar un blog técnico con GitHub Pages y Jekyll"
description: "Un recorrido inicial para escribir artículos en Markdown y publicarlos sin contratar hosting."
date: 2026-10-18 09:00:00 -0400
categories: [Laboratorios]
tags: [laboratorios, github, documentacion]
---

> **Artículo de demostración.** Adapta esta guía y valida cada paso antes de firmarla como experiencia propia.

GitHub Pages permite publicar un sitio estático desde un repositorio de GitHub. Jekyll convierte archivos Markdown en páginas HTML y facilita el manejo de artículos, fechas y etiquetas.

## 1. Crea el repositorio

Para tu página principal de usuario, el nombre debe ser `TU_USUARIO.github.io`. Si lo llamas `blog-seguridad`, la dirección normalmente será `https://TU_USUARIO.github.io/blog-seguridad/`.

## 2. Organiza las publicaciones

Un blog básico tiene esta estructura:

```text
_config.yml
_layouts/
_posts/
assets/
index.html
```

Cada publicación se guarda en `_posts` con el formato `AAAA-MM-DD-titulo.md`.

## 3. Configura la dirección

En `_config.yml`, completa `url` y `baseurl`. Usa `baseurl: ""` para `TU_USUARIO.github.io` y `baseurl: "/blog-seguridad"` para un repositorio llamado `blog-seguridad`.

## 4. Publica y verifica

En el repositorio, abre **Settings → Pages** y selecciona **Deploy from a branch**, rama `master`, carpeta `/(root)` en este repositorio.

Verifica en **Actions** el resultado del despliegue y abre la URL publicada. Comprueba que los artículos, las etiquetas y los estilos carguen sin errores.

Consulta las [instrucciones oficiales de GitHub Pages](https://docs.github.com/es/pages/quickstart) para conocer los requisitos vigentes.
