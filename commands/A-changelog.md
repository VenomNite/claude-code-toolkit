---
argument-hint: [version] | [entry-type] [description] | [--commit] [mensaje] [--amend] [--no-push]
description: Generate and maintain project changelog with integrated commit functionality (formerly A-commit)
model: sonnet
---

# Add Changelog Entry

Generate and maintain project changelog: $ARGUMENTS

## Context
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`

## Current State

- Existing changelog: @CHANGELOG.md (if exists)
- Recent commits: !`git log --oneline -10`
- Current version: !`git describe --tags --abbrev=0 2>/dev/null || echo "No tags found"`

## Task

1. **Changelog Format**
   ```markdown
   # Changelog
   
   All notable changes to this project will be documented in this file.
   
   ## [Unreleased]
   ### Added
   - New features
   
   ### Changed
   - Changes in existing functionality
   
   ### Deprecated
   - Soon-to-be removed features
   
   ### Removed
   - Removed features
   
   ### Fixed
   - Bug fixes
   
   ### Security
   - Security improvements
   ```

2. **Version Entries**
   ```markdown
   ## [1.2.3] - 2025-01-15
   ### Added
   - User authentication system
   - Dark mode toggle
   - Export functionality for reports
   
   ### Fixed
   - Memory leak in background tasks
   - Timezone handling issues
   ```

Remember to keep entries clear, categorized, and focused on user-facing changes.

## 🔄 INTEGRATED COMMIT FUNCTIONALITY (Formerly A-commit)

### **Smart Commit Mode** (when --commit flag is used)
```bash
/A-changelog --commit "corrige: validación de formulario"
/A-changelog --commit  # auto-genera mensaje
/A-changelog --commit --amend --no-push
```

### **Commit Process**
1. **Pre-commit**: `git fetch --prune`
2. **Staging**: Si vacío → `git add -A`
3. **Mensaje**:
   - Con [mensaje] → usar como título (≤72 chars)
   - Sin mensaje → auto: "actualiza: [archivos principales]"
4. **Commit**: Normal o --amend (sin coautores según reglas globales)
5. **Push**: Al remoto salvo --no-push

### **Integrated Release Flow**
```bash
# Opción 1: Solo changelog
/A-changelog "2.1.1" "Fixed user authentication timeout"

# Opción 2: Changelog + commit + tag
/A-changelog --commit --release "2.1.1" "Fixed user authentication timeout"

# Opción 3: Solo commit (funcionalidad heredada de A-commit)
/A-changelog --commit "corrige: timeout de autenticación"
```

### **Release Management Features**
- **Auto-tagging**: Con --release crea git tag automáticamente
- **Version bumping**: Actualiza versión en package.json/pyproject.toml si existe
- **Commit integration**: Combina changelog update + commit en una operación
- **Castellano por defecto**: Commits en castellano sin coautores

## DoD
- CHANGELOG.md creado/actualizado con formato estándar
- Versión actual detectada correctamente desde git tags
- Commits recientes analizados para generar entradas
- Entrada formateada apropiadamente con fecha ISO (YYYY-MM-DD)
- Cambios categorizados correctamente: Added, Changed, Deprecated, Removed, Fixed, Security
- Enlaces de versión incluidos si aplican (comparaciones git)
- **[Cuando --commit]**: Fetch ejecutado, archivos staged, commit realizado sin coautores, push automático
- **[Cuando --release]**: Tag creado, versión actualizada en archivos de configuración