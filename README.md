# Web de la Unidad Pastoral de San Blas

Web de WordPress basada en el diseño de
[parroquiasdesancristobal.archimadrid.es](https://parroquiasdesancristobal.archimadrid.es) (tema Avada).
Se construye en local y, cuando esté lista, se sube al WordPress que proporcione el Arzobispado de Madrid.

## Estructura

| Carpeta / archivo | Contenido |
|---|---|
| `plantilla/` | Plantilla de San Cristóbal sin noticias ni datos personales: páginas, menú, cabecera y pie de Avada, y opciones de diseño |
| `blueprint.json` | Receta de instalación del WordPress local (idioma, Avada, importación de la plantilla) |
| `scripts/iniciar.ps1` | Arranca el WordPress local |
| `scripts/empaquetar.ps1` | Genera el paquete para subir al servidor definitivo |
| `docs/` | Inventario de la web de San Cristóbal y lista de datos de San Blas que hay que reunir |
| `privado/` | **No se sube a GitHub.** Los `.zip` de Avada |
| `%LOCALAPPDATA%\SanBlasWeb\sitio` | El WordPress local con todo lo que se edite. Fuera de OneDrive y de GitHub: Playground no puede escribir en carpetas sincronizadas |

## Requisitos

- Windows con PowerShell y [Node.js](https://nodejs.org) 20 o superior. No hace falta Docker ni XAMPP:
  el WordPress local funciona con [WordPress Playground](https://wordpress.github.io/wordpress-playground/).
- Los archivos de Avada (ver abajo).

### Archivos de Avada

Avada es un tema de pago y su licencia no permite publicarlo, por eso no está en el repositorio.
Copia en `privado/` estos tres archivos, con estos nombres exactos:

- `Avada.zip` (el tema)
- `fusion-core.zip` (plugin Avada Core)
- `fusion-builder.zip` (plugin Avada Builder)

Se descargan desde la cuenta de ThemeForest con la licencia del Arzobispado, o los puede facilitar
el equipo técnico que mantiene la web de San Cristóbal (Avada Core 5.11.6 / Avada Builder 3.11.6).

## Uso

```powershell
.\scripts\iniciar.ps1
```

Abre http://127.0.0.1:9400/wp-admin (entra ya con sesión iniciada). La primera vez tarda unos minutos
porque instala WordPress e importa la plantilla. Para empezar de cero: `.\scripts\iniciar.ps1 -Reinstalar`.
Si faltan los zip de Avada, instala igualmente WordPress con el contenido, pero sin el diseño; al añadirlos,
ejecuta `-Reinstalar`.

Después de la primera instalación, en el panel local:

1. Avada → Options: subir el logo de San Blas y ajustar la paleta si se cambian los colores.
2. Apariencia → Menús: revisar el menú principal.
3. Sustituir los textos de cada página con los datos de `docs/datos-san-blas-a-reunir.md`.
4. Borrar lo que sobra: páginas en borrador, las de ejemplo en inglés (Blog, Contact)
   y las de grupos que no existan en San Blas. **«Home» es la portada: no se borra.**

## Subir al servidor del Arzobispado

1. En el panel local: Herramientas → Exportar → Todo el contenido → guardar como `paquete/contenido.xml`.
2. Avada → Options → Import/Export → Export → guardar como `paquete/opciones-avada.json`.
3. Ejecutar `.\scripts\empaquetar.ps1`: genera `paquete-san-blas-AAAA-MM-DD.zip`.
4. En el WordPress definitivo (con Avada ya instalado): Herramientas → Importar → WordPress con `contenido.xml`,
   y Avada → Options → Import/Export con `opciones-avada.json`. Las imágenes van en la carpeta `uploads` del zip.

## Plugins

Los plugins que necesita la web se detallan en `docs/inventario-san-cristobal.md`.
