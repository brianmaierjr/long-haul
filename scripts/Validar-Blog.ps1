#requires -Version 5.1
[CmdletBinding()]
param([string]$Ruta = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference = 'Stop'
Write-Host '=== VALIDACION PREPUBLICACION GITHUB PAGES ===' -ForegroundColor Cyan
$required = @('_config.yml','index.html','_layouts/default.html','_layouts/post.html','_posts','assets/css/style.css','assets/js/main.js')
$issues = 0
foreach ($f in $required) {
  $ok = Test-Path -LiteralPath (Join-Path $Ruta $f)
  Write-Host ('[{0}] {1}' -f $(if ($ok) {'OK'} else {'ERROR'}), $f) -ForegroundColor $(if($ok){'Green'}else{'Red'})
  if (-not $ok) {$issues++}
}
$config = Join-Path $Ruta '_config.yml'
if (Test-Path -LiteralPath $config) {
  $text = Get-Content -LiteralPath $config -Raw -Encoding UTF8
  if ($text -match 'TU_USUARIO') {Write-Warning 'Debes reemplazar TU_USUARIO en _config.yml antes de publicar.'; $issues++}
  if ($text -match '(?m)^baseurl:\s*""') {Write-Host '[INFO] Configurado para repositorio raiz: usuario.github.io' -ForegroundColor Gray}
  else {Write-Host '[INFO] Verifica que baseurl coincida exactamente con el repositorio de proyecto.' -ForegroundColor Yellow}
}
$posts = @(Get-ChildItem (Join-Path $Ruta '_posts') -Filter '*.md' -File -ErrorAction SilentlyContinue)
Write-Host "[INFO] Publicaciones Markdown: $($posts.Count)"
foreach($post in $posts){
  if($post.Name -notmatch '^\d{4}-\d{2}-\d{2}-.+\.md$'){
    Write-Warning "Formato de nombre de post invalido: $($post.Name)"; $issues++
  }
}
if($issues -eq 0){Write-Host 'VALIDACION ESTRUCTURAL OK (no reemplaza la compilacion Jekyll).' -ForegroundColor Green}
else {Write-Host "Pendientes encontrados: $issues" -ForegroundColor Yellow}
exit [int]($issues -gt 0)
