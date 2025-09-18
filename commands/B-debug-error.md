---
model: sonnet
description: Debug sistemático con logs estructurados, matrices de análisis y forensic mode para resolución avanzada de errores
argument-hint: [error/problema] [--forensic deep|surface] [--logs structured|timeline] [--stack auto|detect]
---

# B-Debug Error - Advanced Debugging with Structured Analytics

Debug sistemático y forensic analysis: $ARGUMENTS

## Contexto Automático
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Stack detection: !`find . -name "package.json" -o -name "requirements.txt" -o -name "pom.xml" -o -name "Cargo.toml" -o -name "*.sln" | head -3`
- Recent changes: !`git log --oneline -5 --stat 2>/dev/null || echo "No git history"`
- Error context: Auto-cargar stack-specific debugging

## 🔍 Forensic Mode Activation

### **🚨 INITIALIZE ADVANCED DEBUG MODE**

**Error/Problema**: $ARGUMENTS
**Stack detectado**: Aplicar debugging específico del stack
**Forensic Level**: Auto-detectar complejidad y aplicar deep analysis si es necesario

### **1. Error Intelligence Gathering (Enhanced)**
- **Error Classification**: Categorizar error por tipo y severidad
- **Stack Context**: Aplicar conocimiento específico de tecnologías detectadas
- **Timeline Analysis**: Capturar secuencia temporal de eventos
- **Environment Forensics**: Diferencias entre dev/staging/prod
- **Impact Assessment**: Scope y consecuencias del error

#### **Structured Error Log Template**
```
## 📊 ERROR INTELLIGENCE MATRIX
| Attribute | Value | Impact | Priority | Stack Context |
|-----------|-------|--------|----------|---------------|
| Error Type | [Runtime/Compile/Logic] | [High/Medium/Low] | [Critical/High/Medium] | [Stack-specific] |
| Frequency | [Always/Intermittent/Rare] | [User Impact %] | [Business Priority] | [Framework Pattern] |
| Environment | [Dev/Staging/Prod] | [Affected Users] | [Fix Urgency] | [Deployment Context] |
| Timing | [Startup/Runtime/Shutdown] | [Performance Impact] | [SLA Impact] | [Lifecycle Phase] |
```

### **2. Stack-Specific Error Patterns (Automated)**

**Node.js/JavaScript**: Event loop blocking, callback hell, promise rejections, memory leaks
**Python**: GIL issues, import errors, async/await problems, dependency conflicts
**Java/Spring**: ClassPath issues, dependency injection failures, transaction problems, memory heap
**React/Frontend**: Component lifecycle, state management, rendering issues, bundle problems
**Database**: Connection pooling, query performance, transaction locks, schema migrations
**DevOps/Cloud**: Container issues, network connectivity, resource limits, configuration drift

### **3. Reproduction Matrix (Systematic)**

#### **Reproduction Analysis Matrix**
| Environment | Success Rate | Conditions | Variables | Stack Factors |
|-------------|-------------|------------|-----------|---------------|
| Local Dev | [%] | [Specific conditions] | [Environment vars] | [Local stack config] |
| Docker/Container | [%] | [Container conditions] | [Resource limits] | [Containerization issues] |
| Staging | [%] | [Staging conditions] | [Data differences] | [Staging-specific config] |
| Production | [%] | [Prod conditions] | [Load factors] | [Production patterns] |

### **4. Forensic Stack Trace Analysis (Deep Dive)**

#### **Call Chain Forensics**
- **Bottom-up Analysis**: Desde el punto de falla hacia arriba
- **Pattern Detection**: Identificar patrones conocidos del stack
- **Memory State**: Estado de memoria en el momento del error
- **Thread Analysis**: Análisis de concurrencia y locks

#### **Stack Trace Matrix**
| Level | Function/Method | File:Line | Memory State | Thread ID | Stack Context |
|-------|-----------------|-----------|--------------|-----------|---------------|
| 0 (Error Point) | [Function] | [File:Line] | [Memory MB] | [Thread] | [Stack-specific] |
| 1 (Caller) | [Function] | [File:Line] | [Memory MB] | [Thread] | [Framework context] |
| N (Root) | [Function] | [File:Line] | [Memory MB] | [Thread] | [Application context] |

### **5. Hypothesis Generation Matrix (Advanced)**

