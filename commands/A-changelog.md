---
argument-hint: [version] | [entry-type] [description]
description: Generate and maintain project changelog
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

## DoD
- CHANGELOG.md creado/actualizado con formato estándar
- Versión actual detectada correctamente desde git tags
- Commits recientes analizados para generar entradas
- Entrada formateada apropiadamente con fecha ISO (YYYY-MM-DD)
- Cambios categorizados correctamente: Added, Changed, Deprecated, Removed, Fixed, Security
- Enlaces de versión incluidos si aplican (comparaciones git)