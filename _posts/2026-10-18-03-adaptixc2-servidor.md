---
title: "AdaptixC2: servidor de laboratorio en Docker"
description: "InstalaciÃ³n y aislamiento del servidor de administraciÃ³n de AdaptixC2."
date: 2026-10-18
categories: [Laboratorios]
tags: [adaptixc2, docker, hardening]
serie: laboratorio-ciberseguridad
orden: 3
---

> **Serie Laboratorio de ciberseguridad - Manual 03/06:** [Ver el indice completo]({{ '/manuales/' | relative_url }})

{% raw %}
## Propósito y límites

Registrar el proceso de compilación y los controles necesarios para mantener el **servidor administrativo** accesible únicamente desde el host Windows a través de HAProxy en `localhost:4321`, sin publicar directamente el contenedor del servidor.

**Referencia validada:** código `e99535c`, Ubuntu 24.04 WSL2; contenedor `adaptix-server-runtime` en red Docker `internal: true`, sin puertos publicados; `adaptix-admin-proxy` con TCP passthrough `127.0.0.1:4321:4321`; certificado propio para `localhost`/`127.0.0.1`; extenders deshabilitados; autenticación de operadores específicos (`only_password: false`); usuario del contenedor `1000:1000`, capacidades descartadas, `no-new-privileges`.

> **Distinción importante:** la instalación original usa `compose.lab.yml` y `compose.proxy.yml` personalizados que no fueron proporcionados como archivos exportables. Por lo tanto, esta guía contiene el procedimiento **comprobado** y una ruta oficial de compilación, pero **no promete reproducción idéntica sin los Compose originales saneados**. No copies automáticamente el Compose upstream a un entorno expuesto: su runtime puede usar networking de host.

## 1. Requisitos

```bash
docker compose version
docker info --format '{{.ServerVersion}}'
git --version
```

Reserva una carpeta privada **fuera** del repositorio GitHub público para certificados, configuración y datos:

```bash
mkdir -p "$HOME/labs/adaptix-c2/config/tls" "$HOME/labs/adaptix-c2/source"
chmod 700 "$HOME/labs/adaptix-c2/config" "$HOME/labs/adaptix-c2/config/tls"
```

## 2. Descargar y fijar versión

Si aún no hay un clon:

```bash
git clone https://github.com/Adaptix-Framework/AdaptixC2.git "$HOME/labs/adaptix-c2/source"
cd "$HOME/labs/adaptix-c2/source"
git checkout e99535c
git rev-parse --short HEAD
```

Esperado: `e99535c` (u ocho/caracteres iniciales iguales). En una instalación futura, verifica que el commit exista y tenga las dependencias documentadas; no asumas que `main` conserva los mismos argumentos.

## 3. Compilar solo el servidor por el método oficial

Desde el árbol fuente:

```bash
cd "$HOME/labs/adaptix-c2/source"
make docker-build-server
ls -la AdaptixServer/server-dist
```

En las versiones que admiten este objetivo, el build de Docker deja el servidor compilado en `AdaptixServer/server-dist`. Si el comando no existe, consulta `make help` o los objetivos del `Makefile` del commit fijado. No uses `make docker-clean-all` en un entorno con datos.

El servidor/extenders compilados requieren versiones de Go compatibles; la documentación oficial indica Go 1.25.4 para builds nativos de esta rama. El build Docker permite aislar las dependencias del host.

## 4. Crear certificados locales **fuera de Git**

Genera un certificado de laboratorio con SAN `DNS:localhost` y `IP:127.0.0.1`:

```bash
cd "$HOME/labs/adaptix-c2/config/tls"
openssl req -x509 -newkey rsa:3072 -sha256 -nodes \
  -keyout server.rsa.key -out server.rsa.crt -days 365 \
  -subj '/CN=localhost' \
  -addext 'subjectAltName=DNS:localhost,IP:127.0.0.1'
chmod 600 server.rsa.key
chmod 644 server.rsa.crt
openssl x509 -in server.rsa.crt -noout -subject -ext subjectAltName
```

**Nunca incluyas** `server.rsa.key` en Git. El certificado público puede ser distribuido a operadores autorizados por un canal controlado; no lo subas a ciegas si revela infraestructura interna.

## 5. Perfil privado y controles mínimos

