# Prepara el paquete para subir la web al WordPress del Arzobispado.
# Antes, en el WordPress local (http://127.0.0.1:9400/wp-admin):
#   1. Herramientas -> Exportar -> Todo el contenido  -> guardar en .\paquete\contenido.xml
#   2. Avada -> Options -> Import/Export -> Export    -> guardar en .\paquete\opciones-avada.json
# Este script añade las imágenes subidas y deja todo en paquete-san-blas-AAAA-MM-DD.zip
$ErrorActionPreference = 'Stop'
$raiz = Split-Path $PSScriptRoot -Parent
$paquete = Join-Path $raiz 'paquete'
$uploads = Join-Path $env:LOCALAPPDATA 'SanBlasWeb\sitio\wp-content\uploads'

New-Item -ItemType Directory -Force $paquete | Out-Null
foreach ($f in 'contenido.xml', 'opciones-avada.json') {
	if (-not (Test-Path (Join-Path $paquete $f))) {
		throw "Falta paquete\$f. Expórtalo desde el panel local (ver cabecera de este script)."
	}
}

$destino = Join-Path $raiz ("paquete-san-blas-{0:yyyy-MM-dd}.zip" -f (Get-Date))
$archivos = @((Join-Path $paquete '*'))
if (Test-Path $uploads) { $archivos += $uploads }
Compress-Archive -Path $archivos -DestinationPath $destino -Force
Write-Host "Paquete listo: $destino"
