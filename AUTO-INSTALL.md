# Claude Code Toolkit - Dual-Scope Auto Installation

**INSTRUCTIONS FOR CLAUDE CODE:**

This document allows you to automatically install the complete Claude Code Toolkit with **dual-scope architecture** supporting both user and global installations.

## 🎯 OBJECTIVE

Automatically install with **dual-scope support**:
- ✅ 18 specialized commands
- ✅ 12 specialized M1 agents
- ✅ Advanced monitoring script
- ✅ Dual-scope configuration (user/global)
- ✅ Required Python dependencies

## 📋 INSTALLATION SCOPES

### 🏠 USER SCOPE (Default)
```
~/.claude/
├── commands/          # User commands (override global)
├── agents/           # User agents (override global)
├── scripts/          # User scripts
└── settings.json     # User settings
```

### 🌐 GLOBAL SCOPE (System-wide)
```
/usr/local/share/claude/
├── commands/          # Global commands (fallback)
├── agents/           # Global agents (fallback)
├── scripts/          # Global scripts
└── config/
    └── global-settings.json
```

**PRECEDENCE:** Claude Code searches `User → Global → Built-in defaults`

## 📋 INSTALLATION PROCESS

### STEP 1: Choose Installation Method

**Execute these commands to determine installation scope:**

```bash
# METHOD A: User Installation (Default - No sudo required)
./install.sh
# OR explicitly:
./install.sh --user

# METHOD B: Global Installation (Requires sudo)
sudo ./install.sh --global

# METHOD C: Test First (Dry Run)
./install.sh --dry-run --verbose           # Test user installation
sudo ./install.sh --global --dry-run       # Test global installation
```

### STEP 2: Verify Requirements

**Execute these commands to verify the system:**

```bash
# Verify Python 3.7+
python3 --version

# Verify Git (optional but recommended)
git --version

# Check current installations
echo "USER scope commands: $(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)"
echo "USER scope agents: $(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)"
echo "GLOBAL scope commands: $(ls /usr/local/share/claude/commands/*.md 2>/dev/null | wc -l)"
echo "GLOBAL scope agents: $(ls /usr/local/share/claude/agents/*.md 2>/dev/null | wc -l)"
```

### STEP 3: Clone Repository (If Needed)

**Clone the toolkit repository:**

```bash
# Clone to temporary directory
cd /tmp
git clone https://github.com/Ghenwy/claude-code-toolkit.git
cd claude-code-toolkit

# Verify downloaded content
echo "✅ Available commands: $(ls commands/*.md | wc -l)"
echo "✅ Available agents: $(ls agents/*.md | wc -l)"
echo "✅ Available scripts: $(ls scripts/*.py | wc -l)"
```

### STEP 4A: USER SCOPE INSTALLATION

**Install in user scope (default, no sudo required):**

```bash
# Automatic installation with full verification
./install.sh --verbose

# Verify user installation
./install.sh --verify --verbose

# Show installation details
echo "📂 USER INSTALLATION SUMMARY:"
echo "==============================="
echo "Commands: $(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)/18"
echo "Agents: $(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)/12"
echo "Scripts: $(ls ~/.claude/scripts/*.py 2>/dev/null | wc -l)"
echo "Settings: $(test -f ~/.claude/settings.json && echo "✅ Configured" || echo "❌ Missing")"

# Key files verification
echo ""
echo "🔍 KEY FILES VERIFICATION:"
[ -f ~/.claude/commands/A-plan.md ] && echo "  ✅ A-plan.md" || echo "  ❌ A-plan.md"
[ -f ~/.claude/commands/A-ai-code.md ] && echo "  ✅ A-ai-code.md" || echo "  ❌ A-ai-code.md"
[ -f ~/.claude/agents/M1-qa-gatekeeper.md ] && echo "  ✅ M1-qa-gatekeeper.md" || echo "  ❌ M1-qa-gatekeeper.md"
[ -f ~/.claude/agents/m1-ultrathink-orchestrator.md ] && echo "  ✅ m1-ultrathink-orchestrator.md" || echo "  ❌ m1-ultrathink-orchestrator.md"
[ -f ~/.claude/scripts/context-monitor-generic.py ] && echo "  ✅ context-monitor-generic.py" || echo "  ❌ context-monitor-generic.py"
```

### STEP 4B: GLOBAL SCOPE INSTALLATION

**Install in global scope (requires sudo):**

