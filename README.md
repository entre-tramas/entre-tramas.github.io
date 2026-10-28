# Entre-Tramas — Club de lectura de cuentos

Sitio informativo (estático, data-driven) para **Entre-Tramas**, el club de lectura de cuentos de La Plata (y virtual).
Está pensado como *landing one-page* + una página secundaria de modalidad presencial.

- **Instagram ( contacto real ):** [@club.entre.tramas](https://www.instagram.com/club.entre.tramas/)
- **Sin pagos ni inscripciones automáticas:** todo el funnel pasa por Instagram (DM).

## Stack

| Pieza | Elección | Nota |
| HTML | Jekyll + Liquid | el copy ya no vive en el HTML: vive en `_data/*.yml` |
| CSS | `assets/css/site.css` | variables CSS al inicio (`:root`) para retheming |
| Interactividad | [HTMX 2.0.4](https://htmx.org) vía CDN | solo para alternar modalidad virtual/presencial |
| JavaScript propio | **ninguno** | 0 líneas de JS custom |
| CMS | [Sveltia CMS](https://sveltia-cms) en `admin/` | editar todo el contenido sin tocar código |
| Fallback sin JS | enlaces reales (`presencial.html`, `index.html#modalidades`) | la navegación no depende de HTMX |
| Fuentes | Fraunces (display, serif) + Inter (UI) + JetBrains Mono (etiquetas) | Google Fonts |

## Estructura

```
.
├── index.html                      # plantilla del landing (Liquid sobre _data/landing.yml)
├── presencial.html                 # plantilla de la página presencial (Liquid sobre _data/presencial.yml)
├── partials/
│   ├── modalidad-virtual.html      # fragmento HTMX (Liquid; comparte data con el landing)
│   └── modalidad-presencial.html   # ídem
├── _config.yml                     # configuración Jekyll (url, excludes)
├── Gemfile                         # jekyll en local (bundle install)
├── admin/
│   ├── index.html                  # Sveltia CMS (carga desde CDN)
│   └── config.yml                  # esquema del CMS (espejo exacto de los .yml)
├── _data/
│   ├── landing.yml                 # TODO el contenido de la home (hero → footer)
│   └── presencial.yml              # contenido de la página presencial
├── assets/
│   ├── css/site.css                # todo el estílo
│   └── favicon.svg
├── robots.txt
├── sitemap.xml
└── README.md
```

## Levantar el sitio en local

```bash
bundle install               # una vez
bundle exec jekyll serve     # → http://127.0.0.1:4000
```

También sigue funcionando el servidor plano para revisar el HTML estático:

```bash
./serve.sh   # http://localhost:8080 (NO_OPEN=1 ./serve.sh en scripts)
```

> HTMX requiere servir los archivos con un servidor HTTP real (los `hx-get` no funcionan con `file://`).
> El build oficial lo hace GitHub Pages con sus propias reglas; en local usamos Jekyll 4.4 con el mismo subconjunto de Liquid, y para desplegar solo hacen falta commits.

## Administrar el contenido (Sveltia CMS)

El 100% del texto del sitio se edita desde **/admin/** sin tocar una línea de HTML:

- **Remoto (producción):** abrí <https://entre-tramas.github.io/admin/> e iniciá sesión con GitHub:
  - Sveltia pide el repo `entre-tramas/entre-tramas.github.io` vía token: generás en
    *GitHub → Settings → Developer settings → Personal access tokens* un PAT con
    permiso repo (contenido: read & write) y lo pegás la primera vez.
  - Cada "Guardar" = commit directo al repo → la página del club se actualiza cuando Pages recompila (~1 min).
- **Local (sin token):** `bundle exec jekyll serve` + <http://127.0.0.1:4000/admin/>:
  Sveltia usa *File System Access API* (Chrome) para escribir directo en los `yml` del repo —
  el preview del sitio en la otra pestaña recarga solo.
- **Dos colecciones:** *Página de inicio* (todo el landing, sección por sección) y *Página presencial*.
  Las tarjetas Vritual/Presencial se editan una sola vez (fuente única en `landing.yml → modalidades`).
- Las imágenes nuevas que suba el CMS van a `assets/media/`.

## Publicado en https://entre-tramas.github.io/

El login real de la cuenta GitHub es **entre-tramas** (con guion), así que el
user-site vive en <https://entre-tramas.github.io/> y el repo en
`entre-tramas/entre-tramas.github.io` (Pages servido desde `main` / raíz).

Estado: publicado ✓ — creado y empujado con `gh` (cuenta active entre-tramas,
clave SSH `~/.ssh/github_entretramas` registrada como auth + signing en la cuenta).

Si más adelante se renombra la cuenta a `entretramas` (Settings → Change
username), la URL pasa a <https://entretramas.github.io/> y basta actualizar
`canonical`, `sitemap.xml`, `robots.txt`, `_config.yml` y este README.

## Personalización rápida

Todo el look se controla con las variables al inicio de `assets/css/site.css`:

```css
:root {
  --paper: #f4ede0;        /* fondo general */
  --paper-alt: #ece2cf;    /* franjas alternadas */
  --ink: #1a1814;          /* texto principal */
  --wine: #8a2a1f;         /* acento principal */
  --gold: #b8872a;         /* acento secundario */
  --serif: 'Fraunces', …;
  --sans: 'Inter', …;
  --mono: 'JetBrains Mono', …;
}
```

Y todo el **texto** desde el CMS (`/admin/`) o directamente editando `_data/*.yml`.

Pendiente de completar por el cliente (buscar `<-- FIXME` o los literales):
- nombre de quien coordina las sesiones
- mail de contacto
- foto real del club (hoy hay un bloque placeholder en el hero)

## SEO / datos

- `lang="es-AR"`, canonical hacia `https://entre-tramas.github.io/`
- Meta dinámica: `_data/landing.yml → meta` (título, descripción, OG, Twitter) — editable desde el CMS
- JSON-LD `@type: Organization` + `WebSite` + `FAQPage` en la home (el FAQ se genera desde el mismo listado del CMS)
- `sitemap.xml` y `robots.txt` listos

Hecho para leer despacio.