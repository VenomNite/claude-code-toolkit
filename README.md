# Claude Code Toolkit 🚀

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.7+](https://img.shields.io/badge/python-3.7+-blue.svg)](https://www.python.org/downloads/)
[![GitHub release](https://img.shields.io/github/v/release/Ghenwy/claude-code-toolkit)](https://github.com/Ghenwy/claude-code-toolkit/releases)
[![Claude AI](https://img.shields.io/badge/Claude%20AI-Compatible-orange)](https://claude.ai)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Maintenance](https://img.shields.io/maintenance/yes/2025)](https://github.com/Ghenwy/claude-code-toolkit/graphs/commit-activity)

[![Claude Code](https://img.shields.io/badge/Claude%20Code-Extension-blue)](https://claude.ai/code)
[![AI Automation](https://img.shields.io/badge/AI-Automation-green)](https://github.com/Ghenwy/claude-code-toolkit)
[![Commands](https://img.shields.io/badge/Commands-17-brightgreen)](https://github.com/Ghenwy/claude-code-toolkit#-commands-matrix)
[![Agents](https://img.shields.io/badge/Agents-12-orange)](https://github.com/Ghenwy/claude-code-toolkit#-agents-matrix)
[![Status Line](https://img.shields.io/badge/Status%20Line-Enhanced-purple)](https://github.com/Ghenwy/claude-code-toolkit#-status-line-integration)
[![Workflow](https://img.shields.io/badge/Workflow-Orchestration-red)](https://github.com/Ghenwy/claude-code-toolkit)
[![Context Monitor](https://img.shields.io/badge/Context-Monitor-yellow)](https://github.com/Ghenwy/claude-code-toolkit)

> **🎯 Transform your development workflow with AI automation**
> Professional toolkit featuring **17 specialized commands** and **12 intelligent agents** for automated workflow orchestration, Claude AI integration, and maximum developer productivity.

```mermaid
graph LR
    A[💡 Idea] --> B[📋 /A-plan]
    B --> C[🤖 /A-ai-code]
    C --> D[✅ /M1-qa-gatekeeper]
    D --> E[🚀 Production]
    style A fill:#e1f5fe
    style E fill:#e8f5e8
```

> **🏆 Version 2.1.0 - Dual-Scope Architecture**
> Supports both user (`~/.claude/`) and global (`/usr/local/share/claude/`) installations with automatic precedence management and comprehensive testing framework.

## 📋 Table of Contents

- [Quick Start](#-quick-start)
- [Commands Matrix](#-commands-matrix)
- [Agents Matrix](#-agents-matrix)
- [Status Line Integration](#-status-line-integration)
- [Key Features](#-key-features)
- [Usage Examples](#-usage-examples)
- [Dependencies](#-dependencies)
- [Documentation](#-documentation)
- [Contributing](#-contributing)

## 🚀 What's Included

| Component | Count | Description |
|-----------|-------|-------------|
| 📋 **Commands** | 17 | Automation tools for planning, orchestration, monitoring |
| 🤖 **Agents** | 12 | Specialized AI agents for development tasks |
| 📊 **Scripts** | 1 | Advanced status line monitoring |

## 🎯 Quick Start

### 🤖 **For Claude Code Users** (Recommended)

Simply tell your Claude Code:
```
"Read AUTO-INSTALL.md and perform the complete automatic installation"
```

### 👨‍💻 **For Human Users**

```bash
# 1. Clone & Install
git clone https://github.com/Ghenwy/claude-code-toolkit.git
cd claude-code-toolkit
./install.sh

# 2. Test Core Features
/A-plan "Build a task manager app"
/B-HealthCheck --fast
/A-ai-code --coordinar "Add user authentication"
```


## 📋 Commands Matrix

| Command | Category | Purpose | Key Features |
|---------|----------|---------|--------------|
| **A-plan** | 📈 Planning | Project specifications generator | Gap analysis, adaptive questions, 3-doc output |
| **A-ai-code** | 🤖 Orchestration | Multi-agent project coordinator | Agent delegation, progress tracking, parallel execution |
| **B-create-feature** | 🏗️ Scaffolding | Intelligent feature scaffolding | Auto-detection, templates, instant creation |
| **B-explain-code** | 📖 Analysis | Structured code analysis vs native | 13 matrices, auto-detection, standards integration, diagrams |
| **B-debug-error** | 🐛 Debugging | Systematic error analysis and resolution | Error classification, forensics, stack-specific solutions |
| **B-HealthCheck** | 🏥 Monitoring | AI tools health monitor | Parallel testing, diagnostics, troubleshooting |
| **A-update-docs** | 📚 Documentation | Smart doc updater | Git context, auto-compaction, critical preservation |
| **A-architecture** | 🏗️ Architecture | System design assistant | Architecture patterns, best practices |
| **A-audit** | 🔍 Quality | Code audit automation | Quality metrics, compliance checks |
| **A-changelog** | 📝 Documentation | Changelog generator | Release notes, version tracking |
| **A-commit** | 📝 Git | Smart commit assistant | Conventional commits, message optimization |
| **A-insights** | 📊 Analytics | Developer behavior + codebase curiosities | Git patterns, hotspots, team analytics, fun facts |
| **A-onboarding** | 🎯 Setup | Auto-discovery onboarding generator | Project analysis, setup commands, no docs assumed |
| **A-organize** | 📁 Organization | Physical file reorganization vs manual | Auto dependency updates, path preservation, backup |
| **A-todo** | ✅ Tasks | Smart todo management | Task tracking, prioritization |
| **A-workflow** | 🔄 Process | Workflow orchestrator | Agent coordination, task delegation |
| **B-ultra-think** | 🧠 Analysis | Deep thinking assistant | Complex problem solving |

> **⚡ Quick Reference**: See [CHEAT-SHEET.md](docs/CHEAT-SHEET.md) for ultra-fast command reference

## 🤖 Agents Matrix

| Agent | Specialty | Use Cases | Expertise Level |
|-------|-----------|-----------|-----------------|
| **M1-qa-gatekeeper** | 🛡️ Quality Assurance | Pre-production validation | Zero-tolerance standards |
| **m1-ultrathink-orchestrator** | 🧠 AI Orchestration | Multi-AI coordination | Supreme director |
| **M1-general-purpose-agent** | 🎯 General Development | Multi-step tasks | Versatile problem solver |
| **M1-senior-backend-architect** | ⚙️ Backend Systems | API design, architecture | 10+ years experience |
| **M1-frontend-architect-protocol** | 🎨 Frontend Systems | UI architecture, performance | Protocol-driven |
| **M1-senior-documentation-architect** | 📚 Documentation | Technical writing | Multi-audience docs |
| **M1-technical-research-analyst** | 🔬 Research | Technology validation | Authoritative sources |
| **M1-human-behavior-simulator** | 👥 UX Testing | User behavior simulation | Authentic patterns |
| **M1-ux-strategy-protocol** | 🎨 UX Strategy | Design psychology | Strategic approach |
| **M1-game-design-architect** | 🎮 Game Development | Mechanics, monetization | Mathematical models |
| **M1-unity-game-developer** | 🎮 Unity Development | C# scripting, optimization | Cross-platform expert |
| **M1-2d-game-asset-optimizer** | 🎨 Game Assets | Sprites, animations, VFX | Performance optimization |

## 🔄 Workflow

**Entry Point:** Use `/claude-toolkit "your request"` for universal intent recognition and auto-routing

**Development Flow:** Project Idea → `/A-plan` → Specifications → `/A-ai-code --coordinar` → Agent Orchestration → Development → `/M1-qa-gatekeeper` → Quality Validation → Production Ready

**Analytics & Discovery:** `/A-insights` reveals team patterns and codebase curiosities, `/A-onboarding` generates setup guides from project analysis

**Supporting Tools:** `/B-HealthCheck` monitors AI tools, `/A-update-docs` maintains documentation throughout the process.

## ⚙️ Installation

### 🤖 **Claude Code Auto-Install** (Recommended)

> **Let Claude Code handle everything for you**

Simply tell your Claude Code:
```
"Read AUTO-INSTALL.md and perform the complete automatic installation"
```

Claude Code will automatically execute all 10 installation steps, including dependency management, backups, and configuration.

### ⚡ Quick Install (Human Users)
```bash
curl -sSL https://raw.githubusercontent.com/Ghenwy/claude-code-toolkit/main/install.sh | bash
```

### 🔧 Manual Installation
```bash
git clone https://github.com/Ghenwy/claude-code-toolkit.git
cd claude-code-toolkit
cp commands/* ~/.claude/commands/
cp agents/* ~/.claude/agents/
cp scripts/* ~/.claude/scripts/
```

## 📊 Status Line Integration

Real-time monitoring with advanced metrics:

```
📁 my-project 🌿main | 🟡 ██▁▁ ✓69% (138k) | L.R. @ 04:00🕐 C.U. 🟢 ▁▁▁▁ 19% ⌚ 02:25 Sep 19
```

**Setup:**
```json
{
  "statusLine": {
    "type": "command",
    "command": "python3 ~/.claude/scripts/context-monitor.py"
  }
}
```

## 🚀 Key Features

### 🧠 **Intelligent Planning**
- **Gap Analysis**: Automatically identifies missing specifications
- **Adaptive Questioning**: Context-aware question generation
- **Think Hard Mode**: Deep reasoning for complex projects

### 🤖 **AI Orchestration**
- **Multi-Agent Coordination**: Parallel and sequential task execution
- **Progress Tracking**: Real-time status monitoring
- **Dependency Management**: Smart task sequencing

### 🏥 **Health Monitoring**
- **Parallel Testing**: Simultaneous AI tool verification
- **Smart Diagnostics**: Automatic troubleshooting suggestions
- **Performance Metrics**: Response time and reliability tracking

### 🛡️ **Quality Assurance**
- **Zero-Tolerance Standards**: 90% test coverage minimum
- **Security Compliance**: OWASP validation
- **Performance SLAs**: Real load testing

### 📋 **Standards System**
- **11 YAML Standards**: Technology-specific coding standards and best practices
- **Auto-Detection**: `standards/{detected-stack}.yaml || standards/general.yaml` fallback
- **Universal Integration**: All commands leverage standards for consistent output

### 🎯 **Learning Curve Solutions**
- **Progressive Disclosure**: CHEAT-SHEET.md (beginner) → USER-GUIDE.md (intermediate) → individual commands (advanced)
- **Universal Router**: `claude-toolkit.md` with intent recognition and confidence scoring
- **Smart Defaults**: Context-aware depth control and audience-appropriate explanations

### 🔍 **Auto-Discovery Capabilities**
- **Project Analysis**: Technology stack, framework, and architecture detection without assuming documentation
- **Developer Analytics**: Real git patterns, team working hours, codebase hotspots and curiosities
- **Environment Setup**: Automatic extraction of setup commands from package.json, requirements.txt, etc.

### ⚡ **Testing Infrastructure**
- **QUICK-TESTS.md**: 30-second validation system for all 17 commands
- **Minimal Context**: Efficient testing with automatic cleanup procedures
- **100% Coverage**: Every command validated and verified functional

## 📈 Usage Examples

### Project Planning
```bash
/A-plan "E-commerce platform with real-time inventory" --scope mvp
# → Generates: specifications.md, strategic-plan.md, todo-roadmap.md
```

### AI Orchestration
```bash
/A-ai-code --coordinar "Implement JWT authentication with role-based access"
# → Coordinates: backend-architect + frontend-architect + qa-gatekeeper
```

### Health Monitoring
```bash
/B-HealthCheck --detailed
# → Tests all AI tools in parallel, provides diagnostic report
```

### Developer Analytics
```bash
/A-insights . --git --files --deps
# → Real analytics: peak coding hours, hotspots, technical debt, fun facts
```

### Auto-Discovery Onboarding
```bash
/A-onboarding --role developer --depth comprehensive
# → Complete setup guide from project analysis, no docs assumed
```

### Code Analysis vs Native Claude
```bash
/B-explain-code "src/auth/UserService.java" --audience senior --diagrams both
# → 13 structured matrices, auto-detection, ASCII/Mermaid diagrams
```

### Universal Command Router
```bash
/claude-toolkit "build todo app"
# → Intent recognition → auto-routes to /A-plan with confidence scoring
```

## 🔧 Dependencies

- **Python 3.7+** (for status monitoring)
- **Git** (for context integration)
- **Claude Code** (latest version)

Optional AI Tools:
- **codex, qwen, opencode, gemini** (for enhanced orchestration via M1-ultrathink-orchestrator)
- **MCP Servers** (for specialized agent capabilities)

## 📚 Documentation

### 📋 **Quick References**
- **[CHEAT-SHEET.md](docs/CHEAT-SHEET.md)**: Ultra-fast command reference (beginner level)
- **[USER-GUIDE.md](docs/USER-GUIDE.md)**: Step-by-step workflows and examples (intermediate level)

### 🔧 **Installation Guides**
- **[AUTO-INSTALL.md](AUTO-INSTALL.md)**: Automated installation for Claude Code users
- **[install.sh](install.sh)**: Quick installation script for human users

### ⚡ **Testing & Validation**
- **[QUICK-TESTS.md](testing/QUICK-TESTS.md)**: 30-second validation system for all 17 commands
- **[STANDARDS/](standards/)**: 11 YAML files with technology-specific coding standards

### 🎯 **Progressive Learning Path**
1. **Beginner**: Start with [CHEAT-SHEET.md](docs/CHEAT-SHEET.md) for quick command overview
2. **Intermediate**: Follow [USER-GUIDE.md](docs/USER-GUIDE.md) for detailed workflows
3. **Advanced**: Use individual commands directly or `/claude-toolkit` universal router

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Follow the [Contributing Guidelines](docs/CONTRIBUTING.md)
4. Submit a Pull Request

## 📝 License

MIT License - see [LICENSE](LICENSE) for details.

---

**⭐ Star this repo** if you find it useful!
**🐛 Report issues** to help improve the toolkit
**🚀 Share with the community** to help others automate their workflow

*Built with ❤️ for the Claude Code community*