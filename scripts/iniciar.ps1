# Arranca el WordPress local de San Blas con WordPress Playground (sin Docker ni XAMPP).
# Primera vez: instala WordPress, Avada y la plantilla de San Cristóbal según blueprint.json.
# Siguientes veces: reutiliza el sitio guardado en %LOCALAPPDATA%\SanBlasWeb\sitio
# (fuera de OneDrive: Playground no puede escribir en carpetas sincronizadas).
# Uso:  .\scripts\iniciar.ps1            (normal)
#       .\scripts\iniciar.ps1 -Reinstalar (borra el sitio local y empieza de cero)
param(
	[switch]$Reinstalar,
	[int]$Puerto = 9400
)
$ErrorActionPreference = 'Stop'
$raiz = Split-Path $PSScriptRoot -Parent
$sitio = Join-Path $env:LOCALAPPDATA 'SanBlasWeb\sitio'
$privado = Join-Path $raiz 'privado'
$cli = '@wp-playground/cli@3.1.61'

if ($Reinstalar -and (Test-Path $sitio)) {
	Remove-Item -Recurse -Force $sitio -Confirm:$false
}
New-Item -ItemType Directory -Force $sitio, $privado | Out-Null

# Rutas de Windows con «D:» no valen en --mount (usa «:» de separador): se usa --mount-dir
$montajes = @(
	'--mount-dir', "$raiz\plantilla", '/plantilla',
	'--mount-dir', $privado, '/privado'
)
$montajeSitio = @('--mount-dir-before-install', $sitio, '/wordpress')

if (Test-Path (Join-Path $sitio 'wp-config.php')) {
	Write-Host "Arrancando el sitio existente en http://127.0.0.1:$Puerto"
	npx -y $cli server --port=$Puerto --login --wordpress-install-mode=do-not-attempt-installing @montajeSitio @montajes
	exit
}

$blueprint = Join-Path $raiz 'blueprint.json'
$faltan = 'Avada.zip', 'fusion-core.zip', 'fusion-builder.zip' | Where-Object { -not (Test-Path (Join-Path $privado $_)) }
if ($faltan) {
	Write-Warning "Faltan en privado\: $($faltan -join ', '). Se instala sin Avada: el contenido se importa, pero no se verá con el diseño."
	Write-Warning "Cuando tengas los zip, ejecuta .\scripts\iniciar.ps1 -Reinstalar"
	$blueprint = Join-Path $env:TEMP 'blueprint-san-blas-sin-avada.json'
	node -e "const fs=require('fs');const b=JSON.parse(fs.readFileSync(process.argv[1],'utf8'));b.steps=b.steps.filter(s=>!JSON.stringify(s).includes('/privado/'));fs.writeFileSync(process.argv[2],JSON.stringify(b,null,2))" (Join-Path $raiz 'blueprint.json') $blueprint
}

Write-Host "Primera instalación (tarda unos minutos) en http://127.0.0.1:$Puerto"
npx -y $cli server --port=$Puerto --login --blueprint=$blueprint @montajeSitio @montajes
