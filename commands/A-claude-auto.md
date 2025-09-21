---
model: claude-sonnet-4-20250514
description: Universal command router with intelligent intent recognition. Analyzes user requests and automatically executes the most appropriate toolkit command.
argument-hint: "Tell me what you want to do: 'build todo app', 'fix this error', 'explain code', etc."
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep
---

# Claude Toolkit Universal Router 🚀

**Magic Helper** - I analyze what you want and route to the perfect command automatically.

**Your request:** $ARGUMENTS

---

## 🧠 ULTRATHINK INTENT ANALYSIS MODE

**Analyzing your request with deep intent recognition...**

### **Step 1: Intent Categories Detection**

**Scanning for primary intent patterns:**

**🎯 PLANNING INTENT**
- Keywords: plan, build, create, start, new project, develop, make
- **Action:** Generate project specifications and roadmap
- **Route:** A-plan command

**🐛 DEBUGGING INTENT**
- Keywords: error, bug, broken, fix, not working, undefined, null, crash
- **Action:** Systematic error analysis and resolution
- **Route:** B-debug-error command

**🧠 CODE ANALYSIS INTENT**
- Keywords: explain, understand, analyze, what does, how does, code review
- **Action:** Complete code explanation with diagrams
- **Route:** B-explain-code command

**🔧 FEATURE CREATION INTENT**
- Keywords: add feature, create component, scaffold, new functionality
- **Action:** Intelligent feature scaffolding
- **Route:** B-create-feature command

**📐 ARCHITECTURE INTENT**
- Keywords: architecture, design, diagram, system, structure, documentation
- **Action:** Generate architectural documentation
- **Route:** A-architecture command

**🔍 AUDIT INTENT**
- Keywords: review, audit, quality, refactor, improve, analyze quality
- **Action:** Comprehensive code audit
- **Route:** A-audit command

**⚙️ WORKFLOW INTENT**
- Keywords: coordinate, multiple tasks, complex, orchestrate, manage
- **Action:** Multi-agent coordination
- **Route:** A-workflow command

### **Step 2: Confidence Scoring & Decision**

**Analyzing request:** "$ARGUMENTS"

**Intent Recognition Algorithm:**
1. **Extract keywords** from user request
2. **Match against patterns** with weight scoring
3. **Calculate confidence** for each intent category
4. **Apply decision logic** based on confidence scores

**Decision Logic:**
- **≥85% confidence:** Auto-execute most likely command
- **60-84% confidence:** Present top options and ask user
- **<60% confidence:** Show menu of most relevant commands

---

## 🎯 INTENT ANALYSIS RESULTS

**Processing your request...**

### **Confidence Analysis Matrix**

| Intent Category | Match Score | Confidence | Action |
|----------------|-------------|------------|--------|
| [Intent 1] | [Score] | [%] | [Auto/Ask/Menu] |
| [Intent 2] | [Score] | [%] | [Auto/Ask/Menu] |
| [Intent 3] | [Score] | [%] | [Auto/Ask/Menu] |

### **Decision Engine Output**

**🔴 HIGH CONFIDENCE (≥85%)** - Auto-executing optimal command
**🟡 MEDIUM CONFIDENCE (60-84%)** - Need clarification
**🟠 LOW CONFIDENCE (<60%)** - Multiple options available

---

## 🤖 COMMAND EXECUTION LOGIC

### **High Confidence Auto-Execution**
```
Confidence ≥85% detected for: [INTENT]
Automatically executing: /[COMMAND] $ARGUMENTS
```

### **Medium Confidence - User Choice Required**
```
Multiple valid interpretations detected for your request:

Option 1: [Command A] - [Description]
Option 2: [Command B] - [Description]
Option 3: [Command C] - [Description]

**→ PLEASE SELECT YOUR PREFERRED OPTION BEFORE I CONTINUE ←**

Reply with: 1, 2, or 3
```

### **Low Confidence - Command Menu**
```
Your request could match several approaches:

📋 Planning & Strategy:
- A-plan: Generate complete project specifications
- A-architecture: Create architectural documentation

🔧 Development & Analysis:
- B-create-feature: Scaffold new functionality
- B-explain-code: Analyze and explain existing code
- B-debug-error: Systematic error resolution

⚙️ Management & Quality:
- A-audit: Comprehensive code review
- A-workflow: Coordinate multiple tasks

**→ PLEASE SELECT THE BEST MATCH FOR YOUR NEEDS ←**

Reply with the command name (e.g., "A-plan")
```

---

## 📊 KEYWORD MAPPING REFERENCE

**Ultra-simple patterns for junior users:**

### **Planning Keywords**
`plan`, `build`, `create`, `start`, `new`, `project`, `develop`, `make`, `app`, `system`

### **Debugging Keywords**
`error`, `bug`, `broken`, `fix`, `issue`, `not working`, `crash`, `undefined`, `null`, `fail`

### **Analysis Keywords**
`explain`, `understand`, `analyze`, `what`, `how`, `review`, `code`, `function`, `class`

### **Feature Keywords**
`add`, `feature`, `component`, `new`, `functionality`, `implement`, `scaffold`, `generate`

### **Architecture Keywords**
`architecture`, `design`, `diagram`, `structure`, `system`, `documentation`, `overview`

### **Quality Keywords**
`audit`, `review`, `quality`, `refactor`, `improve`, `optimize`, `clean`, `best practices`

---

## 🎯 EXAMPLES & SUCCESS PATTERNS

### **High Confidence Auto-Routes**
```bash
"build a todo app" → 95% confidence → A-plan
"fix undefined variable error" → 90% confidence → B-debug-error
"explain this React component" → 92% confidence → B-explain-code
"add user authentication" → 88% confidence → B-create-feature
```

### **Medium Confidence Clarifications**
```bash
"improve my code" → Could be A-audit (quality) or A-organize (structure)
"create documentation" → Could be A-architecture (diagrams) or A-update-docs (sync)
```

### **Complex Multi-Intent Requests**
```bash
"plan and build a chat app with authentication"
→ Detected: Planning + Feature Creation
→ Recommended: A-plan first, then B-create-feature for auth
```

---

## ⚡ EXECUTION FLOW

1. **Parse user request** with ULTRATHINK mode
2. **Analyze intent** using keyword mapping
3. **Calculate confidence** for each possible command
4. **Route decision:**
   - High confidence: Execute automatically
   - Medium confidence: Ask for clarification
   - Low confidence: Show command menu
5. **Execute selected command** with original arguments

---

## 🎯 SUCCESS METRICS

- **90%+ requests** should auto-route successfully
- **Clear disambiguation** for ambiguous requests
- **Zero failed routes** - always provide valid options
- **Maintains original argument context** for target command

**🚀 Making the toolkit accessible to everyone - from junior developers to senior architects!**