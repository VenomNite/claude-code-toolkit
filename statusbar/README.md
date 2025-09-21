# Status Bar Monitor 📊
### Real-time Claude Code Usage Tracking

> **Advanced status line integration with intelligent plan detection**
>
> Dynamic monitoring system that provides real-time context and cost usage tracking for Claude Code with automatic plan adaptation (Plus/Max x5/Max x20).

[![Python 3.7+](https://img.shields.io/badge/python-3.7+-blue.svg?style=for-the-badge&logo=python)](https://www.python.org/downloads/)
[![Real-time](https://img.shields.io/badge/Monitoring-Real--Time-green?style=for-the-badge)](https://github.com/Ghenwy/claude-code-toolkit)
[![Dynamic Detection](https://img.shields.io/badge/Plan%20Detection-Auto-orange?style=for-the-badge)](https://github.com/Ghenwy/claude-code-toolkit)

---

## ⚡ Overview

The Status Bar Monitor provides **real-time visibility** using **reverse engineering techniques** into your Claude Code usage with **intelligent plan detection** that adapts to your subscription tier automatically (Estimated values).

### Status Line Format
```
📁 project 🌿branch | 🟢 █▁▁▁ ✓43% (86k) | L.R. @ 04:00🕐 C.U. 🟢 ▁▁▁▁ 3% ⌚ 21:12 Sep 2023
```

**Components:**
- **📁 Project**: Current directory and Git branch status
- **🟡 Context**: Usage percentage with confidence indicator
- **L.R. @ time**: Limit Reset time for your session
- **C.U. percentage**: Cost Usage relative to your plan limits

---

## 🎯 Key Features

### **Intelligent Plan Detection**
- **Auto-detects** your Claude subscription (Plus/Max x5/Max x20)
- **Adapts calculations** to your specific token limits
- **95% confidence threshold** for automatic detection
- **Manual override** available for precision control

### **Real-time Monitoring**
- **Context usage** tracking with visual progress bars
- **Session reset** countdown for planning purposes
- **Cost percentage** relative to your plan limits
- **Token count** display for power users

### **Dynamic Adaptation**
- **Plus Plan**: 45K tokens, optimized calculations
- **Max x5 Plan**: 88K tokens, balanced monitoring
- **Max x20 Plan**: 350K tokens, extended tracking

---

## 🔧 Configuration

### **Automatic Mode (Default)**
The system automatically detects your plan by analyzing usage patterns with high confidence scoring.

### **Manual Configuration**
Edit `statusbar-config.yaml` for precise control:

```yaml
# User Plan Detection
user_plan: "max_x5"        # Options: plus | max_x5 | max_x20
detection_mode: "manual"   # Switch from "auto" to "manual"
```

**Available Plans:**
- `plus`: Claude Plus Plan (~45 messages/5h)
- `max_x5`: Claude Max x5 Plan (~225 messages/5h)
- `max_x20`: Claude Max x20 Plan (~900 messages/5h)

---

## 📈 How It Works

The monitor employs **reverse engineering techniques** to estimate usage by:

### **Data Sources (In Priority Order)**
1. **Claude System Messages**: Direct warnings from Claude (100% accurate)
2. **Token Usage Analysis**: Real usage data from transcript files
3. **Session Pattern Recognition**: Frequency and timing analysis
4. **Intelligent Estimation**: Fallback algorithms for missing data

### **Plan Detection Algorithm**
- **Peak Usage Analysis**: Identifies subscription tier from maximum token usage
- **Pattern Recognition**: Analyzes session frequency and timing
- **Confidence Scoring**: Multi-factor validation before auto-detection
- **Fallback Protection**: Defaults to safe estimates when uncertain

---

## ⚠️ Important Disclaimers

### **Accuracy Notice**
- **Estimates Only**: All percentages are intelligent estimates, not official Claude metrics
- **High Accuracy**: Despite sophisticated algorithms, values can deviate from actual usage
- **Confidence Indicators**: ✓ indicates high confidence, ~ indicates estimation
- **Real-time Limitations**: Brief delays possible due to transcript processing

### **Not Official Metrics**
- **Independent Analysis**: Uses publicly available data, not official Claude APIs
- **Best Effort**: Employs advanced techniques but cannot guarantee 100% accuracy
- **Plan Detection**: Automatic detection works well but manual override recommended for critical usage

### **Usage Guidelines**
- **Planning Tool**: Use for general usage awareness and session planning
- **Not Billing**: Do not rely for official billing or quota calculations
- **Verification**: Cross-reference with official Claude usage if precision required

---

## 🔧 Technical Implementation

### **Core Components**
- `context_monitor_generic.py`: Main monitoring engine
- `plan_detector.py`: Intelligent plan detection system
- `statusbar-config.yaml`: Configuration and plan settings
- `test-statusbar.py`: Testing and validation suite

### **Integration**
- **Automatic Setup**: Installed with Claude Code Toolkit
- **Real-time Updates**: Refreshes with each Claude Code interaction
- **Cross-platform**: Linux, macOS, Windows (WSL) compatible

### **Dependencies**
- Python 3.7+ with `yaml` module
- Access to `~/.claude/` transcript files
- Git for repository status (optional)

---

## 🚀 Installation

Automatically installed with [Claude Code Toolkit](https://github.com/Ghenwy/claude-code-toolkit):

```bash
curl -sSL https://raw.githubusercontent.com/Ghenwy/claude-code-toolkit/main/install.sh | bash
```

Manual setup (if needed):
```bash
cp statusbar/*.py ~/.claude/scripts/
cp statusbar/statusbar-config.yaml ~/.claude/scripts/
```

---

## 📖 Troubleshooting

### **Low Detection Confidence**
If auto-detection confidence < 95%, manually set your plan in `statusbar-config.yaml`

### **Incorrect Percentages**
Verify your plan setting matches your actual Claude subscription

### **Missing Status Bar**
Ensure Claude Code status line integration is enabled in your terminal

---

## 🤝 Contributing

Part of the [Claude Code Toolkit](https://github.com/Ghenwy/claude-code-toolkit) project.

**Found an issue?** Report it in the [main repository](https://github.com/Ghenwy/claude-code-toolkit/issues).

---

## 📄 License

MIT License - See [LICENSE](../LICENSE) for details.

---

> **Remember**: This tool provides intelligent estimates based on advanced analysis techniques. While highly accurate, always cross-reference with official Claude metrics for critical usage decisions.