#### **Root Cause Hypothesis Matrix**
| Hypothesis | Probability | Evidence | Test Method | Stack Pattern | Validation |
|------------|------------|----------|-------------|---------------|------------|
| Null Pointer/Undefined | [%] | [Evidence] | [Test approach] | [Language-specific] | [Validation method] |
| Race Condition | [%] | [Evidence] | [Concurrency test] | [Threading model] | [Synchronization check] |
| Memory Exhaustion | [%] | [Evidence] | [Memory profiling] | [GC patterns] | [Heap analysis] |
| External Dependency | [%] | [Evidence] | [Integration test] | [API/Service calls] | [Dependency health] |
| Configuration Drift | [%] | [Evidence] | [Config comparison] | [Environment vars] | [Config validation] |

### **6. Debugging Tools Matrix (Stack-Aware)**

#### **Tool Selection Matrix**
| Stack | Primary Debugger | Profiler | Logger | Monitor | Tracer |
|-------|------------------|----------|--------|---------|--------|
| **Node.js** | Chrome DevTools, VS Code | Clinic.js, Node Profiler | Winston, Pino | PM2, New Relic | OpenTelemetry |
| **Python** | pdb, PyCharm | cProfile, py-spy | logging, loguru | Prometheus, Grafana | OpenTelemetry |
| **Java/Spring** | IntelliJ, Eclipse | JProfiler, VisualVM | Logback, Log4j | Micrometer, APM | Spring Cloud Sleuth |
| **React** | React DevTools | Chrome Profiler | console, Sentry | Lighthouse, Sentry | React Profiler |
| **Database** | Query analyzers | DB profilers | Query logs | DB monitors | Query tracers |

### **7. Forensic Investigation Timeline (Structured)**

#### **Investigation Log Matrix**
| Timestamp | Action | Result | Hypothesis Status | Evidence Found | Next Step |
|-----------|--------|--------|-------------------|----------------|-----------|
| [Time] | [Investigation step] | [Finding] | [Confirmed/Rejected/Pending] | [Evidence] | [Next action] |
| [Time] | [Test execution] | [Result] | [Hypothesis update] | [New evidence] | [Follow-up] |
| [Time] | [Tool analysis] | [Data found] | [Hypothesis refined] | [Diagnostic data] | [Deep dive area] |

### **8. Resource Analysis Matrix (Performance)**

#### **Resource Consumption Matrix**
| Resource | Before Error | During Error | After Error | Stack Impact | Threshold |
|----------|--------------|--------------|-------------|--------------|-----------|
| **Memory** | [MB] | [MB] | [MB] | [Framework memory patterns] | [Stack limit] |
| **CPU** | [%] | [%] | [%] | [Processing patterns] | [Performance budget] |
| **I/O** | [ops/s] | [ops/s] | [ops/s] | [I/O patterns] | [I/O limits] |
| **Network** | [Mbps] | [Mbps] | [Mbps] | [Network patterns] | [Bandwidth limits] |
| **Database** | [connections] | [connections] | [connections] | [Connection pooling] | [Pool limits] |

### **9. Solution Implementation Matrix (Systematic)**

#### **Solution Evaluation Matrix**
| Solution Approach | Complexity | Risk | Impact | Stack Compatibility | Implementation Time |
|-------------------|------------|------|--------|---------------------|-------------------|
| **Quick Fix** | [Low/Med/High] | [Low/Med/High] | [Immediate] | [Full/Partial/None] | [Hours] |
| **Proper Fix** | [Low/Med/High] | [Low/Med/High] | [Complete] | [Full/Partial/None] | [Days] |
| **Refactor** | [Low/Med/High] | [Low/Med/High] | [Long-term] | [Full/Partial/None] | [Weeks] |
| **Architecture Change** | [Low/Med/High] | [Low/Med/High] | [Systemic] | [Full/Partial/None] | [Months] |

### **10. Testing & Validation Matrix (Comprehensive)**

#### **Test Coverage Matrix**
| Test Type | Pre-Fix Status | Post-Fix Status | Success Rate | Stack Coverage | Automation |
|-----------|----------------|-----------------|--------------|----------------|------------|
| **Unit Tests** | [Pass/Fail count] | [Pass/Fail count] | [%] | [Framework tests] | [Automated/Manual] |
| **Integration** | [Pass/Fail count] | [Pass/Fail count] | [%] | [API/Service tests] | [Automated/Manual] |
| **Load Tests** | [Pass/Fail count] | [Pass/Fail count] | [%] | [Performance tests] | [Automated/Manual] |
| **Edge Cases** | [Pass/Fail count] | [Pass/Fail count] | [%] | [Boundary tests] | [Automated/Manual] |

