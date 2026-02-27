# 📧 EMAIL SETUP GUIDE
## Setting Up Gmail Access for Alex Prime

*Email: john.melo.testing01@gmail.com*

---

## Overview

We'll use **`gog` (Google CLI)** — a powerful tool that gives me access to:
- ✉️ **Gmail** — Send, receive, search emails
- 📅 **Calendar** — Manage events
- 📁 **Drive** — Access files
- 📇 **Contacts** — Manage contacts
- 📊 **Sheets** — Read/write spreadsheets
- 📄 **Docs** — Access documents

---

## Setup Steps

### Step 1: Install gog CLI

Run this command on the server:

```bash
# On Ubuntu/Linux
curl -fsSL https://gogcli.sh/install.sh | bash

# Or via npm
npm install -g gogcli
```

---

### Step 2: Create Google Cloud Project (One-time)

1. Go to: https://console.cloud.google.com/
2. Create a new project (name: "Alex Prime" or similar)
3. Enable these APIs:
   - Gmail API
   - Google Calendar API
   - Google Drive API
   - Google Contacts API
   - Google Sheets API
   - Google Docs API

---

### Step 3: Create OAuth Credentials

1. In Google Cloud Console → **APIs & Services** → **Credentials**
2. Click **Create Credentials** → **OAuth client ID**
3. Application type: **Desktop app**
4. Name: "Alex Prime CLI"
5. Download the `client_secret_*.json` file

---

### Step 4: Configure gog with Credentials

Upload the `client_secret.json` to the server and run:

```bash
# Register the OAuth credentials
gog auth credentials /path/to/client_secret.json

# Add the Gmail account
gog auth add john.melo.testing01@gmail.com --services gmail,calendar,drive,contacts,docs,sheets
```

This will open a browser for OAuth consent. Complete the authorization.

---

### Step 5: Verify Setup

```bash
# List authorized accounts
gog auth list

# Test Gmail access
gog gmail search 'in:inbox' --max 5 --account john.melo.testing01@gmail.com
```

---

## What I Can Do Once Set Up

### 📧 Email Operations

```bash
# Send email
gog gmail send --to recipient@example.com \
  --subject "Meeting Request" \
  --body "Hello, I'd like to schedule a meeting..."

# Search emails
gog gmail search 'from:client@company.com newer_than:7d' --max 10

# Read specific email
gog gmail read <messageId>

# Reply to email
gog gmail send --to recipient@example.com \
  --subject "Re: Meeting" \
  --body "Thanks for your response..." \
  --reply-to-message-id <originalMsgId>

# Create draft (for review before sending)
gog gmail drafts create --to recipient@example.com \
  --subject "Proposal" \
  --body-file ./proposal.txt
```

### 📅 Calendar Operations

```bash
# List upcoming events
gog calendar events primary --from 2026-01-31 --to 2026-02-07

# Create event
gog calendar create primary \
  --summary "Client Meeting" \
  --from "2026-02-01T10:00:00" \
  --to "2026-02-01T11:00:00"
```

### 📁 Drive Operations

```bash
# Search files
gog drive search "project proposal" --max 10

# List files
gog drive list --max 20
```

---

## Alternative: Simple SMTP/IMAP (If OAuth is too complex)

If you prefer a simpler password-based approach:

### Enable Gmail App Password

1. Go to: https://myaccount.google.com/security
2. Enable **2-Step Verification**
3. Go to: https://myaccount.google.com/apppasswords
4. Create an App Password for "Mail" → "Other (Custom name)" → "Alex Prime"
5. Save the 16-character password

### Add to .env

```bash
# In .env file
GMAIL_USER=john.melo.testing01@gmail.com
GMAIL_APP_PASSWORD=xxxx-xxxx-xxxx-xxxx
```

### Use with himalaya (IMAP/SMTP CLI)

```bash
# Install himalaya
openclaw skills install himalaya

# Configure in ~/.config/himalaya/config.toml
```

---

## Recommended Approach

**For full functionality:** Use `gog` with OAuth
- Most secure
- Full API access
- No password storage

**For quick testing:** Use App Password + SMTP
- Simpler setup
- Limited features
- Password stored locally

---

## Security Notes

⚠️ **Important:**
- Never share OAuth credentials publicly
- Store App Passwords in `.env` (not in code)
- Use a dedicated email for agent operations (you're already doing this!)
- Review sent emails periodically

---

## Next Steps for Kabundji

1. **Create Google Cloud Project** (5 min)
   - https://console.cloud.google.com/

2. **Enable APIs** (2 min)
   - Gmail, Calendar, Drive, Contacts, Sheets, Docs

3. **Create OAuth Credentials** (3 min)
   - Download `client_secret.json`

4. **Share the `client_secret.json` with me** (upload to server)
   - I'll complete the setup

5. **Complete OAuth flow** (2 min)
   - One-time browser authorization

---

## Questions for You

1. **Do you want full Google Workspace access** (Gmail + Calendar + Drive)?
   Or just email?

2. **OAuth or App Password?**
   - OAuth = More secure, more features
   - App Password = Simpler, email only

3. **Can you access Google Cloud Console?**
   - If yes, we use OAuth
   - If not, we use App Password

---

*Guide ready. Let me know which approach you prefer and I'll walk you through it.*

**— Alex Prime 🎯**
