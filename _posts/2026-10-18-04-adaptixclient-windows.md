---
title: "Compilar AdaptixClient en Windows 11"
description: "Preparación de dependencias y compilación de AdaptixClient con MSYS2 y Qt."
date: 2026-10-18
categories: [Herramientas]
tags: [adaptixc2, windows, compilacion]
serie: laboratorio-ciberseguridad
orden: 4
---

> **Serie Laboratorio de ciberseguridad - Manual 04/06:** [Ver el indice completo]({{ '/manuales/' | relative_url }})

{% raw %}
## Alcance

Guía reconstruida a partir de la compilación **comprobada en Windows 11**: MSYS2 MINGW64, GCC 16.2, CMake 4.4, Ninja 1.13, Qt 6.11, OpenSSL 3.6; ejecutable generado de aproximadamente 38 MB y ventana gráfica `Connect` abierta. Las versiones de paquetes pueden evolucionar.

## 1. Instalar MSYS2 y actualizar

En Windows PowerShell:

```powershell
winget install --id MSYS2.MSYS2 --exact --source winget --scope user --location C:\msys64 --accept-source-agreements --accept-package-agreements
& 'C:\msys64\usr\bin\bash.exe' -lc 'pacman -Syu'
```

Si el actualizador solicita cerrar/reabrir un shell, sigue las indicaciones de MSYS2 y vuelve a ejecutar la actualización. Verifica que exista `C:\msys64\mingw64\bin`.

## 2. Instalar herramientas y módulos Qt necesarios

```powershell
& 'C:\msys64\usr\bin\bash.exe' -lc 'pacman -S --needed mingw-w64-x86_64-gcc mingw-w64-x86_64-cmake mingw-w64-x86_64-ninja mingw-w64-x86_64-qt6-base mingw-w64-x86_64-qt6-declarative mingw-w64-x86_64-qt6-websockets mingw-w64-x86_64-qt6-tools mingw-w64-x86_64-qt6-svg mingw-w64-x86_64-openssl'
```

Verifica:

```powershell
$env:Path = 'C:\msys64\mingw64\bin;C:\msys64\usr\bin;' + $env:Path
cmake --version
ninja --version
g++ --version
```

## 3. Obtener el código fuente

Ruta utilizada en el laboratorio (ajusta usuario/ruta WSL):

```powershell
$proyecto = "$env:USERPROFILE\Documents\AdaptixC2-Build\AdaptixClient"
New-Item -ItemType Directory -Force -Path $proyecto | Out-Null
$origenWSL = '\\wsl.localhost\Ubuntu-24.04\home\<usuario>\labs\adaptix-c2\source\AdaptixClient'
robocopy $origenWSL $proyecto /E
```

`robocopy` puede devolver códigos 0 a 7 aun sin un error fatal; inspecciona la salida. Alternativa: clonar el repositorio público en Windows y seleccionar explícitamente el commit de referencia. No combines fuentes de versiones distintas entre servidor/cliente.

## 4. Revisar la configuración de Qt

En este caso, el `CMakeLists.txt` de la copia para Windows apuntaba `Qt6_DIR` a `C:/msys64/mingw64/lib/cmake`; se corrigió a `C:/msys64/mingw64/lib/cmake/Qt6` **solo en la copia Windows**, conservando respaldo.

```powershell
Select-String -Path "$proyecto\CMakeLists.txt" -Pattern 'Qt6_DIR'
```

**No sustituyas rutas a ciegas:** corrige únicamente si ves el mismo error y confirma que `Qt6Config.cmake` existe en el destino.

## 5. Configurar CMake y compilar

```powershell
$build = Join-Path $proyecto 'cmake-build-release'
cmake -S $proyecto -B $build -G Ninja `
  -DCMAKE_BUILD_TYPE=Release `
  -DCMAKE_C_COMPILER=C:/msys64/mingw64/bin/gcc.exe `
  -DCMAKE_CXX_COMPILER=C:/msys64/mingw64/bin/g++.exe `
  -DCMAKE_PREFIX_PATH=C:/msys64/mingw64 `
  -DOPENSSL_ROOT_DIR=C:/msys64/mingw64
