# Model Allocation Strategy

*Alex Prime's intelligent model routing for optimal cost/performance*

---

## 🎯 Overview

Different tasks need different models. Here's my allocation strategy:

| Task Type | Primary Model | Fallback | Speed Model |
|-----------|--------------|----------|-------------|
| **Coding/Development** | Claude Opus 4.5 | Kimi K2.5 (NVIDIA) | Groq Llama 3.3 |
| **Research/Analysis** | Claude Opus 4.5 | OpenRouter Llama | Groq |
| **Social Media** | Claude Opus 4.5 | Groq Llama 3.3 | Groq |
| **Quick Chat** | Claude Opus 4.5 | Claude Haiku | Groq |
| **Image Generation** | Flux / DALL-E | - | - |
| **Voice/TTS** | ElevenLabs | OpenAI TTS | - |

---

## 💻 Coding & Development

### Primary: Claude Opus 4.5
- **Why:** Best reasoning, code quality, debugging
- **Cost:** $5/$25 per MTok (input/output)
- **Use for:** Architecture decisions, complex code, refactoring

### Fallback: Kimi K2.5 (NVIDIA)
- **Why:** Free credits, good at code
- **Cost:** Free tier
- **Use for:** When Anthropic budget is tight

### Speed: Groq Llama 3.3 70B
- **Why:** Ultra-fast, free
- **Cost:** Free tier
- **Use for:** Quick code snippets, syntax questions

---

## 🔍 Research & Analysis

### Primary: Claude Opus 4.5
- **Why:** Deep reasoning, nuanced analysis
- **Use for:** Complex research, strategic decisions

### Web Search: Brave API
- **Cost:** Free tier (2000 queries/month, 1/sec rate limit)
- **Use for:** Current information, fact-checking

### Summaries: Claude Sonnet 4.5
- **Cost:** $3/$15 per MTok
- **Use for:** Summarizing large documents (cheaper than Opus)

---

## 📱 Social Media

### Content Creation: Claude Opus 4.5
- **Use for:** Thoughtful posts, strategy

### Quick Posts: Groq Llama 3.3
- **Use for:** Fast replies, simple updates

### Images: Flux / DALL-E 3
- **Use for:** Visual content generation

---

## 💬 Chat & Communication

### Primary: Claude Opus 4.5 (via OpenClaw)
- Main session handler
- WhatsApp/Telegram/Discord

### Quick Reply Mode: Claude Haiku 4.5
- **Cost:** $1/$5 per MTok (5x cheaper than Opus)
- **Use for:** Simple acknowledgments, quick responses

### Voice: ElevenLabs (if configured)
- **Use for:** Audio messages, storytime

---

## 💰 Cost Optimization Rules

1. **Opus for thinking** - Complex tasks, reasoning, coding
2. **Haiku for speed** - Quick responses, simple tasks
3. **Free tiers first** - Groq/NVIDIA for non-critical work
4. **Batch when possible** - 50% off with Anthropic batch API
5. **Cache prompts** - System prompts are cached automatically

---

## 📊 Anthropic Plans Comparison

### Current: API Pay-per-token ($20 credit)
| Model | Input | Output |
|-------|-------|--------|
| Opus 4.5 | $5/MTok | $25/MTok |
| Sonnet 4.5 | $3/MTok | $15/MTok |
| Haiku 4.5 | $1/MTok | $5/MTok |

### Claude Max Plan (NOT API)
- **$100/month:** 5x Pro usage limits (web/app only)
- **$200/month:** 20x Pro usage limits
- ⚠️ This is for claude.ai web, NOT API access
- ⚠️ No "unlimited API" plan exists

### Recommendation for Kabundji
1. Keep current $20/month API approach
2. Use free tier providers (Groq, NVIDIA) for backup
3. Consider Max only if doing heavy claude.ai web usage
4. For true unlimited: Enterprise negotiation needed

---

## 🔄 Fallback Chain

```
Primary: Anthropic Claude Opus 4.5
    ↓ (if rate limited or error)
Fallback 1: Groq Llama 3.3 70B (free, ultra-fast)
    ↓ (if unavailable)
Fallback 2: NVIDIA Kimi K2.5 (free credits)
    ↓ (if unavailable)  
Fallback 3: OpenRouter Llama/Qwen (free tier)
    ↓ (if unavailable)
Fallback 4: Moonshot Kimi K2 (cheap backup)
```

---

## 🎛️ OpenClaw Model Override

You can override my model per-session:
```
/status → See current model
session_status(model="sonnet") → Switch to Sonnet
session_status(model="default") → Reset to Opus
```

---

---

## 📅 Update: February 3, 2026 - Cost Optimization Implemented

### Changes Applied

| Setting | Before | After | Savings |
|---------|--------|-------|---------|
| **Heartbeat Model** | Opus 4.5 | Haiku 4 | ~80% cheaper |
| **Heartbeat Interval** | 10s | 1 hour | 360x fewer calls |
| **Subagent Model** | Opus 4.5 | Kimi K2.5 (free) | ~$100+/month |

### Model Aliases Now Available

- `/status model=opus` → Claude Opus 4.5
- `/status model=sonnet` → Claude Sonnet 4.5
- `/status model=haiku` → Claude Haiku 4
- `/status model=kimi` → Kimi K2.5 (NVIDIA)
- `/status model=groq` → Llama 3.3 70B (Groq)

### Sonnet 5 "Fennec" - Coming Soon?

Leaked info suggests Claude Sonnet 5 may launch today (Feb 3). If confirmed:
- 50% cheaper than Opus 4.5
- May match or exceed Opus performance
- Will add as primary when available

See: `docs/SONNET5-RESEARCH.md` for full analysis.

---

*Last Updated: 2026-02-03*
