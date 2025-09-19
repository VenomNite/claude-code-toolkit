---
model: sonnet
description: Advanced Productivity Augmenter - Comprehensive productivity system with smart prioritization, workflows, and insights
argument-hint: [add|complete|list|prioritize|energy|timeblock|workflow|insights|habits|focus|review|import|due|remove|undo] [texto] [--scope] [--priority] [--energy] [--due] [--n]
allowed-tools: [Read, Write, Edit, Bash, Glob, Grep]
---

# Advanced Productivity Augmenter

Load standards/{detected-stack}.yaml || standards/general.yaml as fallback for productivity and task management standards.

Transforma la gestión de tareas básica en un sistema de productividad integral con priorización inteligente, workflows personalizados e insights automatizados: $ARGUMENTS

## Sistema de Productividad Integral

### Core Features (Mantiene compatibilidad con comandos existentes)
- **Smart Prioritization**: Eisenhower Matrix + energy levels + deadline urgency
- **Productivity Workflows**: Morning routines, daily reviews, weekly planning
- **Intelligent Suggestions**: Auto task breakdown, time estimation, optimization tips
- **Energy Management**: Match task difficulty to personal energy patterns
- **Habit Tracking**: Streak tracking, productive habits, achievement system
- **Focus Sessions**: Deep work blocks, Pomodoro integration, distraction management
- **Analytics & Insights**: Productivity patterns, weekly reviews, improvement recommendations

## Contexto y Arquitectura
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Archivos principales:
  - Claude/todos/<scope>.md (tasks con metadata avanzada)
  - Claude/productivity/<scope>-habits.md (habit tracking)
  - Claude/productivity/<scope>-insights.md (analytics y patterns)
- Estructura mejorada con Eisenhower quadrants y energy levels

## Comandos del Sistema

### Gestión de Tareas (Backward Compatible)
1. **add**: Añade tarea con auto-categorización inteligente
   - Formato: `- [ ] [P1-P4] [E:H/M/L] tarea | Due: DD/MM/YYYY @HH:MM | Created: timestamp`
   - Auto-detecta prioridad usando keywords (urgent, important, deadline)
   - Sugiere energy level basado en tipo de tarea

2. **complete --n**: Completa tarea con productivity insights
   - Mueve a Completed, añade Done timestamp
   - Calcula tiempo real vs estimado
   - Actualiza productivity analytics

3. **list**: Muestra vista organizada por Eisenhower Matrix
   - Quadrant I: Urgent + Important (Do First) 🔥
   - Quadrant II: Important, Not Urgent (Schedule) 📅
   - Quadrant III: Urgent, Not Important (Delegate) 👥
   - Quadrant IV: Neither (Eliminate) 🗑️

### Smart Prioritization
4. **prioritize**: Reclasifica tareas usando Eisenhower Matrix
   - Análisis automático de urgency (deadline proximity)
   - Assessment de importance (impact on goals)
   - Recomendaciones de action (do/schedule/delegate/eliminate)

5. **energy**: Gestión de niveles de energía personal
   - High Energy (E:H): Creative work, complex problem solving
   - Medium Energy (E:M): Routine tasks, meetings, communication
   - Low Energy (E:L): Administrative work, organizing, reading
   - Match tasks to current energy level

### Productivity Workflows
6. **workflow**: Ejecuta rutinas de productividad personalizadas
   - `--morning`: Morning routine setup (review day, set priorities)
   - `--daily`: Daily review (completed tasks, next day planning)
   - `--weekly`: Weekly planning (goals review, priority setting)
   - `--reflection`: Retrospective and improvement identification

7. **timeblock**: Time boxing y gestión de focus sessions
   - Pomodoro integration (25min focus + 5min break)
   - Deep work blocks (90-120min for complex tasks)
   - Break reminders and wellness prompts
   - Calendar time blocking suggestions

### Intelligent Features
8. **insights**: Productivity analytics y recommendations
   - Task completion patterns (best productive hours)
   - Energy level optimization suggestions
   - Time estimation accuracy improvement
   - Weekly productivity score and trends

9. **habits**: Sistema de tracking de hábitos productivos
   - Streak tracking for productive behaviors
   - Achievement badges (7-day streak, 30-day streak, etc.)
   - Habit formation recommendations (2-5 month cycles)
   - Integration with daily workflows

10. **focus**: Gestión de sesiones de trabajo profundo
    - Distraction blocking suggestions
    - Flow state optimization
    - Context switching minimization
    - Batch processing similar tasks

11. **review**: Comprehensive productivity analysis
    - Weekly accomplishment summary
    - Goal progress tracking
    - Productivity bottleneck identification
    - Next week optimization recommendations

### Legacy Operations (Preserved)
12. **import**: Convierte bullets existentes con auto-categorización
13. **due --n --due**: Asigna/modifica fechas límite con urgency update
14. **remove/undo --n**: Elimina o restaura con productivity impact

