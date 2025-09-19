---
model: sonnet
description: Developer behavior analytics y codebase curiosities con Git patterns, hotspots reales y métricas factibles
argument-hint: [directory] [--git|--files|--deps|--patterns] [--period 1w|1m|3m|6m] [--export md|csv]
allowed-tools: Read, Glob, Grep, Write, Bash
---

# A-Insights - Developer Analytics & Codebase Curiosities

Análisis de patrones de desarrollo y curiosidades del codebase: $ARGUMENTS

## Contexto Automático & Project Detection
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Git repository: !`git rev-parse --is-inside-work-tree 2>/dev/null || echo "No git repo"`
- Stack detection: !`find . -name "package.json" -o -name "requirements.txt" -o -name "pom.xml" -o -name "Cargo.toml" | head -1`
- Standards loading: Load standards/{detected-stack}.yaml || standards/general.yaml as fallback

## 🔍 DEVELOPER BEHAVIOR ANALYTICS

### **1. Git Pattern Analysis (Real Data)**

#### **Working Hours Heatmap**
```bash
# Peak coding hours (real git data)
git log --pretty=format:"%ad" --date=format:"%H" | sort | uniq -c | sort -nr | head -5
```

#### **Developer Activity Matrix**
| Metric | Command | Insight Type |
|--------|---------|--------------|
| **Peak Hours** | `git log --date=format:"%H"` | When team codes most |
| **Commit Frequency** | `git log --since="1 month" --pretty=format:"%an" \| sort \| uniq -c` | Developer activity |
| **Weekend Work** | `git log --date=format:"%a" \| grep -E "Sat\|Sun"` | Work-life balance |
| **Commit Size Patterns** | `git log --stat \| grep "insertions\|deletions"` | Code change patterns |

### **2. Codebase Hotspots (File-Level Analytics)**

#### **Hotspot Detection Matrix**
```bash
# Most modified files (maintenance burden)
git log --name-only --pretty=format: | sort | uniq -c | sort -nr | head -10

# Largest files (complexity indicators)
find . -name "*.js" -o -name "*.py" -o -name "*.java" | xargs wc -l | sort -nr | head -5

# Oldest vs newest files
ls -la --time-style=+%Y-%m-%d | sort -k6
```

#### **Technical Debt Indicators**
| Indicator | Detection Command | Interpretation |
|-----------|-------------------|----------------|
| **TODO/FIXME Count** | `grep -r "TODO\|FIXME\|HACK" . --include="*.ext"` | Postponed work |
| **Large Functions** | `grep -n "function\|def\|public" . \| wc -l` | Potential complexity |
| **Duplicate Code** | `sort file \| uniq -d` | Copy-paste patterns |
| **Comment Density** | Compare total lines vs comment lines | Documentation level |

### **3. Codebase Curiosities Discovery**

#### **Fun Facts Matrix**
| Curiosity | Analysis Method | Example Output |
|-----------|-----------------|----------------|
| **Oldest Code** | `git log --reverse --format="%ai %s" \| head -1` | "2019-03-15: Initial commit" |
| **Busiest File** | `git log --name-only \| grep -v "^$" \| sort \| uniq -c \| sort -nr \| head -1` | "auth.js modified 247 times" |
| **Largest Commit** | `git log --stat \| grep "insertions" \| sort -nr \| head -1` | "2847 insertions in one commit" |
| **Night Owl Commits** | `git log --date=format:"%H" \| grep -E "0[0-5]\|2[2-3]"` | Late night coding sessions |

### **4. Dependency & Import Patterns**

#### **Dependency Analysis Matrix**
```bash
# Most imported modules (JavaScript/TypeScript)
grep -r "import.*from\|require(" . --include="*.js" --include="*.ts" |
  sed 's/.*from.*["'"'"']\([^"'"'"']*\)["'"'"'].*/\1/' | sort | uniq -c | sort -nr | head -10

# Python imports
grep -r "^import\|^from.*import" . --include="*.py" |
  sed 's/.*import \([^ ]*\).*/\1/' | sort | uniq -c | sort -nr | head -10

# External vs internal dependencies
grep -r "import" . | grep -E "\.\/" | wc -l  # Internal
grep -r "import" . | grep -v -E "\.\/" | wc -l  # External
```

