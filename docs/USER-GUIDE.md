# Claude Code Toolkit - User Guide 📖

**Complete documentation | Step-by-step workflows**

**🔗 Navigation**: [← Quick Reference](CHEAT-SHEET.md) • [Installation Guide](../INSTALLATION.md) • [Contributing Guide](../CONTRIBUTING.md) • [Commands Reference](../README.md#-commands-matrix) • [Agents Reference](../README.md#-ai-agents-matrix)

## 🚀 Getting Started

### First Steps
1. **Test your setup:** `/B-HealthCheck`
2. **See all commands:** Check [CHEAT-SHEET.md](CHEAT-SHEET.md)
3. **Start with:** A simple project planning

---

## 📋 Common Workflows

### 🎯 "I want to start a new project"
**Goal:** Plan everything from scratch
```bash
/A-plan "build a task management app with React and Node.js"
```
**Result:** 3 files created:
- `1-specifications.md` - What to build
- `2-strategic-plan.md` - How to build it
- `3-todo-roadmap.md` - Step-by-step tasks

**Next step:** Use `/A-ai-code --coordinar` to start coding

---

### 🔧 "I want to add a new feature"
**Goal:** Scaffold feature with best practices
```bash
/B-create-feature "user-authentication" --type fullstack --arch auto
```
**Result:** Complete feature scaffolding with:
- Backend API endpoints
- Frontend components
- Database migrations
- Tests

**Alternative:** Simple features → `/A-ai-code --assist "add login button"`

#### **🎯 When to use which:**
- **B-create-feature:** Complete scaffolding needed, auto-templates, instant structure
- **A-ai-code:** Complex coordination, multiple agents, project-level orchestration

---

### 🐛 "I have an error I can't fix"
**Goal:** Debug systematically
```bash
/B-debug-error "TypeError: Cannot read property 'map' of undefined"
```
**Result:** Forensic analysis with:
- Error classification
- Stack-specific debugging
- Step-by-step fix suggestions

**Pro tip:** Include actual error message for better analysis

---

### 🧠 "I don't understand this code"
**Goal:** Learn how code works
```bash
/B-explain-code "src/components/UserProfile.jsx" --audience junior
```
**Result:** Complete explanation with:
- ASCII diagrams
- Line-by-line breakdown
- Language-specific insights

**Options:** `--audience junior|senior|expert` for depth level

#### **🔍 B-explain-code vs Native Claude:**
- **Native Claude:** Free-form explanation, variable output structure
- **B-explain-code:** 13 standardized matrices, auto language/framework detection, ASCII/Mermaid diagrams, standards integration

**When to use B-explain-code:** Need structured analysis, reproducible output, framework-specific insights, visual diagrams

---

### 📐 "I need architecture documentation"
**Goal:** Document system design
```bash
/A-architecture --c4 "user management system"
```
**Result:** Professional diagrams:
- Context diagrams
- Container views
- Component relationships

**Formats:** `--c4 | --arc42 | --adr | --mermaid`

---

### 🔍 "I want a code quality review"
**Goal:** Comprehensive audit
```bash
/A-audit src/ --scope module --fix
```
**Result:** Detailed report with:
- Quality matrices
- Refactoring priorities
- Security assessment
- Performance analysis

**Options:** `--fix` proposes concrete changes

---

### 🎮 "I'm working on a game"
**Goal:** Game-specific development
```bash
/A-workflow "balance RPG progression system"
```
**Result:** Orchestrates specialized agents:
- M1-game-design-architect for mechanics
- M1-unity-game-developer for implementation
- M1-2d-game-asset-optimizer for assets

---

### 🎨 "I need UI/UX strategy"
**Goal:** Design direction
```bash
/A-workflow "design mobile banking app UX"
```
**Result:** Coordinates:
- M1-ux-strategy-protocol for strategy
- M1-human-behavior-simulator for testing
- M1-frontend-architect-protocol for implementation

---

## 🤖 Agent Deep Dives

### When to use M1-Agents directly

**Research-heavy tasks:**
```bash
/Task --subagent M1-technical-research-analyst "compare React vs Vue 2024"
```

**Quality validation:**
```bash
/Task --subagent M1-qa-gatekeeper "validate payment system before deploy"
```

**Complex orchestration:**
```bash
/Task --subagent M1-ultrathink-orchestrator "migrate legacy API to microservices"
```

---

## 💡 Pro Tips

### Workflow Combinations
**Planning → Coding → Review:**
```bash
/A-plan "feature idea"        # Plan it
/A-ai-code --coordinar        # Build it
/A-audit --fix               # Perfect it
```

**Error → Fix → Document:**
```bash
/B-debug-error "error desc"   # Understand it
/A-ai-code --assist "fix"     # Fix it
/A-update-docs               # Document it
```

### Context is King
- **Be specific:** "undefined error in React component" > "error"
- **Include files:** `/B-explain-code src/utils/api.js` > "explain API code"
- **Mention stack:** "Node.js authentication" > "authentication"

### Time-Savers
- **Quick test:** `/B-HealthCheck` (30 seconds)
- **Fast plan:** `/A-plan` for any project idea
- **Instant fix:** `/B-debug-error` with exact error message
- **Team insights:** `/A-insights` for developer patterns + fun facts
- **Auto onboarding:** `/A-onboarding` generates setup from current project

---

### 📊 "I want to understand team patterns"
**Goal:** Developer analytics and codebase curiosities
```bash
/A-insights . --git --files --deps
```
**Result:** Real analytics with:
- Peak coding hours from git history
- Hotspots and most modified files
- Technical debt indicators (TODO/FIXME count)
- Fun facts (night owl commits, busiest files)

---

### 🎯 "I need onboarding for new team member"
**Goal:** Auto-generate setup guide without assuming docs exist
```bash
/A-onboarding --role developer --depth comprehensive
```
**Result:** Complete guide with:
- Auto-detected technology stack
- Real setup commands from package.json/requirements.txt
- Project structure analysis
- Development workflow from actual scripts

---

### 📁 "I need to reorganize my project structure"
**Goal:** Physical file reorganization without breaking dependencies
```bash
/A-organize --scan
# Review the plan
/A-organize --apply
```
**Result:** Complete reorganization with:
- All import/export paths automatically updated
- Backup created before any changes
- Zero broken dependencies guaranteed
- Standards-compliant structure applied

#### **🔄 A-organize vs Manual Reorganization:**
- **Manual:** Move files, manually update 50+ import paths, high risk of broken imports
- **A-organize:** Automated dependency tracking, bulk path updates, backup safety, validation

**When to use A-organize:** Restructuring beyond simple file moves, multiple dependencies, risk of breaking imports

---

## 🎯 Success Patterns

### Project Lifecycle
1. **Planning:** A-plan → specifications
2. **Architecture:** A-architecture → diagrams
3. **Development:** A-ai-code + B-create-feature
4. **Quality:** A-audit + testing agents
5. **Maintenance:** A-update-docs + A-organize

### Team Workflows
- **Onboarding:** A-onboarding for new members
- **Code Review:** A-audit for quality gates
- **Release:** A-changelog for release notes

### Problem-Solving
- **Unknown error:** B-debug-error first
- **Complex problem:** B-ultra-think for analysis
- **Legacy code:** B-explain-code to understand first

---

**🚀 Ready to build amazing things!**