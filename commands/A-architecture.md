---
model: claude-sonnet-4-20250514
description: Genera documentación de arquitectura (diagramas, ADRs, vistas) en formato minimalista
argument-hint: [--c4|--arc42|--adr|--plantuml|--mermaid] [descripción] [--full]
---

# Architecture Documentation

Documenta la arquitectura del sistema usando marcos reconocidos: $ARGUMENTS

## Contexto
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Detectar: @docs/, @README.md, @docker-compose.yml, @k8s/, *.puml, *.mmd
- Frameworks: C4, Arc42, ADR, PlantUML/Mermaid

## Proceso
1. **Análisis**: Detectar servicios, APIs, dependencias externas
2. **Generación**:
   - **--c4**: Context + Containers (+ Components si --full)
   - **--arc42**: Contexto + Building Blocks + Runtime
   - **--adr**: Crear/actualizar decisión arquitectural
   - **--mermaid**: Diagramas interactivos (flowchart, sequence, C4)
   - **--plantuml**: Diagramas como código
3. **Matrices**: Dependencias, riesgos, decisiones
4. **Salida**: Markdown + diagramas en Claude/docs/

## Matrices (incluir siempre)
**Matriz de Componentes**
| Componente | Tipo | Responsabilidad | Dependencias | Estado |
|---|---|---|---|---|

**Matriz de Decisiones (ADR)**
| Decisión | Contexto | Alternativas | Consecuencias | Estado |
|---|---|---|---|---|

**Matriz de Integraciones**
| Sistema Externo | Protocolo | Datos | Criticidad | Fallback |
|---|---|---|---|---|

## Output
- Documentación en Claude/docs/architecture/
- Diagramas en Claude/docs/diagrams/ (.puml/.mmd)
- ADRs en Claude/docs/adr/
- Matrices embebidas en documentación

## Ejemplos
- `/architecture --c4`
- `/architecture --mermaid "diagrama de secuencia login"`
- `/architecture --adr "migrar a Postgres"`
- `/architecture --arc42 --full`

## DoD
- Stack detectado y servicios/APIs identificados correctamente
- Diagramas generados según tipo especificado (C4, Arc42, PlantUML, Mermaid)
- Documentación exportada en Claude/docs/ con estructura coherente
- Matrices de dependencias y riesgos arquitecturales incluidas
- ADRs creados/actualizados con justificación técnica
- Diagramas como código validados y renderizables