# Email Sequence for Qualified Leads
*Pulse Graphix | 3-Email Automated Follow-Up Sequence*

---

## Email 1: The Intro (Send immediately after cold call/meeting)

**Subject:** Great chatting with you, {FirstName}

```
Hi {FirstName},

Thanks for taking the time to chat with me today!

As promised, I'm sending over a quick overview of how Pulse Graphix helps
businesses like {BusinessName} stand out online — without the agency price tag.

[LINK TO PROPOSAL OR PORTFOLIO]

A few quick wins we discussed:
• {Specific Pain Point 1} → {Quick Solution}
• {Specific Pain Point 2} → {Quick Solution}

I've attached a personalized proposal with 3 options — from a quick refresh to a
full rebrand + website.

Questions? Just reply to this email. I'm here.

Best,
Chicco Mutombo Kabundji
Pulse Graphix
📞 +33 6 12 77 64 98
```

---

## Email 2: The Value Add (Send 3 days later if no response)

**Subject:** Saw this and thought of you, {FirstName}

```
Hi {FirstName},

Quick follow-up — hope things are going well at {BusinessName}!

I wanted to share something that might interest you:

[Relevant case study / industry insight / competitor analysis]

I recently helped a {similar business type} in {location} increase their
{specific metric} by {percentage} with a {solution type}. 

The kicker? It was done in {timeframe} and cost less than {price comparison}.

Worth a 10-minute chat to see if something similar could work for you?

→ Book a quick call: [CALENDLY LINK]

Best,
Chicco
```

---

## Email 3: The Soft Close (Send 7 days later if no response)

**Subject:** Should I close your file, {FirstName}?

```
Hi {FirstName},

I don't want to be that person who keeps emailing when the timing isn't right.

So — should I close your file for now, or is there still interest in:

• {Service discussed 1}
• {Service discussed 2}
• {Service discussed 3}

Totally fine if it's a "not right now." I'll check back in a few months.

If it IS still interesting, just reply with "yes" and I'll send over next steps.

Either way, thanks for your time!

Chicco
Pulse Graphix
```

---

## 🔄 n8n Workflow Setup

### Required Nodes:
1. **Webhook/Trigger** — Triggered manually or via CRM
2. **Delay Node** — Wait 3 days between Email 2
3. **Delay Node** — Wait 7 days between Email 3
4. **Gmail Node** — Send emails with dynamic variables
5. **Condition Node** — Check if email opened/replied (stop sequence if engaged)
6. **Airtable/Notion Node** — Update lead status

### Variables Needed:
- `firstName`
- `businessName`
- `email`
- `painPoint1`
- `painPoint2`
- `servicesDiscussed[]`
- `proposalLink`
- `calendlyLink`

---

## 📊 Expected Results

| Metric | Target |
|--------|--------|
| Open Rate (Email 1) | 65%+ |
| Open Rate (Email 2) | 45%+ |
| Open Rate (Email 3) | 35%+ |
| Reply Rate | 15-25% |
| Unsubscribe Rate | < 2% |

---

*Created: Feb 26, 2026 | Status: Ready for n8n implementation*
