# Remotion Skills Guide — Programmatic Video Creation

## What is Remotion?

**Remotion** = React + Video. You write TypeScript/React code → export MP4 videos.

- **Creator:** Jonny Burger (Twitter: @JnyBgr)
- **License:** Free for individuals/small teams (3 people)
- **Pricing:** $25/mo per seat (creators) OR $0.01/render + $100/mo min (automation)
- **Output:** Real MP4 files, not screen recordings

---

## Why Remotion for Pulse Graphix?

| Problem | Old Way | Remotion Way |
|---------|---------|--------------|
| 10 TikToks/week | 5 hours editing | 10 minutes generating |
| Consistent branding | Templates in Canva | Code-based templates |
| A/B testing thumbnails | Manual creation | Change one variable, re-render |
| Multi-language content | Re-edit manually | Change text prop, re-render 10 languages |
| Data-driven videos | Impossible | Feed API data → generate 100 videos |

---

## Core Concepts

### 1. Frames
Videos are 30-60fps. Frame 0 = start, Frame 900 = 15 seconds at 60fps.

### 2. Interpolation
Smooth transitions using `interpolate()`:
```typescript
const opacity = interpolate(frame, [0, 30], [0, 1]); // Fade in over 1 sec
```

### 3. Spring Animation
Physics-based animations:
```typescript
const scale = spring({frame, fps, config: {damping: 12}});
```

### 4. Sequences
Time-based content organization:
```typescript
<Sequence from={0} durationInFrames={60}> // Frames 0-60
  <Intro />
</Sequence>
<Sequence from={60} durationInFrames={90}> // Frames 60-150
  <MainContent />
</Sequence>
```

---

## Template Library (For Your Use)

### Template 1: "3 Tips" Video
**Platform:** TikTok/Reels (1080×1920, 12-15 sec)
**Use case:** Quick tips, listicles, "X things you need to know"
**Code location:** `remotion-templates/VideoTemplate.tsx`

**How to customize:**
```typescript
const TIPS = [
  {emoji: '🐢', text: 'Slow load times', color: '#E74C3C'},
  {emoji: '📱', text: 'Bad mobile UX', color: '#3498DB'},
  {emoji: '🔘', text: 'No clear CTA', color: '#27AE60'},
];
// Change this array → new video in seconds
```

### Template 2: "Quote Card" Video
**Platform:** All platforms
**Use case:** Motivational content, testimonials
**Animation:** Text reveal line-by-line

### Template 3: "Before/After"
**Platform:** LinkedIn, Instagram
**Use case:** Portfolio showcase
**Animation:** Slider reveal

### Template 4: "Number Counter"
**Platform:** LinkedIn
**Use case:** Stats, results, case studies
**Animation:** Numbers count up

### Template 5: "Day in Life"
**Platform:** TikTok/Reels
**Use case:** Behind the scenes, personal brand
**Animation:** Photo slideshow + text overlays

---

## CLI Commands

```bash
# Start development server (preview in browser)
npx remotion studio src/index.ts

# Render video to MP4
npx remotion render src/index.ts VideoTemplate out/video.mp4

# Render specific composition
npx remotion render src/index.ts MyVideo out.mp4 --props='{"title":"Hello"}'

# Render still frame
npx remotion still src/index.ts TitleCard title.png
```

---

## Integration with Your Workflow

### Plan A: Local Development (Start here)
1. Design templates in code
2. Preview in browser
3. Generate videos manually
4. Upload to social platforms

### Plan B: n8n Automation (Scale up)
```
Google Sheet (content) 
  → n8n trigger
    → Remotion render API call
      → Save to Google Drive
        → Buffer/Post to Social
```

### Plan C: Remotion Cloud (Enterprise)
- Use Remotion's Lambda for serverless rendering
- No local setup needed
- Pay per render ($0.01/sec)

---

## Pricing Breakdown

| Plan | Cost | Best For |
|------|------|----------|
| **Free** | $0 | Individuals, testing |
| **Creator** | $25/mo/seat | You making videos for yourself |
| **Automator** | $0.01/render + $100/mo | Building tools for clients |
| **Enterprise** | $500+/mo | Custom contracts |

**Your use case:** Start with Free → Creator ($25/mo) → Automator if building Pulse Graphix video tool

---

## Sample Commands for Your Workflow

```bash
# Generate 10 quote videos from CSV
cat quotes.csv | xargs -I {} npx remotion render src/index.ts QuoteCard "out/{}.mp4" --props="{\"quote\":\"{}\"}"

# Batch render for the week
for tip in tips/*.json; do
  npx remotion render src/index.ts TipsVideo "out/$(basename $tip .json).mp4" --props="$(cat $tip)"
done
```

---

## Resources

- **Docs:** https://www.remotion.dev/docs
- **Examples:** https://github.com/remotion-dev/remotion/tree/main/packages/example
- **Discord:** https://discord.gg/remotion
- **GitHub:** https://github.com/remotion-dev/remotion

---

*Created: February 25, 2026*
*Status: Remotion installed, first template created*
*Next: Build remaining templates, connect to n8n automation*
