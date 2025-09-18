# Claude Code Toolkit - Auto Installation

**INSTRUCTIONS FOR CLAUDE CODE:**

This document allows you to automatically install the complete Claude Code Toolkit. Read and execute the steps in order.

## 🎯 OBJECTIVE

Automatically install:
- ✅ 17 specialized commands
- ✅ 12 specialized M1 agents
- ✅ Advanced monitoring script
- ✅ Status line configuration
- ✅ Required Python dependencies

## 📋 INSTALLATION PROCESS

### STEP 1: Verify Requirements

**Execute these commands to verify the system:**

```bash
# Verify Python 3.7+
python3 --version

# Verify Git (optional)
git --version

# Verify/create Claude Code directory
ls ~/.claude/ || mkdir -p ~/.claude/{commands,agents,scripts}

# Count current commands and agents (for backup)
echo "Current commands: $(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)"
echo "Current agents: $(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)"
```

### STEP 2: Clone Repository

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

### STEP 3: Install Python Dependencies

**Install required dependencies:**

```bash
# Install from requirements.txt
pip3 install --user -r requirements.txt

# Verify installation
python3 -c "import psutil; print('✅ psutil installed correctly')"
python3 -c "import dateutil; print('✅ python-dateutil installed correctly')"
```

### STEP 4: Automatic Backup (If Needed)

**Create backup of existing files:**

```bash
# Only if existing files are present
if [ "$(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)" -gt 0 ] || [ "$(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)" -gt 0 ]; then
    BACKUP_DIR="$HOME/.claude/backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"

    # Backup commands
    [ -d ~/.claude/commands ] && cp -r ~/.claude/commands "$BACKUP_DIR/"

    # Backup agents
    [ -d ~/.claude/agents ] && cp -r ~/.claude/agents "$BACKUP_DIR/"

    # Backup scripts
    [ -d ~/.claude/scripts ] && cp -r ~/.claude/scripts "$BACKUP_DIR/"

    echo "✅ Backup created at: $BACKUP_DIR"
else
    echo "ℹ️ No existing files found, skipping backup"
fi
```

### STEP 5: Install Commands

**Copy all commands to Claude Code directory:**

```bash
# Copy commands
cp commands/*.md ~/.claude/commands/

# Verify installation
INSTALLED_COMMANDS=$(ls ~/.claude/commands/*.md | wc -l)
echo "✅ Commands installed: $INSTALLED_COMMANDS"

# List main commands
echo "📋 Key commands installed:"
ls ~/.claude/commands/ | grep -E "A-plan|A-ai-code|B-HealthCheck|A-update-docs"
```

### STEP 6: Install Agents

**Copy all agents to Claude Code directory:**

```bash
# Copy agents
cp agents/*.md ~/.claude/agents/

# Verify installation
INSTALLED_AGENTS=$(ls ~/.claude/agents/*.md | wc -l)
echo "✅ Agents installed: $INSTALLED_AGENTS"

# List main agents
echo "🤖 Key agents installed:"
ls ~/.claude/agents/ | grep -E "M1-qa-gatekeeper|m1-ultrathink-orchestrator|M1-general-purpose"
```

### STEP 7: Install Monitoring Scripts

**Install advanced status line script:**

```bash
# Copy monitoring script
cp scripts/context-monitor-generic.py ~/.claude/scripts/context-monitor.py

# Make executable
chmod +x ~/.claude/scripts/context-monitor.py

# Verify script
python3 ~/.claude/scripts/context-monitor.py --help 2>/dev/null || echo "✅ Script installed (requires JSON input)"
```

### STEP 8: Configure Status Line

**Configure status line automatically:**

```bash
# Configuration file
SETTINGS_FILE="$HOME/.claude/settings.json"

# Check if configuration exists
if [ -f "$SETTINGS_FILE" ]; then
    echo "ℹ️ Existing settings.json found"

    # Check if statusLine already exists
    if grep -q "statusLine" "$SETTINGS_FILE"; then
        echo "ℹ️ statusLine already configured"
    else
        echo "➕ Adding statusLine configuration..."
        # Use Python to modify existing JSON
        python3 -c "
import json
with open('$SETTINGS_FILE', 'r') as f:
    settings = json.load(f)
settings['statusLine'] = {
    'type': 'command',
    'command': 'python3 ~/.claude/scripts/context-monitor.py'
}
with open('$SETTINGS_FILE', 'w') as f:
    json.dump(settings, f, indent=2)
print('✅ statusLine added to existing configuration')
"
    fi
else
    echo "📄 Creating new settings.json..."
    cat > "$SETTINGS_FILE" << 'EOF'
{
  "statusLine": {
    "type": "command",
    "command": "python3 ~/.claude/scripts/context-monitor.py"
  }
}
EOF
    echo "✅ settings.json created with statusLine configured"
fi
```

