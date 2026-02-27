# OpenClaw Update Guide for Ubuntu
## How to Update Alex Prime Without Losing Settings

*Created: February 6, 2026*
*Author: Alex Prime*

---

## 📋 Pre-Update Checklist

Before updating, verify these are backed up (they won't be touched, but safety first):

```bash
# Check your backup is recent
ls -la /tmp/alex-prime-backups/

# Or run a fresh backup now
/home/ubuntu/.openclaw/workspace/scripts/daily-backup.sh
```

**Safe files (never touched by updates):**
- `~/.openclaw/openclaw.json` — Main config
- `~/.openclaw/workspace/` — All personality files (SOUL.md, MEMORY.md, etc.)
- `~/.openclaw/credentials/` — API keys, WhatsApp session

---

## 🚀 Update Methods

### Method 1: One-Line Installer (Recommended)

```bash
curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard
```

This will:
- Detect existing install
- Upgrade in place
- Run `openclaw doctor` automatically
- Keep all your settings

---

### Method 2: Manual NPM Update

```bash
# Step 1: Check current version
openclaw --version

# Step 2: Update to latest
npm i -g openclaw@latest

# Step 3: Run health check
openclaw doctor

# Step 4: Restart gateway
openclaw gateway restart

# Step 5: Verify health
openclaw health
```

---

### Method 3: Update via OpenClaw Command

```bash
# If installed from source (git)
openclaw update

# This does everything automatically:
# - Fetches latest code
# - Installs dependencies
# - Runs doctor
# - Restarts gateway
```

---

## 🔧 Post-Update Verification

After any update, run these checks:

```bash
# 1. Check new version
openclaw --version

# 2. Check gateway status
openclaw gateway status

# 3. Check system health
openclaw health

# 4. Check logs for errors
openclaw logs --follow
# (Press Ctrl+C to exit logs)
```

---

## 🔄 Switching Update Channels

```bash
# Switch to beta (newer features, less stable)
openclaw update --channel beta

# Switch to dev (bleeding edge)
openclaw update --channel dev

# Switch back to stable
openclaw update --channel stable
```

---

## ⏪ Rollback (If Something Breaks)

### Rollback to specific version:
```bash
# Install known-good version
npm i -g openclaw@2026.1.29

# Restart
openclaw gateway restart

# Run doctor
openclaw doctor
```

### Check available versions:
```bash
npm view openclaw versions --json | tail -20
```

---

## 🔐 What's Preserved During Updates

| Component | Location | Preserved? |
|-----------|----------|------------|
| Main config | `~/.openclaw/openclaw.json` | ✅ YES |
| Personality | `~/.openclaw/workspace/` | ✅ YES |
| Credentials | `~/.openclaw/credentials/` | ✅ YES |
| WhatsApp session | `~/.openclaw/credentials/whatsapp/` | ✅ YES |
| Memory database | `~/.openclaw/memory/` | ✅ YES |
| Agent sessions | `~/.openclaw/agents/` | ✅ YES |

---

## 📞 Troubleshooting

### Gateway won't start after update:
```bash
openclaw doctor
openclaw gateway restart
```

### Config issues:
```bash
# View current config
openclaw gateway config.get

# Reset to defaults (careful!)
openclaw doctor --repair
```

### Check for errors:
```bash
openclaw logs --follow
```

---

## 📅 Update Schedule Recommendation

- **Stable releases**: Update monthly
- **Security patches**: Update immediately
- **Major versions**: Test on non-critical system first

---

*For support: https://discord.gg/clawd*
*Docs: https://docs.openclaw.ai*
