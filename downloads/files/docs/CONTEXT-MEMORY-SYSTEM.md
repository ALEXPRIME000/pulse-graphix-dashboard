# 🧠 CONTEXT & MEMORY MANAGEMENT SYSTEM
## Alex Prime — Intelligent Context Management Protocol

**Created:** February 14, 2026  
**Author:** Alex Prime (designed with Opus 4.6 deep thinking)  
**Purpose:** Prevent context overflow, maintain accuracy, and ensure continuity across sessions  
**Status:** ACTIVE — Follow this protocol every session

---

## The Problem

Context windows have a hard limit. When conversations get long:
- Older messages get compressed or dropped
- Important details get lost in the noise
- Accuracy degrades as context fills with completed/irrelevant data
- Token costs increase unnecessarily
- Agent performance drops

## The Solution: 3-Tier Memory Architecture

### Tier 1: HOT MEMORY (Always in Context)
**Location:** Loaded every session via AGENTS.md directive  
**Max Size:** ~2,000 tokens combined  
**Contains:** Only what's needed RIGHT NOW

| File | Purpose | Max Size | Update Frequency |
|------|---------|----------|-----------------|
| `SOUL.md` | Identity & personality | 500 tokens | Rarely |
| `USER.md` | Who Kabundji is | 800 tokens | Monthly |
| `HEARTBEAT.md` | Current workflow rules | 500 tokens | As needed |
| `IDENTITY.md` | Agent identity | 200 tokens | Rarely |

**Rules:**
- Keep these files LEAN — every word costs tokens
- No completed tasks, no history, no archives
- Only active directives and current identity

### Tier 2: WARM MEMORY (Loaded on Demand)
**Location:** `MEMORY.md` + `memory/YYYY-MM-DD.md`  
**Max Size:** MEMORY.md ≤ 3,000 tokens; daily files ≤ 2,000 tokens each  
**Contains:** Recent context, active projects, key decisions

| File | Purpose | When to Load |
|------|---------|-------------|
| `MEMORY.md` | Curated long-term memory | Main sessions only |
| `memory/today.md` | Today's activity log | Every session |
| `memory/yesterday.md` | Yesterday's context | If needed for continuity |
| `TODO.md` | Active task tracker | On heartbeats |

**Rules:**
- MEMORY.md is curated — NOT a dump of everything
- Use `memory_search` to find specific info instead of loading entire files
- Daily files get archived after 7 days (see Tier 3)

### Tier 3: COLD MEMORY (Searchable Archive)
**Location:** `memory/archive/` + `docs/` + `business/`  
**Max Size:** Unlimited (stored on disk)  
**Contains:** Completed work, historical decisions, reference documents

| Location | Contents |
|----------|----------|
| `memory/archive/YYYY-MM.md` | Monthly summaries (compressed from daily files) |
| `memory/archive/decisions.md` | Key decisions log with dates and reasoning |
| `memory/archive/lessons.md` | Lessons learned (mistakes, insights) |
| `docs/` | Reference documents, guides, research |
| `business/` | Business documents, briefs, strategies |
| `social-media/` | Strategy documents |
| `prospects/` | Lead research |
| `templates/` | Design templates |

**Rules:**
- Never load cold memory into context unless specifically needed
- Use `memory_search` to find relevant snippets
- Summarize before loading — never dump raw files into context

---

## Context Budget Protocol

### Per-Session Token Budget (Target)

```
CATEGORY              | MAX TOKENS | NOTES
──────────────────────┼────────────┼──────────────────────
System Prompt         |   ~3,000   | OpenClaw injects this
Hot Memory (Tier 1)   |   ~2,000   | SOUL + USER + HEARTBEAT + IDENTITY
Warm Memory (Tier 2)  |   ~3,000   | MEMORY.md (only in main sessions)
Conversation History  |  ~50,000   | Managed by OpenClaw compaction
Working Space         |  ~40,000   | For actual task work
──────────────────────┼────────────┼──────────────────────
TOTAL AVAILABLE       | ~100,000   | Varies by model
```

### Rules for Staying Within Budget

1. **Write to files, not inline** — If output > 500 tokens, write to a file and summarize
2. **Don't repeat context** — If info is in a file, reference it, don't paste it
3. **Compress completed work** — Move done tasks from TODO.md to archive
4. **Use memory_search** — Search before loading entire files
5. **Batch tool outputs** — Process results, don't echo them verbatim
6. **Summarize sub-agent results** — Don't paste full transcripts

---

## Daily Memory Maintenance Protocol

### Every Morning (First Heartbeat After 06:00 UTC)
1. Archive yesterday's daily file if > 2,000 tokens:
   - Summarize key events into 500-token version
   - Move original to `memory/archive/raw/YYYY-MM-DD.md`
   - Keep summary as `memory/YYYY-MM-DD.md`
