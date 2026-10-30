# Inventario de parroquiasdesancristobal.archimadrid.es (28/10/2026)

Base para clonar la web de la Unidad Pastoral de San Blas.

## Plataforma
- WordPress 7.1.3 (instalación simple, no multisitio)
- Tema: Avada (Avada Core 5.11.6, Avada Builder 3.11.6)

## Plugins
| Plugin | Estado | ¿Llevar a San Blas? |
|---|---|---|
| Avada Core / Avada Builder | activo | Sí (imprescindible) |
| Asesor de Cookies RGPD 0.34 | activo | Sí |
| Cabeceras y pies de página de WP 3.1.4 | activo | Según uso |
| Jetpack 16.3.1 | activo | Opcional |
| Under Construction 4.03 | activo | Útil mientras se monta |
| User Activity Log 2.2 | activo | Opcional |
| Wordfence, WP Fastest Cache, Yoast SEO | inactivos | No |

## Contenido (exportación completa: 12 MB, 2.450 elementos)
| Tipo | Nº | ¿Para la plantilla? |
|---|---|---|
| Páginas | 50 | Sí |
| Elementos de menú | 44 | Sí |
| Layouts / secciones de Avada (cabecera, pie…) | 6 + 12 | Sí |
| Elementos Avada reutilizables | 12 | Sí |
| Formularios Avada | 1 | Sí |
| Portfolio | 6 | Sí |
| CSS personalizado / estilos globales | 2 + 2 | Sí |
| Entradas (noticias) | 527 | No: son de San Cristóbal |
| Medios | 1.770 | Solo los 34 que usan las páginas |
| Feedback (envíos de formularios) | 17 | **No: contienen datos personales** |

## Diseño (opciones de Avada)
- Paleta: blanco `#ffffff`, grises `#f4f4f4` / `#eaeaea`, amarillo claro `#fee997`,
  dorado `#dcaf54` (color principal), marrón `#402e32` (texto, pie)
- Tipografías: Red Hat Display 700 (títulos) y Roboto (texto)
- Ancho 1200 px, cabecera v3 fija, sin barra de título de página
- La cabecera y el pie reales están en las secciones Avada «Global Menu Header» y «Global Footer»

## Plantilla para el sitio de San Blas (`plantilla/`)
| Archivo | Uso |
|---|---|
| `plantilla-san-cristobal.xml` | Herramientas → Importar → WordPress. 136 elementos + 41 medios. Autores sustituidos por «editor» |
| `opciones-avada.json` | Avada → Options → Import/Export |
| `contenido-plantilla.md` | Lista de páginas, layouts y secciones incluidos |

Limpieza aplicada: sin noticias, sin envíos de formularios, sin emails de autores.
En las opciones de Avada se ha vaciado la clave de Google Maps de San Cristóbal (San Blas necesitará la suya)
y el texto de copyright de Avada que venía de serie.

Al importar: activar antes Avada Core y Avada Builder, marcar «Descargar e importar archivos adjuntos»
y asignar los autores a un usuario de San Blas.

Pendiente de revisar tras importar: páginas en borrador o pendientes («Elementor #5050», «Rito del Matrimonio»,
«Rito del Bautismo», «PARTIDA DE BAUTISMO») y las de ejemplo en inglés («Blog», «Contact»): probablemente sobran.
**«Home» no se borra: es la portada** (vídeo de fondo con el logo encima).

## Ajustes que no viajan en la exportación (los aplica el blueprint)
- Diseño global de Avada (opción `fusion_tb_layout_default`): cabecera «Global Menu Header» y pie «Global Footer»
- Portada = página «Home»
- Direcciones de imágenes y vídeo: de parroquiasdesancristobal.archimadrid.es a las copias locales
- El logo blanco de la portada era una miniatura de Elementor y no se importa: se sustituye por el de San Blas

## Menú principal
INICIO · Parroquias (Horarios, Calendario parroquial, N.ª S.ª de los Desamparados, San Lucas) ·
Sacramentos y celebraciones (Bautismo, Confirmación, Eucaristía, Matrimonio, Perdón, Unción de los enfermos,
Misa de funeral, Misa de quince años) · Grupos (Club de amigos, Junior, Juveniles, Postcomunión,
Catequesis tradicional, Iniciación cristiana, Pastoral de la salud, Piedad Popular, Renovación Carismática) ·
Cáritas (Acogida) · SARCU · Donativos · Contacto
