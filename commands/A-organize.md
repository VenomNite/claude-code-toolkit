---
model: sonnet
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

## Modes & Workflow

### **Standard Workflow**
1. `--scan` → Análisis y matrices, sin cambios
2. Review manual del plan generado
3. `--apply` → Ejecuta reorganización con dependency preservation

### **Direct Modes**
- `--apply`: Scan interno + apply en una pasada (si confías)
- `--predict-issues --horizon [1d|1w|2w|1m|3m|6m|1y]`: Solo predicción (default: 1m)
- `--full-restructure`: Reestructuración completa siguiendo best practices

## Proceso Core

### **Dependency Preservation** (CRÍTICO)
1. **Complete Dependency Map**:
   - Imports/exports por stack: `import|require|from` (JS), `import|from` (Python), etc.
   - Relative/absolute path analysis
   - Asset references (images, styles, configs)  
   - Dynamic imports/requires detection

2. **Safe Reorganization**:
   - Move files to new structure
   - **Auto-update ALL import paths** (preserve relative/absolute)
   - **Preserve export/import naming exactly**
   - Update asset references, config paths
   - Validate no broken imports post-move

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

**Matriz de Reorganización**
| Archivo | Ubicación Actual | Nueva Ubicación | Imports Updated | Status |
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

### **Standard Workflow**
```bash
/A-organize --scan
# → Análisis completo, matrices generadas
# Review manual del plan

/A-organize --apply  
# → Ejecuta el plan, preserva dependencias
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

## DoD
- Stack detectado y standards/{detected-stack}.yaml rules cargadas
- Dependency map completo pre-move
- ALL imports/exports/paths actualizados correctamente
- Post-reorganization validation passed (no broken imports)  
- Backup created antes de cambios
- Matrices generadas con validation status
- Plan ejecutable o ejecutado según mode