#### **Import Insights Matrix**
| Pattern | Detection | Insight |
|---------|-----------|---------|
| **Heavy Importers** | Files with most import statements | Potential coupling issues |
| **External Dependency Ratio** | External vs internal imports | Project self-sufficiency |
| **Unused Imports** | Imported but not referenced | Cleanup opportunities |
| **Deep Import Paths** | Import path length analysis | Architecture complexity |

### **5. Development Pattern Analysis**

#### **Code Quality Patterns**
```bash
# Comment to code ratio (real calculation)
TOTAL_LINES=$(find . -name "*.js" -o -name "*.py" | xargs cat | wc -l 2>/dev/null || echo 0)
COMMENT_LINES=$(grep -r "//\|#\|/\*" . --include="*.js" --include="*.py" | wc -l 2>/dev/null || echo 0)
COMMENT_RATIO=$((COMMENT_LINES * 100 / TOTAL_LINES))

# File size distribution
find . -name "*.js" -o -name "*.py" | xargs wc -l | awk '{print $1}' | sort -n
```

#### **Development Health Matrix**
| Health Metric | Calculation | Good Range | Current Status |
|---------------|-------------|------------|----------------|
| **Avg File Size** | Total lines / file count | 50-200 lines | [Calculated] |
| **Comment Ratio** | Comment lines / total lines | 10-30% | [Calculated] |
| **Function Length** | Lines per function average | 5-20 lines | [Analyzed] |
| **Test Coverage Proxy** | Test files / source files | 50%+ | [Estimated] |

### **6. Git History Insights**

#### **Project Evolution Timeline**
```bash
# Commit activity over time
git log --pretty=format:"%ai" | cut -d- -f1-2 | sort | uniq -c

# Code churn analysis (files changed frequently)
git log --name-only --since="3 months ago" | grep -v "^$" | sort | uniq -c | sort -nr

# Bug fix patterns
git log --oneline | grep -i -E "fix|bug|error|patch" | wc -l
git log --oneline | grep -i -E "feat|add|new" | wc -l
```

#### **Maintenance Patterns Matrix**
| Pattern | Analysis | Insight |
|---------|----------|---------|
| **Fix vs Feature Ratio** | Bug commits / feature commits | Maintenance burden |
| **Refactor Frequency** | Commits with "refactor" keyword | Code health maintenance |
| **File Stability** | Files never/rarely modified | Stable core vs changing areas |
| **Commit Message Quality** | Average commit message length | Documentation discipline |

### **7. Real-Time Analytics Dashboard**

#### **Executive Summary Matrix**
| Metric Category | Key Findings | Action Items |
|-----------------|--------------|--------------|
| **Team Patterns** | [Peak hours, activity distribution] | [Schedule optimization] |
| **Code Health** | [Comment ratio, file sizes, complexity] | [Refactoring priorities] |
| **Maintenance Load** | [Hotspots, technical debt indicators] | [Cleanup opportunities] |
| **Architecture** | [Dependencies, coupling indicators] | [Structure improvements] |

### **8. Curiosities & Fun Facts Report**

#### **Did You Know? Section**
- 🕒 **Peak coding time**: [Most active hour with commit count]
- 📁 **Busiest file**: [File with most modifications]
- 📅 **Project age**: [Days since first commit]
- 🔄 **Most refactored area**: [Directory with most churn]
- 💬 **Chattiest developer**: [Developer with longest commit messages]
- 🌙 **Night owl factor**: [Percentage of commits after 10 PM]

### **DoD (Definition of Done) - Insights Analysis**
- ✅ Git repository analyzed for behavior patterns
- ✅ File-level hotspots and complexity identified
- ✅ Real technical debt metrics calculated
- ✅ Dependency patterns analyzed with actual imports
- ✅ Developer working patterns extracted from git history
- ✅ Curiosities and fun facts generated from real data
- ✅ Executive dashboard with actionable insights
- ✅ All metrics based on actual bash commands and real data

## Usage Examples

```bash
# Complete analytics dashboard
/A-insights . --git --files --deps

# Focus on development patterns only
/A-insights src/ --patterns --period 3m

# Export detailed report
/A-insights . --export md
```

**Core Value**: Real developer behavior analytics and codebase curiosities based on actual git history, file analysis, and factible bash commands. No fantasies, only data-driven insights from your actual project.