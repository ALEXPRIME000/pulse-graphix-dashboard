# Pulse Graphix Business Dashboard

![Pulse Graphix](https://img.shields.io/badge/Pulse-Graphix-00FF00?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Production-00FF00?style=for-the-badge)

Professional business dashboard for Pulse Graphix creative agency. Real-time metrics tracking, pipeline management, and analytics visualization.

## 🎨 Brand Identity

- **Owner:** Chicco Mutombo Kabundji
- **Colors:** Neon Green (#00FF00) on Black (#0D0D0D)
- **Style:** Modern, sleek, glass-morphism design

## ✨ Features

### 📊 Dashboard Sections

1. **Revenue Overview**
   - Monthly revenue tracker with targets
   - Revenue breakdown by service type
   - Interactive charts (Chart.js)

2. **Leads Pipeline**
   - Kanban-style prospect management
   - Real prospects from Torcy area
   - Star ratings and value tracking

3. **Projects Status**
   - Active project tracking
   - Progress bars with status indicators
   - Visual timeline

4. **Services Pricing**
   - Quick reference pricing table
   - Starter/Pro/Enterprise tiers
   - 9 service offerings

5. **Design Shop Products**
   - 10 digital products
   - Bestseller and new badges
   - Pricing with discounts

6. **Social Media Metrics**
   - Platform status tracking
   - Content calendar overview
   - Engagement metrics

### 🎯 Key Metrics

- Total Prospects: 20+ (4 qualified)
- Pipeline Value: €4,500
- Revenue This Month: €0 (just launched)
- Shop Products: 10
- Services: 9
- Client Satisfaction: 98%

## 🚀 Technology Stack

- **Frontend:** Pure HTML5
- **Styling:** Tailwind CSS (CDN)
- **Charts:** Chart.js
- **Fonts:** Inter (Google Fonts)
- **Data:** JSON-based (data.json)

## 📦 Installation

### Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/ALEXPRIME000/pulse-graphix-dashboard.git
   cd pulse-graphix-dashboard
   ```

2. Open in browser:
   ```bash
   # Simple HTTP server (Python 3)
   python3 -m http.server 8000
   
   # Or using Node.js
   npx http-server
   ```

3. Navigate to `http://localhost:8000`

### Deploy to Vercel

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/ALEXPRIME000/pulse-graphix-dashboard)

**Manual Deployment:**

1. Install Vercel CLI:
   ```bash
   npm i -g vercel
   ```

2. Deploy:
   ```bash
   cd pulse-graphix-dashboard
   vercel
   ```

3. Follow the prompts. The dashboard will be live at your Vercel URL.

**Auto-Deploy (Recommended):**
- Connect this repository to Vercel dashboard
- Every push to `main` branch auto-deploys
- Zero configuration needed (static site)

## 📝 Data Management

All dashboard data is stored in `data.json`. Update this file to reflect:
- New leads and prospects
- Project progress
- Revenue changes
- Shop products
- Social media stats

The dashboard auto-loads from `data.json` - no code changes needed for data updates.

## 🎨 Design Specifications

### Color Palette
- **Primary:** #00FF00 (Neon Green)
- **Background:** #0D0D0D (True Black)
- **Cards:** #111111 (Dark Gray)
- **Borders:** #222222 (Light Gray)

### Typography
- **Font Family:** Inter
- **Weights:** 300, 400, 500, 600, 700, 800, 900

### Effects
- Glass-morphism cards with backdrop blur
- Smooth hover animations
- Neon glow on interactive elements
- Progressive progress bars

## 📱 Responsive Design

Fully responsive across devices:
- Mobile (320px+)
- Tablet (768px+)
- Desktop (1024px+)
- Large screens (1440px+)

## 🔄 Auto-Refresh

Dashboard timestamp updates every 60 seconds. Data refreshes on page load.

## 📄 License

© 2026 Pulse Graphix. All rights reserved.

---

**Built with precision for Chicco Mutombo Kabundji**  
*Pulse Graphix - Creative Excellence*
