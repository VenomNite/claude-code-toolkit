---
model: sonnet
description: Orquesta trabajo entre agentes M1 especializados con dependencias inteligentes y coordinación automática
argument-hint: [descripción-tarea | archivo-plan] [--plan-only] [--stack auto|react|vue|node|python] [--output-dir]
---

# M1 Workflow Orchestrator

Delega y coordina trabajo entre agentes M1 especializados: $ARGUMENTS

## Contexto
- Proyecto actual: !`git rev-parse --show-toplevel 2>/dev/null || pwd` + detección de estructura
- Stack: autodetección vía package.json/@angular/cli.json/requirements.txt o --stack
- jStyle rules: Claude/Doc/jStyle-{stack}/ + Claude/Doc/jStyle-General/
- Agentes disponibles: !`ls ~/.claude/commands/M1-*.md | wc -l` agentes especializados
- Plan existente: Si se pasa archivo, cargar desde ruta especificada

## Proceso Detallado

### 1. **Análisis y Parsing**
- **Input parsing**: Distinguir entre descripción libre vs archivo de plan
- **Detección de contexto**: Stack, arquitectura, dependencias existentes
- **Scope analysis**: Alcance del trabajo (módulo, feature, refactor completo)
- **Constraint detection**: Limitaciones técnicas, tiempo, recursos

### 2. **Descomposición Inteligente** 
- **Task breakdown**: Dividir en subtareas especializadas y atómicas
- **Skill mapping**: Mapear subtareas → expertise requerido
- **Dependency analysis**: Identificar prerrequisitos y bloqueos
- **Risk assessment**: Detectar puntos críticos y complejidad

### 3. **Agent Discovery & Selection**
- **Agent enumeration**: Listar todos los agentes M1-* disponibles
- **Capability matching**: Seleccionar agentes óptimos por subtarea
- **Load balancing**: Distribuir trabajo equitativamente
- **Fallback planning**: Agentes alternativos si principal no disponible

### 4. **Dependency Graph Construction**
- **Sequential dependencies**: Backend → Frontend → QA → Deploy
- **Parallel opportunities**: Frontend + Backend, Docs + Testing
- **Critical path**: Identificar ruta crítica del proyecto
- **Sync points**: Momentos de integración y validación

### 5. **Context Preparation**
- **Project state**: Estructura actual, archivos relevantes, configuraciones
- **jStyle injection**: Reglas específicas del stack + generales
- **Historical context**: Commits recientes, decisiones arquitecturales
- **Agent briefing**: Contexto específico para cada agente especializado

### 6. **Orchestration & Launch**
- **Parallel execution**: Lanzar agentes sin dependencias simultáneamente
- **Progress monitoring**: Seguimiento de estado en tiempo real
- **Dynamic adjustment**: Replanificar si agente falla o se bloquea
- **Handoff management**: Transferencia limpia entre fases

### 7. **Integration & Validation**
- **Result consolidation**: Integrar outputs de múltiples agentes
- **Consistency check**: Verificar coherencia entre componentes
- **Quality validation**: M1-qa-gatekeeper para validación final
- **Documentation sync**: Actualizar documentación con cambios

## Agent Discovery & Tool Arsenal
- **Auto-detection**: !`ls ~/.claude/commands/M1-*.md` + capability parsing automático
- **Dynamic mapping**: Tasks → agentes óptimos + fallback chains

### **Full Tool Access per Agent**
- **Core tools**: Read/Write/Edit, Bash, Glob/Grep, WebFetch/WebSearch, Task, TodoWrite
- **MCP Servers**: Si tienen MCPs especializados disponibles, USARLOS
- **Specialized tools**: Herramientas específicas según expertise del agente

**Instrucción crítica**: Usar TODAS las herramientas + MCPs disponibles para máxima calidad

## jStyle Philosophy Integration

