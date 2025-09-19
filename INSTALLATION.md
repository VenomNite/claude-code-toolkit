# 🚀 Claude Code Toolkit Installation Guide
## ULTRATHINK DUAL-SCOPE ARCHITECTURE

**Complete installation guide supporting both user and global installations with precedence management.**

**🔗 Navigation**: [← Main README](README.md) • [Quick Start](README.md#-quick-start-30-seconds) • [User Guide](docs/USER-GUIDE.md) • [Command Reference](docs/CHEAT-SHEET.md) • [Auto-Install Guide](AUTO-INSTALL.md)

## ⚡ Quick Installation (Recommended)

### 🏠 User Installation (Default)
```bash
# One-line install for current user only
curl -sSL https://raw.githubusercontent.com/Ghenwy/claude-code-toolkit/main/install.sh | bash

# Or clone and install with verification
git clone https://github.com/Ghenwy/claude-code-toolkit.git
cd claude-code-toolkit
./install.sh --verbose
```

### 🌐 Global Installation (System-wide)
```bash
# Clone and install globally (requires sudo)
git clone https://github.com/Ghenwy/claude-code-toolkit.git
cd claude-code-toolkit
sudo ./install.sh --global --verbose
```

## 📂 Installation Scopes

### 🏠 USER SCOPE (Default)
```
~/.claude/
├── commands/          # User commands (override global)
├── agents/           # User agents (override global)
├── scripts/          # User monitoring scripts
├── settings.json     # User-specific settings
└── backup_YYYYMMDD_HHMMSS/    # Automatic backups
```

**Benefits:**
- ✅ No admin privileges required
- ✅ Personal customization
- ✅ Overrides global installation
- ✅ Automatic backup creation

### 🌐 GLOBAL SCOPE (System-wide)
```
/usr/local/share/claude/
├── commands/          # Global commands (fallback)
├── agents/           # Global agents (fallback)
├── scripts/          # Global monitoring scripts
└── config/
    └── global-settings.json    # System-wide settings
```

**Benefits:**
- ✅ Available to all users
- ✅ Centralized management
- ✅ Professional deployment
- ✅ Follows Unix conventions

### 🎯 Precedence System
Claude Code searches in this order:
1. **`~/.claude/`** (User scope - highest priority)
2. **`/usr/local/share/claude/`** (Global scope - fallback)
3. **Built-in defaults** (Claude Code internal)

## 🔧 Dual-Scope Installation

### Option 1: Quick Install with Scope Selection

```bash
# User installation (default)
./install.sh

# Global installation
sudo ./install.sh --global

# Test installation first
./install.sh --dry-run --verbose
sudo ./install.sh --global --dry-run --verbose
```

### Option 2: Advanced Installation with Full Control

```bash
# Step-by-step installation with all options
./install.sh --help          # Show all available options
./install.sh --version       # Show installer version
./install.sh --verify        # Verify existing installation
./install.sh --force         # Force reinstall
./install.sh --verbose       # Detailed output
./install.sh --uninstall     # Remove installation
```

## 📋 Prerequisites

### 1. System Requirements
```bash
# Check Python version (3.7+ required)
python3 --version

# Check Git (recommended)
git --version

# Check sudo access (for global installation)
sudo -v
```

### 2. Verify Installation Directories
```bash
# Check existing installations
echo "USER commands: $(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)"
echo "USER agents: $(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)"
echo "GLOBAL commands: $(ls /usr/local/share/claude/commands/*.md 2>/dev/null | wc -l)"
echo "GLOBAL agents: $(ls /usr/local/share/claude/agents/*.md 2>/dev/null | wc -l)"

# Verify which scope is currently active
if [ -d ~/.claude/commands ] && [ "$(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)" -gt 0 ]; then
    echo "🏠 USER scope is active (overriding global)"
elif [ -d /usr/local/share/claude/commands ] && [ "$(ls /usr/local/share/claude/commands/*.md 2>/dev/null | wc -l)" -gt 0 ]; then
    echo "🌐 GLOBAL scope is active"
else
    echo "❌ No installation found"
fi
```

## 🛠️ Manual Installation

### For User Scope (~/.claude/)

```bash
# 1. Create user directories
mkdir -p ~/.claude/{commands,agents,scripts}

# 2. Install Python dependencies
pip3 install --user psutil python-dateutil

# 3. Copy toolkit files
cp commands/*.md ~/.claude/commands/
cp agents/*.md ~/.claude/agents/
cp scripts/*.py ~/.claude/scripts/
chmod +x ~/.claude/scripts/*.py

# 4. Configure status line
cat > ~/.claude/settings.json << 'EOF'
{
  "statusLine": {
    "type": "command",
    "command": "python3 ~/.claude/scripts/context-monitor-generic.py"
  }
}
EOF

# 5. Verify installation
echo "Commands: $(ls ~/.claude/commands/*.md | wc -l)/18"
echo "Agents: $(ls ~/.claude/agents/*.md | wc -l)/12"
```

### For Global Scope (/usr/local/share/claude/)

```bash
# 1. Create global directories (requires sudo)
sudo mkdir -p /usr/local/share/claude/{commands,agents,scripts,config}

# 2. Install Python dependencies (user scope)
pip3 install --user psutil python-dateutil

# 3. Copy toolkit files with correct permissions
sudo cp commands/*.md /usr/local/share/claude/commands/
sudo cp agents/*.md /usr/local/share/claude/agents/
sudo cp scripts/*.py /usr/local/share/claude/scripts/
sudo chmod 644 /usr/local/share/claude/commands/*.md
sudo chmod 644 /usr/local/share/claude/agents/*.md
sudo chmod 755 /usr/local/share/claude/scripts/*.py

# 4. Configure global settings
sudo tee /usr/local/share/claude/config/global-settings.json > /dev/null << 'EOF'
{
  "statusLine": {
    "type": "command",
    "command": "python3 /usr/local/share/claude/scripts/context-monitor-generic.py"
  },
  "installation": {
    "scope": "global",
    "installed_at": "$(date -Iseconds)"
  }
}
EOF

# 5. Set proper ownership
sudo chown -R root:root /usr/local/share/claude
sudo chmod -R 755 /usr/local/share/claude

# 6. Verify installation
echo "Commands: $(ls /usr/local/share/claude/commands/*.md | wc -l)/18"
echo "Agents: $(ls /usr/local/share/claude/agents/*.md | wc -l)/12"
```

## 🔍 Installation Verification

### Comprehensive Verification Script

```bash
#!/bin/bash
echo "🔍 CLAUDE CODE TOOLKIT VERIFICATION"
echo "==================================="

# Check both scopes
USER_COMMANDS=$(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)
USER_AGENTS=$(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)
GLOBAL_COMMANDS=$(ls /usr/local/share/claude/commands/*.md 2>/dev/null | wc -l)
GLOBAL_AGENTS=$(ls /usr/local/share/claude/agents/*.md 2>/dev/null | wc -l)

echo "📂 USER SCOPE:"
echo "  Location: ~/.claude/"
echo "  Commands: $USER_COMMANDS/18"
echo "  Agents: $USER_AGENTS/12"
echo "  Settings: $(test -f ~/.claude/settings.json && echo "✅" || echo "❌")"

echo ""
echo "🌐 GLOBAL SCOPE:"
echo "  Location: /usr/local/share/claude/"
echo "  Commands: $GLOBAL_COMMANDS/18"
echo "  Agents: $GLOBAL_AGENTS/12"
echo "  Settings: $(test -f /usr/local/share/claude/config/global-settings.json && echo "✅" || echo "❌")"

echo ""
echo "🎯 EFFECTIVE SCOPE (Claude Code will use):"
if [ $USER_COMMANDS -gt 0 ] || [ $USER_AGENTS -gt 0 ]; then
    echo "  ✅ USER scope active (overrides global)"
    echo "  📁 Commands from: ~/.claude/"
else
    echo "  ✅ GLOBAL scope active"
    echo "  📁 Commands from: /usr/local/share/claude/"
fi

# Test key commands availability
echo ""
echo "🧪 KEY COMMANDS TEST:"
KEY_COMMANDS=("A-plan.md" "A-ai-code.md" "B-HealthCheck.md")
for cmd in "${KEY_COMMANDS[@]}"; do
    if [ -f ~/.claude/commands/$cmd ]; then
        echo "  ✅ $cmd (user)"
    elif [ -f /usr/local/share/claude/commands/$cmd ]; then
        echo "  ✅ $cmd (global)"
    else
        echo "  ❌ $cmd (missing)"
    fi
done

# Test Python dependencies
echo ""
echo "🐍 PYTHON DEPENDENCIES:"
python3 -c "import psutil; print('  ✅ psutil')" 2>/dev/null || echo "  ❌ psutil"
python3 -c "import dateutil; print('  ✅ python-dateutil')" 2>/dev/null || echo "  ❌ python-dateutil"
```

### Quick Test Commands

```bash
# Test installation status
./install.sh --verify --verbose

# Test specific scope
./install.sh --user --verify
sudo ./install.sh --global --verify

# Test Python dependencies
python3 -c "import psutil, dateutil; print('✅ Dependencies OK')"

# Test monitoring script
if [ -f ~/.claude/scripts/context-monitor-generic.py ]; then
    python3 ~/.claude/scripts/context-monitor-generic.py --version 2>/dev/null || echo "Script requires JSON input (normal)"
fi
```

## 🔄 Managing Multiple Installations

### Switch Between Scopes

```bash
# Install user version (will override global)
./install.sh --user

# Install global version (active if no user version)
sudo ./install.sh --global

# Remove user version (falls back to global)
./install.sh --uninstall --user

# Remove global version
sudo ./install.sh --uninstall --global

# Remove both (complete cleanup)
./install.sh --uninstall --user
sudo ./install.sh --uninstall --global
```

### Backup and Restore

```bash
# Automatic backups are created during installation
ls ~/.claude/backup_*/  # User scope backups
ls /usr/local/share/claude/backup_*/  # Global scope backups

# Manual backup creation
mkdir -p ~/claude-toolkit-backup/$(date +%Y%m%d)
cp -r ~/.claude/* ~/claude-toolkit-backup/$(date +%Y%m%d)/user/
sudo cp -r /usr/local/share/claude/* ~/claude-toolkit-backup/$(date +%Y%m%d)/global/

# Restore from backup
cp -r ~/claude-toolkit-backup/20231218/user/* ~/.claude/
sudo cp -r ~/claude-toolkit-backup/20231218/global/* /usr/local/share/claude/
```

## ❗ Troubleshooting

### Common Issues by Scope

#### 🏠 User Scope Issues

**Commands don't appear:**
```bash
# Check file existence and permissions
ls -la ~/.claude/commands/
chmod +x ~/.claude/commands/*.md ~/.claude/agents/*.md

# Restart Claude Code completely
# Check for typos in command names
```

**Python dependency errors:**
```bash
# Reinstall dependencies
pip3 install --user --upgrade psutil python-dateutil

# Check Python path
python3 -c "import sys; print(sys.path)"

# Verify installation
python3 -c "import psutil, dateutil; print('OK')"
```

**Status line not working:**
```bash
# Check settings file
cat ~/.claude/settings.json

# Test script directly
python3 ~/.claude/scripts/context-monitor-generic.py

# Recreate settings
./install.sh --force
```

#### 🌐 Global Scope Issues

**Permission denied errors:**
```bash
# Fix ownership and permissions
sudo chown -R root:root /usr/local/share/claude
sudo chmod -R 755 /usr/local/share/claude
sudo chmod 644 /usr/local/share/claude/commands/*.md
sudo chmod 644 /usr/local/share/claude/agents/*.md
sudo chmod 755 /usr/local/share/claude/scripts/*.py
```

**Global installation fails:**
```bash
# Check sudo access
sudo -v

# Verify directory creation
sudo mkdir -p /usr/local/share/claude
ls -la /usr/local/share/

# Check disk space
df -h /usr/local/share/
```

**Global commands not found:**
```bash
# Verify Claude Code looks in global location
# Check if user installation is overriding
ls ~/.claude/commands/ 2>/dev/null | wc -l

# Force global by removing user installation
rm -rf ~/.claude/commands ~/.claude/agents
```

### Platform-Specific Issues

#### 🐧 Linux
```bash
# Missing dependencies
sudo apt update
sudo apt install python3 python3-pip python3-dev git

# Permission issues
sudo usermod -a -G wheel $USER  # Add user to wheel group
newgrp wheel  # Activate group

# Path issues
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

#### 🍎 macOS
```bash
# Install Homebrew (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Python via Homebrew
brew install python3 git

# Fix permissions on macOS
sudo chown -R $(whoami) ~/.claude/
sudo chown -R root:wheel /usr/local/share/claude/
```

#### 🪟 Windows (WSL)
```bash
# Use WSL2 for best compatibility
wsl --version

# Install Ubuntu from Microsoft Store if needed
# Then follow Linux instructions

# Fix WSL path issues
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
```

### Advanced Troubleshooting

#### Conflicting Installations
```bash
# Diagnose conflicting installations
echo "Checking for conflicts..."
find /usr -name "*.claude*" 2>/dev/null
find $HOME -name "*.claude*" 2>/dev/null

# Clean slate reinstall
rm -rf ~/.claude
sudo rm -rf /usr/local/share/claude
./install.sh --user --verbose
```

#### Network Issues
```bash
# Test GitHub connectivity
curl -I https://raw.githubusercontent.com/Ghenwy/claude-code-toolkit/main/install.sh

# Use alternative clone method
git clone git@github.com:Ghenwy/claude-code-toolkit.git

# Download manually if needed
wget https://github.com/Ghenwy/claude-code-toolkit/archive/main.zip
unzip main.zip
cd claude-code-toolkit-main
```

#### Performance Issues
```bash
# Check disk space
df -h ~/.claude/
df -h /usr/local/share/claude/

# Check file counts
find ~/.claude -type f | wc -l
find /usr/local/share/claude -type f | wc -l

# Optimize installation
./install.sh --force --verbose  # Recreate with optimizations
```

## 🔐 Security Considerations

### User Scope Security
- ✅ No root privileges required
- ✅ Isolated to user's home directory
- ✅ No system-wide impact
- ✅ User-controlled permissions

### Global Scope Security
- ⚠️ Requires sudo for installation
- ✅ Read-only files for non-root users
- ✅ Follows Unix security conventions
- ✅ Centralized audit trail

### Best Practices
```bash
# Verify installation integrity
shasum -a 256 install.sh  # Check installer hash
./install.sh --verify     # Verify installed files

# Regular security updates
git pull origin main      # Update to latest version
./install.sh --force      # Reinstall with updates

# Audit installed commands
grep -r "sudo\|rm -rf\|chmod" ~/.claude/commands/
```

## 🔄 Updates and Maintenance

### Update Toolkit
```bash
# Standard update process
cd claude-code-toolkit
git pull origin main

# Update user installation
./install.sh --force --verbose

# Update global installation
sudo ./install.sh --global --force --verbose

# Verify update
./install.sh --verify --verbose
```

### Selective Updates
```bash
# Update only commands
cp commands/*.md ~/.claude/commands/
sudo cp commands/*.md /usr/local/share/claude/commands/

# Update only agents
cp agents/*.md ~/.claude/agents/
sudo cp agents/*.md /usr/local/share/claude/agents/

# Update only scripts
cp scripts/*.py ~/.claude/scripts/
sudo cp scripts/*.py /usr/local/share/claude/scripts/
```

### Maintenance Commands
```bash
# Clean old backups (older than 30 days)
find ~/.claude/backup_* -type d -mtime +30 -exec rm -rf {} +
sudo find /usr/local/share/claude/backup_* -type d -mtime +30 -exec rm -rf {} +

# Verify file integrity
./install.sh --verify --verbose

# Performance check
time ./install.sh --dry-run  # Should complete in <5 seconds
```

## 🆘 Get Help

### Self-Diagnostic Tools
```bash
# Comprehensive system check
./install.sh --verify --verbose

# Generate diagnostic report
./install.sh --verify --verbose > diagnostic-report.txt 2>&1

# Check installer version and capabilities
./install.sh --version
./install.sh --help
```

### Support Resources
- 📖 [README.md](claude-code-toolkit/README.md) - Complete documentation
- 🤝 [CONTRIBUTING.md](claude-code-toolkit/CONTRIBUTING.md) - Development guidelines
- 🐛 [GitHub Issues](https://github.com/Ghenwy/claude-code-toolkit/issues) - Report problems
- 💬 [GitHub Discussions](https://github.com/Ghenwy/claude-code-toolkit/discussions) - Community support

### Diagnostic Information for Bug Reports
When reporting issues, please include:

```bash
# System information
uname -a
python3 --version
git --version

# Installation information
./install.sh --verify --verbose

# Permission information
ls -la ~/.claude/
ls -la /usr/local/share/claude/

# Environment information
echo $PATH
echo $PYTHONPATH
env | grep -i claude
```

---

## 🏆 ULTRATHINK ARCHITECTURE SUMMARY

**Professional-grade dual-scope installation system with:**

- ✅ **Flexible deployment** - User or global scope selection
- ✅ **Intelligent precedence** - User overrides global seamlessly
- ✅ **Robust error handling** - Comprehensive troubleshooting
- ✅ **Security-first design** - Following Unix best practices
- ✅ **Complete tooling** - Verify, uninstall, dry-run modes
- ✅ **Professional documentation** - Exhaustive troubleshooting guide
- ✅ **Cross-platform support** - Linux, macOS, Windows (WSL)
- ✅ **Zero-conflict installation** - Automatic backup system

**Ready for enterprise deployment and personal use.**

---

**Need more help?** Check the [comprehensive troubleshooting guide](https://github.com/Ghenwy/claude-code-toolkit/wiki/Troubleshooting) or open an issue!