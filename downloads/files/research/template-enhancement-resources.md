# 🎯 Template Enhancement Resources — Deep Analysis
*Compiled: Feb 18, 2026 | For: Pulse Graphix Template System*

---

## 1. SUPAHERO (supahero.io) — Hero Section Library

### What It Is
Curated library of high-quality hero sections from real websites. Now merged with **screensdesign.com** (biggest UX app library). Also sells **Framer templates** directly.

### Key Patterns to Steal
- **Story-driven heroes** — not just tagline + button. Show the product/service value visually in the first fold
- **Split hero layouts** — text left, interactive visual right
- **Video background heroes** — ambient motion, not autoplay with sound
- **Gradient mesh heroes** — soft organic shapes behind bold typography
- **3D element heroes** — floating objects, isometric illustrations

### How to Apply to Our Templates
| Pattern | Implementation | Priority |
|---------|---------------|----------|
| Hero variant library | Build 10+ hero section variants per template | 🔴 HIGH |
| Animated hero backgrounds | Use Unicorn Studio WebGL or CSS animations | 🔴 HIGH |
| Interactive product mockups | Embed rotating/scrolling device frames | 🟡 MED |
| Split-screen layout | 50/50 or 60/40 text-visual splits | 🔴 HIGH |
| Scroll-triggered reveals | Fade-in, slide-up on scroll | 🟡 MED |

---

## 2. BENTO GRIDS (bentogrids.com) — Layout Inspiration

### What It Is
Curated collection of bento-style grid layouts. The trend was popularized by **Apple's product spec videos** (iPhone/Mac events) and Microsoft's Metro design.

### Why Bento Grids Are a Goldmine for Templates
- **Most requested layout style in 2025-2026** — every SaaS, startup, and portfolio wants it
- **Modular by nature** — easy for clients to rearrange
- **Visual hierarchy built-in** — large feature cards + smaller detail cards
- **Works for everything:** features, pricing, team, stats, testimonials

### Key Bento Patterns
| Pattern | Description | Use Case |
|---------|-------------|----------|
| **2:1 Feature Grid** | 1 large card (2 cols) + 2 small cards | Feature highlights |
| **Stats Bento** | Numbers in varying card sizes | Dashboard-style metrics |
| **Image + Text Mix** | Alternating visual/text cards | Portfolio, services |
| **Nested Bento** | Cards within cards | Complex feature pages |
| **Animated Bento** | Cards animate in on scroll, hover effects | Premium SaaS templates |

### How to Apply
```
EVERY Pulse Graphix template should include:
1. At least ONE bento grid section (features or services)
2. CSS Grid with gap: 1rem, varying span sizes
3. Hover state on each card (subtle lift + shadow)
4. Optional: animated counters in stat cards
```

**CSS Framework:**
```css
.bento-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1rem;
}
.bento-card { border-radius: 1.25rem; }
.bento-card--large { grid-column: span 2; grid-row: span 2; }
.bento-card--wide { grid-column: span 2; }
.bento-card--tall { grid-row: span 2; }
```

---

## 3. CTA GALLERY (cta.gallery) — Call-to-Action Patterns

### What It Is
Curated gallery of CTAs sorted by **industry** and **mode** (light/dark). Sponsored by Webestica (Webflow + Bootstrap template creator — competitor to study).

### CTA Patterns That Convert (2026 Trends)
| Pattern | Description | Conversion Impact |
|---------|-------------|-------------------|
| **Benefit-driven text** | "Start growing" not "Sign up" | +20-35% clicks |
| **Dual CTA** | Primary + secondary ("Try free" + "See demo") | +15% engagement |
| **Social proof CTA** | "Join 10,000+ users" near button | +25% trust |
| **Animated CTA** | Subtle pulse, gradient shift on button | +10% attention |
| **Contextual CTA** | Changes based on scroll position/section | +30% relevance |
| **Sticky CTA** | Fixed bottom bar on mobile | +40% mobile conversion |
| **Input + CTA combo** | Email field + "Get started" in one line | Reduces friction |