cmake --build $build --config Release --parallel 2
```

Validaciones:

```powershell
Test-Path "$build\AdaptixClient.exe"
ninja -C $build -n
```

Esperado: ejecutable existente y `ninja: no work to do` cuando el build haya finalizado. Si aparece error de módulo Qt faltante, corrige el paquete de **ese** módulo y reconfigura.

## 6. Preparar distribución y desplegar Qt

```powershell
$dist = Join-Path $proyecto 'dist'
New-Item -ItemType Directory -Path $dist -Force | Out-Null
Copy-Item "$build\AdaptixClient.exe" "$dist\AdaptixClient.exe" -Force
& 'C:\msys64\mingw64\bin\windeployqt.exe' --release --dir $dist "$dist\AdaptixClient.exe"
```

Revisa los plugins `platforms\qwindows.dll` y `sqldrivers\qsqlite.dll`.

## 7. Dependencias que se resolvieron en el laboratorio

El primer análisis de imports con `objdump` descubrió DLL de MinGW64 no incluidas por `windeployqt`. Se incorporaron **29 DLL distintas**, comprobando SHA-256 después de cada copia. Para diagnosticar tu versión:

```powershell
& 'C:\msys64\mingw64\bin\objdump.exe' -p "$dist\AdaptixClient.exe" | Select-String 'DLL Name:'
```

Bibliotecas añadidas en el entorno de referencia (no es una lista universal):

```text
libb2-1.dll            libbrotlidec.dll           libdouble-conversion.dll
libfreetype-6.dll      libgcc_s_seh-1.dll         libgio-2.0-0.dll
libgobject-2.0-0.dll  libharfbuzz-0.dll          libicuin78.dll
libicuuc78.dll        libjpeg-8.dll              libmd4c.dll
libpcre2-16-0.dll     libpng16-16.dll            libsqlite3-0.dll
libstdc++-6.dll       libwinpthread-1.dll        libzstd.dll
zlib1.dll             libbrotlicommon.dll        libbz2-1.dll
libffi-8.dll          libglib-2.0-0.dll          libgmodule-2.0-0.dll
libgraphite2.dll      libicudt78.dll             libintl-8.dll
libiconv-2.dll        libpcre2-8-0.dll
```

Para copiar **solo si el análisis de tu distribución lo requiere**:

```powershell
$dll = 'libstdc++-6.dll'   # ejemplo: sustituir por DLL verificada
$src = Join-Path 'C:\msys64\mingw64\bin' $dll
$dst = Join-Path $dist $dll
Copy-Item -LiteralPath $src -Destination $dst -Force
(Get-FileHash $src -Algorithm SHA256).Hash -eq (Get-FileHash $dst -Algorithm SHA256).Hash
```

En el laboratorio los plugins SQL opcionales `qsqlibase.dll`, `qsqlmysql.dll` y `qsqlpsql.dll` se respaldaron fuera de `dist` porque referenciaban Firebird, MariaDB y PostgreSQL; **se conservó `qsqlite.dll`**. No elimines drivers si tu aplicación realmente los necesita.

La auditoría final analizó **69 binarios**, con **0 imports potencialmente faltantes**; esto no equivale a probar todas las cargas dinámicas.

## 8. Primer inicio

```powershell
Start-Process -FilePath "$dist\AdaptixClient.exe" -WorkingDirectory $dist
Get-Process AdaptixClient | Select-Object Id,ProcessName,MainWindowTitle
```

En el caso validado la ventana principal fue `Connect`. El equipo Windows pudo alcanzar `https://localhost:4321` una vez iniciado `adaptix-admin-proxy` en Docker; la validación del certificado se hizo **antes** de ingresar credenciales.

## 9. Diagnóstico

- `Qt6Svg` no disponible: confirma el paquete `mingw-w64-x86_64-qt6-svg`.
- Ventana sin abrir: inspecciona DLL directas e indirectas, plugins de Qt y registro de eventos de Windows.
- `else` no reconocido en PowerShell: ejecuta un bloque completo `if (...) { ... } else { ... }`, no separadamente.
- `Test-NetConnection localhost -Port 4321` falla aunque la GUI esté abierta: es un problema de servidor/proxy, no prueba de fallo del cliente.
- No distribuyas claves `.key`, perfiles privados ni contraseñas junto al ejecutable.

## Fuente oficial

- [AdaptixC2 — Client Installation](https://adaptix-framework.gitbook.io/adaptix-framework/adaptix-c2/getting-starting/installation-client)

{% endraw %}
