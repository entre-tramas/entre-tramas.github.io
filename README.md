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
python3 -m http.server 8080
# → http://localhost:8080
```

> HTMX requiere servir los archivos con un servidor HTTP real (los `hx-get` no funcionan con `file://`).

## Publicarlo en https://entretramas.github.io/

Decisión: se publica como *user-site* de la cuenta GitHub **entretramas** (a crear).

1. Crear la cuenta GitHub `entretramas` (verificación por email incluida).
2. Loguearla en la CLI y dejar la actual como alternativa:

   ```bash
   gh auth login                   # cuenta nueva: entretramas (device flow)
   gh auth switch -u entretramas
   ```

3. Publicar (crea el repo y hace push del contenido actual):

   ```bash
   gh repo create entretramas/entretramas.github.io --public --source=. --remote=origin --push
   ```

4. Activar Pages servido desde `main` / raíz:

   ```bash
   gh api -X POST repos/entretramas/entretramas.github.io/pages \
        -f "source[branch]=main" -f "source[path]=/"
   ```

5. Al minuto: el sitio queda en <https://entretramas.github.io>.

> Los `canonical`, `sitemap.xml` y `robots.txt` ya apuntan a esa URL: publicar desde la cuenta nueva no requiere retocar el sitio.
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

- `lang="es-AR"`, canonical hacia `https://entretramas.github.io/`
- Open Graph completo (title / description / locale `es_AR`)
- JSON-LD `@type: Course` (club gratuito) + `FAQPage` en la home
- `sitemap.xml` y `robots.txt` listos

Hecho para leer despacio.