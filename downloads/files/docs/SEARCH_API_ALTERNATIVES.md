# Search API Alternatives Research
*For Kabundji — February 14, 2026*

## Current Situation
- **Brave Search API**: Free tier = 1 request/second, 2,000 queries/month
- **Status**: Rate limited (hit quota)
- **Need**: Alternative search APIs for prospect research

---

## RECOMMENDED: Google Programmable Search API ⭐

### Free Tier
- **100 queries/day** (3,000/month)
- **$5 per 1,000 queries** after free tier
- **Hard cap**: 10,000 queries/day ($50/day max)

### Pros
- ✅ Google index (largest)
- ✅ JSON API, easy integration
- ✅ Custom search engine setup
- ✅ Region/language filtering
- ✅ Image search available

### Cons
- ❌ Not real Google results (simplified, no knowledge graphs)
- ❌ Smaller result set than real Google
- ❌ May differ from actual Google rankings

### Setup
1. Create Google Cloud account
2. Enable Custom Search JSON API
3. Create Programmable Search Engine
4. Get API key + CX (search engine ID)

### Best For
- Local business prospecting
- General web search automation
- SEO ranking checks

---

## OPTION 2: Bing Search API (Retiring Soon ⚠️)

### Pricing
- **Free**: 1,000 transactions/month
- **Paid**: $15-25 per 1,000 searches

### ⚠️ CRITICAL: Bing retiring API on August 11, 2025
- Microsoft replacing with "Grounding with Bing Search"
- Only works within Azure AI Foundry
- NOT recommended for new projects

---

## OPTION 3: SerpApi (Paid, Best for Real Results)

### Pricing
- **Developer**: $50/month = 5,000 searches
- **$2 per 1,000** at scale (1M+ searches)
- Can do 100M+ searches/month

### Pros
- ✅ Real Google/Bing/Yahoo/Yandex/DuckDuckGo results
- ✅ All search engines (Google, Bing, Yandex, Baidu, etc.)
- ✅ No rate limits like official APIs
- ✅ Knowledge graphs, carousels, all result types
- ✅ Good for SEO tracking

### Cons
- ❌ $50/month minimum
- ❌ Web scraping approach (may break if engines change)

### Best For
- High-volume prospecting
- SEO monitoring
- Real Google results needed

---

## OPTION 4: Tavily AI Search API

### Pricing
- **Free**: 1,000 API calls/month
- **Paid**: Starts at ~$0.01 per search

### Pros
- ✅ AI-optimized results
- ✅ Summarized content
- ✅ Good for research tasks

### Cons
- ❌ Smaller index than Google
- ❌ French locale coverage unknown

---

## OPTION 5: Exa (formerly Metaphor)

### Pricing
- **Free**: 100 searches/month
- **Paid**: $0.015 per search

### Pros
- ✅ Semantic/expert search
- ✅ Good for finding authoritative sources

### Cons
- ❌ Smaller index
- ❌ Expensive for high volume

---

## COMPARISON TABLE

| Provider | Free Tier | Paid Tier | Real Google? | French Results | Best Use |
|----------|-----------|-----------|--------------|----------------|----------|
| **Brave** (current) | 2,000/mo | $3/1K | No (own index) | ✅ Good | Privacy-focused |
| **Google Custom** ⭐ | 3,000/mo | $5/1K | Partial | ✅ Excellent | Best replacement |
| **SerpApi** | None | $2-10/1K | ✅ Yes | ✅ Yes | High volume/SEO |
| **Tavily** | 1,000/mo | ~$0.01/search | AI summarizer | ? | AI research |
| **Exa** | 100/mo | $0.015/search | No (semantic) | ? | Expert search |

---

## RECOMMENDATION

### Immediate Action
1. **Sign up for Google Programmable Search API**
   - 100 free searches/day = enough for prospect research
   - Easy to integrate ($5/1K after free tier)
   - URL: https://programmablesearchengine.google.com/about/

### Long Term
2. **Consider SerpApi** if volume > 5,000/month
   - $50/month for real Google results
   - No rate limits
   - Best for serious prospecting automation

---

## INTEGRATION NOTES

### OpenClaw Config
Currently using `brave` provider. Can switch to:
- `google` (Custom Search API)
- Or use direct HTTP calls to other services

### Contact
Need help with API integration? I can write the config once you have keys.

---

*Research completed: 2026-02-14*  
*Use this for planning which APIs to subscribe to*
