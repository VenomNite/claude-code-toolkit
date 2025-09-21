---
model: claude-sonnet-4-20250514
description: Auto-organización inteligente con preservación total de dependencias/imports/exports/rutas. Predict-issues y full-restructure.
argument-hint: [--scan|--apply|--predict-issues|--full-restructure] [--scope project|module|dir] [--stack auto|react|node|python|java] [--horizon 1d|1w|2w|1m|3m|6m|1y]
---

# Auto-Organize with Standards

Reorganización inteligente con preservación total de dependencias aplicando standards/{detected-stack}.yaml $ARGUMENTS

## Contexto  
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Stack detection: !`find . -name "package.json" -o -name "requirements.txt" -o -name "pom.xml" | head -1`
- Current files: !`find . -type f \( -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.java" \) | wc -l`
- Git activity: !`git log --oneline --since="3 months" --name-only | sort | uniq -c | sort -nr | head -10`
- Standards loading: Load standards/{detected-stack}.yaml || standards/general.yaml as fallback

## Modes & Workflow (SAFETY FIRST)

### **Default Safe Mode (Recommended)**
1. **Default behavior**: `--dry-run` automático (no cambios sin confirmar)
2. **Scan + Diff Preview** → Análisis completo + preview de cambios
3. **Manual Confirmation** → Usuario debe confirmar explícitamente
4. **Apply with Backup** → Ejecuta con backup automático

### **Standard Workflow**
```bash
/A-organize                    # DEFAULT: dry-run + diff preview
# → Shows matrices + diff preview + requires confirmation
# → "Continue with reorganization? [y/N]"

/A-organize --apply            # Skip dry-run, direct application
# → "WARNING: Direct apply mode. Create backup? [Y/n]"
# → "Show diff preview? [Y/n]"
# → Ejecuta con confirmación
```

### **Safety Override Modes**
- `--apply`: Skip dry-run, pero aún requiere confirmación + diff preview
- `--force`: Skip ALL safety (backup + confirmación + diff) - DANGEROUS
- `--quiet`: Minimal output, pero conserva safety prompts

### **Analysis Modes**
- `--predict-issues --horizon [1d|1w|2w|1m|3m|6m|1y]`: Solo predicción (default: 1m)
- `--full-restructure`: Reestructuración completa siguiendo best practices

## Proceso Core

### **Dependency Preservation** (CRÍTICO)
1. **Complete Dependency Map**:
   - Imports/exports por stack: `import|require|from` (JS), `import|from` (Python), etc.
   - Relative/absolute path analysis
   - Asset references (images, styles, configs)  
   - Dynamic imports/requires detection

2. **Safe Reorganization with Safety Gates**:
   - **Pre-Move Backup**: Automatic backup to `Claude/backup/organize-${timestamp}/`
   - **Diff Preview**: Show exactly what will change (paths, imports, references)
   - **User Confirmation**: "Continue with these changes? [y/N]"
   - **Move files to new structure** (only after confirmation)
   - **Auto-update ALL import paths** (preserve relative/absolute)
   - **Preserve export/import naming exactly**
   - **Update asset references, config paths**
   - **Post-move validation**: Syntax check + broken import detection
   - **Rollback capability**: "Revert changes? Backup available at [path]"

### **Predict Issues** (por horizon)
- **1d-1w**: Growth pattern analysis → immediate bottlenecks
- **2w-1m**: File size trends → split candidates  
- **3m-6m**: Import complexity growth → refactor architecture needs
- **1y**: Strategic structure sustainability analysis

### **Full Restructure** 
- Load standards/{detected-stack}.yaml architecture patterns
- Apply best practices: React (features/), Node (modules/), Python (packages/), etc.
- Complete structural transformation with dependency preservation

## Matrices (incluir siempre)

**Matriz de Dependencias (Pre-Move)**
| Archivo | Imports From | Exports To | Asset Refs | Path Type |
|---|---|---|---|---|

**Matriz de Reorganización (Diff Preview)**
| Archivo | Ubicación Actual | Nueva Ubicación | Imports Updated | Risk Level | Backup Status |
|---|---|---|---|---|---|

**Matriz de Safety Validation**
| Check | Status | Details | Action Required | Rollback Available |
|---|---|---|---|---|

**Matriz de Predicción** (predict-issues)
| Directorio/Archivo | Issue Predicho | Probabilidad | Horizon | Acción Preventiva |
|---|---|---|---|---|

**Matriz Standards Compliance**
| Regla | Violación Actual | Fix Propuesto | Transgresión Justificada | Beneficio |
|---|---|---|---|---|

## Tool Arsenal
- **Glob**: Inventory masivo por stack patterns
- **Grep**: Dependency analysis masivo con stack-specific patterns
- **Read**: Import/export parsing + path resolution  
- **Edit**: Mass path updates durante reorganización
- **Bash**: Post-move validation (syntax check por stack)

## Output Structure  
- **Scan**: `Claude/reports/organize/scan-${timestamp}.md`
- **Apply**: Backup en `Claude/backup/organize-${timestamp}/` + execution log
- **Predict**: `Claude/predictions/organize-issues-${horizon}-${timestamp}.md`
- **Full**: `Claude/restructure/plan-execution-${timestamp}.md`

## Standards Integration
- **"Less is sometimes better"**: Estructura simple, lógica, mantenible
- **Modularidad SIEMPRE**: Interfaces claras entre directorios reorganizados  
- **Transgresión justificada**: Documentar cuando organización rompe convención por beneficio
- **NO code changes**: Solo organización - el código es tuyo

## Examples

### **Safe Workflow Examples**
```bash
# DEFAULT SAFE MODE (Recommended)
/A-organize
# → Shows dependency matrix
# → Shows diff preview: "components/Header.js → features/ui/Header.js"
# → Shows impact: "3 imports will be updated in App.js, Layout.js, index.js"
# → Asks: "Continue with reorganization? [y/N]"
# → Creates backup before proceeding

# DIRECT APPLICATION (with safety prompts)
/A-organize --apply
# → "WARNING: Direct apply mode. Create backup? [Y/n]"
# → "Show diff preview? [Y/n]"
# → "Continue with 14 file moves and 23 import updates? [y/N]"

# DANGEROUS MODE (not recommended)
/A-organize --force
# → "DANGER: No safety checks. Backup recommended. Continue? [y/N]"
```

### **Predict Issues**
```bash
/A-organize --predict-issues --horizon 1m
# → "components/ será inmanejable en 3 semanas (23 files, +2/week trend)"
# → "user.service.js alcanzará 500 lines en 2 semanas (+15 lines/week)"
```

### **Full Restructure**
```bash
/A-organize --full-restructure --stack react
# → Detecta estructura vs React best practices  
# → Reorganiza: components/ → features/auth/, features/user/, shared/
# → "147 archivos reorganizados, estructura enterprise-ready"
```

## DoD (Safety-First Definition of Done)
- **Safety gates passed**: Backup created, diff previewed, user confirmed
- Stack detectado y standards/{detected-stack}.yaml rules cargadas
- Dependency map completo pre-move con risk assessment
- **Diff preview shown**: Usuario ve exactamente qué cambiará antes de aplicar
- **User confirmation**: Explicit "yes" required para cambios destructivos
- ALL imports/exports/paths actualizados correctamente
- Post-reorganization validation passed (no broken imports)
- **Rollback capability**: Backup disponible con instrucciones de restore
- Matrices generadas con safety validation status
- Error handling: Failed moves revert automatically