### **11. Prevention & Monitoring Matrix (Proactive)**

#### **Prevention Measures Matrix**
| Prevention Type | Implementation | Monitoring | Alert Threshold | Stack Integration | Effectiveness |
|-----------------|----------------|------------|------------------|-------------------|---------------|
| **Input Validation** | [Validation rules] | [Validation metrics] | [Error rate] | [Framework validators] | [% reduction] |
| **Error Handling** | [Try/catch patterns] | [Error metrics] | [Error count] | [Framework handlers] | [Recovery rate] |
| **Defensive Programming** | [Null checks, guards] | [Defense metrics] | [Failure rate] | [Language patterns] | [Stability improvement] |
| **Monitoring** | [Health checks] | [System metrics] | [Performance thresholds] | [APM integration] | [Detection speed] |

### **12. Forensic Documentation Template (Structured)**

```
## 🔬 FORENSIC DEBUG REPORT

### Executive Summary
- **Error**: [One-line description]
- **Root Cause**: [Technical cause]
- **Impact**: [Business/user impact]
- **Resolution Time**: [Investigation + fix time]
- **Prevention**: [Long-term prevention measure]

### Investigation Timeline
[Timeline matrix from section 7]

### Technical Analysis
- **Stack**: [Technology stack involved]
- **Error Classification**: [Type, severity, frequency]
- **Reproduction**: [Conditions and steps]
- **Resource Impact**: [Memory, CPU, I/O analysis]

### Solution Implementation
- **Approach Selected**: [From solution matrix]
- **Implementation Details**: [Technical details]
- **Testing Results**: [Test coverage matrix]
- **Deployment**: [Rollout strategy]

### Prevention Measures
- **Immediate**: [Quick wins]
- **Short-term**: [Process improvements]
- **Long-term**: [Architecture changes]
- **Monitoring**: [New monitoring added]

### Lessons Learned
- **What worked well**: [Successful techniques]
- **What could improve**: [Process improvements]
- **Knowledge gaps**: [Team training needs]
- **Tool gaps**: [Missing debugging tools]
```

### **13. Stack-Specific Debugging Patterns (Enhanced)**

#### **Advanced Stack Patterns**
```bash
# Node.js - Memory leak detection
node --inspect --max-old-space-size=4096 app.js
# Heap dump analysis with Chrome DevTools

# Python - GIL analysis
python -X dev -m cProfile -s cumulative script.py
# Async debugging with aiodebug

# Java - JVM analysis
java -XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDetails app.jar
# Thread dump analysis with jstack

# React - Component analysis
React.Profiler API + Chrome DevTools Performance tab
# Bundle analysis with webpack-bundle-analyzer

# Database - Query analysis
EXPLAIN ANALYZE + pg_stat_statements (PostgreSQL)
# Slow query log analysis + SHOW PROCESSLIST (MySQL)
```

### **14. DoD (Definition of Done) - Debug Resolution**
- ✅ Error reproducido y documentado en matriz estructurada
- ✅ Stack-specific debugging tools aplicados correctamente
- ✅ Root cause identificado y verificado con evidencia
- ✅ Solución implementada y validada con testing matrix
- ✅ Prevention measures implementadas y monitorizadas
- ✅ Forensic documentation completa generada
- ✅ Team knowledge sharing completado
- ✅ Monitoring y alerting mejorado para prevención futura
- ✅ Regression testing ejecutado exitosamente

## Usage Examples

```bash
# Forensic debugging con matrices completas
/B-debug-error "OutOfMemoryError en producción" --forensic deep --logs structured

# Debug con análisis específico de stack
/B-debug-error "React component not rendering" --stack auto --logs timeline

# Debug rápido con logs estructurados
/B-debug-error "API timeout intermitente" --forensic surface --logs structured
```

**Enhanced Features**: Forensic mode, stack-aware debugging, structured matrices, timeline analysis, prevention measures, comprehensive documentation templates.

**Automation**: Auto-detect stack, auto-apply debugging patterns, auto-generate documentation, structured log analysis.

**Output**: Complete forensic report with matrices, timelines, prevention measures, and actionable insights for team learning.