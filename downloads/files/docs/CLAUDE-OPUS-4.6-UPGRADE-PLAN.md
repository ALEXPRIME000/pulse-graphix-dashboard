# Claude Opus 4.6 Upgrade Plan
## Upgrading Alex Prime's Brain to the Latest Model

*Created: February 6, 2026*
*Author: Alex Prime*

---

## 🧠 What's New in Claude Opus 4.6

**Released:** February 5, 2026 (yesterday!)

### Key Improvements:

| Feature | Description |
|---------|-------------|
| **1 Million Token Context** | 4x larger than previous (was 256K) — can handle entire codebases |
| **Agent Teams** | Multiple agents working in parallel on different parts of a task |
| **Better Coding** | Improved software development capabilities |
| **PowerPoint Integration** | Direct integration with Microsoft Office |
| **Enterprise Focus** | Designed for knowledge workers, not just developers |

### Pricing (Unchanged):
- **Input:** $5 per 1 million tokens
- **Output:** $25 per 1 million tokens
- **Extended context (>200K):** $10/$37.50 per million tokens

---

## 🎯 Why Upgrade?

### Benefits for Alex Prime:

1. **Longer Memory per Session**
   - 1M tokens = ~750,000 words of context
   - Can read entire projects without forgetting earlier parts

2. **Agent Teams Feature**
   - Can spawn sub-agents that work in parallel
   - Faster completion of complex tasks
   - Better overnight work capability

3. **Better Coding**
   - Improved code generation
   - Better understanding of large codebases
   - More accurate debugging

4. **Same Price**
   - No cost increase from Opus 4.5
   - Same $20/month Anthropic plan works

---

## 📊 Plan Options

### Option A: Stay on Current Plan ($20/month)
- ✅ Get Opus 4.6 automatically (just model name change)
- ✅ No action needed from you
- ⚠️ Limited usage (same token limits)

### Option B: Upgrade to Max Plan ($100/month)
- ✅ 5x more usage
- ✅ Priority access to new features
- ✅ Agent teams preview access
- ✅ Better for heavy overnight work
- ⚠️ Higher cost

### Option C: API Direct ($5/$25 per million tokens)
- ✅ Pay only for what you use
- ✅ No monthly cap
- ✅ Full access to all features
- ⚠️ Can get expensive with heavy use
- ⚠️ Need to manage billing

---

## 🛠️ How to Upgrade

### Step 1: Update OpenClaw (if needed)
```bash
curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard
```

### Step 2: Change Model in Config

**Option A — Via OpenClaw CLI:**
```bash
# View current config
openclaw gateway config.get

# The model should auto-update if using "anthropic/claude-opus-4"
# If pinned to specific version, update manually
```

**Option B — Edit Config Directly:**
```bash
nano ~/.openclaw/openclaw.json
```

Find the models section and change:
```json
"default": "anthropic/claude-opus-4-6"
```

### Step 3: Restart Gateway
```bash
openclaw gateway restart
```

### Step 4: Verify
```bash
openclaw status
# Should show: model=anthropic/claude-opus-4-6
```

---

## 💰 Cost Comparison

| Plan | Monthly Cost | Best For |
|------|--------------|----------|
| Current (Anthropic $20) | $20 | Light usage, testing |
| Max Plan | $100 | Heavy daily use, overnight work |
| API Direct | Variable (~$50-200) | Predictable heavy workloads |

### Estimated Usage (Alex Prime):
- ~500K tokens/day average
- ~15M tokens/month
- **API cost:** ~$75-100/month (input) + ~$375-500/month (output)
- **Recommendation:** Max Plan ($100) is better value for consistent use

---

## 🚀 Upgrade Steps Summary

1. **Immediate (Free):**
   - Update OpenClaw to get Opus 4.6 support
   - Model may auto-switch or need config change

2. **If Upgrading Plan:**
   - Go to: https://console.anthropic.com
   - Upgrade to Max plan
   - Update API key if needed

3. **After Upgrade:**
   - Test with complex task
   - Monitor token usage
   - Verify agent teams work (if on API/Max)

---

## ⚠️ Important Notes

- Opus 4.6 is **backward compatible** — all existing prompts work
- Agent teams requires API access or Max plan (preview)
- 1M context is opt-in (uses more tokens = more cost)
- Your personality files (SOUL.md, etc.) are NOT affected

---

## 🔮 Recommendation

**For Kabundji's Use Case:**

Given that you want Alex Prime to:
- Work overnight autonomously
- Handle complex multi-step tasks
- Be more productive

**Recommended:** Upgrade to **Max Plan ($100/month)** when ready.

This gives:
- Full Opus 4.6 access
- Agent teams preview
- 5x usage headroom
- Priority support

**Timeline:**
1. Week 1: Test Opus 4.6 on current plan
2. Week 2: Evaluate if usage hits limits
3. Week 3: Upgrade to Max if needed

---

*Questions? Ask Alex Prime or check https://docs.anthropic.com*
