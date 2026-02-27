# Email Sequences — All 4 Companies

**Created:** 2026-02-20 (Overnight session)  
**Status:** Drafts ready for review  
**Path:** `/home/ubuntu/.openclaw/workspace/marketing/email-sequences/`

---

## 📧 What's Included

4 complete 3-email sequences for automated cold outreach:

| Company | Sequence File | Target | CTA Strategy |
|---------|--------------|--------|--------------|
| **Pulse Graphix** | `email-sequence-pulse-graphix.html` | Local businesses (restaurants, salons, shops) | Free 15-min call + free audit |
| **Nexus AI Academy** | `email-sequence-nexus-ai.html` | Companies needing AI team training | AI skills gap assessment + consultation |
| **Invest in Congo** | `email-sequence-invest-congo.html` | Investors interested in DRC | Private briefing + NDA deals |
| **Pulse Architects** | `email-sequence-pulse-architects.html` | Architects needing portfolio + revenue | Portfolio demo + revenue calculator |

---

## 📅 Email Sequence Structure

### Email 1 — Introduction (Day 0)
- **Goal:** Get attention, establish credibility
- **Content:** Problem observation + solution preview + soft CTA
- **Tone:** Helpful, observant, not salesy

### Email 2 — Value/Proof (Day 3-5)
- **Goal:** Build trust, show results
- **Content:** Case study/story + specific numbers + free resource
- **Tone:** Informative, social proof-focused

### Email 3 — Final CTA (Day 7-14)
- **Goal:** Get commitment or permission to stay in touch
- **Content:** Two clear options + graceful exit + newsletter offer
- **Tone:** Respectful, professional, non-pushy

---

## 🎨 Design Features

- **Dark theme:** Matches current UI aesthetic
- **Brand colors:** Each company has its signature palette
- **Responsive:** Works on mobile and desktop
- **Template variables:** `{{first_name}}`, `{{business_name}}`, etc.
- **Unsubscribe:** GDPR-compliant footer on every email

---

## ⚙️ How to Use

1. **Review** the HTML files in-browser (open in Chrome/Firefox)
2. **Customize** the template variables at the top:
   - Replace `{{first_name}}` with actual first name
   - Replace `{{calendar_link}}` with your Calendly/Cal.com URL
   - Replace case study details with real examples
3. **Extract** the HTML for your email platform (remove the preview wrapper)
4. **Test** send to yourself before live deployment
5. **Automate** via n8n, Mailchimp, or similar (set delays between emails)

---

## 🔄 Integration Options

| Platform | How to integrate |
|----------|-----------------|
| **n8n** | HTML node + delay node + Gmail/SendGrid node |
| **Mailchimp** | Import HTML as template, set automation workflow |
| **Brevo** | Create campaign, paste HTML, set trigger rules |
| **HubSpot** | Email template + workflow automation |

---

## 📝 Next Steps (Pending Kabundji Approval)

- [ ] Review tone and messaging
- [ ] Add real case studies (currently placeholders)
- [ ] Replace `{{calendar_link}}` with actual Calendly URLs
- [ ] Set up email automation in n8n or chosen platform
- [ ] Test send sequences to yourself first
- [ ] Launch to prospect lists

---

## 💡 Optional Enhancements

- Add A/B test variants (different subject lines)
- Create plain-text fallback versions
- Add tracking pixel for open/click rates
- Segment by industry (different sequences per sector)
- Add SMS follow-up for non-openers

---

**Ready for review!** Check each HTML file to see the full email preview with styling. 🎯