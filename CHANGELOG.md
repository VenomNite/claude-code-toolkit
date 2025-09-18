# Changelog

All notable changes to this project will be documented in this file.

## [1.0.3] - 2025-09-18

### Removed
- **A-setupclaude command** 
  - Eliminated from commands directory
  - Updated command count from 18 to 17 across all documentation
  - Cleaned references from README.md, AUTO-INSTALL.md, QUICK-INSTALL.md

### Fixed
- **Context monitor script improvements**
  - Enhanced context-monitor-generic.py with real token data parsing
  - Fixed frozen 65% context display issue
  - Added dynamic token-based percentage calculation
  - Improved accuracy indicators and debugging information
  - Adjusted cost usage display normalization for better visual representation
  - Removed excessive alert messages (COMPACT!, SOON, MONITOR)
  - Optimized progress bars from 8 to 4 segments for compact display
  - Updated separators for cleaner visual presentation
  - Enhanced clock icons differentiation (🕐 vs ⌚)

## [1.0.2] - 2025-09-18

### Fixed
- **Date corrections across all files**
  - Fixed incorrect year 2024 → 2025 in LICENSE copyright
  - Updated research period in M1-technical-research-analyst.md
  - Corrected example date in A-changelog.md
  - Fixed CHANGELOG.md version dates

### Changed
- Reorganized CHANGELOG.md

## [1.0.1] - 2025-09-18

### Fixed
- **README.md visual improvements**
  - Removed broken Mermaid diagrams causing lexical errors
  - Added comprehensive table of contents after presentation
  - Replaced workflow diagram with clean text description
  - Maintained all functionality while improving readability
  - Kept existing command and agent matrices in table format

### Changed
- Simplified workflow presentation from complex diagrams to clear text flow
- Improved document structure and navigation with table of contents

## [1.0.0] - 2025-09-18

### Added
- **Initial release** of Claude Code Toolkit
- **17 automation commands** for comprehensive workflow management
  - `A-plan`: Project planning with gap analysis and adaptive questioning
  - `A-ai-code`: AI agent orchestration and coordination
  - `B-HealthCheck`: Parallel AI tools health monitoring
  - `A-update-docs`: Smart documentation updates with Git context
  - `A-architecture`: System design assistant
  - `A-audit`: Code audit automation
  - `A-changelog`: Changelog generator
  - `A-commit`: Smart commit assistant
  - `A-insights`: Project insights generator
  - `A-onboarding`: Project onboarding automation
  - `A-organize`: Project structure optimizer
  - `A-todo`: Smart todo management
  - `A-workflow`: Workflow orchestrator
  - `B-ultra-think`: Deep thinking assistant with multi-perspective analysis
- **12 specialized M1 agents** for development tasks
  - `M1-qa-gatekeeper`: Zero-tolerance quality assurance
  - `m1-ultrathink-orchestrator`: Multi-AI coordination
  - `M1-general-purpose-agent`: Versatile problem solver
  - `M1-senior-backend-architect`: Backend systems expert
  - `M1-frontend-architect-protocol`: Frontend architecture specialist
  - `M1-senior-documentation-architect`: Technical writing expert
  - `M1-technical-research-analyst`: Technology validation specialist
  - `M1-human-behavior-simulator`: UX testing with behavioral simulation
  - `M1-ux-strategy-protocol`: Design psychology strategist
  - `M1-game-design-architect`: Game development mechanics expert
  - `M1-unity-game-developer`: Unity C# scripting specialist
  - `M1-2d-game-asset-optimizer`: Game assets performance optimizer
- **Advanced status line monitoring** with real-time metrics
- **Automated installation system** supporting both human and AI users
- **Comprehensive documentation** with matrices and usage examples
- **Git context integration** for automated documentation updates
- **Parallel processing capabilities** for AI tools and health checks

### Installation Options
- **Auto-install for Claude Code**: `AUTO-INSTALL.md` with 10-step process
- **Quick install script**: One-line curl installation
- **Manual installation**: Step-by-step setup guide

### Key Features
- **Intelligent Planning**: Gap analysis, adaptive questioning, think hard mode
- **AI Orchestration**: Multi-agent coordination, progress tracking, dependency management
- **Health Monitoring**: Parallel testing, smart diagnostics, performance metrics
- **Quality Assurance**: Zero-tolerance standards, security compliance, performance SLAs

### Documentation
- Professional README.md with table of contents and clean matrices
- Contributing guidelines for community development
- Installation guides for multiple user types
- Usage examples and best practices

---

**Repository**: https://github.com/Ghenwy/claude-code-toolkit
**License**: MIT License