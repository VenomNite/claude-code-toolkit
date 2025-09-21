# Quick Tests ⚡ (Ultra-Fast, Low Token)

🔧 **ENVIRONMENT REQUIREMENT:**
Execute commands within Claude Code environment, not bash/terminal.

🚨 **CRITICAL - MANDATORY CLEANUP** 🚨
**AFTER COMPLETING TESTS:**
1. **REPORT RESULTS:** "✅ 16/16 Pass" or "❌ X/16 Failed: [list]"
2. **EXPLAIN FAILURES:** What failed and how to fix it
3. **CLEAN EVERYTHING:** Delete created files CRITICAL, revert changes made by test.
4. **RESET CHECKBOXES:** Leave document in original empty state

**Time: 5 minutes TOTAL for all 16 tests | Context: Minimal**

## A-Commands (10 tests)

### A-ai-code
**Run:** `/A-ai-code --assist "add button"`
**Check:** Code suggestions appear
**Pass:** ☐

### A-architecture
**Run:** `/A-architecture --c4`
**Check:** Diagram generated
**Pass:** ☐

### A-audit
**Run:** `/A-audit src/`
**Check:** Audit report with matrices
**Pass:** ☐

### A-changelog
**Run:** `/A-changelog`
**Check:** Changelog entries appear
**Pass:** ☐

### A-commit
**Run:** `/A-commit "test message"`
**Check:** Commit created
**Pass:** ☐

### A-insights
**Run:** `/A-insights --dashboard`
**Check:** Metrics dashboard shown
**Pass:** ☐

### A-onboarding
**Run:** `/A-onboarding --developer`
**Check:** Onboarding guide created
**Pass:** ☐

### A-organize
**Run:** `/A-organize --scan`
**Check:** Organization plan shown
**Pass:** ☐

### A-plan
**Run:** `/A-plan "test app"`
**Check:** 3 files created
**Pass:** ☐

### A-todo
**Run:** `/A-todo`
**Check:** Todo list created
**Pass:** ☐

### A-update-docs
**Run:** `/A-update-docs`
**Check:** Documentation updated
**Pass:** ☐


## B-Commands (5 tests)

### B-create-feature
**Run:** `/B-create-feature "test-feature"`
**Check:** Scaffolding generated
**Pass:** ☐

### B-debug-error
**Run:** `/B-debug-error "undefined variable"`
**Check:** Debug analysis appears
**Pass:** ☐

### B-explain-code
**Run:** `/B-explain-code "function test(){}"`
**Check:** Code explanation with diagrams
**Pass:** ☐

### B-HealthCheck
**Run:** `/B-HealthCheck`
**Check:** All tools show green ✅
**Pass:** ☐

### B-ultra-think
**Run:** `/B-ultra-think "simple problem"`
**Check:** Multi-perspective analysis
**Pass:** ☐

---

## Overall Result
**Passed:** ___/16
**Status:** ☐ All Good ☐ Issues Found

**🎯 16/16 Pass = Toolkit Perfect | <14/16 = Check Failed Tests**