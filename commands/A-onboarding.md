---
description: Auto-Discovery Onboarding generator que analiza el código actual y genera guía completa sin asumir documentación previa
argument-hint: [--role developer|designer|devops|qa] [--depth quick|standard|comprehensive] [--include-examples]
model: claude-sonnet-4-20250514
allowed-tools: Read, Glob, Grep, Write, Bash
---

# A-Onboarding - Auto-Discovery Onboarding Generator

Generación automática de guía de onboarding desde análisis del proyecto actual: $ARGUMENTS

## Contexto Automático & Project Discovery
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Git status: !`git status --porcelain 2>/dev/null | wc -l` uncommitted changes
- Standards loading: Load standards/{detected-stack}.yaml || standards/general.yaml as fallback

## 🔍 PROJECT AUTO-DISCOVERY

### **1. Technology Stack Detection (Real Analysis)**

#### **Stack Intelligence Matrix**
```bash
# Multi-stack detection (comprehensive)
find . -name "package.json" -o -name "requirements.txt" -o -name "pom.xml" -o -name "Cargo.toml" -o -name "go.mod" -o -name "composer.json"

# Framework detection from dependencies
grep -E "react|vue|angular|express|fastapi|spring|django|rails" package.json requirements.txt pom.xml 2>/dev/null

# Database detection
grep -r "mongodb\|postgresql\|mysql\|redis\|sqlite" . --include="*.json" --include="*.py" --include="*.js" --include="*.java" | head -5
```

#### **Development Tools Detection**
| Tool Category | Detection Command | Purpose |
|---------------|-------------------|---------|
| **Package Manager** | `ls -la \| grep -E "package-lock\|yarn.lock\|Pipfile\|Cargo.lock"` | Dependency management |
| **Linting/Formatting** | `ls -la \| grep -E "eslint\|prettier\|pylint\|black"` | Code quality tools |
| **Testing Framework** | `grep -E "jest\|pytest\|junit\|mocha" package.json requirements.txt pom.xml 2>/dev/null` | Testing setup |
| **Build Tools** | `grep -E "webpack\|vite\|rollup\|gradle\|maven" . -r --include="*.json" --include="*.xml"` | Build configuration |

### **2. Project Structure Auto-Analysis**

#### **Architecture Discovery Matrix**
```bash
# Directory structure mapping
tree -d -L 3 2>/dev/null || find . -type d -maxdepth 3 | grep -v node_modules | sort

# Entry points detection
find . -name "main.*" -o -name "app.*" -o -name "index.*" -o -name "server.*" | grep -E "\.(js|py|go|java|rs|php)$"

# Configuration files discovery
find . -name "*.config.*" -o -name ".env*" -o -name "docker-compose.*" -o -name "Dockerfile"
```

#### **Code Organization Pattern**
| Pattern | Detection Method | Insight |
|---------|------------------|---------|
| **MVC Structure** | `find . -name "*controller*" -o -name "*model*" -o -name "*view*"` | Traditional MVC |
| **Component Architecture** | `find . -name "*component*" -o -path "*/components/*"` | Component-based |
| **Microservices** | `find . -name "docker-compose*" -o -name "*service*"` | Service architecture |
| **Feature Modules** | `find . -path "*/features/*" -o -path "*/modules/*"` | Feature-driven |

### **3. Development Environment Auto-Setup**

#### **Installation Commands Discovery**
```bash
# Node.js setup detection
if [ -f "package.json" ]; then
  echo "Node.js Project Detected"
  jq '.scripts' package.json 2>/dev/null
  jq '.engines' package.json 2>/dev/null
fi

# Python setup detection
if [ -f "requirements.txt" ] || [ -f "setup.py" ]; then
  echo "Python Project Detected"
  python --version 2>/dev/null || python3 --version 2>/dev/null
  grep -E "python_requires|install_requires" setup.py 2>/dev/null
fi

# Java setup detection
if [ -f "pom.xml" ] || [ -f "build.gradle" ]; then
  echo "Java Project Detected"
  grep -E "<java.version>|sourceCompatibility" pom.xml build.gradle 2>/dev/null
fi
```

#### **Environment Setup Matrix**
| Setup Step | Auto-Detection | Command Generation |
|------------|----------------|-------------------|
| **Language Runtime** | Version from config files | Install command for detected version |
| **Package Manager** | Lock files analysis | npm/pip/maven/cargo install commands |
| **Dependencies** | package.json/requirements analysis | Dependency installation steps |
| **Environment Variables** | .env file discovery | Environment configuration guide |

### **4. Existing Documentation Integration**

#### **Documentation Discovery & Analysis**
```bash
# Find all documentation files
find . -name "README*" -o -name "DOCS*" -o -path "*/docs/*" -name "*.md" | head -10

# Extract existing setup instructions
grep -A 10 -i -E "install|setup|getting started|quick start" README.md 2>/dev/null

# API documentation detection
find . -name "*api*" -name "*.md" -o -name "swagger*" -o -name "openapi*"
```

