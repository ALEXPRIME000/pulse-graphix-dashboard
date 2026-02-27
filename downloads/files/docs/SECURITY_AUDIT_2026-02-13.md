# OpenClaw Security Audit Report
**Date:** 2026-02-13  
**System:** Ubuntu 24.04.3 LTS (AWS EC2)  
**User:** ubuntu (non-root)  
**Audit By:** Alex Prime

---

## 🚨 CRITICAL Finding: Firewall Disabled

**Status:** **INSECURE - IMMEDIATE ACTION REQUIRED**

Ubuntu UFW firewall is **INACTIVE**. Your VPS is exposed on all ports.

```
Status: inactive
```

**Risk:** Any service listening is accessible from the internet without filtering.

**Fix Required:**
```bash
# Enable UFW with safe defaults
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp    # SSH (required for access)
sudo ufw allow 443/tcp   # HTTPS (if using)
sudo ufw allow 80/tcp    # HTTP (if using)
sudo ufw enable

# Verify
sudo ufw status verbose
```

---

## 🔑 Credentials Security Assessment

### ✅ Good: File Permissions

| File/Directory | Permission | Status |
|----------------|------------|--------|
| `~/.openclaw/credentials/` | 700 (drwx------) | ✅ Secure |
| `~/.openclaw/openclaw.json` | 600 (-rw-------) | ✅ Secure |
| `github_token.txt` | 600 | ✅ Secure |
| `vercel_token.txt` | 600 | ✅ Secure |
| `n8n.json` | 600 | ✅ Secure |
| `google_client_secret.json` | 600 | ✅ Secure |
| `~/.ssh/` | 700 | ✅ Secure |
| `~/.ssh/authorized_keys` | 600 | ✅ Secure |

### ⚠️ API Keys Stored In Plain Text

**Location:** `~/.openclaw/openclaw.json`

API keys are stored in this file with proper permissions (600), but they are:
- Visible to the ubuntu user
- In JSON format (human readable)
- Not encrypted at rest

**Keys Found:**
- OpenRouter API key
- Other model provider keys

**Mitigation:** File permissions prevent other users from reading. This is the expected OpenClaw behavior.

---

## 🌐 Network Exposure

### Open Ports (Active Listening)

| Port | Protocol | Bind Address | Service | Risk |
|------|----------|--------------|---------|------|
| 22 | TCP | 0.0.0.0 (all) | SSH | ⚠️ Needs firewall |
| 53 | UDP/TCP | 127.0.0.53 | System DNS | ✅ Local only |
| 323 | UDP | 127.0.0.1 | NTP | ✅ Local only |
| 5353 | UDP | 0.0.0.0 / [::] | mDNS (OpenClaw) | ⚠️ Multicast only |
| 18789 | TCP | 127.0.0.1 | OpenClaw Gateway | ✅ Local only |
| 18792 | TCP | 127.0.0.1 | OpenClaw Gateway | ✅ Local only |
| 44573 | UDP | 0.0.0.0 | Ephemeral | Low risk |

**Good News:**
- OpenClaw gateway only listens on localhost (127.0.0.1)
- Cannot be accessed from external network directly

---

## 🔒 SSH Security

### ✅ Key-Based Authentication
- `~/.ssh/authorized_keys` exists
- Proper permissions (600)
- SSH directory proper permissions (700)

### ⚠️ Unknown Configuration
Could not read `/etc/ssh/sshd_config` (requires sudo)

**Recommended Checks:**
```bash
sudo grep -E "^(PermitRootLogin|PasswordAuthentication|PubkeyAuthentication)" /etc/ssh/sshd_config
```

**Best Practices:**
- `PermitRootLogin no` (disable root login)
- `PasswordAuthentication no` (keys only)
- `PubkeyAuthentication yes` (ensure enabled)

---

## 🛡️ OpenClaw Security Configuration

### OpenClaw Config File
**Location:** `~/.openclaw/openclaw.json`
- Version: 2026.2.6-3
- Permissions: 600 (good)

### Security Features Available
Run these commands to audit and fix:
```bash
# OpenClaw security audit
openclaw security audit --deep

# Apply safe defaults (prompts before changes)
openclaw security audit --fix
```

---

## 📜 Prompt Injection Risks

### Current State
- System prompt includes safety guidelines
- OpenClaw uses instruction hierarchies
- Model-level safety filters active

### Additional Recommendations
1. **Disable tool auto-execution** for critical operations
2. **Add confirmation prompts** before:
   - Sending messages
   - Executing shell commands
   - Accessing credentials
3. **Log all external actions** for review

---

## 🔧 Remediation Plan

### Priority 1: Enable Firewall (CRITICAL)
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw enable
sudo ufw status
```

### Priority 2: Harden SSH
```bash
# Run as root or sudo
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd
```

### Priority 3: Enable Automatic Security Updates
```bash
sudo apt install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
# Select "Yes" for automatic updates
```

### Priority 4: OpenClaw Security Hardening
```bash
# Run OpenClaw security audit
openclaw security audit --deep

# Review and apply fixes
openclaw security audit --fix
```

### Priority 5: Verify Credentials Security
```bash
# Check all credential files have 600 permissions
ls -la ~/.openclaw/credentials/
ls -la ~/.openclaw/openclaw.json
ls -la ~/.ssh/

# Fix if needed:
chmod 700 ~/.openclaw/credentials/
chmod 600 ~/.openclaw/credentials/*
chmod 600 ~/.openclaw/openclaw.json
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/authorized_keys
```

---

## 📊 Security Score

| Category | Score | Notes |
|----------|-------|-------|
| Firewall | 🔴 0/10 | Disabled - CRITICAL |
| SSH | 🟡 6/10 | Key auth, unknown config |
| Credentials | 🟢 8/10 | Good permissions, plain text |
| OpenClaw | 🟢 7/10 | Localhost only, needs audit |
| Updates | 🟡 5/10 | Unknown auto-update status |
| **Overall** | 🟡 **5.2/10** | **Fix firewall ASAP** |

---

## 📋 Status Check Commands

Run these anytime to verify security:

```bash
# Check firewall
sudo ufw status verbose

# Check open ports
ss -ltnup

# Check OpenClaw security
openclaw security audit --deep

# Check file permissions
ls -la ~/.openclaw/credentials/
ls -la ~/.ssh/

# Check SSH config
sudo grep -E "^(PermitRootLogin|PasswordAuthentication)" /etc/ssh/sshd_config
```

---

## 🔄 Schedule Periodic Audits

Recommend weekly security checks:
```bash
# Add to crontab (run Sundays at 2am)
0 2 * * 0 /usr/local/bin/openclaw security audit --deep >> ~/.openclaw/security-audit.log 2>&1
```

---

## Next Actions Required

1. **Approve firewall enablement?** (Y/N)
2. **Approve SSH hardening?** (Y/N)
3. **Run OpenClaw security audit --fix?** (Y/N)
4. **Schedule weekly security audits?** (Y/N)

---

*Document stored in: `docs/SECURITY_AUDIT_2026-02-13.md`*  
*Last updated: 2026-02-13 16:05 UTC*
