# Publicación del blog CyberSec en NoTrustedx.github.io

## Estado del repositorio

- Cuenta: `NoTrustedx`
- Repositorio existente: `https://github.com/NoTrustedx/notrustedx.github.io`
- Rama actual de producción: `master`
- Contenido actual: tema Jekyll Long Haul, distinto a esta plantilla.
- **No se debe reemplazar `master` directamente sin revisar los cambios.**

## Despliegue seguro con revisión

1. En Windows instala Git y asegúrate de poder iniciar sesión en GitHub.
2. Abre PowerShell en la carpeta descomprimida y valida:
   `powershell.exe -NoProfile -File .\scripts\Validar-Blog.ps1`
3. Ejecuta: `powershell.exe -NoProfile -File .\scripts\Publicar-Blog-GitHub.ps1`
4. El script clona `master`, crea una rama nueva, sustituye *solo en esa rama* la antigua plantilla y sube la propuesta.
5. Abre el enlace de comparación que muestra el script, revisa archivos eliminados y agregados y crea el Pull Request.
6. **Solo cuando decidas reemplazar el sitio**, acepta/mergea el PR hacia `master`.
7. En GitHub ve a `Settings → Pages → Build and deployment`: fuente `Deploy from a branch`, rama `master`, carpeta `/(root)`. Guarda cambios si corresponde.
8. Revisa el flujo en `Actions` y comprueba `https://notrustedx.github.io/`.

### Límites y precauciones

- Las tres publicaciones son demostraciones, no experiencias profesionales atribuibles al autor sin edición.
- No publiques datos de clientes, IP privadas, credenciales ni capturas confidenciales.
- El repositorio anterior permanece íntegro en el historial de Git incluso después de mezclar el PR.
- Si eliges *no reemplazar* el blog anterior, no mezcles la propuesta: puedes publicar el ZIP en otro repositorio con URL propia.
- Una comprobación de archivos no equivale a compilación Jekyll ni validación de la URL en producción.
