# Cloud Storage Services Comparison
*For Kabundji — February 14, 2026*

## Your Use Case Summary
- **Need**: Backup workspace files, documents, templates
- **Location**: Remote VPS/workspace
- **Priority**: Reliable backup, easy integration for me (AI agent)
- **Ideal**: Large space at low cost, API/CLI access for automation

---

## TOP RECOMMENDATIONS ⭐

### 1. Google Drive ⭐ BEST OVERALL
| Feature | Details |
|---------|---------|
| **Free Storage** | 15 GB (shared with Gmail, Photos) |
| **Paid Plans** | 100 GB: $1.67/mo → 2 TB: $9.99/mo |
| **Max Storage** | 30 TB |
| **API Access** | ✅ Excellent (Google Drive API) |
| **CLI Tools** | ✅ rclone, drive CLI |
| **Sync** | Web, Desktop, Mobile |

**Pros:**
- ✅ **Best integration with OpenClaw** — likely already supported
- ✅ Most generous free tier (15 GB)
- ✅ API access for automation
- ✅ Fast sync (1 Gbps speeds)
- ✅ Built-in Docs/Sheets/Slides for quick editing
- ✅ 5 TB file size limit

**Cons:**
- ❌ Privacy concerns (Google scans files)
- ❌ Shared quota with Gmail

**Price Examples (yearly = 16% discount):**
- 100 GB: $19.99/year ($1.67/mo)
- 2 TB: $99.99/year ($8.33/mo)
- 5 TB: $249.99/year

**Verdict**: **RECOMMENDED** — Best value, easy API, generous free storage

---

### 2. IDrive ⭐ BEST FOR BACKUP
| Feature | Details |
|---------|---------|
| **Free Storage** | 10 GB |
| **Paid Plans** | **5 TB: $24.88 first year** → then $69.95/year |
| **Max Storage** | 50 TB+ (plans scale) |
| **API Access** | ✅ Yes (REST API) |
| **CLI Tools** | ✅ Linux/Windows/Mac CLI |
| **Backup Type** | Continuous, block-level sync |

**Pros:**
- ✅ **CHEAPEST storage per TB** by far
- ✅ Can backup to physical drives they send you
- ✅ Can backup AWS, Dropbox, Google Drive (clone other clouds!)
- ✅ Continuous backup (changes sync instantly)
- ✅ Linux/Windows/Mac CLI available

**Cons:**
- ❌ Not as user-friendly as Google Drive
- ❌ Sharing not as seamless

**Pricing (Annual — 50% off first year):**
| Plan | First Year | Regular | Per TB/Year |
|------|------------|---------|-------------|
| Mini (100 GB) | $3.71 | $9.95 | ~$100 |
| Personal (5 TB) | **$24.88** | $69.95 | **$14/TB** |
| Personal (10 TB) | $49.88 | $99.95 | **$10/TB** |

**Verdict**: **BEST VALUE FOR PURE BACKUP** — 5TB for $25 first year

---

### 3. Dropbox — Best for Collaboration
| Feature | Details |
|---------|---------|
| **Free Storage** | 2 GB (worst free tier) |
| **Paid Plans** | 2 TB: $10/mo → 3 TB: $17/mo |
| **API Access** | ✅ Yes |
| **CLI Tools** | ✅ Yes |
| **Unique** | Block-level sync, eSignatures |

**Pros:**
- ✅ Block-level sync (only changed chunks synced)
- ✅ Best third-party integrations
- ✅ eSignatures built-in
- ✅ Fast sync

**Cons:**
- ❌ Expensive ($10/mo for 2TB vs $25 first year for 5TB with IDrive)
- ❌ Free tier only 2 GB
- ❌ Security breaches in past

**Pricing:**
- Plus (2 TB): $9.99/mo or $119.88/year
- Family (2 TB, 6 users): $16.99/mo

**Verdict**: Good for collaboration, but **overpriced** for pure storage

---

### 4. Microsoft OneDrive — Good for Office Users
| Feature | Details |
|---------|---------|
| **Free Storage** | 5 GB |
| **Paid Plans** | 100 GB: $1.67/mo → 6 TB: $8.33/mo |
| **API Access** | ✅ Yes |
| **CLI Tools** | ✅ Via rclone |
| **Unique** | Personal Vault, Office Online |

**Pros:**
- ✅ Good value (6 TB for $8.33/mo)
- ✅ Personal Vault (secure file storage)
- ✅ Block-level sync
- ✅ Built-in Office apps

**Cons:**
- ❌ Works best with Windows
- ❌ Smaller ecosystem than Google Drive

**Pricing:**
- 100 GB: $1.99/mo
- Microsoft 365 (1 TB): $6.99/mo (includes Office apps)
- Family (6 TB across 6 users): $9.99/mo

**Verdict**: Good if already using Microsoft 365

---

## QUICK COMPARISON TABLE

| Service | Free | 2 TB Cost | 5 TB Cost | API | Best For |
|---------|------|-----------|-----------|-----|----------|
| **Google Drive** | 15 GB | $8.33/mo | — | ✅ | General use, productivity |
| **IDrive** | 10 GB | — | $24.88/yr (1st yr) | ✅ | **Cheapest backup** |
| **Dropbox** | 2 GB | $10/mo | $17+/mo | ✅ | Collaboration, sync |
| **OneDrive** | 5 GB | Included in M365 | $8.33/mo | ✅ | Office integration |
| **pCloud** | 10 GB | $9.99/mo | — | ✅ | Lifetime plans |
| **Sync.com** | 5 GB | $8/mo | — | ✅ | **Privacy** |

---

## RECOMMENDATION FOR YOUR USE CASE

### Option A: Budget-Focused → **IDrive**
- **5 TB for $24.88 first year** ($69.95/year after)
- Perfect for automated backups of workspace
- Can backup entire VPS/image disks
- CLI tools for automation

### Option B: Balanced → **Google Drive**
- Start with free 15 GB
- Upgrade to 2 TB: $99.99/year
- Best API/integration with my tools
- Can access files anywhere, edit in Docs

### Option C: Privacy-Focused → **Sync.com**
- Client-side encryption
- 5 GB free
- 2 TB: $8/month
- Zero-knowledge (even they can't read your files)

---

## FOR AI AGENT (MY) WORKFLOW

**What I Need:**
1. A folder/directory in cloud storage
2. API key or connection method
3. Automation to sync key files

**Best Setup:**
```
Workspace → (rsync/rclone) → Google Drive OR IDrive
```

**What to Back Up:**
- `/workspace/templates/*` — Your templates
- `/workspace/prospects/*` — Prospect research
- `/workspace/business/*` — Strategy documents
- `/workspace/memory/*.md` — Daily logs
- `/workspace/dashboard/*` — Dashboard files

---

## NEXT STEPS

1. **Pick a service** from above (I recommend IDrive or Google)
2. **Set up account** and share credentials/API key with me
3. **I'll configure** automated backup scripts
4. **I'll push** current workspace files to the cloud

**Want me to:**
- [ ] Create a backup script once you choose?
- [ ] Compare specific features in more detail?
- [ ] Research enterprise options (if needed)?

---

*Sources: Cloudwards.net 2026 review, IDrive pricing, CNET, PCMag, Zapier*
*Research completed: 2026-02-14*
