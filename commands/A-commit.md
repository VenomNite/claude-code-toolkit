---
model: sonnet
description: Commit en castellano (sin coautores) con fetch y push; mensaje auto si no se pasa
argument-hint: [mensaje] [--amend] [--no-push]
---

# Smart Commit (ES)

Commit limpio y conciso en castellano: $ARGUMENTS

## Contexto
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Branch actual: !`git branch --show-current`
- Staging: !`git status --porcelain`

## Proceso
1. **Previa**: !`git fetch --prune`
2. **Staging**: Si vacío → !`git add -A`
3. **Mensaje**: 
   - Con [mensaje] → usar como título (≤72 chars)
   - Sin mensaje → auto: "actualiza: [archivos principales]"
4. **Commit**: Normal o --amend (sin coautores)
5. **Push**: Al remoto salvo --no-push

## Output
- Commit en castellano con título conciso
- Push automático si hay upstream
- Muestra: !`git log -1 --oneline`

## Ejemplos
- `/commit "corrige: validación de formulario"`
- `/commit` (auto-genera)
- `/commit --amend --no-push`

## DoD
- Fetch remoto ejecutado correctamente con --prune
- Archivos añadidos al staging area (si estaba vacío)
- Mensaje en castellano generado o aplicado (≤72 chars)
- Commit realizado sin coautores Claude según reglas globales
- Push automático ejecutado (excepto con --no-push)
- Confirmación final: git log -1 --oneline mostrado