### How to Apply
```
EVERY template CTA section must include:
1. Benefit-driven button text (never generic "Submit")
2. Supporting micro-copy below button ("No credit card required")
3. Social proof element (avatar stack, user count, logos)
4. At least 2 CTA variants (hero CTA + mid-page CTA + footer CTA)
5. Mobile sticky CTA option
```

---

## 4. MOBBIN (mobbin.com) — UI/UX Pattern Library

### What It Is
Massive searchable database of **1,150+ apps**, **593,700+ screens**, **315,100+ flows** from real iOS, Android & web apps. Features:
- **Flows** — complete user journeys with transitions & animations
- **Prototype mode** — step-by-step interactive walkthroughs
- **Figma plugin** — copy designs directly into Figma
- **Collections** — save & organize inspiration

### Pricing
- **Free tier** — limited browsing
- **Pro** — full access (~$1,000/yr for teams, varies)

### How to Use for Templates
| Use Case | What to Study | Template Application |
|----------|--------------|---------------------|
| **Onboarding flows** | How top apps welcome users | Add onboarding screens to SaaS templates |
| **Dashboard layouts** | Real dashboard patterns from 1000+ apps | Build premium dashboard templates |
| **Settings pages** | Best UX for settings/account | Include settings page in web app templates |
| **Pricing pages** | How successful SaaS present pricing | Create high-converting pricing sections |
| **Empty states** | How apps handle no-data situations | Add empty state designs to templates |
| **Navigation patterns** | Sidebar, top-nav, command palette | Multiple nav options per template |

### Key Insight
Mobbin is your **research tool, not your design tool**. Use it to study what works in production apps, then apply those patterns to templates. The free tier is enough for inspiration browsing.

---

## 5. DRIBBBLE (dribbble.com) — Creative Visuals

### What It Is
The world's biggest design community. 3,500+ SaaS landing page designs alone.

### How to Use Strategically
| Strategy | Action |
|----------|--------|
| **Trend scouting** | Browse "Popular" weekly for emerging styles |
| **Color palette mining** | Screenshot palettes from top shots |
| **Component harvesting** | Study specific elements (cards, headers, footers) |
| **Client convincing** | Show Dribbble shots as style references in proposals |
| **Competitive analysis** | Search "Framer template" or "Webflow template" to see what sells |

### Current Dribbble Trends (2026)
- Glassmorphism 2.0 (frosted glass + subtle grain texture)
- 3D floating elements (product mockups, abstract shapes)
- Dark mode with neon accents (electric blue, cyan, purple)
- Oversized typography (120px+ display fonts)
- Gradient mesh backgrounds
- Claymorphism (soft 3D clay-like UI elements)
- Organic/blob shapes as section dividers

---

## 6. UNICORN STUDIO (unicorn.studio) — WebGL Backgrounds

### What It Is
No-code tool for creating **WebGL effects, motion, and interactivity**. Embeds into Framer, Webflow, or any website. Uses SDK for native code embedding for max performance.

### Why This Is a Game-Changer for Templates
- **Premium differentiator** — animated WebGL backgrounds instantly elevate any template from $49 to $99+
- **No-code** — you don't need Three.js knowledge
- **Embeddable** — works with Framer and Webflow (our target platforms)
- **Performance** — native SDK means no iframe jank

### Effects Available
| Effect Type | Description | Template Use |
|-------------|-------------|-------------|
| **Gradient mesh** | Animated flowing gradients | Hero backgrounds |
| **Particle fields** | Floating dots/connections | Tech/SaaS hero |
| **Noise/grain** | Animated grain texture | Dark mode luxury feel |
| **Blob morph** | Organic shape animations | Creative agency templates |
| **3D scenes** | Rotating objects, depth | Product showcases |
| **Cursor reactive** | Effects follow mouse | Interactive hero sections |

### Pricing to Investigate
Need to check current plans — was mentioned in our template strategy as a key tool.

---

## 🚀 ENHANCEMENT RECOMMENDATIONS

### Tier 1: Immediate Template Upgrades (This Week)

**1. Bento Grid Section Component**
Build a reusable bento grid component with 5 layout variants:
- 2×2 balanced
- Featured (1 large + 3 small)
- Masonry-style (mixed heights)
- Stats dashboard
- Image gallery

