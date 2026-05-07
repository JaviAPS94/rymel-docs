# CLAUDE.md — Repositorio rymel-docs

Contexto operativo para Claude Code. Se carga automáticamente al abrir sesión en este directorio.

## Qué es este repo

Paquete documental formal del **proyecto Rymel** (cliente: Rymel). Contiene 4 documentos `.md` que describen requerimientos, arquitectura, módulos y plan de fases de la Plataforma Rymel.

La Plataforma Rymel se compone de 4 sub-proyectos ubicados en el directorio padre `../`:

- `project-back` — API NestJS + TypeORM + MSSQL
- `project-front` — SPA React + Redux Toolkit
- `project-admin` — SPA React + Zustand
- `secure-function-engine-api` — Microservicio NestJS (cifrado/evaluación de fórmulas)

**Autor del paquete:** Alex Pinaida (alex.pinaida@rappi.com)
**Remoto:** `git@github.com:JaviAPS94/rymel-docs.git`

## Estructura

```
docs/                                          ← raíz del repo git (este directorio)
├── CLAUDE.md                                  ← este archivo
├── README.md                                  ← índice + política de versionado
├── 01_Especificacion_Requerimientos_SRS.md    ← DOC-01 SRS
├── 02_Arquitectura_Tecnica.md                 ← DOC-02
├── 03_Especificacion_Funcional_Modulos.md     ← DOC-03
├── 04_Estructura_Web_y_Plan_Fases.md          ← DOC-04
└── releases/
    ├── README.md                              ← guía del archivo de versiones
    ├── snapshot.sh                            ← script de snapshot (semver, idempotente)
    └── vX.Y.Z/                                ← snapshots inmutables (uno por release)
```

## Restricciones críticas

- El directorio padre `Rymel/` **NO tiene git** y **nunca debe tenerlo**. Las carpetas hermanas (`project-admin`, `project-back`, `project-front`, `secure-function-engine-api`) tienen sus propios repos remotos independientes.
- **Solo `docs/` es repo git** en este árbol. El remoto es `origin → JaviAPS94/rymel-docs` (privado).
- Los snapshots en `releases/vX.Y.Z/` son **inmutables**. Nunca editar contenido ahí; el script `snapshot.sh` se niega a sobrescribir versiones existentes.
- Convenciones de los documentos: español, tono formal, diagramas en Mermaid, encabezados máximo H3 (Notion-friendly), referencias cruzadas con formato `DOC-XX §N.N`.

## Política de versionado (semver `MAJOR.MINOR.PATCH`)

Los 4 documentos vivos siempre reflejan la versión vigente más reciente. El número se mantiene en tres lugares:

1. Header **"Versión:"** al inicio de cada documento.
2. Tabla **"Control de versiones del documento"** al final de cada documento.
3. Tabla **"Control de versiones del paquete"** en `README.md` §6.

Reglas:

| Tipo | Cuándo se incrementa | Ejemplo |
|------|----------------------|---------|
| **PATCH** (`x.y.Z`) | Tipos, aclaraciones, ajustes menores. | `1.0.0` → `1.0.1` |
| **MINOR** (`x.Y.0`) | Nuevos requerimientos, módulos, casos de uso, secciones, fases. | `1.0.x` → `1.1.0` |
| **MAJOR** (`X.0.0`) | Reestructura del paquete o cambio de alcance del proyecto. | `1.x.x` → `2.0.0` |

## Workflow para publicar una nueva versión

Ejemplo: cierre de v1.1.0.

1. **Edita** los `.md` afectados con los cambios sustantivos.
2. **Actualiza la versión** en cada documento modificado:
   - Header `Versión: 1.1.0`.
   - Nueva fila en su tabla "Control de versiones del documento" describiendo qué cambió.
3. **Actualiza** `README.md` §6 (tabla "Control de versiones del paquete") con la fila correspondiente.
4. **Commits intermedios** durante el trabajo:
   ```bash
   git add .
   git commit -m "<descripción concreta del cambio>"
   git push
   ```
5. **Cierre formal — generar snapshot:**
   ```bash
   ./releases/snapshot.sh 1.1.0
   ```
   El script crea `releases/v1.1.0/` con los `.md` vigentes + `MANIFEST.txt`. Falla si la versión ya existe (las versiones son inmutables).
6. **Actualiza** `releases/README.md` §5 — agrega fila en la tabla "Versiones publicadas".
7. **Commit del snapshot, tag y push:**
   ```bash
   git add .
   git commit -m "snapshot v1.1.0"
   git tag -a v1.1.0 -m "v1.1.0 — <resumen del cambio>"
   git push
   git push --tags
   ```
8. **Crear GitHub Release** (web o `gh`):
   - **Web:** `https://github.com/JaviAPS94/rymel-docs/releases` → Draft new → tag `v1.1.0` → título `v1.1.0 — <título>` → notas → Publish.
   - **CLI:** `gh release create v1.1.0 --title "v1.1.0 — <título>" --notes-from-tag`.

## Comandos frecuentes

```bash
git log --oneline --decorate          # historial con tags
git tag -l -n5                        # tags con sus mensajes
git diff v1.0.0..v1.1.0 -- '*.md'     # qué cambió entre versiones
./releases/snapshot.sh 1.1.0          # nuevo snapshot (con validación semver)
```

## Cosas que NO hacer

- `git init` en `Rymel/` o cualquier directorio superior.
- Editar archivos dentro de `releases/vX.Y.Z/` (snapshots inmutables).
- `git push --force` a `main` (rompe trazabilidad y desincroniza tags).
- `git push --delete origin vX.Y.Z` (los tags publicados son entregables al cliente).
- Mensajes de commit vagos tipo "update" o "changes" — describe qué se modificó y por qué.
- Saltarse pasos del workflow (especialmente el snapshot antes del tag): el snapshot y el tag deben quedar en el mismo commit o consecutivos.

## Convenciones de redacción

- Cada nuevo requerimiento usa el formato `RF-NNN` (funcional) o `RNF-NNN` (no funcional), continuando la numeración existente.
- Cada nuevo caso de uso usa `CU-NNN` y debe incluir: actor principal, actores secundarios, precondiciones, postcondiciones, flujo principal numerado, flujos alternativos, reglas relacionadas, requerimientos cubiertos, y un diagrama Mermaid de secuencia.
- Cada nueva regla de negocio usa `RN-XX`.
- Las referencias cruzadas entre documentos usan `DOC-XX §N.N`.