#### **Documentation Integration Matrix**
| Source | Analysis Method | Integration Strategy |
|--------|-----------------|---------------------|
| **README.md** | Parse setup sections | Merge with auto-generated content |
| **docs/ folder** | Scan for getting-started guides | Reference existing documentation |
| **API docs** | Detect endpoints documentation | Include API reference links |
| **Code comments** | Extract setup-related comments | Add developer insights |

### **5. Development Workflow Discovery**

#### **Workflow Commands Auto-Detection**
```bash
# Development scripts discovery (package.json)
jq '.scripts | to_entries[] | select(.key | test("dev|start|serve|run"))' package.json 2>/dev/null

# Testing commands discovery
jq '.scripts | to_entries[] | select(.key | test("test|spec"))' package.json 2>/dev/null

# Build commands discovery
jq '.scripts | to_entries[] | select(.key | test("build|compile|dist"))' package.json 2>/dev/null

# Deployment scripts discovery
ls -la | grep -E "deploy|docker|k8s|terraform"
```

#### **Development Workflow Matrix**
| Workflow Step | Detection Pattern | Generated Instructions |
|---------------|-------------------|----------------------|
| **Local Development** | dev/start/serve scripts | How to run locally |
| **Testing** | test/spec scripts | How to run tests |
| **Building** | build/compile scripts | How to build project |
| **Deployment** | deploy scripts/Docker files | How to deploy |

### **6. Environment & Configuration Analysis**

#### **Configuration Discovery**
```bash
# Environment variables detection
grep -r "process\.env\|os\.environ\|System\.getenv" . --include="*.js" --include="*.py" --include="*.java" | cut -d: -f2 | sort | uniq

# Configuration files analysis
find . -name "config.*" -o -name "settings.*" -o -name ".env*" | xargs ls -la 2>/dev/null

# Database configuration detection
grep -r "database\|db_url\|connection_string" . --include="*.json" --include="*.py" --include="*.js" | head -5
```

### **7. API & Endpoints Discovery**

#### **API Structure Analysis**
```bash
# REST endpoints detection
grep -r "app\.\(get\|post\|put\|delete\)\|@app\.route\|@RestController\|router\." . --include="*.py" --include="*.js" --include="*.java" | head -10

# GraphQL detection
grep -r "graphql\|Query\|Mutation" . --include="*.js" --include="*.py" --include="*.java" | head -5

# WebSocket detection
grep -r "websocket\|socket\.io\|ws://" . --include="*.js" --include="*.py" | head -5
```

### **8. Development Team Insights**

#### **Team Patterns Discovery**
```bash
# Git contributors analysis
git log --pretty=format:"%an" | sort | uniq -c | sort -nr | head -5 2>/dev/null

# Recent activity patterns
git log --since="1 month ago" --pretty=format:"%an %ad" --date=short | head -10 2>/dev/null

# Branching strategy detection
git branch -a 2>/dev/null | grep -E "develop|staging|main|master"
```

### **9. Auto-Generated Onboarding Sections**

#### **Section 1: Project Overview (Auto-Generated)**
- **Purpose**: Extracted from README.md if exists, or inferred from directory structure
- **Technology Stack**: Auto-detected languages, frameworks, databases
- **Architecture**: Inferred from directory patterns and configuration files
- **Key Components**: Main directories and their detected purposes

#### **Section 2: Quick Setup (Commands Ready)**
- **Prerequisites**: Detected from version requirements in config files
- **Installation**: Generated commands based on detected package managers
- **Environment**: Required environment variables from code analysis
- **Verification**: Test commands from package.json/scripts

#### **Section 3: Development Workflow**
- **Local Development**: Auto-detected dev server commands
- **Testing**: Discovered test scripts and frameworks
- **Building**: Build commands from package.json/build configs
- **Code Quality**: Detected linting/formatting tools

#### **Section 4: Project Navigation**
- **Entry Points**: Main files to start exploring
- **API Endpoints**: Discovered routes and their purposes
- **Configuration**: Important config files and their purposes
- **Documentation**: Links to existing docs found in project

### **DoD (Definition of Done) - Auto-Discovery Onboarding**
- ✅ Technology stack auto-detected from actual project files
- ✅ Project structure analyzed and mapped automatically
- ✅ Development environment setup generated from real configurations
- ✅ Existing documentation discovered and integrated
- ✅ Development workflow commands extracted from package.json/scripts
- ✅ Environment variables and configuration requirements identified
- ✅ API endpoints and architecture patterns discovered
- ✅ Team insights and Git patterns analyzed
- ✅ Complete onboarding guide generated without assuming prior documentation
- ✅ All analysis based on actual file inspection and bash commands

## Usage Examples

```bash
# Complete auto-discovery onboarding
/A-onboarding --role developer --depth comprehensive

# Quick setup guide for new team member
/A-onboarding --role developer --depth quick --include-examples

# DevOps-focused onboarding
/A-onboarding --role devops --depth standard
```

**Core Value**: Auto-discovery onboarding that analyzes your actual project structure, extracts real setup commands, integrates existing documentation, and generates comprehensive guides without assuming any prior documentation exists.