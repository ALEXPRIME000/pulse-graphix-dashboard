# GLM-5 Research — Adding to Our LLM Stack
*Date: 2026-02-13 | Released: Feb 11, 2026 (2 days ago!)*

---

## 🔥 What is GLM-5?

**GLM-5** is Zhipu AI's (Z.ai) new flagship open-source LLM.

| Spec | Value |
|------|-------|
| **Parameters** | 744B total (40B active — MoE architecture) |
| **Context** | 128K tokens |
| **License** | MIT (fully open-source, commercial use!) |
| **Released** | February 11, 2026 |
| **Beats** | GPT-5.2 on BrowseComp, Vending Bench 2 & Terminal-Bench |
| **Competes with** | Claude Opus 4.5, GPT-5.2, Gemini 3.0 Pro |
| **Specialty** | Complex systems engineering, long-horizon agentic tasks |

---

## 💰 Pricing (Z.ai Direct API)

| Model | Input (per 1M tokens) | Output (per 1M tokens) | Notes |
|-------|----------------------|------------------------|-------|
| **GLM-5** | $1.00 | $3.20 | Flagship |
| **GLM-5-Code** | $1.20 | $5.00 | Coding specialist |
| **GLM-4.7** | $0.60 | $2.20 | Previous gen |
| **GLM-4.7-Flash** | **FREE** | **FREE** | Fast, free forever |
| **GLM-4.5-Flash** | **FREE** | **FREE** | Free forever |
| **GLM-4.5-Air** | $0.20 | $1.10 | Lightweight |

**Cached input is limited-time FREE for all paid models!**

---

## 🆓 FREE Access Options

### 1. Z.ai Direct (Free Trial Credits)
- **URL:** https://z.ai
- **API:** https://api.z.ai/api/paas/v4/chat/completions
- **Free credits for new users** on signup
- **GLM-4.7-Flash & GLM-4.5-Flash = permanently FREE**
- Coding plan from $10/mo (supports Claude Code, OpenClaw)

### 2. OpenRouter
- **URL:** https://openrouter.ai/z-ai/glm-5
- Already on OpenRouter — we have an OpenRouter account!
- Can add to our fallback chain immediately

### 3. Puter.js (Unlimited, No API Key)
- **URL:** https://developer.puter.com/tutorials/free-unlimited-zai-glm-api/
- Free unlimited access via Puter.js SDK
- "User-Pays" model — each user covers costs
- Works for web apps

### 4. Ollama (Self-hosted, FREE)
- Download weights from HuggingFace: https://huggingface.co/zai-org/GLM-5
- Run locally with Ollama
- Completely free, no API limits
- Requires significant GPU (744B model)

### 5. Modal (Free Trial)
- **URL:** https://modal.com/blog/try-glm-5
- Free trial available

---

## 🔧 How to Add GLM-5 to OpenClaw

### Option A: Via OpenRouter (Easiest)
We already have OpenRouter configured. GLM-5 is available at:
- Model ID: `z-ai/glm-5`
- Provider: `openrouter`
- Full path: `openrouter/z-ai/glm-5`

**To add:** Update OpenClaw config to include `openrouter/z-ai/glm-5` as a fallback model.

### Option B: Z.ai Direct API
1. Sign up at https://z.ai
2. Get API key
3. Add to OpenClaw config as custom provider:
   - Base URL: `https://api.z.ai/api/paas/v4`
   - OpenAI-compatible API format
   - Model: `glm-5`

### Option C: Free Flash Models
For cost optimization, add the FREE models:
- `openrouter/z-ai/glm-4.7-flash` (FREE!)
- `openrouter/z-ai/glm-4.5-flash` (FREE!)

---

## 📊 Comparison with Our Current Models

| Model | Input Cost | Output Cost | Quality | Speed |
|-------|-----------|-------------|---------|-------|
| Claude Opus 4.6 | $15.00 | $75.00 | ⭐⭐⭐⭐⭐ | Slow |
| **GLM-5** | **$1.00** | **$3.20** | ⭐⭐⭐⭐ | Medium |
| Groq Llama 3.3 | Free | Free | ⭐⭐⭐ | Ultra-fast |
| **GLM-4.7-Flash** | **FREE** | **FREE** | ⭐⭐⭐⭐ | Fast |
| NVIDIA Kimi K2.5 | Free credits | Free credits | ⭐⭐⭐⭐ | Medium |

**GLM-5 is 15x cheaper than Claude Opus for input, 23x cheaper for output!**

---

## 🎯 Recommendation

1. **Immediately add GLM-4.7-Flash (FREE)** to our fallback chain via OpenRouter
2. **Add GLM-5** via OpenRouter for high-quality tasks at 15x lower cost
3. **Sign up at Z.ai** for direct API access + free trial credits
4. **Updated fallback chain:** Opus → GLM-5 → Groq → GLM-4.7-Flash → NVIDIA → OpenRouter

---

*This model could save us significant costs while maintaining quality for coding and agentic tasks.*