Crea el perfil privado `~/labs/adaptix-c2/config/profile.yaml` a partir del ejemplo de **la misma versión**. Ajusta y valida como mínimo:

```yaml
Teamserver:
  interface: '0.0.0.0'     # escucha DENTRO de la red Docker privada
  port: 4321
  endpoint: '/endpoint'
  only_password: false
  # Agrega usuarios/contraseñas fuertes en un perfil PRIVADO.
  # Configura cert/key con las rutas REALES dentro del contenedor.
  extenders: []            # sin listeners/agentes al iniciar este laboratorio
```

Este fragmento es **ilustrativo y deliberadamente incompleto**: conserva las demás secciones obligatorias del `profile.yaml` de la versión usada, incluido el servidor HTTP y TLS. No publiques el YAML real ni las credenciales. No sustituyas el perfil por el fragmento anterior.

## 6. Separación de redes y proxy

En la instalación de referencia se verificó:

```bash
# Red interna del servidor (el nombre depende del proyecto Compose):
docker network inspect adaptixc2_adaptix-isolated \
  --format '{{.Internal}}'

# Ninguna publicación directa del servidor:
docker inspect adaptix-server-runtime \
  --format '{{json .HostConfig.PortBindings}}'

# Proxy publicado únicamente en localhost:
docker port adaptix-admin-proxy
```

Esperado: `true` para la red interna, sin publicación directa en `adaptix-server-runtime`, y `127.0.0.1:4321` para el proxy.

**Arquitectura recomendada:**

```text
Windows AdaptixClient -> 127.0.0.1:4321 -> HAProxy (TCP passthrough)
                                             -> AdaptixServer:4321
                                                (Docker internal:true)
```

El proxy tiene dos redes: una para el puerto publicado y otra para acceder al servicio en la red interna. Mantén `cap_drop: ALL`, `no-new-privileges`, rootfs read-only si es compatible, UID sin privilegios y bind mounts de solo lectura para configuración y TLS. Al crear los Compose personalizados comprueba los nombres de servicios, rutas internas y volúmenes reales del runtime. **No publiques ejemplos de Compose inventados como si fueran los de la instalación validada.**

## 7. Iniciar una instalación ya configurada

**Solo para contenedores ya creados y auditados:**

```bash
docker start adaptix-server-runtime
docker start adaptix-admin-proxy
docker ps --filter name=adaptix-
```

En una instalación nueva, primero debes construir y validar un Compose seguro; `docker start` no crea contenedores ni redes.

## 8. Validación desde Windows: TCP y TLS

```powershell
Test-NetConnection 127.0.0.1 -Port 4321
$cert = '\\wsl.localhost\Ubuntu-24.04\home\<usuario>\labs\adaptix-c2\config\tls\server.rsa.crt'
Test-Path -LiteralPath $cert
curl.exe --cacert $cert --silent --show-error --output NUL --write-out 'HTTP %{http_code}\n' https://localhost:4321/endpoint
Write-Host "curl exit code:" $LASTEXITCODE
```

El camino `<usuario>` se sustituye por el usuario de Ubuntu. En el laboratorio de referencia, `curl` obtuvo **HTTP 404 con código de salida 0** para un `GET` no soportado: TLS validado, aunque el 404 **no demuestra** autenticación. No emplees `-k` o `--insecure` para ocultar errores de TLS.

## 9. Diagnóstico del proxy

```bash
docker ps -a --filter name=adaptix-
docker logs --tail 100 adaptix-admin-proxy
docker logs --tail 100 adaptix-server-runtime
```

Síntoma observado en el entorno: HAProxy `Exited (255)` y `Test-NetConnection` fallido. Se resolvió iniciando **solo** `adaptix-admin-proxy` y volviendo a comprobar TCP y TLS. Si reaparece, investiga logs y política de reinicio; no reinicies Docker Desktop sin necesidad.

## Fuentes oficiales

- [AdaptixC2 — Server Installation](https://adaptix-framework.gitbook.io/adaptix-framework/adaptix-c2/getting-starting/installation-server)
- [AdaptixC2 — Starting](https://adaptix-framework.gitbook.io/adaptix-framework/adaptix-c2/getting-starting/starting)
- [GitHub AdaptixC2](https://github.com/Adaptix-Framework/AdaptixC2)

{% endraw %}