```bash
# Check if sudo is available
if command -v sudo &> /dev/null; then
    echo "✅ sudo available for global installation"
else
    echo "❌ sudo not available - falling back to user installation"
    ./install.sh --user
    exit 0
fi

# Global installation with verification
sudo ./install.sh --global --verbose

# Verify global installation
sudo ./install.sh --global --verify --verbose

# Show installation details
echo "🌐 GLOBAL INSTALLATION SUMMARY:"
echo "================================"
echo "Commands: $(ls /usr/local/share/claude/commands/*.md 2>/dev/null | wc -l)/18"
echo "Agents: $(ls /usr/local/share/claude/agents/*.md 2>/dev/null | wc -l)/12"
echo "Scripts: $(ls /usr/local/share/claude/scripts/*.py 2>/dev/null | wc -l)"
echo "Settings: $(test -f /usr/local/share/claude/config/global-settings.json && echo "✅ Configured" || echo "❌ Missing")"

# Key files verification
echo ""
echo "🔍 GLOBAL KEY FILES VERIFICATION:"
[ -f /usr/local/share/claude/commands/A-plan.md ] && echo "  ✅ A-plan.md" || echo "  ❌ A-plan.md"
[ -f /usr/local/share/claude/commands/A-ai-code.md ] && echo "  ✅ A-ai-code.md" || echo "  ❌ A-ai-code.md"
[ -f /usr/local/share/claude/agents/M1-qa-gatekeeper.md ] && echo "  ✅ M1-qa-gatekeeper.md" || echo "  ❌ M1-qa-gatekeeper.md"
[ -f /usr/local/share/claude/agents/m1-ultrathink-orchestrator.md ] && echo "  ✅ m1-ultrathink-orchestrator.md" || echo "  ❌ m1-ultrathink-orchestrator.md"
[ -f /usr/local/share/claude/scripts/context-monitor-generic.py ] && echo "  ✅ context-monitor-generic.py" || echo "  ❌ context-monitor-generic.py"
```

### STEP 5: Install Python Dependencies

**Install required dependencies (scope-independent):**

```bash
# Install from requirements.txt
pip3 install --user -r requirements.txt

# Verify installation
python3 -c "import psutil; print('✅ psutil installed correctly')"
python3 -c "import dateutil; print('✅ python-dateutil installed correctly')"
```

### STEP 6: Final Verification & Testing

**Comprehensive verification of installation:**

```bash
echo "🔍 COMPREHENSIVE VERIFICATION:"
echo "==============================="

# Check both scopes
USER_COMMANDS=$(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)
USER_AGENTS=$(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)
GLOBAL_COMMANDS=$(ls /usr/local/share/claude/commands/*.md 2>/dev/null | wc -l)
GLOBAL_AGENTS=$(ls /usr/local/share/claude/agents/*.md 2>/dev/null | wc -l)

echo "📂 USER SCOPE:"
echo "  Commands: $USER_COMMANDS/18"
echo "  Agents: $USER_AGENTS/12"

echo "🌐 GLOBAL SCOPE:"
echo "  Commands: $GLOBAL_COMMANDS/18"
echo "  Agents: $GLOBAL_AGENTS/12"

# Show effective precedence
echo ""
echo "🎯 EFFECTIVE PRECEDENCE (Claude Code will use):"
if [ $USER_COMMANDS -gt 0 ] || [ $USER_AGENTS -gt 0 ]; then
    echo "  ✅ USER scope takes precedence (commands found in ~/.claude/)"
    echo "  📁 Active location: ~/.claude/"
else
    echo "  ✅ GLOBAL scope active (no user override)"
    echo "  📁 Active location: /usr/local/share/claude/"
fi

# Test basic functionality
echo ""
echo "🧪 BASIC FUNCTIONALITY TESTS:"
echo "=============================="

# Test monitoring script
if [ -f ~/.claude/scripts/context-monitor-generic.py ]; then
    echo "Test 1: User monitoring script..."
    python3 ~/.claude/scripts/context-monitor-generic.py --help 2>/dev/null && echo "  ✅ User script functional" || echo "  ℹ️ Script requires JSON input (normal)"
elif [ -f /usr/local/share/claude/scripts/context-monitor-generic.py ]; then
    echo "Test 1: Global monitoring script..."
    python3 /usr/local/share/claude/scripts/context-monitor-generic.py --help 2>/dev/null && echo "  ✅ Global script functional" || echo "  ℹ️ Script requires JSON input (normal)"
else
    echo "  ❌ No monitoring script found"
fi

# Test command availability
echo "Test 2: Command files verification..."
if [ $USER_COMMANDS -gt 0 ]; then
    echo "  ✅ User commands available for Claude Code"
elif [ $GLOBAL_COMMANDS -gt 0 ]; then
    echo "  ✅ Global commands available for Claude Code"
else
    echo "  ❌ No commands found in any scope"
fi

# Test agent availability
echo "Test 3: Agent files verification..."
if [ $USER_AGENTS -gt 0 ]; then
    echo "  ✅ User agents available for Claude Code"
elif [ $GLOBAL_AGENTS -gt 0 ]; then
    echo "  ✅ Global agents available for Claude Code"
else
    echo "  ❌ No agents found in any scope"
fi
```