### **Core Principles** (NON-NEGOTIABLE)
- **"Less is sometimes better"** → Simplicidad sostenible > barroquismo
- **Modularidad SIEMPRE** → Interfaces claras, dependencias explícitas  
- **Calidad mínima no negociable** → "Funciona pero es un desastre" = RECHAZADO

### **Transgresión Justificada** (PERMITIDA si)
1. **Mejora funcionalidad/usabilidad/calidad** demostrablemente
2. **Mantiene o mejora modularidad** del sistema
3. **Se documenta explícitamente** en "Transgresiones justificadas": beneficio + mitigación

### **Anti-Patterns** (PROHIBIDOS)
- Monolitos sin justificación arquitectural sólida
- Funciones >100 líneas sin descomposición clara
- Dependencias cíclicas entre módulos
- Código duplicado sin abstracción apropiada
- Violaciones a principios SOLID sin justificación

## Dependency Rules Engine

### **Sequential Patterns**
```
Research → Architecture → Development → Testing → Documentation → Deployment
Backend API → Frontend Integration → E2E Testing  
UX Strategy → UI Components → User Testing
jStyle Review → Implementation → Quality Gates → Integration
```

### **Parallel Execution** 
```
Frontend Development || Backend Development || Documentation
Multiple backend agents on different modules simultaneously
Unit testing || Integration testing || Security audit
Code review || Performance optimization || Asset creation
```

### **Smart Dependencies**
```
API contract design → (Frontend consumption || Backend implementation)
Database schema → (Backend models || Migration scripts || Documentation)  
Security audit → (Code hardening || Documentation || Testing updates)
```

### **Sync Points**
```
Architecture Review: Requires jStyle compliance + modular design approval
Integration Testing: Requires (Backend + Frontend) COMPLETE + API contracts validated
Quality Gates: Requires (Development + Testing + Security) COMPLETE + jStyle standards met
Final Review: Requires ALL AGENTS COMPLETE + consolidated quality validation
```

## Output Structure

### **Master Todo List** 
- **Ubicación**: Claude/Plan/workflow-{timestamp}.md o {plan-dir}/workflow-execution.md
- **Updates**: Actualización automática cuando agentes completan tareas

### **Agent-Specific Outputs**
- **Individual todos**: Claude/MemoriaAgentes/{agent-name}-{timestamp}-todo.md
- **Progress tracking**: Estado en tiempo real + deliverables específicos
- **Integration report**: Resumen consolidado + quality metrics + next steps

## Advanced Features
- **Plan file support**: Markdown parsing + YAML frontmatter + task extraction
- **Dynamic replanning**: Auto-recovery + scope adjustment + resource optimization  
- **Progress visualization**: Real-time status + ETA + critical path + risk assessment
- **Error handling**: Agent timeouts + rollback strategies + quality safeguards

## Examples

### **Simple Task**
```bash
/A-workflow "Añadir validación email a formulario"
# → M1-frontend (UI validation) || M1-backend (API validation) || M1-qa (testing)
# → All agents use full toolset + jStyle + modular approach
```

### **Complex Feature**
```bash
/A-workflow "Sistema completo autenticación JWT con roles" 
# → M1-research (security analysis) → M1-backend (API design)
# → M1-frontend (UI flows) || M1-documentation (guides)
# → M1-qa (security testing) → Integration validation
```

### **Plan File Execution**
```bash
/A-workflow Claude/Plan/nueva-fase-implementacion.md
# → Parser plan → Extract tasks → Map agents → Execute with jStyle compliance
```

### **Planning Only**
```bash
/A-workflow "Migración completa a TypeScript" --plan-only  
# → Generate detailed plan with dependencies + jStyle considerations
```

## DoD (Definition of Done)

- **Master todo**: Creado y ubicado correctamente  
- **Agent context**: Preparado con jStyle + project info + think prompt
- **Dependency graph**: Construido y validado
- **Agentes launched**: Con contexto completo y instrucciones específicas
- **Progress tracking**: Sistema de seguimiento activo
- **Quality gates**: Checkpoints definidos y configurados
- **Integration plan**: Estrategia de consolidación de resultados clara