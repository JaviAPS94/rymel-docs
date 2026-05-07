#!/usr/bin/env bash
# snapshot.sh
# Crea un snapshot inmutable del paquete documental Rymel vigente.
#
# Uso:    ./snapshot.sh <versión>
# Ejemplo: ./snapshot.sh 1.1.0
#
# El snapshot copia todos los archivos .md de docs/ a docs/releases/v<versión>/
# junto con un MANIFEST.txt. Las versiones existentes son inmutables: el script
# se niega a sobrescribir un release ya publicado.

set -euo pipefail

# -------- 1. Argumento --------
if [[ $# -ne 1 ]]; then
  echo "Uso: $0 <versión>"
  echo "Ejemplo: $0 1.1.0"
  exit 1
fi

VERSION="$1"

# -------- 2. Validar formato semver MAJOR.MINOR.PATCH --------
if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: '$VERSION' no es un semver válido (formato esperado: X.Y.Z)"
  exit 1
fi

# -------- 3. Resolver rutas --------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="$SCRIPT_DIR/v$VERSION"

# -------- 4. Refusar sobrescribir --------
if [[ -e "$TARGET_DIR" ]]; then
  echo "Error: la versión v$VERSION ya existe en:"
  echo "  $TARGET_DIR"
  echo ""
  echo "Las versiones publicadas son inmutables. Usa otro número."
  exit 1
fi

echo "Preparando snapshot v$VERSION"
echo "  Origen:  $DOCS_DIR"
echo "  Destino: $TARGET_DIR"
echo ""

# -------- 5. Copiar archivos .md de la raíz de docs/ --------
mkdir -p "$TARGET_DIR"
shopt -s nullglob
COPIED=0
for f in "$DOCS_DIR"/*.md; do
  cp -p "$f" "$TARGET_DIR/"
  echo "  + $(basename "$f")"
  COPIED=$((COPIED + 1))
done
shopt -u nullglob

if [[ "$COPIED" -eq 0 ]]; then
  echo "Error: no se encontraron archivos .md en $DOCS_DIR"
  rmdir "$TARGET_DIR"
  exit 1
fi

# -------- 6. Generar MANIFEST.txt --------
DATE=$(date '+%Y-%m-%d %H:%M:%S %z')
HOST=$(uname -n 2>/dev/null || echo desconocido)
USER_NAME=$(id -un 2>/dev/null || echo desconocido)

{
  echo "Snapshot del paquete documental Rymel"
  echo "======================================"
  echo "Versión:       v$VERSION"
  echo "Fecha:         $DATE"
  echo "Generado por:  $USER_NAME @ $HOST"
  echo "Archivos:      $COPIED"
  echo ""
  echo "Contenido:"
  for f in "$TARGET_DIR"/*.md; do
    size=$(wc -c < "$f" | tr -d ' ')
    echo "  $(basename "$f") (${size} bytes)"
  done
  echo ""
  echo "Este snapshot es INMUTABLE. Cualquier corrección debe aplicarse a los"
  echo "documentos vivos en docs/ y publicarse como una nueva versión."
} > "$TARGET_DIR/MANIFEST.txt"

# -------- 7. Resumen final --------
echo ""
echo "Snapshot v$VERSION creado correctamente:"
echo "  $TARGET_DIR"
echo ""
echo "Próximos pasos sugeridos:"
echo "  1. Agregar fila a docs/releases/README.md → tabla 'Versiones publicadas'."
echo "  2. (Opcional) Crear tag git: git tag v$VERSION && git push --tags"
echo "  3. Subir snapshot a Notion en 'Archivo de versiones' como entregable formal."
