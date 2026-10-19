#requires -Version 5.1
[CmdletBinding()]
param(
  [string]$Repo = 'NoTrustedx/notrustedx.github.io',
  [string]$Base = 'master',
  [string]$Branch = ('cybersec-blog-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
)
$ErrorActionPreference = 'Stop'
$source = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) { throw 'Git no encontrado. Instala Git for Windows y vuelve a intentar.' }
if (-not (Test-Path -LiteralPath (Join-Path $source '_config.yml'))) { throw 'No se encontro _config.yml en la carpeta del blog.' }
if (-not (Test-Path -LiteralPath (Join-Path $source 'assets/css/style.css'))) { throw 'No se encontro CSS. Descomprime el ZIP completo.' }
$hostURL = 'https://github.com/' + $Repo
Write-Host '=== Preparar CyberSec Blog para GitHub ===' -ForegroundColor Cyan
Write-Host "Repositorio: $Repo"
Write-Host "Rama original, NO se modificara: $Base" -ForegroundColor Green
Write-Host "Rama de propuesta: $Branch"
Write-Host 'ADVERTENCIA: En la rama NUEVA se sustituira el tema existente por el blog CyberSec.' -ForegroundColor Yellow
Write-Host 'Se recomienda revisar luego el Pull Request antes de integrarlo.' -ForegroundColor Yellow
$confirm = Read-Host 'Escribe PUBLICAR para clonar, preparar y subir la rama (o Enter para cancelar)'
if ($confirm -cne 'PUBLICAR') { Write-Host 'Cancelado sin cambios en GitHub.'; return }
$work = Join-Path $env:TEMP ('CyberSecBlog_' + (Get-Date -Format 'yyyyMMdd_HHmmss'))
& git clone --depth 1 --branch $Base --single-branch ($hostURL + '.git') $work
if ($LASTEXITCODE -ne 0) { throw 'No se pudo clonar. Revisa autenticacion y conectividad.' }
& git -C $work checkout -b $Branch
if ($LASTEXITCODE -ne 0) { throw 'No se pudo crear la rama de propuesta.' }
& git -C $work rm -r -q -- .
if ($LASTEXITCODE -ne 0) { throw 'No se pudieron retirar los archivos antiguos en la rama de propuesta.' }
Get-ChildItem -LiteralPath $source -Force | ForEach-Object {
  Copy-Item -LiteralPath $_.FullName -Destination $work -Recurse -Force
}
& git -C $work add -A
if ($LASTEXITCODE -ne 0) { throw 'No se pudieron agregar archivos.' }
Write-Host '=== Cambios propuestos ===' -ForegroundColor Cyan
& git -C $work diff --cached --stat
if ($LASTEXITCODE -ne 0) { throw 'No se pudo obtener la vista previa de cambios.' }
& git -C $work diff --cached --quiet
if ($LASTEXITCODE -eq 0) { Write-Host 'No hay cambios para publicar.'; return }
& git -C $work commit -m 'Propuesta: nuevo blog CyberSec Research and Labs'
if ($LASTEXITCODE -ne 0) { throw 'Fallo el commit. Configura user.name y user.email en Git.' }
& git -C $work push -u origin $Branch
if ($LASTEXITCODE -ne 0) { throw 'Fallo el push. Comprueba permisos/autenticacion de GitHub; master no se modifico.' }
$compare = $hostURL + '/compare/' + $Base + '...' + $Branch + '?expand=1'
Write-Host 'Rama propuesta publicada correctamente. MASTER NO HA CAMBIADO.' -ForegroundColor Green
Write-Host "Revisar y crear PR: $compare" -ForegroundColor Cyan
Write-Host "Copia local: $work"
Write-Host 'Cuando apruebes el PR, integralo en master; despues valida Settings > Pages.'