**2. Hero Section Library (5 Variants Per Template)**
- Video background hero
- Split screen (text + mockup)
- Centered minimal (gradient + headline)
- Animated gradient mesh (Unicorn Studio)
- Interactive/3D hero

**3. CTA Section Upgrade**
Replace basic CTAs with conversion-optimized patterns:
- Add social proof near every CTA button
- Dual CTA (primary + ghost button)
- Sticky mobile CTA bar
- Benefit-driven copy defaults

### Tier 2: Premium Template Differentiators (Next 2 Weeks)

**4. Unicorn Studio Integration**
- Create 5 reusable WebGL backgrounds
- Package as "premium backgrounds" included with templates
- This alone justifies premium pricing ($79-99 vs $49)

**5. Micro-Animation System**
Build a consistent animation library:
- Scroll reveal (fade-up, fade-in, slide-left/right)
- Hover states (lift, glow, scale)
- Loading/transition animations
- Counter animations for stats sections
- Staggered grid animations (cards appear one by one)

**6. Mobbin-Inspired Flow Pages**
Add these pages to every SaaS template:
- Onboarding wizard (3-step)
- Settings/account page
- Empty states
- 404 page (branded)
- Pricing comparison table

### Tier 3: Competitive Moat (Month 2-3)

**7. "Sections Library" Product**
Instead of selling complete templates, sell a **sections library**:
- 50+ sections (heroes, features, CTAs, pricing, testimonials, FAQs, footers)
- Mix-and-match in Framer/Webflow
- Price: $149-199 for the full library
- Recurring updates ($99/yr)

**8. Industry-Specific Template Packs**
Based on Mobbin research, create specialized packs:
- Restaurant/Food ($79)
- SaaS/Startup ($99)
- Agency/Portfolio ($89)
- E-commerce ($99)
- Personal Brand ($69)

---

## 📊 COMPETITIVE EDGE SUMMARY

| What Most Template Sellers Do | What We Should Do |
|-------------------------------|-------------------|
| Static hero section | 5 hero variants + WebGL option |
| Basic CSS grid | Bento grid system with animations |
| Generic "Sign Up" CTA | Conversion-optimized dual CTAs with social proof |
| No animations | Micro-animation system (scroll, hover, load) |
| One layout per template | Modular sections library approach |
| Screenshots as previews | Interactive Framer previews |
| No dark mode | Light + dark mode included |
| Single industry | Industry-specific customization notes |

---

## 🔧 SKILLS WE ALREADY HAVE

| Skill | Relevance | Status |
|-------|-----------|--------|
| `canvas-design` | Visual art, poster design | ✅ Installed |
| `typography` | Type scales, font pairing | ✅ Installed |
| `web-typography` | Web font loading, responsive type | ✅ Installed |
| `icon-design` | Lucide/Heroicons/Phosphor selection | ✅ Installed |
| `favicon-gen` | Favicon for template branding | ✅ Installed |
| `shadcn-ui` | Component patterns, Tailwind | ✅ Installed |
| `ui-design-system` | Design system architecture | ✅ Installed |
| `color-palette` | WCAG accessible palettes | ✅ Installed |
| `happy-hues` | Curated color schemes | ✅ Installed |
| `frontend-design` | Modern UI guidelines | ✅ Installed |
| `html-to-pdf` | Export proposals as PDF | ✅ Installed |

### Skills We Could Use (Not Installed)
| Need | Solution |
|------|----------|
| WebGL/Three.js animations | Unicorn Studio (no-code) or custom Three.js |
| Framer-specific patterns | Need Framer skill or documentation |
| GSAP animations | Could build or find a skill |
| Webflow integration | Need Webflow skill |

---

## 🎯 NEXT STEPS

1. **Build bento grid component** — reusable CSS Grid + Tailwind
2. **Create 5 hero variants** — one for each style
3. **Set up Unicorn Studio account** — test WebGL backgrounds
4. **Study top 10 Framer templates on marketplace** — reverse-engineer what sells
5. **Build micro-animation CSS library** — scroll reveals, hover states
6. **Create a "sections library" prototype** — test modular approach

---

*Save this file. Reference when building any new template.*