2. Review MEMORY.md — remove anything no longer relevant
3. Create today's daily file: `memory/YYYY-MM-DD.md`

### Weekly (Every Monday)
1. Compress last 7 daily files into weekly summary
2. Update `memory/archive/YYYY-WNN.md` (week number)
3. Review and trim MEMORY.md:
   - Remove completed project details (keep only lessons)
   - Update active project status
   - Remove outdated credentials/links
4. Clean TODO.md — move completed items to archive

### Monthly (First Monday of Month)
1. Create monthly summary: `memory/archive/YYYY-MM.md`
2. Review all warm memory files for relevance
3. Update `memory/archive/decisions.md` with month's key decisions
4. Update `memory/archive/lessons.md` with new insights
5. Audit MEMORY.md — should be < 3,000 tokens

---

## MEMORY.md Structure (Keep This Lean!)

```markdown
# MEMORY.md — Alex Prime Long-Term Memory
*Last Updated: YYYY-MM-DD*

## 🔥 ACTIVE RIGHT NOW (remove when done)
- Current project: [name] — [1-line status]
- Blocked on: [what]
- Next action: [what]

## 👤 Key Context
- [Only things that affect EVERY interaction]
- [Kabundji preferences that matter daily]

## 🏢 Business Quick Reference
- [Company name, key URLs, pricing summary]
- [NOT full briefs — those live in business/ folder]

## 🔑 Credentials & Access
- [Active credentials only]
- [Remove expired/unused]

## 📝 Lessons Learned
- [Only lessons that prevent repeated mistakes]
- [Max 10 items — archive the rest]

## 🔗 Key File Locations
- [Map of where important files live]
- [So we can find them without loading everything]
```

**Target:** MEMORY.md should be readable in 30 seconds. If it takes longer, it's too long.

---

## Smart Context Loading Rules

### Session Start Checklist
```
1. Read SOUL.md ✓ (always)
2. Read USER.md ✓ (always)
3. Read HEARTBEAT.md ✓ (always)
4. Read IDENTITY.md ✓ (always)
5. IF main session → Read MEMORY.md
6. IF heartbeat → Read TODO.md
7. IF specific topic → memory_search for relevant context
8. NEVER load more than 2 reference docs at once
```

### During Conversation
```
- Need old info? → memory_search first, then memory_get specific lines
- Need a file's content? → Read only relevant sections (use offset/limit)
- Creating output? → Write to file if > 500 tokens
- Sub-agent result? → Summarize in 2-3 sentences, reference file location
- Repeating yourself? → Stop. Reference the file instead.
```

### Before Responding
```
- Is my response > 1,000 tokens? → Consider writing to file
- Am I pasting file contents? → Just reference the path
- Am I listing completed tasks? → Summarize count, reference TODO.md
- Am I echoing tool output? → Extract key info only
```

---

## Compaction-Friendly Practices

OpenClaw automatically compacts conversation history when context gets long. To make compaction work better:

1. **Front-load important info** — Key decisions at start of messages
2. **Use clear section headers** — Compaction preserves structure
3. **Don't spread one topic across many messages** — Consolidate
4. **Mark what matters** — Use 🔥 or ⚠️ for critical items
5. **End messages with status** — "Status: X done, Y pending" helps recovery

---

## Emergency Context Recovery

If context gets corrupted or compacted too aggressively:

1. Read `MEMORY.md` — curated essentials
2. Read `TODO.md` — current task status
3. Read `memory/YYYY-MM-DD.md` (today) — what happened today
4. Run `memory_search` for specific topics
5. Check git log for recent commits: `git log --oneline -20`

This should reconstruct 90%+ of needed context in < 5,000 tokens.

---

## File Size Limits (Enforced)

| File | Max Lines | Max Tokens | Action When Exceeded |
|------|-----------|------------|---------------------|
| MEMORY.md | 150 | 3,000 | Archive old sections |
| TODO.md | 120 | 2,500 | Move completed to archive |
| HEARTBEAT.md | 50 | 1,000 | Keep only active rules |
| Daily memory | 100 | 2,000 | Summarize, archive raw |
| SOUL.md | 30 | 500 | Keep minimal |
| USER.md | 80 | 800 | Keep essential only |

---

## Implementation Checklist

- [ ] Create `memory/archive/` directory
- [ ] Create `memory/archive/decisions.md`
- [ ] Create `memory/archive/lessons.md`
- [ ] Trim MEMORY.md to < 150 lines
- [ ] Archive old daily memory files (> 7 days)
- [ ] Update AGENTS.md to reference this system
- [ ] Add weekly maintenance reminder to HEARTBEAT.md

---

*"The goal isn't to remember everything — it's to remember what matters and know where to find the rest."*
