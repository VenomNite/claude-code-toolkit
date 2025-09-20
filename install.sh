#!/bin/bash

# Claude Code Toolkit - Dual-Scope Installation Script
# Version: 2.2.0 - Agent Enhancement Initiative Complete
# Supports both user (~/.claude/) and global (/usr/local/share/claude/) installation

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# ============================================================================
# CONFIGURATION & VARIABLES
# ============================================================================

# Version and metadata
readonly VERSION="2.2.0"
readonly SCRIPT_NAME="$(basename "$0")"
readonly TOOLKIT_NAME="Claude Code Toolkit"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# Installation scopes
readonly USER_CLAUDE_DIR="$HOME/.claude"
readonly GLOBAL_CLAUDE_DIR="/usr/local/share/claude"

# Default configuration
INSTALL_SCOPE="user"  # Default to user installation
VERBOSE=false
DRY_RUN=false
FORCE_INSTALL=false

# Runtime variables
CLAUDE_DIR=""
BACKUP_DIR=""
REQUIRES_SUDO=false

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

print_header() {
    echo -e "${BLUE}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              Claude Code Toolkit Installer v${VERSION}               ║"
    echo "║                    Dual-Scope Architecture                   ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
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

print_verbose() {
    if [[ "$VERBOSE" == true ]]; then
        echo -e "${BLUE}🔍 [VERBOSE] $1${NC}"
    fi
}

print_usage() {
    cat << EOF
${BOLD}${TOOLKIT_NAME} Installer v${VERSION}${NC}

${BOLD}USAGE:${NC}
    $SCRIPT_NAME [OPTIONS]

${BOLD}OPTIONS:${NC}
    --user              Install in user scope (~/.claude/) [DEFAULT]
    --global            Install in global scope (/usr/local/share/claude/)
    --help, -h          Show this help message
    --version, -v       Show version information
    --verbose           Enable verbose output
    --dry-run           Show what would be done without executing
    --force             Force installation even if files exist
    --verify            Verify existing installation
    --uninstall         Uninstall (respects scope)

${BOLD}EXAMPLES:${NC}
    $SCRIPT_NAME                    # Install for current user
    $SCRIPT_NAME --global           # Install globally (requires sudo)
    $SCRIPT_NAME --verify --verbose # Verify installation with details
    sudo $SCRIPT_NAME --global      # Explicit sudo for global install

${BOLD}SCOPES:${NC}
    User scope:   ~/.claude/
                 • Personal installation
                 • No admin privileges required
                 • Overrides global installation

    Global scope: /usr/local/share/claude/
                 • System-wide installation
                 • Requires admin privileges (sudo)
                 • Fallback for all users

${BOLD}PRECEDENCE:${NC}
    Claude Code searches: User → Global → Built-in defaults

EOF
}

print_version() {
    echo "${TOOLKIT_NAME} Installer v${VERSION}"
    echo "Dual-scope installation system"
}

# ============================================================================
# SYSTEM DETECTION & VALIDATION
# ============================================================================

detect_system() {
    print_verbose "Detecting system configuration..."

    # Detect OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        print_verbose "Operating System: Linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        print_verbose "Operating System: macOS"
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        print_verbose "Operating System: Windows (WSL/Cygwin)"
    else
        print_warning "Unknown operating system: $OSTYPE"
    fi

    # Check if running in WSL
    if grep -qi microsoft /proc/version 2>/dev/null; then
        print_verbose "Environment: Windows Subsystem for Linux"
    fi
}

check_permissions() {
    print_verbose "Checking permissions for scope: $INSTALL_SCOPE"

    if [[ "$INSTALL_SCOPE" == "global" ]]; then
        # Check if we can write to global directory
        if [[ $EUID -eq 0 ]]; then
            print_verbose "Running as root - global installation permitted"
            REQUIRES_SUDO=false
        elif mkdir -p "$GLOBAL_CLAUDE_DIR" 2>/dev/null && [[ -w "$GLOBAL_CLAUDE_DIR" ]]; then
            print_verbose "Global directory writable without sudo"
            REQUIRES_SUDO=false
        else
            print_verbose "Global installation requires sudo"
            REQUIRES_SUDO=true

            # Check if sudo is available
            if ! command -v sudo &> /dev/null; then
                print_error "Global installation requires sudo, but sudo is not available"
                print_info "Try: $SCRIPT_NAME --user  # for user-only installation"
                return 1
            fi

            # Test sudo access
            if ! sudo -n true 2>/dev/null; then
                print_error "Global installation requires sudo privileges"
                print_info "Please run: sudo $SCRIPT_NAME --global"
                print_info "Or try:     $SCRIPT_NAME --user  # for user-only installation"
                return 1
            fi
        fi
    else
        # User scope - check home directory access
        if [[ ! -w "$HOME" ]]; then
            print_error "Cannot write to home directory: $HOME"
            return 1
        fi
        print_verbose "User directory access confirmed"
    fi

    return 0
}

check_dependencies() {
    print_info "Checking system dependencies..."
    local missing_deps=()

    # Check Python 3.7+
    if command -v python3 &> /dev/null; then
        local python_version
        python_version=$(python3 --version 2>&1 | cut -d' ' -f2)
        local python_major=$(echo "$python_version" | cut -d. -f1)
        local python_minor=$(echo "$python_version" | cut -d. -f2)

        if [[ $python_major -eq 3 && $python_minor -ge 7 ]] || [[ $python_major -gt 3 ]]; then
            print_success "Python $python_version found"
        else
            print_error "Python 3.7+ required, found: $python_version"
            missing_deps+=("python3>=3.7")
        fi
    else
        print_error "Python 3 not found"
        missing_deps+=("python3")
    fi

    # Check Git (optional but recommended)
    if command -v git &> /dev/null; then
        print_success "Git found"
    else
        print_warning "Git not found - some features may be limited"
    fi

    # Check pip3
    if command -v pip3 &> /dev/null; then
        print_success "pip3 found"
    else
        print_warning "pip3 not found - Python dependencies may fail"
        missing_deps+=("python3-pip")
    fi

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        print_info "Please install missing dependencies and try again"
        return 1
    fi

    return 0
}

# ============================================================================
# INSTALLATION LOGIC
# ============================================================================

setup_directories() {
    print_info "Setting up installation directories..."

    # Set CLAUDE_DIR based on scope
    if [[ "$INSTALL_SCOPE" == "global" ]]; then
        CLAUDE_DIR="$GLOBAL_CLAUDE_DIR"
        BACKUP_DIR="$CLAUDE_DIR/backup_$(date +%Y%m%d_%H%M%S)"
    else
        CLAUDE_DIR="$USER_CLAUDE_DIR"
        BACKUP_DIR="$CLAUDE_DIR/backup_$(date +%Y%m%d_%H%M%S)"
    fi

    print_verbose "Installation directory: $CLAUDE_DIR"
    print_verbose "Backup directory: $BACKUP_DIR"

    # Create directories with appropriate permissions
    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would create: $CLAUDE_DIR/{commands,agents,scripts,config}"
        return 0
    fi

    if [[ "$INSTALL_SCOPE" == "global" && "$REQUIRES_SUDO" == true ]]; then
        sudo mkdir -p "$CLAUDE_DIR"/{commands,agents,scripts,config}
        sudo chown -R root:root "$CLAUDE_DIR"
        sudo chmod -R 755 "$CLAUDE_DIR"
    else
        mkdir -p "$CLAUDE_DIR"/{commands,agents,scripts,config}
    fi

    print_success "Directories created successfully"
}

install_python_dependencies() {
    print_info "Installing Python dependencies..."

    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would install: psutil"
        return 0
    fi

    local pip_cmd="pip3 install --user"

    if [[ -f "requirements.txt" ]]; then
        print_verbose "Installing from requirements.txt"
        if $pip_cmd -r requirements.txt; then
            print_success "Python dependencies installed from requirements.txt"
        else
            print_warning "Failed to install from requirements.txt, trying individual packages"
            $pip_cmd psutil
        fi
    else
        print_verbose "Installing basic dependencies manually"
        $pip_cmd psutil
    fi

    # Verify installation
    if python3 -c "import psutil" 2>/dev/null; then
        print_success "Python dependencies verified"
    else
        print_error "Python dependency verification failed"
        return 1
    fi
}

backup_existing() {
    print_info "Creating backup of existing installation..."

    local has_existing=false

    # Check for existing files
    if [[ -d "$CLAUDE_DIR/commands" ]] && [[ -n "$(ls -A "$CLAUDE_DIR/commands" 2>/dev/null)" ]]; then
        has_existing=true
    fi
    if [[ -d "$CLAUDE_DIR/agents" ]] && [[ -n "$(ls -A "$CLAUDE_DIR/agents" 2>/dev/null)" ]]; then
        has_existing=true
    fi

    if [[ "$has_existing" == false ]]; then
        print_info "No existing installation found, skipping backup"
        return 0
    fi

    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would create backup at: $BACKUP_DIR"
        return 0
    fi

    # Create backup directory
    if [[ "$INSTALL_SCOPE" == "global" && "$REQUIRES_SUDO" == true ]]; then
        sudo mkdir -p "$BACKUP_DIR"
        [[ -d "$CLAUDE_DIR/commands" ]] && sudo cp -r "$CLAUDE_DIR/commands" "$BACKUP_DIR/"
        [[ -d "$CLAUDE_DIR/agents" ]] && sudo cp -r "$CLAUDE_DIR/agents" "$BACKUP_DIR/"
        [[ -d "$CLAUDE_DIR/scripts" ]] && sudo cp -r "$CLAUDE_DIR/scripts" "$BACKUP_DIR/"
        [[ -d "$CLAUDE_DIR/config" ]] && sudo cp -r "$CLAUDE_DIR/config" "$BACKUP_DIR/"
    else
        mkdir -p "$BACKUP_DIR"
        [[ -d "$CLAUDE_DIR/commands" ]] && cp -r "$CLAUDE_DIR/commands" "$BACKUP_DIR/"
        [[ -d "$CLAUDE_DIR/agents" ]] && cp -r "$CLAUDE_DIR/agents" "$BACKUP_DIR/"
        [[ -d "$CLAUDE_DIR/scripts" ]] && cp -r "$CLAUDE_DIR/scripts" "$BACKUP_DIR/"
        [[ -d "$CLAUDE_DIR/config" ]] && cp -r "$CLAUDE_DIR/config" "$BACKUP_DIR/"
    fi

    print_success "Backup created: $BACKUP_DIR"
}

install_commands() {
    print_info "Installing commands..."

    if [[ ! -d "commands" ]]; then
        print_error "Commands directory not found in current location"
        print_info "Please run this script from the claude-code-toolkit directory"
        return 1
    fi

    local command_count
    command_count=$(ls commands/*.md 2>/dev/null | wc -l)

    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would install $command_count commands to: $CLAUDE_DIR/commands/"
        return 0
    fi

    if [[ "$INSTALL_SCOPE" == "global" && "$REQUIRES_SUDO" == true ]]; then
        sudo cp commands/*.md "$CLAUDE_DIR/commands/" 2>/dev/null || true
        sudo chmod 644 "$CLAUDE_DIR/commands"/*.md
    else
        cp commands/*.md "$CLAUDE_DIR/commands/" 2>/dev/null || true
    fi

    print_success "$command_count commands installed"
}

install_agents() {
    print_info "Installing agents..."

    if [[ ! -d "agents" ]]; then
        print_error "Agents directory not found in current location"
        return 1
    fi

    local agent_count
    agent_count=$(ls agents/*.md 2>/dev/null | wc -l)

    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would install $agent_count agents to: $CLAUDE_DIR/agents/"
        return 0
    fi

    if [[ "$INSTALL_SCOPE" == "global" && "$REQUIRES_SUDO" == true ]]; then
        sudo cp agents/*.md "$CLAUDE_DIR/agents/" 2>/dev/null || true
        sudo chmod 644 "$CLAUDE_DIR/agents"/*.md
    else
        cp agents/*.md "$CLAUDE_DIR/agents/" 2>/dev/null || true
    fi

    print_success "$agent_count agents installed"
}

install_scripts() {
    print_info "Installing monitoring scripts..."

    if [[ ! -d "statusbar" ]]; then
        print_warning "Statusbar directory not found, skipping"
        return 0
    fi

    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would install scripts to: $CLAUDE_DIR/scripts/"
        return 0
    fi

    if [[ "$INSTALL_SCOPE" == "global" && "$REQUIRES_SUDO" == true ]]; then
        sudo cp statusbar/*.py "$CLAUDE_DIR/scripts/" 2>/dev/null || true
        sudo chmod 755 "$CLAUDE_DIR/scripts"/*.py
    else
        cp statusbar/*.py "$CLAUDE_DIR/scripts/" 2>/dev/null || true
        chmod +x "$CLAUDE_DIR/scripts"/*.py 2>/dev/null || true
    fi

    print_success "Scripts installed"
}

configure_settings() {
    print_info "Configuring settings..."

    local settings_file
    if [[ "$INSTALL_SCOPE" == "global" ]]; then
        settings_file="$CLAUDE_DIR/config/global-settings.json"
    else
        settings_file="$CLAUDE_DIR/settings.json"
    fi

    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would configure: $settings_file"
        return 0
    fi

    local script_path
    if [[ "$INSTALL_SCOPE" == "global" ]]; then
        script_path="$CLAUDE_DIR/scripts/context_monitor_generic.py"
    else
        script_path="~/.claude/scripts/context_monitor_generic.py"
    fi

    # Create settings content
    local settings_content
    settings_content=$(cat << EOF
{
  "statusLine": {
    "type": "command",
    "command": "python3 $script_path"
  },
  "installation": {
    "scope": "$INSTALL_SCOPE",
    "version": "$VERSION",
    "installed_at": "$(date -Iseconds)",
    "installer": "claude-code-toolkit"
  }
}
EOF
)

    if [[ "$INSTALL_SCOPE" == "global" && "$REQUIRES_SUDO" == true ]]; then
        echo "$settings_content" | sudo tee "$settings_file" > /dev/null
        sudo chmod 644 "$settings_file"
    else
        echo "$settings_content" > "$settings_file"
    fi

    print_success "Settings configured: $settings_file"
}

# ============================================================================
# VERIFICATION & VALIDATION
# ============================================================================

verify_installation() {
    print_info "Verifying installation..."

    local commands_count=0
    local agents_count=0
    local scripts_count=0
    local errors=()

    # Count installed files
    if [[ -d "$CLAUDE_DIR/commands" ]]; then
        commands_count=$(ls "$CLAUDE_DIR/commands"/*.md 2>/dev/null | wc -l)
    fi
    if [[ -d "$CLAUDE_DIR/agents" ]]; then
        agents_count=$(ls "$CLAUDE_DIR/agents"/*.md 2>/dev/null | wc -l)
    fi
    if [[ -d "$CLAUDE_DIR/scripts" ]]; then
        scripts_count=$(ls "$CLAUDE_DIR/scripts"/*.py 2>/dev/null | wc -l)
    fi

    # Verify expected counts
    if [[ $commands_count -ne 16 ]]; then
        errors+=("Expected 16 commands, found $commands_count")
    fi
    if [[ $agents_count -ne 10 ]]; then
        errors+=("Expected 10 agents, found $agents_count")
    fi
    if [[ $scripts_count -eq 0 ]]; then
        errors+=("No monitoring scripts found")
    fi

    # Verify key files
    local key_files=(
        "commands/A-plan.md"
        "commands/A-ai-code.md"
        "agents/M1-qa-gatekeeper.md"
        "agents/m1-ultrathink-orchestrator.md"
        "scripts/context_monitor_generic.py"
    )

    for file in "${key_files[@]}"; do
        if [[ ! -f "$CLAUDE_DIR/$file" ]]; then
            errors+=("Missing key file: $file")
        fi
    done

    # Report results
    if [[ ${#errors[@]} -eq 0 ]]; then
        print_success "Installation verification passed!"
        echo
        print_info "Installation Summary:"
        echo "  📂 Scope: $INSTALL_SCOPE"
        echo "  📁 Location: $CLAUDE_DIR"
        echo "  📋 Commands: $commands_count/16"
        echo "  🤖 Agents: $agents_count/10"
        echo "  📄 Scripts: $scripts_count"

        if [[ -d "$BACKUP_DIR" ]]; then
            echo "  💾 Backup: $BACKUP_DIR"
        fi

        return 0
    else
        print_error "Installation verification failed:"
        for error in "${errors[@]}"; do
            echo "    • $error"
        done
        return 1
    fi
}

# ============================================================================
# UNINSTALL LOGIC
# ============================================================================

uninstall() {
    print_info "Uninstalling Claude Code Toolkit..."
    print_warning "This will remove all installed files in $INSTALL_SCOPE scope"

    # Determine target directory
    if [[ "$INSTALL_SCOPE" == "global" ]]; then
        CLAUDE_DIR="$GLOBAL_CLAUDE_DIR"
    else
        CLAUDE_DIR="$USER_CLAUDE_DIR"
    fi

    if [[ ! -d "$CLAUDE_DIR" ]]; then
        print_info "No installation found in $INSTALL_SCOPE scope"
        return 0
    fi

    # Confirm uninstallation
    if [[ "$FORCE_INSTALL" == false ]]; then
        echo -n "Are you sure you want to uninstall? [y/N] "
        read -r confirmation
        if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
            print_info "Uninstallation cancelled"
            return 0
        fi
    fi

    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would remove: $CLAUDE_DIR"
        return 0
    fi

    # Remove installation
    if [[ "$INSTALL_SCOPE" == "global" && $EUID -ne 0 ]]; then
        if command -v sudo &> /dev/null; then
            sudo rm -rf "$CLAUDE_DIR"
        else
            print_error "Global uninstall requires sudo, but sudo is not available"
            return 1
        fi
    else
        rm -rf "$CLAUDE_DIR"
    fi

    print_success "Claude Code Toolkit uninstalled from $INSTALL_SCOPE scope"
}

# ============================================================================
# ARGUMENT PARSING
# ============================================================================

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --user)
                INSTALL_SCOPE="user"
                shift
                ;;
            --global)
                INSTALL_SCOPE="global"
                shift
                ;;
            --help|-h)
                print_usage
                exit 0
                ;;
            --version|-v)
                print_version
                exit 0
                ;;
            --verbose)
                VERBOSE=true
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --force)
                FORCE_INSTALL=true
                shift
                ;;
            --verify)
                # Set up directory based on scope
                if [[ "$INSTALL_SCOPE" == "global" ]]; then
                    CLAUDE_DIR="$GLOBAL_CLAUDE_DIR"
                else
                    CLAUDE_DIR="$USER_CLAUDE_DIR"
                fi
                verify_installation
                exit $?
                ;;
            --uninstall)
                uninstall
                exit $?
                ;;
            *)
                print_error "Unknown option: $1"
                print_info "Use --help for usage information"
                exit 1
                ;;
        esac
    done
}

# ============================================================================
# MAIN INSTALLATION PROCESS
# ============================================================================

main() {
    # Parse command line arguments
    parse_arguments "$@"

    # Print header
    print_header

    if [[ "$DRY_RUN" == true ]]; then
        print_warning "DRY RUN MODE - No changes will be made"
        echo
    fi

    print_info "Installation scope: $INSTALL_SCOPE"
    print_verbose "Verbose mode enabled"

    # Pre-flight checks
    if [[ ! -f "README.md" ]] || [[ ! -d "commands" ]]; then
        print_error "Please run this script from the claude-code-toolkit directory"
        print_info "Current directory: $(pwd)"
        exit 1
    fi

    # System detection and validation
    detect_system
    check_dependencies || exit 1
    check_permissions || exit 1

    # Installation process
    setup_directories || exit 1
    install_python_dependencies || exit 1
    backup_existing || exit 1
    install_commands || exit 1
    install_agents || exit 1
    install_scripts || exit 1
    configure_settings || exit 1

    # Final verification
    verify_installation || exit 1

    # Success message
    echo
    print_success "🎉 Claude Code Toolkit installation complete!"

    if [[ "$DRY_RUN" == false ]]; then
        echo
        print_info "Next steps:"
        echo "  1. Restart Claude Code to activate new features"
        echo "  2. Test installation: /A-plan \"test project\""
        echo "  3. Explore commands: Use the installed toolkit commands"

        if [[ "$INSTALL_SCOPE" == "user" ]]; then
            echo "  4. Consider global install: sudo $SCRIPT_NAME --global"
        fi
    fi
}

# ============================================================================
# ERROR HANDLING & CLEANUP
# ============================================================================

# Set up error handling
trap 'echo -e "\n${RED}❌ Installation failed at line $LINENO${NC}" >&2' ERR

# Run main function with all arguments
main "$@"