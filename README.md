# Entre-Tramas — Club de lectura de cuentos

Sitio informativo (SPA estática) para **Entre-Tramas**, el club de lectura de cuentos de La Plata (y virtual).
Está pensado como *landing one-page* + una página secundaria de modalidad presencial.

- **Instagram ( contacto real ):** [@club.entre.tramas](https://www.instagram.com/club.entre.tramas/)
- **Sin pagos ni inscripciones automáticas:** todo el funnel pasa por Instagram (DM).

## Stack

| Pieza | Elección | Nota |
|---|---|---|
| HTML | `.html` plano | sin build, sin bundler |
| CSS | `assets/css/site.css` | variables CSS al inicio (`:root`) para retheming |
| Interactividad | [HTMX 2.0.4](https://htmx.org) vía CDN | solo para alternar modalidad virtual/presencial |
| JavaScript propio | **ninguno** | 0 líneas de JS custom |
| Fallback sin JS | enlaces reales (`presencial.html`, `index.html#modalidades`) | la navegación no depende de HTMX |
| Fuentes | Fraunces (display, serif) + Inter (UI) + JetBrains Mono (etiquetas/precios) | Google Fonts |
| Iconografía | SVG/emoji inline | sin dependencias |

## Estructura

```
.
├── index.html                      # landing (hero → club → modalidades → selección → cómo funciona → incluye → muestra → preguntas → contacto)
├── presencial.html                 # página fallback sin JS para la pestaña "Presencial"
├── partials/
│   ├── modalidad-virtual.html      # fragmento HTMX (se inyecta en #modalidad-card)
│   └── modalidad-presencial.html   # ídem
├── assets/
│   ├── css/site.css                # todo el estílo
│   └── favicon.svg
├── robots.txt
├── sitemap.xml
└── README.md
```

## Levantarlo en local

```bash
# en la raíz del repo
./serve.sh   # http://localhost:8080 (NO_OPEN=1 ./serve.sh en scripts)
# → http://localhost:8080
```

> HTMX requiere servir los archivos con un servidor HTTP real (los `hx-get` no funcionan con `file://`).

## Publicado en https://entre-tramas.github.io/

El login real de la cuenta GitHub es **entre-tramas** (con guion), así que el
user-site vive en <https://entre-tramas.github.io/> y el repo en
`entre-tramas/entre-tramas.github.io` (Pages servido desde `main` / raíz).

Estado: publicado ✓ — creado y empujado con `gh` (cuenta active entre-tramas,
clave SSH `~/.ssh/github_entretramas` registrada como auth + signing en la cuenta).

Si más adelante se renombra la cuenta a `entretramas` (Settings → Change
username), la URL pasa a <https://entretramas.github.io/> y basta actualizar
`canonical`, `sitemap.xml`, `robots.txt` y este README.
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

Pendiente de completar por el cliente (buscar `<-- FIXME` o los literales):
- nombre de quien coordina las sesiones
- mail de contacto
- foto real del club (hoy hay un bloque placeholder en el hero)

## SEO / datos

- `lang="es-AR"`, canonical hacia `https://entre-tramas.github.io/`
- Open Graph completo (title / description / locale `es_AR`)
- JSON-LD `@type: Course` (club gratuito) + `FAQPage` en la home
- `sitemap.xml` y `robots.txt` listos

Hecho para leer despacio.