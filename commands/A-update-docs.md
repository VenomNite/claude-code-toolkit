---
model: claude-sonnet-4-20250514
description: Automatically updates project documentation files (QWEN.md, CLAUDE.md, CHANGELOG.md, AGENTS.md) with latest developments while preserving critical information and intelligent size optimization.
argument-hint: "Usage: /A-update-docs - Automatically updates all project documentation files"
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
keywords: ["documentation", "git context", "smart compactation", "critical preservation", "changelog", "automatic updates"]
category: "documentation-automation"
---

# A-update-docs

Automatically updates project documentation files (QWEN.md, CLAUDE.md, CHANGELOG.md, AGENTS.md) with latest developments while preserving critical information and intelligent size optimization.

## Usage
```
/A-update-docs
```

## Description
Global documentation updater that scans and refreshes project documentation files while maintaining critical information integrity. Features intelligent compactation for oversized documents and works across all projects with smart content preservation.

## Features
- **Git Context Integration**: Analyzes last 3 commits for automatic context recovery and enhanced updates
- **Smart File Detection**: Automatically finds documentation files in project root using relative paths
- **Critical Content Preservation**: Never removes security warnings, production blockers, or critical notes
- **Intelligent Size Management**: 550-line limit with automatic smart compactation for oversized files
- **CHANGELOG Exception**: CHANGELOG.md receives size warning only (never auto-compacted)
- **Smart Compactation**: Uses /think to find optimal compression strategies without losing critical info
- **File Exclusions**: Automatically ignores Claude/ subdirectories except Claude/sessions (sessions MUST be updated)
- **Retry Mechanism**: Attempts to relocate missing files before skipping
- **Cross-Project Compatibility**: Works in any project directory structure

## Target Files
- `QWEN.md` - AI context and recent developments
- `CLAUDE.md` - Claude Code comprehensive guidance
- `AGENTS.md` - Agent-specific guidelines
- `Claude/sessions/*.md` - Session documentation (MUST be updated)

## Excluded Files/Directories
- `.claude/` - Claude Config Manager extension data

## Git Context Integration
- **Auto-detect current branch**: `git rev-parse --abbrev-ref HEAD`
- **Analyze last 3 commits**: `git log -3 --oneline --stat --pretty=format:"%h %s"`
- **Extract development context**: Recent changes, file modifications, commit messages
- **Smart context synthesis**: Understand what's been developed recently
- **Enhanced documentation**: Use git context to write more accurate updates
- **Contextual prioritization**: Recent developments get priority in documentation

## Execution Process
1. **Git Context Discovery**:
   - Detect current branch and repository status
   - Analyze last 3 commits (messages + file changes + stats)
   - Extract recent development patterns and focus areas
   - Identify key changes for documentation updates
2. **File Discovery**: Scans current directory for documentation files (relative paths)
   - Targets: QWEN.md, CLAUDE.md, CHANGELOG.md, AGENTS.md
   - **MUST Include**: Claude/sessions/*.md files (session documentation)
   - **Excludes**: Other Claude/ subdirectories (MemoriaAgentes/, ChangesFixes/, Doc/)
3. **Context-Aware Analysis**: Combines git history with existing docs
4. Reads and analyzes existing content + measures line count
5. Identifies critical sections automatically
6. **Auto-Compactation**: For oversized files (except CHANGELOG.md):
   - Applies /think analysis for optimal compression
   - **Contextual Preservation**: Prioritizes recent developments over old content
   - Preserves all critical information
   - Achieves 550-line compliance intelligently
7. **Smart Documentation Updates**: Uses recent commit context for better accuracy
8. Syncs versions and timestamps across documents

## Safety Features
- Detects critical sections (🚨, ❌, CRITICAL, IMMEDIATE, PRODUCTION BLOCKER)
- Intelligent compactation preserves ALL critical content
- CHANGELOG.md protected from auto-compactation (warning only)
- Uses /think methodology for optimal compression strategies
- Maintains version consistency across documents

## Smart Compactation Process
1. **Size Analysis**: Identifies files exceeding 550-line limit
2. **CHANGELOG Exception**: CHANGELOG.md gets warning only, no compactation
3. **Think Analysis**: Uses /think to analyze best compression approach:
   - Identify redundant content sections
   - Consolidate duplicate information
   - Compress verbose explanations while preserving meaning
   - Move historical/deprecated content to condensed format
4. **Critical Preservation**: NEVER removes critical warnings, production blockers, or security notes
5. **Intelligent Optimization**: Maintains document usefulness while achieving size compliance

## Error Handling
- **Git Repository Detection**: Graceful fallback if not in git repo (skips git context)
- **Commit History**: Handles repos with <3 commits gracefully
- Missing files: Retry search in subdirectories, skip if not found
- Claude/sessions/ files: MUST be processed (never ignored)
- Other Claude/ subdirectories: Automatically ignored (MemoriaAgentes/, ChangesFixes/, Doc/)
- CHANGELOG.md oversized: Warning message only (no auto-compactation)
- Other oversized files: Automatic intelligent compactation with critical preservation
- Permission issues: Clear error messaging and fallback options

## Compactation Strategy Examples
- **Redundant Sections**: Merge similar content blocks
- **Historical Data**: Compress old version info while keeping recent changes detailed
- **Verbose Explanations**: Condense explanations without losing technical accuracy
- **Duplicate Information**: Consolidate repeated information across sections
- **Critical Content**: ALWAYS preserved regardless of size constraints

## Output
- **Git Context Report**: Current branch, last 3 commits analysis, recent development focus
- File status report (found/missing, size, critical content detected)
- **Size Compliance Report**:
  - Files within limit: ✅ Updated normally
  - CHANGELOG.md oversized: ⚠️ Warning displayed (no compactation)
  - Other oversized files: 🔄 Auto-compacted with /think analysis report
- **Contextual Update Summary**: How git context influenced documentation updates
- **Compactation Summary**: Shows compression strategies applied and bytes saved
- **Critical Content Verification**: Confirms all critical sections preserved
- Version sync confirmation across all documents

## Implementation Notes
- **Git-First Approach**: Always starts with git context analysis before documentation updates
- **Relative Path Priority**: Uses `./FILENAME.md` pattern for cross-project compatibility
- **Think-Driven Compactation**: Each oversized file gets custom /think analysis for optimal compression
- **CHANGELOG.md Special Treatment**: Only file exempt from auto-compactation due to historical importance
- **Zero Critical Loss**: Compression algorithms guarantee no loss of critical information
- **Smart Consolidation**: Automatically merges redundant sections while preserving unique content
- **Context-Aware Updates**: Recent commit context drives documentation accuracy and relevance
- **Branch-Aware Processing**: Adapts behavior based on current branch (main/develop/feature)