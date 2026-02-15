# 🚀 Deployment Guide

## Quick Deploy to Vercel (Recommended)

### Option 1: One-Click Deploy

1. Click this button:  
   [![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/ALEXPRIME000/pulse-graphix-dashboard)

2. Sign in with GitHub (if not already signed in)

3. Click "Deploy" - that's it! ✨

### Option 2: Connect from Vercel Dashboard

1. Go to [vercel.com/dashboard](https://vercel.com/dashboard)

2. Click "Add New..." → "Project"

3. Import from GitHub:
   - Select: `ALEXPRIME000/pulse-graphix-dashboard`

4. Configure (or use defaults):
   - **Framework Preset:** Other
   - **Root Directory:** `./`
   - **Build Command:** (leave empty)
   - **Output Directory:** `./`

5. Click "Deploy"

6. Done! Your dashboard will be live at: `https://pulse-graphix-dashboard.vercel.app`

### Option 3: CLI Deploy

```bash
# Install Vercel CLI
npm i -g vercel

# Navigate to project
cd pulse-graphix-dashboard

# Deploy
vercel

# Follow prompts:
# - Link to existing project? No
# - Project name? pulse-graphix-dashboard
# - Directory? ./
# - Override settings? No

# Production deploy
vercel --prod
```

## 🔄 Auto-Deploy Setup

Once connected to Vercel:

1. Every push to `main` branch = auto-deploy
2. Pull requests = preview deployments
3. Rollback available in Vercel dashboard

**No build step needed** - this is a static site!

## 📊 Update Dashboard Data

To update metrics without touching code:

1. Edit `data.json` locally or on GitHub

2. Commit and push:
   ```bash
   git add data.json
   git commit -m "Update metrics"
   git push
   ```

3. Vercel auto-deploys in ~30 seconds

## 🎨 Custom Domain (Optional)

1. In Vercel dashboard → Project Settings → Domains

2. Add your domain:
   - `pulsegraphix.com`
   - `dashboard.pulsegraphix.com`

3. Update DNS records as shown by Vercel

4. SSL certificate auto-configured ✓

## 📱 Preview URLs

Every deployment gets a unique URL:
- **Production:** `pulse-graphix-dashboard.vercel.app`
- **Latest:** `pulse-graphix-dashboard-git-main.vercel.app`
- **Commit:** `pulse-graphix-dashboard-{hash}.vercel.app`

## 🔧 Environment Variables

None needed! This dashboard is 100% client-side.

## ⚡ Performance

Expected scores:
- **Lighthouse:** 95+ (all metrics)
- **Load time:** <1s (first load)
- **CDN:** Global edge network
- **SSL:** Auto-enabled

## 🐛 Troubleshooting

**Dashboard not loading data?**
- Check browser console for errors
- Verify `data.json` is valid JSON
- Clear cache and hard refresh (Ctrl+Shift+R)

**Charts not rendering?**
- Ensure Chart.js CDN is accessible
- Check browser compatibility (modern browsers only)

**Vercel build failing?**
- This shouldn't happen (no build step!)
- Check if `index.html` exists in root
- Verify `vercel.json` syntax

## 📞 Support

Issues? Open a GitHub issue or contact Chicco Mutombo Kabundji.

---

**Ready to launch!** 🚀  
*Built for Pulse Graphix*
