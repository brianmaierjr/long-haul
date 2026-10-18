---
title: "Buenas prácticas para laboratorios aislados con Docker"
description: "Controles básicos de exposición, redes, credenciales y trazabilidad en entornos de práctica."
date: 2026-10-12 10:00:00 -0400
categories: [Laboratorios]
tags: [laboratorios, docker, blue-team]
---

> **Artículo de demostración.** No describe un despliegue real ni una validación efectuada en sistemas productivos.

Los laboratorios de ciberseguridad deben ser **reproducibles, aislados y verificables**. Un servicio de práctica que escucha en todas las interfaces puede quedar accidentalmente accesible desde otras redes.

## Escucha local por defecto

Cuando solo necesitas acceso desde el mismo equipo, publica puertos en `127.0.0.1`:

```yaml
services:
  app-laboratorio:
    image: nginx:stable-alpine
    ports:
      - "127.0.0.1:8080:80"
    read_only: true
```

Este ejemplo es educativo. La imagen y sus opciones deben evaluarse antes de su despliegue.

## Lista de validación

1. **Redes:** define qué contenedores pueden comunicarse entre sí.
2. **Credenciales:** reemplaza valores predeterminados y evita incluir secretos en Git.
3. **Persistencia:** identifica los volúmenes que necesitan respaldo.
4. **Versiones:** documenta las imágenes y revisa actualizaciones de seguridad.
5. **Evidencia:** registra versión, fecha, pruebas realizadas y resultados.

## Comprobaciones de operación

{% raw %}
```bash
docker compose ps
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
```
{% endraw %}

Comprueba qué direcciones y puertos están publicados, además de revisar los logs y el estado de salud cuando existan verificaciones configuradas.
