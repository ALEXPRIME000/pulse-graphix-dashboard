# LLM Cost Optimization Guide

*Goal: Maximize AI usage while minimizing costs*

---

## 🆓 FREE Options

### 1. OpenRouter Free Models
**URL:** https://openrouter.ai/collections/free-models

Available free models include:
- **Llama 3.3 70B** — Meta's best open model, 128K context
- **GPT-OSS 120B** — OpenAI's open-weight MoE model
- **Mistral models** — Various free tiers
- **Qwen models** — Some free variants

**Setup:** Create account at openrouter.ai, get API key, no credit card needed for free tier.

---

### 2. Groq (Extremely Fast + Free Tier)
**URL:** https://console.groq.com

- **Llama 3.3 70B Versatile** — 128K context, tool use, JSON mode
- **Speed:** 100+ tokens/second (fastest inference available)
- **Free tier:** Yes, with rate limits
- **Paid:** Very cheap when you exceed free tier

**Why use:** Best for quick tasks that need speed over deep reasoning.

---

### 3. GitHub Copilot ($10/month = Unlimited Claude Access!)
**URL:** https://github.com/features/copilot

For $10/month you get:
- Unlimited GPT-5-mini access
- **300 requests/month to Claude Sonnet 4.5**
- Access to premium models
- Can bring your own API key too

**Bonus:** There's a reverse proxy project that exposes Copilot as OpenAI/Anthropic compatible API:
https://github.com/ericc-ch/copilot-api

---

### 4. NVIDIA API Catalog
**URL:** https://build.nvidia.com

- Free trial with **1,000-5,000 credits**
- Various LLMs, vision, speech models
- Good for experimentation

---

### 5. Cloudflare Workers AI
- **10,000 neurons/day FREE**
- Edge deployment
- Fast, lightweight

---

## 💰 CHEAP Options (Best Value)

### 1. Kimi K2 (Moonshot AI) — BEST VALUE
**URL:** https://platform.moonshot.ai

**Pricing:**
- Input: $0.60/million tokens
- Output: $2.50/million tokens
- Cache hits: $0.15/million tokens

**Specs:**
- 1 trillion parameters (32B activated)
- 256K context
- State-of-the-art for coding & reasoning
- OpenAI/Anthropic compatible API

**Even cheaper via DeepInfra:**
- $0.55/$2.20 per million tokens (in/out)

---

### 2. DeepInfra
**URL:** https://deepinfra.com

- Hosts Kimi K2, DeepSeek R1/V3, Llama, etc.
- Pay-per-use, no contracts
- Often cheapest for open-source models

---

### 3. Qwen 3 (Alibaba)
**URL:** https://qwen.ai/apiplatform

- Alibaba's flagship model
- Competitive pricing
- Strong multilingual support
- Available via multiple providers

---

## 🔧 OpenClaw Fallback Setup

Configure OpenClaw to use cheap models for routine tasks, Opus for complex ones:

```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-opus-4-5",
        "fallbacks": [
          "openrouter/meta-llama/llama-3.3-70b-instruct",
          "groq/llama-3.3-70b-versatile"
        ]
      }
    }
  },
  "models": {
    "providers": {
      "openrouter": {
        "baseUrl": "https://openrouter.ai/api/v1",
        "apiKey": "YOUR_OPENROUTER_KEY",
        "models": [
          {"id": "meta-llama/llama-3.3-70b-instruct", "name": "Llama 3.3 70B"}
        ]
      },
      "groq": {
        "baseUrl": "https://api.groq.com/openai/v1",
        "apiKey": "YOUR_GROQ_KEY",
        "models": [
          {"id": "llama-3.3-70b-versatile", "name": "Llama 3.3 70B Groq"}
        ]
      }
    }
  }
}
```

---

## 📊 Cost Comparison (per 1M tokens)

| Provider | Model | Input | Output |
|----------|-------|-------|--------|
| Anthropic | Claude Opus 4.5 | $15 | $75 |
| Anthropic | Claude Sonnet 4.5 | $3 | $15 |
| OpenAI | GPT-4 | $10 | $30 |
| Moonshot | Kimi K2 | $0.60 | $2.50 |
| DeepInfra | Kimi K2 | $0.55 | $2.20 |
| Groq | Llama 3.3 70B | ~$0.60 | ~$0.80 |
| OpenRouter | Llama 3.3 70B | FREE | FREE |

**Opus is ~30x more expensive than Kimi K2!**

---

## 🎯 Recommended Strategy

1. **Complex reasoning/important tasks:** Claude Opus 4.5
2. **Coding/general tasks:** Kimi K2 or Sonnet 4.5
3. **Quick queries/drafts:** Groq Llama (fastest)
4. **Experimentation:** OpenRouter free models

---

## 🔑 API Keys to Get

1. **OpenRouter** (free): https://openrouter.ai/keys
2. **Groq** (free): https://console.groq.com
3. **Moonshot/Kimi** ($1 min): https://platform.moonshot.ai
4. **DeepInfra** (pay-per-use): https://deepinfra.com
5. **GitHub Copilot** ($10/mo): https://github.com/features/copilot

---

*Last Updated: 2026-02-01*
