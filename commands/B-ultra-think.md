---
model: sonnet
description: Análisis profundo multi-perspectiva con coding standards flexible, auto-detección de stack y think harder mode
argument-hint: [problema/pregunta] [--depth surface|deep|think-harder] [--stack auto|detect] [--jstyle flexible|advisory|strict]
---

# B-Ultra Think - Deep Analysis & Think Harder Mode

Análisis profundo y resolución de problemas complejos con metodología mejorada: $ARGUMENTS

## Contexto Automático
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Stack detection: !`find . -name "package.json" -o -name "requirements.txt" -o -name "pom.xml" -o -name "Cargo.toml" -o -name "*.sln" | head -3`
- Recent activity: !`git log --oneline -5 2>/dev/null || echo "No git history"`
- coding standards rules: Auto-cargar coding standards con **enfoque flexible**

## Think Harder Mode Activation

### **🧠 INITIALIZE ENHANCED ANALYSIS MODE**

**Reconocimiento del problema**: $ARGUMENTS
**Nivel de análisis**: Auto-detectar complejidad y aplicar depth apropiado
**Stack detectado**: Aplicar reglas específicas con flexibilidad

### **1. Parse del Problema (Enhanced)**
- Extraer desafío core de: **$ARGUMENTS**
- **Stack Context**: Aplicar conocimiento específico de tecnologías detectadas
- **coding standards Lens**: Evaluar con "Less is sometimes better" + modularidad (flexible)
- Identificar stakeholders, constraints y complejidades ocultas
- **Assumption Challenge**: Cuestionar supuestos automáticamente

### **2. Multi-Dimensional Analysis (Mejorado)**

#### **Technical Perspective (Stack-Aware)**
- Viabilidad técnica considerando stack detectado
- Patrones específicos del framework/lenguaje en uso
- Escalabilidad con tecnologías actuales
- Security implications específicas del stack

#### **Business Perspective**
- ROI y time-to-market en contexto del proyecto actual
- Competitive advantages específicos
- Risk vs reward con tecnologías en uso

#### **User/System Perspective**
- UX implications con stack frontend detectado
- Integration points en arquitectura actual
- Performance characteristics del stack

#### **coding standards Perspective (Flexible)**
- **"Less is sometimes better"**: ¿Simplificar o añadir complejidad justificada?
- **Modularidad**: Impacto en separación de responsabilidades
- **Transgresión Justificada**: Cuándo saltarse reglas por calidad/funcionalidad
- **Quality Gates**: Estándares no negociables vs flexibles

### **3. Think Harder Deep Dive (Nuevo)**

**Para problemas complejos, activar Think Harder Mode:**

#### **Multi-Order Thinking**
- **First-Order**: Consecuencias directas inmediatas
- **Second-Order**: Consecuencias de las consecuencias
- **Third-Order**: Efectos sistémicos y feedback loops
- **N-Order**: Cascading effects a largo plazo

#### **Contrarian Analysis**
- Devil's advocate sistemático a cada solución
- Inversion thinking: "¿Qué NO hacer?"
- Red team vs blue team perspective
- Worst-case scenario planning

#### **Cross-Domain Pattern Matching**
- Analogías de otros dominios/industrias
- Pattern libraries de stack específico
- Biological/natural systems parallels
- Historical precedents y lessons learned

### **4. Stack-Specific Analysis (Automatizado)**

**Node.js/JavaScript**: Async patterns, event loop, package ecosystem
**Python**: GIL considerations, library ecosystem, deployment patterns
**Java/Spring**: Enterprise patterns, JVM optimization, Spring ecosystem
**React/Frontend**: Component lifecycle, state management, performance
**Database**: ACID properties, scaling patterns, consistency models
**DevOps/Cloud**: Infrastructure patterns, scaling, observability

### **5. Solution Generation (Enhanced)**

#### **Conventional Solutions**
- Best practices del stack actual
- Framework-specific patterns
- Industry standard approaches

#### **Creative Solutions**
- Cross-pollination de otros stacks
- Hybrid approaches innovadores
- Contrarian solutions que desafían normas