### STEP 9: Final Verification

**Verify everything is installed correctly:**

```bash
echo "🔍 FINAL VERIFICATION:"
echo "===================="

# Count installed files
COMMANDS_COUNT=$(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)
AGENTS_COUNT=$(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)

echo "📋 Commands installed: $COMMANDS_COUNT/17"
echo "🤖 Agents installed: $AGENTS_COUNT/12"

# Verify key files
echo ""
echo "✅ KEY FILES:"
[ -f ~/.claude/commands/A-plan.md ] && echo "  ✅ A-plan.md" || echo "  ❌ A-plan.md"
[ -f ~/.claude/commands/A-ai-code.md ] && echo "  ✅ A-ai-code.md" || echo "  ❌ A-ai-code.md"
[ -f ~/.claude/commands/B-HealthCheck.md ] && echo "  ✅ B-HealthCheck.md" || echo "  ❌ B-HealthCheck.md"
[ -f ~/.claude/agents/M1-qa-gatekeeper.md ] && echo "  ✅ M1-qa-gatekeeper.md" || echo "  ❌ M1-qa-gatekeeper.md"
[ -f ~/.claude/agents/m1-ultrathink-orchestrator.md ] && echo "  ✅ m1-ultrathink-orchestrator.md" || echo "  ❌ m1-ultrathink-orchestrator.md"
[ -f ~/.claude/scripts/context-monitor.py ] && echo "  ✅ context-monitor.py" || echo "  ❌ context-monitor.py"
[ -f ~/.claude/settings.json ] && echo "  ✅ settings.json" || echo "  ❌ settings.json"

echo ""
echo "🧹 CLEANUP:"
echo "==========="
# Clean temporary directory
cd /tmp
rm -rf claude-code-toolkit
echo "✅ Temporary directory cleaned"
```

### STEP 10: Post-Installation Tests

**Run these tests to verify functionality:**

```bash
echo ""
echo "🧪 BASIC TESTS:"
echo "==============="

# Test 1: Basic command
echo "Test 1: Verify A-plan command..."
if [ -f ~/.claude/commands/A-plan.md ]; then
    echo "✅ A-plan available for use"
else
    echo "❌ A-plan not found"
fi

# Test 2: Basic agent
echo "Test 2: Verify qa-gatekeeper agent..."
if [ -f ~/.claude/agents/M1-qa-gatekeeper.md ]; then
    echo "✅ M1-qa-gatekeeper available for use"
else
    echo "❌ M1-qa-gatekeeper not found"
fi

# Test 3: Monitoring script
echo "Test 3: Verify monitoring script..."
if [ -f ~/.claude/scripts/context-monitor.py ]; then
    echo "✅ Monitoring script installed"
else
    echo "❌ Monitoring script not found"
fi

# Test 4: Configuration
echo "Test 4: Verify configuration..."
if grep -q "statusLine" ~/.claude/settings.json 2>/dev/null; then
    echo "✅ statusLine configured"
else
    echo "❌ statusLine not configured"
fi
```

## 🎉 INSTALLATION COMPLETED

**After executing all steps, you will have available:**

### 📋 Main Commands:
- **`/A-plan`** - Specification generator with gap analysis
- **`/A-ai-code --coordinar`** - Master agent orchestrator
- **`/B-HealthCheck`** - Parallel AI tools monitor
- **`/A-update-docs`** - Intelligent updater with Git context

### 🤖 Specialized Agents:
- **M1-qa-gatekeeper** - Zero-tolerance quality control
- **m1-ultrathink-orchestrator** - Supreme AI tools director
- **M1-general-purpose-agent** - Versatile agent for complex tasks
- **+ 9 more specialized agents**

### 📊 Advanced Status Line:
```
📁 project 🌿main || 🟡 █████▁▁▁ ~65% || L.R. @ 19:00⚡ C.U. 🟢 █▁▁▁▁▁▁▁ 22%⚡ ⌚ 16:09 Sep 18
```

## 🔄 NEXT STEPS

1. **Restart Claude Code** to activate new commands
2. **Test the installation:**
   ```
   /A-plan "test project"
   /B-HealthCheck --fast
   ```
3. **Explore commands:** Review documentation in the repository
4. **Configure as needed:** Customize agents or commands

## ❗ TROUBLESHOOTING

If you encounter problems:

1. **Commands don't appear:** Restart Claude Code completely
2. **Python errors:** Run `pip3 install --user psutil python-dateutil`
3. **Status line not working:** Verify `~/.claude/settings.json`
4. **Permissions:** Run `chmod +x ~/.claude/commands/*.md ~/.claude/agents/*.md`

**Enjoy the Claude Code Toolkit!** 🚀