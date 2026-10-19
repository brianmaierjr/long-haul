---
title: "Cómo documentar evidencias en una investigación OSINT"
description: "Una plantilla sencilla para mantener hallazgos verificables, cronología y trazabilidad."
date: 2026-10-05 11:00:00 -0400
categories: [OSINT]
tags: [osint, documentacion, blue-team]
---

> **Artículo de demostración.** Adapta la metodología a las reglas de compromiso de tu evaluación.

La investigación de fuentes abiertas debe distinguir entre **hechos observados**, **inferencias** y **riesgos hipotéticos**. Una captura aislada puede perder valor si no conserva contexto y fecha.

## Ficha mínima por evidencia

| Campo | Qué registrar |
|---|---|
| Identificador | Código único de la evidencia |
| Fecha y zona horaria | Momento de recolección |
| Fuente | URL o fuente pública consultada |
| Método | Navegación manual, consulta DNS, revisión documental |
| Observación | Información que aparece efectivamente |
| Limitación | Lo que no se pudo corroborar |
| Integridad | Hash de archivo cuando corresponda |

## Ejemplo de resumen

**Hallazgo:** un servicio público presenta metadatos tecnológicos visibles.

**Evidencia:** fecha, URL pública, captura de la respuesta sin credenciales ni datos personales.

**Interpretación:** la mera presencia de una tecnología no demuestra vulnerabilidad; se necesita correlación con versiones y avisos confiables.

**Recomendación:** validar inventario, configuración, exposición y responsables con el propietario del activo.

## Límites éticos

No publiques credenciales, información personal, topologías confidenciales ni direcciones internas de clientes. Define por escrito el alcance antes de realizar acciones activas.