#### **coding standards Solutions**
- Soluciones que respetan modularidad
- "Less is better" implementations
- Transgresiones justificadas cuando mejoran calidad

### **6. Structured Output (Matrices)**

**Matriz de Análisis Multi-Perspectiva**
| Perspectiva | Análisis | Pros | Contras | Stack Impact | coding standards Score |
|---|---|---|---|---|---|

**Matriz de Soluciones**
| Solución | Viabilidad | Complejidad | coding standards | Transgresión | Justificación |
|---|---|---|---|---|---|

**Matriz Think Harder**
| Orden | Consecuencia | Probabilidad | Impacto | Mitigación | Timeline |
|---|---|---|---|---|---|

**Matriz de Decisión**
| Factor | Peso | Opción A | Opción B | Opción C | Recomendado |
|---|---|---|---|---|---|

## Enhanced Recommendation Structure

```
## 🎯 Problem Analysis
- **Core Challenge**: [Desafío fundamental]
- **Stack Context**: [Tecnologías relevantes]
- **Key Constraints**: [Limitaciones identificadas]
- **coding standards Considerations**: [Reglas aplicables flexiblemente]

## 🔍 Think Harder Insights
- **Multi-Order Effects**: [Consecuencias cascada]
- **Contrarian View**: [Perspectiva opuesta]
- **Cross-Domain Patterns**: [Analogías útiles]
- **Hidden Assumptions**: [Supuestos cuestionados]

## ⚡ Solution Options

### Option 1: [Stack-Optimized Solution]
- **Description**: [Solución específica del stack]
- **coding standards Compliance**: [Flexible/Strict - con justificación]
- **Implementation**: [Pasos específicos del stack]
- **Risk Assessment**: [Riesgos con mitigación]
- **Think Harder**: [Efectos de segundo/tercer orden]

### Option 2: [Creative/Contrarian Solution]
[Similar structure]

## 🎯 Final Recommendation
- **Recommended Approach**: [Opción elegida]
- **coding standards Rationale**: [Por qué es modular/simple O por qué transgrede justificadamente]
- **Implementation Roadmap**: [Pasos concretos]
- **Success Metrics**: [Métricas medibles]
- **Risk Mitigation**: [Plan de contingencia]

## 🔮 Think Harder Predictions
- **6 Months**: [Efectos esperados]
- **1 Year**: [Consecuencias sistémicas]
- **Systemic Changes**: [Cambios emergentes]
```

## coding standards Integration (Flexible)

### **Aplicación Suave de Reglas**
- **"Less is sometimes better"**: Evaluar si simplicidad es realmente mejor
- **Modularidad**: Preservar cuando sea posible, justificar excepciones
- **Transgresión Justificada**: Documentar cuándo saltarse reglas mejora:
  - Funcionalidad crítica
  - Calidad del código
  - Performance esencial
  - User experience
  - Maintainability a largo plazo

### **Stack-Specific coding standards
- **Cargar reglas específicas**: coding standards detectado automáticamente
- **Adaptar al contexto**: Reglas más estrictas para core, flexibles para features
- **Experiencia over dogma**: Priorizar results over perfect compliance

## DoD (Definition of Done)
- ✅ Stack detectado y reglas coding standards cargadas
- ✅ Multi-perspectiva analysis completado (técnico, business, usuario, coding standards
- ✅ Think Harder mode aplicado para problemas complejos
- ✅ Matrices estructuradas generadas con datos cuantificados
- ✅ Soluciones evaluadas con coding standards flexible (transgresiones justificadas)
- ✅ Recommendation con implementation roadmap específico del stack
- ✅ Multi-order effects analizados y documentados
- ✅ Success metrics definidos y medibles
- ✅ Risk mitigation plan specific al contexto del proyecto

## Usage Examples

```bash
# Análisis arquitectural con think harder
/B-ultra-think "¿Microservicios o monolito?" --depth think-harder

# Decisión técnica con coding standards flexible
/B-ultra-think "Implementar cache Redis vs in-memory" --jstyle flexible

# Problema complejo de performance
/B-ultra-think "Optimizar sistema para 10x traffic" --stack auto --depth think-harder
```