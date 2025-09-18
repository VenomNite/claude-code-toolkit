# 🚀 QUICK INSTALL - Claude Code Toolkit

**For other Claude Code users:**

> Give this file to your Claude Code and say: **"Read QUICK-INSTALL.md and perform the complete automatic installation"**

## ✨ INSTALLATION IN 3 STEPS

### 1️⃣ **CLONE AND PREPARE**
```bash
cd /tmp && git clone https://github.com/Ghenwy/claude-code-toolkit.git && cd claude-code-toolkit
```

### 2️⃣ **RUN INSTALLER**
```bash
chmod +x install.sh && ./install.sh
```

### 3️⃣ **VERIFY INSTALLATION**
```bash
echo "Commands: $(ls ~/.claude/commands/*.md | wc -l)" && echo "Agents: $(ls ~/.claude/agents/*.md | wc -l)"
```

## 🎯 **WHAT GETS INSTALLED AUTOMATICALLY**

- ✅ **17 commands** - /A-plan, /A-ai-code, /B-HealthCheck, etc.
- ✅ **12 M1 agents** - qa-gatekeeper, ultrathink-orchestrator, etc.
- ✅ **Advanced status line** - Real-time monitoring
- ✅ **Python dependencies** - psutil, python-dateutil
- ✅ **Automatic backup** - Of existing files
- ✅ **Complete configuration** - settings.json updated

## 🧪 **QUICK TEST**
After installation, test these commands:
```bash
/A-plan "test project"
/B-HealthCheck --fast
/A-ai-code --help
```

## 📊 **NEW STATUS LINE**
You'll see something like:
```
📁 my-project 🌿main || 🟡 █████▁▁▁ ~65% || L.R. @ 19:00⚡ C.U. 🟢 █▁▁▁▁▁▁▁ 22%⚡ ⌚ 16:09 Sep 18
```

---

**Having problems?** Read [AUTO-INSTALL.md](AUTO-INSTALL.md) for detailed step-by-step installation.