### STEP 7: Cleanup

**Clean temporary files:**

```bash
echo "🧹 CLEANUP:"
echo "==========="
# Clean temporary directory
cd /tmp
rm -rf claude-code-toolkit
echo "✅ Temporary directory cleaned"
```

## 🎉 INSTALLATION COMPLETED

**After executing all steps, you will have available:**

### 📋 Main Commands (18 total):
- **`/A-plan`** - Specification generator with gap analysis
- **`/A-ai-code --coordinar`** - Master agent orchestrator
- **`/B-HealthCheck`** - Parallel AI tools monitor
- **`/A-update-docs`** - Intelligent updater with Git context

### 🤖 Specialized Agents (12 total):
- **M1-qa-gatekeeper** - Zero-tolerance quality control
- **m1-ultrathink-orchestrator** - Supreme AI tools director
- **M1-general-purpose-agent** - Versatile agent for complex tasks
- **+ 9 more specialized agents**

### 📊 Advanced Status Line:
```
📁 project 🌿main || 🟡 █████▁▁▁ ~65% || L.R. @ 19:00⚡ C.U. 🟢 █▁▁▁▁▁▁▁ 22%⚡ ⌚ 16:09 Sep 18
```

## 🔄 MANAGING INSTALLATIONS

### Switch Between Scopes

```bash
# Install user version to override global
./install.sh --user

# Install global version (if no user version, becomes active)
sudo ./install.sh --global

# Remove user version to fall back to global
./install.sh --uninstall --user

# Remove global version
sudo ./install.sh --uninstall --global
```

### Verify Current Active Scope

```bash
# Quick scope check
./install.sh --verify --verbose

# Manual verification
if [ -d ~/.claude/commands ] && [ "$(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)" -gt 0 ]; then
    echo "🏠 USER scope is active (overriding global)"
    echo "   Location: ~/.claude/"
elif [ -d /usr/local/share/claude/commands ] && [ "$(ls /usr/local/share/claude/commands/*.md 2>/dev/null | wc -l)" -gt 0 ]; then
    echo "🌐 GLOBAL scope is active"
    echo "   Location: /usr/local/share/claude/"
else
    echo "❌ No installation found in any scope"
fi
```

## 🔄 NEXT STEPS

1. **Restart Claude Code** to activate new commands
2. **Test the installation:**
   ```
   /A-plan "test project"
   /B-HealthCheck --fast
   ```
3. **Explore commands:** Review documentation in the repository
4. **Configure as needed:** Customize agents or commands per scope

## ❗ TROUBLESHOOTING

### Common Issues:

1. **Commands don't appear:** Restart Claude Code completely
2. **Python errors:** Run `pip3 install --user psutil python-dateutil`
3. **Global installation fails:** Check sudo permissions or try user scope
4. **Permissions errors:**
   ```bash
   # For user scope:
   chmod +x ~/.claude/commands/*.md ~/.claude/agents/*.md

   # For global scope:
   sudo chmod 644 /usr/local/share/claude/commands/*.md
   sudo chmod 644 /usr/local/share/claude/agents/*.md
   ```
5. **Status line not working:**
   - User scope: Verify `~/.claude/settings.json`
   - Global scope: Verify `/usr/local/share/claude/config/global-settings.json`

### Advanced Troubleshooting:

```bash
# Show detailed installation information
./install.sh --verify --verbose

# Test with dry run to see what would happen
./install.sh --dry-run --verbose
sudo ./install.sh --global --dry-run --verbose

# Force reinstallation if needed
./install.sh --force
sudo ./install.sh --global --force
```

**Enjoy the Claude Code Toolkit with dual-scope architecture!** 🚀

---

### 🏆 ULTRATHINK ARCHITECTURE BENEFITS

- **Flexible deployment:** Choose user or global based on needs
- **Precedence system:** User installations override global seamlessly
- **Zero conflicts:** Backup system protects existing installations
- **Professional grade:** Following Unix conventions and best practices
- **Complete tooling:** Verification, uninstall, dry-run modes included