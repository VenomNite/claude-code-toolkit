#!/bin/bash

# Claude Code Toolkit - Automatic Installation Script
# Version: 1.0

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$CLAUDE_DIR/backup_$(date +%Y%m%d_%H%M%S)"

# Functions
print_header() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║            Claude Code Toolkit Installer            ║"
    echo "║                    Version 1.0                      ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

check_dependencies() {
    print_info "Checking dependencies..."

    # Check Python
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
        print_success "Python 3 found: $PYTHON_VERSION"
    else
        print_error "Python 3 is required but not found"
        exit 1
    fi

    # Check Git
    if command -v git &> /dev/null; then
        print_success "Git found"
    else
        print_warning "Git not found - some features may be limited"
    fi

    # Check Claude Code directory
    if [ -d "$CLAUDE_DIR" ]; then
        print_success "Claude Code directory found: $CLAUDE_DIR"
    else
        print_info "Creating Claude Code directory: $CLAUDE_DIR"
        mkdir -p "$CLAUDE_DIR"/{commands,agents,scripts}
    fi
}

install_python_dependencies() {
    print_info "Installing Python dependencies..."

    if [ -f "requirements.txt" ]; then
        pip3 install --user -r requirements.txt
        print_success "Python dependencies installed"
    else
        print_warning "requirements.txt not found, installing basic dependencies"
        pip3 install --user psutil python-dateutil
    fi
}

backup_existing() {
    if [ -d "$CLAUDE_DIR/commands" ] || [ -d "$CLAUDE_DIR/agents" ]; then
        print_info "Creating backup of existing files..."
        mkdir -p "$BACKUP_DIR"

        if [ -d "$CLAUDE_DIR/commands" ]; then
            cp -r "$CLAUDE_DIR/commands" "$BACKUP_DIR/"
        fi

        if [ -d "$CLAUDE_DIR/agents" ]; then
            cp -r "$CLAUDE_DIR/agents" "$BACKUP_DIR/"
        fi

        if [ -d "$CLAUDE_DIR/scripts" ]; then
            cp -r "$CLAUDE_DIR/scripts" "$BACKUP_DIR/"
        fi

        print_success "Backup created: $BACKUP_DIR"
    fi
}

install_commands() {
    print_info "Installing commands..."
    mkdir -p "$CLAUDE_DIR/commands"

    if [ -d "commands" ]; then
        cp commands/*.md "$CLAUDE_DIR/commands/" 2>/dev/null || true
        COMMANDS_INSTALLED=$(ls commands/*.md 2>/dev/null | wc -l)
        print_success "$COMMANDS_INSTALLED commands installed"
    else
        print_warning "Commands directory not found"
    fi
}

install_agents() {
    print_info "Installing agents..."
    mkdir -p "$CLAUDE_DIR/agents"

    if [ -d "agents" ]; then
        cp agents/*.md "$CLAUDE_DIR/agents/" 2>/dev/null || true
        AGENTS_INSTALLED=$(ls agents/*.md 2>/dev/null | wc -l)
        print_success "$AGENTS_INSTALLED agents installed"
    else
        print_warning "Agents directory not found"
    fi
}

install_scripts() {
    print_info "Installing scripts..."
    mkdir -p "$CLAUDE_DIR/scripts"

    if [ -d "scripts" ]; then
        cp scripts/*.py "$CLAUDE_DIR/scripts/" 2>/dev/null || true
        chmod +x "$CLAUDE_DIR/scripts"/*.py 2>/dev/null || true
        print_success "Scripts installed"
    else
        print_warning "Scripts directory not found"
    fi
}

configure_status_line() {
    print_info "Configuring status line..."

    SETTINGS_FILE="$CLAUDE_DIR/settings.json"

    if [ -f "$SETTINGS_FILE" ]; then
        print_info "Existing settings.json found"
        if ! grep -q "statusLine" "$SETTINGS_FILE"; then
            print_info "Adding statusLine configuration..."
            # Add statusLine config to existing settings
            python3 -c "
import json
with open('$SETTINGS_FILE', 'r') as f:
    settings = json.load(f)
settings['statusLine'] = {
    'type': 'command',
    'command': 'python3 ~/.claude/scripts/context-monitor-generic.py'
}
with open('$SETTINGS_FILE', 'w') as f:
    json.dump(settings, f, indent=2)
"
            print_success "Status line configuration added"
        else
            print_info "Status line already configured"
        fi
    else
        print_info "Creating new settings.json..."
        cat > "$SETTINGS_FILE" << EOF
{
  "statusLine": {
    "type": "command",
    "command": "python3 ~/.claude/scripts/context-monitor-generic.py"
  }
}
EOF
        print_success "Settings.json created with status line configuration"
    fi
}

verify_installation() {
    print_info "Verifying installation..."

    COMMANDS_COUNT=$(ls "$CLAUDE_DIR/commands"/*.md 2>/dev/null | wc -l)
    AGENTS_COUNT=$(ls "$CLAUDE_DIR/agents"/*.md 2>/dev/null | wc -l)

    print_success "Installation completed!"
    echo
    print_info "Summary:"
    echo "  📋 Commands installed: $COMMANDS_COUNT"
    echo "  🤖 Agents installed: $AGENTS_COUNT"
    echo "  📊 Status line: Configured"
    echo "  📁 Installation directory: $CLAUDE_DIR"

    if [ -d "$BACKUP_DIR" ]; then
        echo "  💾 Backup created: $BACKUP_DIR"
    fi

    echo
    print_info "Test your installation:"
    echo "  /A-plan \"test project\""
    echo "  /B-HealthCheck --fast"
    echo "  /A-ai-code --help"
}

print_troubleshooting() {
    echo
    print_info "Troubleshooting:"
    echo "  • Permission errors: Run 'chmod +x ~/.claude/commands/*.md ~/.claude/agents/*.md'"
    echo "  • Python errors: Run 'pip3 install --user -r requirements.txt'"
    echo "  • Status line issues: Check ~/.claude/settings.json"
    echo "  • Backup restore: Copy files from $BACKUP_DIR if needed"
    echo
    print_info "For more help, see: docs/INSTALLATION.md"
}

# Main installation process
main() {
    print_header

    # Check if we're in the right directory
    if [ ! -f "README.md" ] || [ ! -d "commands" ]; then
        print_error "Please run this script from the claude-code-toolkit directory"
        exit 1
    fi

    check_dependencies
    install_python_dependencies
    backup_existing
    install_commands
    install_agents
    install_scripts
    configure_status_line
    verify_installation
    print_troubleshooting

    echo
    print_success "🎉 Claude Code Toolkit installation complete!"
    print_info "Restart Claude Code to activate the new features."
}

# Run main function
main "$@"