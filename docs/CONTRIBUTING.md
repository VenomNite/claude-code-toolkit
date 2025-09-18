# Contributing to Claude Code Toolkit

We welcome contributions from the Claude Code community! This guide will help you get started.

## 🤝 How to Contribute

### 1. Fork the Repository
```bash
git clone https://github.com/Ghenwy/claude-code-toolkit.git
cd claude-code-toolkit
```

### 2. Create a Feature Branch
```bash
git checkout -b feature/your-awesome-feature
```

### 3. Make Your Changes
- Add new commands in `/commands/`
- Add new agents in `/agents/`
- Update documentation as needed

### 4. Test Your Changes
```bash
# Test commands locally
cp commands/your-command.md ~/.claude/commands/
/your-command "test"

# Test agents
cp agents/your-agent.md ~/.claude/agents/
```

### 5. Submit a Pull Request
```bash
git add .
git commit -m "Add awesome new feature"
git push origin feature/your-awesome-feature
```

## 📋 Contribution Guidelines

### Commands
- Use clear, descriptive names (A-prefix for automation, B-prefix for batch operations)
- Include comprehensive documentation with examples
- Follow the standard command structure
- Test thoroughly before submitting

### Agents
- Follow the simplified agent protocol
- Include clear specialization descriptions
- Provide usage examples in the description
- Ensure no personal/sensitive references

### Documentation
- Update README.md if adding significant features
- Include installation instructions for new components
- Provide clear usage examples
- Use consistent formatting

## 🔧 Development Standards

### File Structure
```
commands/
  A-command-name.md     # Automation commands
  B-command-name.md     # Batch/utility commands

agents/
  M1-agent-name.md      # Specialized agents

scripts/
  utility-script.py     # Helper scripts

docs/
  documentation.md      # Additional documentation
```

### Code Quality
- ✅ No hardcoded personal paths
- ✅ Generic, reusable configuration
- ✅ Clear documentation and examples
- ✅ Consistent formatting
- ✅ Error handling where appropriate

### Testing
- Test commands with various inputs
- Verify agents work correctly
- Check for any personal data leaks
- Ensure cross-platform compatibility

## 🚀 Ideas for Contributions

### New Commands
- Project scaffolding automation
- Code analysis and metrics
- Deployment automation
- Testing utilities

### New Agents
- Language-specific specialists
- Framework experts (React, Vue, Angular, etc.)
- DevOps and infrastructure agents
- Security and compliance specialists

### Improvements
- Enhanced error handling
- Better progress tracking
- Integration with more tools
- Performance optimizations

## ❌ What Not to Include

- Personal configuration files
- Hardcoded paths or credentials
- Proprietary or company-specific logic
- Large dependencies without clear benefit

## 📝 Pull Request Template

When submitting a PR, please include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New command
- [ ] New agent
- [ ] Bug fix
- [ ] Documentation update
- [ ] Enhancement

## Testing
- [ ] Tested locally
- [ ] No personal data included
- [ ] Documentation updated
- [ ] Examples provided

## Checklist
- [ ] Code follows project style
- [ ] Self-review completed
- [ ] No breaking changes
- [ ] Backwards compatible
```

## 🐛 Reporting Issues

### Bug Reports
- Use clear, descriptive titles
- Provide steps to reproduce
- Include error messages
- Specify your environment (OS, Claude Code version)

### Feature Requests
- Describe the use case
- Explain the expected behavior
- Consider implementation complexity
- Provide examples if possible

## 💬 Community

- Be respectful and constructive
- Help others learn and improve
- Share knowledge and best practices
- Follow the code of conduct

## 🎯 Recognition

Contributors will be:
- Listed in the project README
- Credited in release notes
- Invited to collaborate on future features

Thank you for helping make Claude Code Toolkit better for everyone! 🚀