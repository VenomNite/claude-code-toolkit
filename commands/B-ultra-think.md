---
model: claude-sonnet-4-20250514
description: Análisis profundo multi-perspectiva para resolución de problemas complejos con context detection
argument-hint: [problema/pregunta] [--depth surface|deep|complete] [--focus analytical|creative|balanced]
allowed-tools: [Read, Write, Edit, Bash, Glob, Grep]
---

# B-Ultra Think - Deep Analysis Framework

Load standards/{detected-stack}.yaml || standards/general.yaml as fallback for analysis standards.

Análisis sistemático multi-perspectiva para problemas complejos: $ARGUMENTS

## Context Detection
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Stack detection: !`find . -name "package.json" -o -name "requirements.txt" -o -name "pom.xml" -o -name "Cargo.toml" -o -name "*.sln" | head -3`
- Recent activity: !`git log --oneline -5 2>/dev/null || echo "No git history"`

## Analysis Framework

### 1. Problem Decomposition
- Extract core challenge from: $ARGUMENTS
- Identify constraints and dependencies
- Map known variables and unknowns
- Define success criteria

### 2. Multi-Perspective Analysis

#### Technical Perspective
- Implementation feasibility with current stack
- Performance and scalability implications
- Security and maintenance considerations
- Integration complexity

#### Business Perspective
- Cost/benefit analysis
- Timeline and resource requirements
- Risk assessment
- Strategic alignment

#### User Perspective
- Impact on user experience
- Adoption challenges
- Training requirements
- Support implications

#### Standards Perspective
- Compliance with team/industry standards
- Code quality impact
- Long-term maintainability
- Documentation requirements

### 3. Solution Generation

#### Conventional Approach
- Industry best practices
- Framework-specific patterns
- Proven implementations
- Low-risk solutions

#### Creative Approach
- Cross-domain analogies
- Novel combinations
- Unconventional methods
- High-potential solutions

#### Hybrid Approach
- Combining conventional and creative elements
- Phased implementations
- Risk-balanced solutions
- Iterative improvements

### 4. Impact Analysis

#### Immediate Effects
- Direct consequences
- Resource consumption
- Performance impact
- User disruption

#### Secondary Effects
- Team workflow changes
- System interactions
- Maintenance overhead
- Scaling implications

#### Long-term Effects
- Technical debt impact
- Evolution flexibility
- Knowledge transfer
- Strategic positioning

## Structured Output

### Analysis Matrix
| Perspective | Key Finding | Pros | Cons | Risk Level | Effort Required |
|---|---|---|---|---|---|

### Solution Comparison
| Solution | Feasibility | Complexity | Standards Compliance | Recommendation |
|---|---|---|---|---|

### Implementation Plan
| Phase | Activities | Timeline | Resources | Success Metrics |
|---|---|---|---|---|

## Decision Framework

```
## Problem Analysis
- Core Challenge: [Main issue to solve]
- Context: [Technology stack and constraints]
- Success Criteria: [Measurable outcomes]

## Multi-Perspective Insights
- Technical: [Implementation considerations]
- Business: [Cost/benefit analysis]
- User: [Experience impact]
- Standards: [Compliance and quality]

## Solution Options

### Option 1: [Conventional Solution]
- Description: [Clear explanation]
- Pros: [Key advantages]
- Cons: [Main drawbacks]
- Risk: [Assessment]
- Effort: [Required resources]

### Option 2: [Creative Solution]
- Description: [Clear explanation]
- Cross-domain insight: [Analogies or patterns]
- Innovation: [Novel aspects]
- Risk: [Assessment]

### Option 3: [Hybrid Solution]
- Description: [Combined approach]
- Phasing: [Implementation stages]
- Balance: [Risk vs innovation]

## Recommendation
- Preferred Option: [Choice with rationale]
- Implementation: [Concrete next steps]
- Success Metrics: [How to measure success]
- Risk Mitigation: [How to handle potential issues]

## Impact Predictions
- Immediate: [Short-term effects]
- 6 months: [Medium-term outcomes]
- Long-term: [Strategic implications]
```

## Standards Integration

### Analysis Standards
- Apply relevant coding standards from detected stack
- Consider architectural guidelines
- Evaluate against quality metrics
- Balance standards with practical constraints

### Decision Criteria
- Prioritize maintainability and clarity
- Consider team expertise and preferences
- Evaluate long-term sustainability
- Factor in business requirements

## Usage Examples

```bash
# Architectural decision analysis
/B-ultra-think "Should we migrate from REST to GraphQL?" --depth complete

# Performance optimization
/B-ultra-think "Database query optimization strategy" --focus analytical

# Feature design analysis
/B-ultra-think "User authentication flow redesign" --depth deep --focus balanced
```

## DoD (Definition of Done)
- Problem clearly decomposed and understood
- Multi-perspective analysis completed (technical, business, user, standards)
- Multiple solution options generated and evaluated
- Impact analysis covering immediate and long-term effects
- Clear recommendation with implementation plan
- Success metrics and risk mitigation defined
- Standards compliance evaluated and documented