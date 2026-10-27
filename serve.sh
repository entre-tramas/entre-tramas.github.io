#!/usr/bin/env bash
# Servidor local de desarrollo para Entre-Tramas (sitio estático + HTMX).
#
# Uso:
#   ./serve.sh                # http://localhost:8080
#   ./serve.sh 3000           # otro puerto
#   NO_OPEN=1 ./serve.sh      # no abre el navegador (útil en scripts/CI)
#
# HTMX necesita un servidor HTTP real: con file:// los hx-get no funcionan.

set -euo pipefail
cd "$(dirname "$0")"

PORT="${1:-8080}"
if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
  echo "Puerto inválido: $PORT" >&2
  exit 1
fi

if (exec 3<>"/dev/tcp/127.0.0.1/$PORT") 2>/dev/null; then
  exec 3>&- 3<&- 2>/dev/null || true
  echo "El puerto ${PORT} ya está en uso. Probá otro: ./serve.sh $((PORT + 1))" >&2
  exit 1
fi

PY=python3
command -v "$PY" >/dev/null 2>&1 || PY=python

URL="http://localhost:${PORT}/"
if [ -z "${NO_OPEN:-}" ] && command -v open >/dev/null 2>&1; then
  ( sleep 1 && open "$URL" ) &
fi

echo "→ Entre-Tramas en ${URL}  (Ctrl+C para parar)"

# http.server sin caché: cada recarga ve los cambios al instante.
exec "$PY" -c '
import http.server, sys

class SinCache(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cache-Control", "no-store")
        super().end_headers()

http.server.test(HandlerClass=SinCache, port=int(sys.argv[1]), bind="127.0.0.1")
' "$PORT"