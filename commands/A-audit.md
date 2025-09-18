---
model: sonnet
description: Deep code audit applying /coding standards with dependency-impact mapping and actionable findings. Git-optional.
argument-hint: [target: file|dir|commit|branch] [--scope repo|module|file] [--full] [--fix|--nofix] [--stack auto|node|python|java|go|rust|php|dotnet|react|vue|angular]
---

# Deep Audit (coding standards

Auditoría profunda y concisa usando /coding standards con grafo de dependencias y matrices para priorizar acciones.

## Contexto
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Stack (auto o `--stack`):
  - Si `--stack` → se toma como hint (normaliza sin exigir coincidencia exacta).
  - Detectar `coding standards del stack y cargar reglas; si no hay coincidencia → `coding standards
- Reglas coding standards cargar 8–12 (`**/coding standards, filosofía *Less is sometimes better*; permitir transgresión justificada (anotar beneficio y mitigación).

## Pasos
- **Inventario & Hotspots**: mapear módulos top-level y tamaños.
- **Grafo & Reverse-Deps (anti-roturas)**:
  - Imports por stack (grep heurístico).
  - Construir reverse-deps del `target`; marcar APIs públicas/contratos.
- **Calidad**: *dead code* candidates, duplicidades (firmas/bloques), smells de estilo/errores (según coding standards del stack).
- **Performance (ligera, si procede)**: N+1, I/O síncrono, loops pesados, bundles grandes (web).  
  Si no aplica → "N/A".
- **Recomendaciones & Parches**: cambios *scope-aware* (no eliminar símbolos usados; si público → deprecate + migrate).  
  `--fix`: proponer *diffs* idempotentes.

## Matrices (incluir siempre)
**Matriz de Impacto (Dependencias)**
| Afecta a | Tipo | Relación | Riesgo rotura | Nota |
|---|---|---|---|---|

**Matriz de Hallazgos (Prioridad)**
| Nivel | Archivo:Línea | Hallazgo | Acción propuesta | Esfuerzo |
|---|---|---|---|---|

**Matriz de Refactors (coding standards**
| Regla coding standards | Caso | Transgresión (si aplica) | Beneficio | Mitigación |
|---|---|---|---|---|

## Salida esperada
- Informe Markdown: resumen (≤10 bullets), 3 matrices, lista de parches (si `--fix`) o plan de deprecación/migración.
- `--full` (opcional) → anexos en `Claude/reports/audit/`:
  - `impact-map-$TARGET.md` (grafo textual/mermaid).
  - `patches-$TARGET.diff` (si procede).

## DoD
- Reglas `/coding standards cargadas (o `coding standards por fallback).
- Reverse-deps generado y respetado.
- 3 matrices completas con archivo:línea.
- Recomendaciones priorizadas con esfuerzo.