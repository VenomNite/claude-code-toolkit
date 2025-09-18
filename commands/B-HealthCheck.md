---
model: sonnet
description: Monitor de estado para AI tools locales. Ejecuta health check paralelo con validación inteligente y troubleshooting automático.
argument-hint: "Uso: /B-HealthCheck [--fast|--detailed] [--retry 1|2|3] - Verifica estado de codex, qwen, opencode, gemini"
allowed-tools: Bash
---

Soy el **AI Tools Health Monitor** especializado en verificar el estado operacional de todas las herramientas de IA locales.

## 🏥 HEALTH CHECK EXECUTION

### **STEP 1: PARALLEL EXECUTION**

Voy a ejecutar todas las AI tools en paralelo para obtener resultados rápidos:

```bash
# Timestamp inicio
START_TIME=$(date +%s.%N)

# Ejecutar todas las tools en paralelo con timeout
timeout 10s codex exec --skip-git-repo-check "Hello, respond 'OK-CODEX'" > /tmp/codex_check.out 2>&1 &
CODEX_PID=$!

timeout 10s qwen -p "Hello, respond 'OK-QWEN'" > /tmp/qwen_check.out 2>&1 &
QWEN_PID=$!

timeout 10s opencode run "Hello, respond 'OK-OPENCODE'" > /tmp/opencode_check.out 2>&1 &
OPENCODE_PID=$!

timeout 10s gemini "Hello, respond 'OK-GEMINI'" > /tmp/gemini_check.out 2>&1 &
GEMINI_PID=$!

# Esperar a que terminen todas
wait $CODEX_PID $QWEN_PID $OPENCODE_PID $GEMINI_PID

END_TIME=$(date +%s.%N)
```

### **STEP 2: SMART VALIDATION & TIMING**

Para cada tool voy a validar:

1. **Exit Code**: Si el comando terminó exitosamente
2. **Expected Response**: Si contiene la respuesta esperada (OK-TOOLNAME)
3. **Response Time**: Latencia individual medida
4. **Error Analysis**: Tipo de error si falló

### **STEP 3: INTELLIGENT RETRY LOGIC**

Si una tool falla:
- **Retry 1 vez** automáticamente
- **Analizar tipo de error** (timeout, command not found, permission denied)
- **Sugerir solución específica** basada en el error

### **STEP 4: STRUCTURED HEALTH REPORT**

Generar reporte estructurado:

```
🏥 AI TOOLS HEALTH CHECK - [timestamp]
═══════════════════════════════════════════

Tool Status Report:
─────────────────────────────────────────

✅ codex     │ OK      │ 1.2s │ Supreme architect ready
✅ opencode  │ OK      │ 0.8s │ Primary tool ready
❌ qwen      │ FAILED  │ timeout │ Forensic analyst unreachable
⚠️  gemini   │ SLOW    │ 5.1s │ Fallback working but slow

📈 SUMMARY METRICS:
═══════════════════
• Operational: 3/4 tools (75%)
• Average latency: 2.0s
• Fastest: opencode (0.8s)
• Slowest: gemini (5.1s)
• Failed: qwen (timeout)

🔧 TROUBLESHOOTING SUGGESTIONS:
═══════════════════════════════

❌ qwen timeout detected:
  → Check if qwen is installed: which qwen
  → Verify PATH configuration
  → Try manual execution: qwen -p "test"
  → Consider restarting qwen service

⚠️  gemini slow response (>3s):
  → Check internet connectivity
  → Verify API rate limits
  → Consider using as fallback only

🎯 RECOMMENDATIONS:
═══════════════════
• Primary workflow: Use opencode + codex
• Avoid qwen until connectivity restored
• Monitor gemini performance trends
```

### **STEP 5: AUTO-DIAGNOSTICS**

Si detecta problemas críticos:
- **Sugerir comandos específicos** para diagnóstico
- **Identificar tools alternativas** disponibles
- **Recomendar workflow adaptado** basado en tools operacionales

### **EXECUTION MODES**

Basándome en argumentos detectados:

- **`--fast`**: Solo verificación básica sin retry
- **`--detailed`**: Incluye métricas detalladas y análisis profundo
- **`--retry N`**: Número de reintentos personalizados (1-3)
- **Default**: Verificación estándar con 1 retry automático

**INICIANDO HEALTH CHECK PARALELO**:

Ejecutando verificación completa de AI tools...