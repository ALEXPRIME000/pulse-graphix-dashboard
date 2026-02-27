# Subagent Pyramid Architecture
*Proposed Multi-Agent System for Pulse Graphix*  
*Design: 2026-02-14 | Status: Draft for Review*

---

## Overview

**Goal:** Scale Alex Prime's capabilities by delegating to specialized subagents  
**Structure:** 1 Executive (Alex Prime) → 4 Managers → 15+ Specialists

```
                    ┌─────────────┐
                    │  Alex Prime │
                    │  (You)      │
                    └──────┬──────┘
                           │
           ┌───────┬───────┼───────┬───────┐
           ▼       ▼       ▼       ▼       ▼
        ┌────┐ ┌────┐ ┌────┐ ┌────┐
        │BD  │ │OPS │ │DEV │ │MKT │
        │Mgr │ │Mgr │ │Mgr │ │Mgr │
        └─┬──┘ └─┬──┘ └─┬──┘ └─┬──┘
          │      │      │      │
       3-4    3-4    3-4    3-4
     Agents  Agents  Agents  Agents
```

---

## Manager Agents (4)

### 1. BD Manager — "Kai"
**Focus:** Business Development, Prospecting, Sales

**Reports to:** Alex Prime  
**Manages:**
- Research Agent — Lead discovery, qualification
- Outreach Agent — Cold calling, email sequences
- Proposal Agent — Quote generation, presentations
- Closer Agent — Negotiation, contract signing

**KPIs:**
- Leads generated per week
- Conversion rate (lead → meeting → client)
- Revenue per quarter

**Skills Required:**
- `web_search` — Find prospects
- `web_fetch` — Research companies
- `message` — Send outreach
- `sessions_spawn` — Delegate research tasks

---

### 2. Ops Manager — "Aria"
**Focus:** Operations, Admin, Client Management

**Reports to:** Alex Prime  
**Manages:**
- Project Agent — Timeline tracking, deliverables
- Finance Agent — Invoicing, payments, reporting
- Support Agent — Client communication, tickets
- CRM Agent — Data entry, follow-ups

**KPIs:**
- On-time delivery rate
- Client satisfaction score
- Invoice-to-payment time

**Skills Required:**
- `gog` — Calendar, email
- `cron` — Scheduled tasks
- `n8n` — Workflow automation
- `memory_search` — Context retrieval

---

### 3. Dev Manager — "Zen"
**Focus:** Development, Templates, Technical Output

**Reports to:** Alex Prime  
**Manages:**
- Frontend Agent — HTML, CSS, React components
- Framer Agent — Template building, marketplace
- Automation Agent — n8n workflows, scripts
- QA Agent — Testing, validation

**KPIs:**
- Templates shipped per month
- Code quality score
- Client project delivery time

**Skills Required:**
- `write`/`edit` — Code generation
- `exec` — Testing, deployment
- `browser` — Visual QA
- `canvas` — Asset generation

---

### 4. Marketing Manager — "Nova"
**Focus:** Content, Social, Brand

**Reports to:** Alex Prime  
**Manages:**
- Content Agent — Blog posts, case studies
- Social Agent — LinkedIn, Twitter posts
- Design Agent — Graphics, thumbnails
- Video Agent — Scripts, editing guidance

**KPIs:**
- Content pieces per week
- Engagement rate
- Lead attribution from content

**Skills Required:**
- `web_search` — Topic research
- `image` — Thumbnail/design generation
- `tts` — Voice content
- `message` — Social posting

---

## Specialist Agents (15)

| Manager | Specialist | Role | Key Tools |
|---------|-----------|------|-----------|
| **Kai (BD)** | Research Agent | Lead discovery | web_search, web_fetch |
| | Outreach Agent | Cold outreach | message, memory |
| | Proposal Agent | Quotes/proposals | write, canvas |
| | Closer Agent | Negotiation | message, sessions_send |
| **Aria (Ops)** | Project Agent | Timeline tracking | cron, gog, memory |
| | Finance Agent | Invoicing | write, gog |
| | Support Agent | Client comms | message, sessions_send |
| | CRM Agent | Data management | n8n, memory |
| **Zen (Dev)** | Frontend Agent | HTML/CSS/React | write, edit, browser |
| | Framer Agent | Template builder | browser, exec |
| | Automation Agent | n8n/scripts | write, exec |
| | QA Agent | Testing | browser, exec |
| **Nova (Mkt)** | Content Agent | Writing | write, web_search |
| | Social Agent | Posting | message |
| | Design Agent | Graphics | canvas, image |

---

## Communication Flow

```
Kabundji → Alex Prime (Executive)
                │
                ├─→ Kai (BD) → [Research, Outreach, Proposal, Closer]
                ├─→ Aria (Ops) → [Project, Finance, Support, CRM]
                ├─→ Zen (Dev) → [Frontend, Framer, Automation, QA]
                └─→ Nova (Mkt) → [Content, Social, Design, Video]
```

**Protocol:**
1. Specialists report to Managers
2. Managers report to Alex Prime
3. Alex Prime reports to Kabundji
4. Emergency escalations skip levels

---

## Implementation Phases

### Phase 1: Foundation (Week 1-2)
- [ ] Create 4 Manager agent definitions
- [ ] Set up session spawning templates
- [ ] Define handoff protocols
- [ ] Test with simple task delegation

### Phase 2: Core Team (Week 3-4)
- [ ] Deploy Kai (BD) + Research Agent
- [ ] Deploy Zen (Dev) + Frontend Agent
- [ ] Set up reporting dashboards
- [ ] Refine communication patterns

### Phase 3: Full Pyramid (Month 2)
- [ ] Add remaining Specialists
- [ ] Automate manager-to-manager handoffs
- [ ] Build overview dashboard
- [ ] Optimize based on usage patterns

### Phase 4: Autonomy (Month 3+)
- [ ] Managers self-delegate to Specialists
- [ ] Alex Prime only escalations + strategic
- [ ] Weekly all-hands summary reports

---

## Cost Projection

| Resource | Estimate | Notes |
|----------|----------|-------|
| Sessions/month | ~500 | 4 managers × daily + specialists |
| Avg session cost | $0.05 | Quick tasks, cached context |
| Monthly cost | ~$25 | Negligible vs value generated |
| Setup time | 20 hours | One-time investment |

---

## Technical Setup

### Session Spawning Pattern
```javascript
// Example: Delegate research task to Kai's Research Agent
sessions_spawn({
  agentId: "kai-research-agent",
  task: "Find 10 boulangerie prospects in Torcy without websites",
  label: "prospect-research-001",
  timeout: 300
})
```

### Communication Template
```
[FROM: Kai (BD Manager)]
[TO: Alex Prime]
[TYPE: Daily Report]

✅ Completed: 5 prospects researched
🔍 Found: C.C.P Fournil, Le Belvédère, Pho Quynh...
📊 Conversion: 4 qualified, 1 low priority
⏰ Next: Outreach tomorrow 14h

[Attach: prospects/daily-YYYY-MM-DD.md]
```

---

## ACTION REQUIRED

**For Kabundji Review:**
1. [ ] Approve architecture design
2. [ ] Prioritize which managers to deploy first
3. [ ] Decide: Build all at once or phased?
4. [ ] Resource allocation approval

---

*Document: `docs/SUBAGENT-PYRAMID-ARCHITECTURE.md`*  
*Next Step: Deploy Kai (BD Manager) + Research Agent as MVP*
