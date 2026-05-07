# Archivo de versiones (releases)

Este directorio contiene **snapshots inmutables** del paquete documental Rymel para cada versión formal cerrada con el cliente.

## 1. Convención

- Cada versión se almacena en `vMAJOR.MINOR.PATCH/` (ej. `v1.0.0/`).
- Los snapshots **nunca se modifican** una vez creados. Si se detecta un error en una versión publicada, la corrección se aplica a los documentos vivos en `docs/` y se publica como **nueva versión**.
- Cada snapshot incluye un `MANIFEST.txt` con metadatos (versión, fecha, autor del sistema, archivos y tamaños).
- Los archivos vivos en `docs/` siempre reflejan **la versión vigente más reciente** (puede ser una pre-release en curso).

## 2. Crear un nuevo snapshot

Antes de ejecutar el script, asegúrate de que:

1. Los headers de los 4 documentos y del `README.md` indiquen la nueva versión.
2. Las tablas "Control de versiones del documento" estén actualizadas con la fila correspondiente.

Luego ejecuta:

```bash
cd /Users/alex.pinaida/Resplados/Code/Rymel/docs/releases
./snapshot.sh 1.1.0
```

El script:

1. Valida el formato semver (`X.Y.Z`).
2. Rechaza versiones ya publicadas.
3. Copia todos los `.md` vigentes desde `docs/` a `docs/releases/v<versión>/`.
4. Genera un `MANIFEST.txt` con metadatos.

## 3. Política de versionado (recordatorio)

| Tipo | Cuándo se incrementa | Ejemplo |
|------|----------------------|---------|
| **MAJOR** (`X.0.0`) | Reestructura del paquete o cambio de alcance del proyecto. | `1.x.x` → `2.0.0` |
| **MINOR** (`x.Y.0`) | Adiciones funcionales: nuevos requerimientos, casos de uso, módulos, fases o secciones. | `1.0.x` → `1.1.0` |
| **PATCH** (`x.y.Z`) | Correcciones tipográficas, aclaraciones, ajustes menores. | `1.0.0` → `1.0.1` |

## 4. Distribución a Notion

Para cada snapshot publicado, el flujo recomendado es:

1. Mantener el árbol vivo **"Documentación Rymel"** en Notion sincronizado con `docs/` (la versión vigente).
2. Al cerrar una versión, **duplicar** el árbol vivo en Notion bajo una subpágina "Archivo de versiones" con sufijo `v1.0.0`, `v1.1.0`, etc.
3. Alternativamente, exportar el árbol vivo a PDF (`···` → Export → PDF) y adjuntarlo en "Archivo de versiones" como entregable inmutable firmable.

## 5. Versiones publicadas

| Versión | Fecha | Autor | Resumen |
|---------|-------|-------|---------|
| [v1.0.0](./v1.0.0/) | 2026-05-06 | Alex Pinaida | Línea base inicial: SRS con casos de uso detallados, arquitectura técnica, especificación funcional/módulos y estructura web/plan de fases. |

> Cada vez que el script `snapshot.sh` cree una nueva versión, **agrega manualmente una fila a esta tabla** describiendo el alcance del cambio.