## Eisenhower Matrix Implementation

### Priority Scoring Algorithm
```
Urgency Score (0-5):
- Due today: +5
- Due within 3 days: +4
- Due within week: +3
- Due within month: +2
- No deadline: +1
- Overdue: +5 (critical)

Importance Score (0-5):
- Career/business impact: +5
- Personal goals: +4
- Skill development: +3
- Routine maintenance: +2
- Optional/nice-to-have: +1

Priority Classification:
- P1 (Quadrant I): U≥4 AND I≥4 (Do First) 🔥
- P2 (Quadrant II): U≤3 AND I≥4 (Schedule) 📅
- P3 (Quadrant III): U≥4 AND I≤3 (Delegate) 👥
- P4 (Quadrant IV): U≤3 AND I≤3 (Eliminate) 🗑️
```

### Energy Matching System
```
High Energy Tasks (E:H):
- Creative work, strategic planning
- Complex problem solving
- Learning new skills
- Important decision making

Medium Energy Tasks (E:M):
- Meetings and communication
- Routine project work
- Code reviews and testing
- Planning and organizing

Low Energy Tasks (E:L):
- Administrative work
- Email processing
- Documentation updates
- Simple maintenance tasks
```

## Intelligent Suggestions Engine

### Auto Task Breakdown
- Tasks >2 hours → suggest subtasks
- Complex projects → milestone breakdown
- Dependencies → sequential ordering
- Resource requirements → preparation steps

### Time Estimation Learning
- Track actual vs estimated time
- Improve future estimates based on patterns
- Adjust for task complexity and energy level
- Account for context switching overhead

### Productivity Optimization
- Batch similar tasks together
- Suggest optimal time slots based on energy
- Identify and eliminate productivity bottlenecks
- Recommend focus session scheduling

## Output y Estructura de Archivos

### Enhanced Markdown Format
```markdown
# Productivity Dashboard - [Scope]

## 🔥 Quadrant I: Do First (Urgent + Important)
- [x] P1 [E:H] Complete quarterly review | Due: today @15:00 | Done: 2025-01-15 14:30
- [ ] P1 [E:M] Client presentation prep | Due: tomorrow @09:00 | Est: 2h

## 📅 Quadrant II: Schedule (Important, Not Urgent)
- [ ] P2 [E:H] Strategic planning session | Due: next week | Est: 3h
- [ ] P2 [E:M] Team skill development | Due: this month | Est: 1h

## 👥 Quadrant III: Delegate (Urgent, Not Important)
- [ ] P3 [E:L] Meeting notes compilation | Due: today @17:00 | Est: 30min

## 🗑️ Quadrant IV: Eliminate (Neither Urgent nor Important)
- [ ] P4 [E:L] Social media updates | Consider eliminating

## 📊 Productivity Metrics
- Completion Rate: 85% (last 7 days)
- Energy Optimization: 92% (tasks matched to energy)
- Time Estimation Accuracy: 78% (improving)
- Focus Sessions: 12 this week (target: 15)

## 🏆 Achievement Progress
- 🔥 7-Day Streak: 5/7 days
- 📈 Productivity Score: 8.2/10 (weekly average)
- ⚡ Energy Optimization: Expert level
```

## Ejemplos de Uso Avanzado

### Smart Task Addition
```bash
/todo add "Prepare investor presentation for Q4 results" --scope business --due "Friday 09:00"
# Auto-categoriza como P1 (urgent + important)
# Sugiere E:H (creative/strategic work)
# Recomienda timeblock de 3 horas
# Sugiere subtasks: research, outline, slides, practice
```

### Productivity Workflow
```bash
/todo workflow --morning --scope daily
# Ejecuta morning routine:
# 1. Review yesterday's completion
# 2. Identify today's P1 tasks
# 3. Match tasks to energy levels
# 4. Set 3 focus session blocks
# 5. Plan breaks and wellness checks
```

### Intelligence and Insights
```bash
/todo insights --scope work
# Muestra:
# - Productivity trends (7/30 day view)
# - Energy optimization score
# - Time estimation accuracy
# - Recommended improvements
# - Achievement progress
```

## DoD - Advanced Productivity System
- ✅ Eisenhower Matrix integration con auto-categorización
- ✅ Energy level management y task matching
- ✅ Productivity workflows (morning, daily, weekly routines)
- ✅ Intelligent suggestions (breakdown, estimation, optimization)
- ✅ Habit tracking con streak monitoring
- ✅ Achievement system con gamification elements
- ✅ Focus session management con time boxing
- ✅ Comprehensive analytics y productivity insights
- ✅ Backward compatibility con todos los comandos existentes
- ✅ Enhanced file structure con metadata y analytics
- ✅ Foundation para Phase B features (calendar, dependencies)
- ✅ Standards system integration
- ✅ Límite de 250 líneas mantenido para optimal performance