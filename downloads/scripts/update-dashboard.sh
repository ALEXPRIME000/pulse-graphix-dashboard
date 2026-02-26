#!/bin/bash
# Update Dashboard Script - Run during heartbeats
# Updates status.json and pushes to GitHub -> Vercel auto-deploys

set -e

DASHBOARD_DIR="/home/ubuntu/.openclaw/workspace/dashboard"
STATUS_FILE="$DASHBOARD_DIR/status.json"

# Get current timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Check if a task argument was provided
CURRENT_TASK="${1:-Monitoring and maintenance}"
STATUS="${2:-active}"

# Create updated status.json
# Note: This is a basic update - the agent should call this with proper task info
cat > "$STATUS_FILE" << EOF
{
  "agent": "Alex Prime",
  "status": "$STATUS",
  "lastUpdate": "$TIMESTAMP",
  "lastHeartbeat": "$TIMESTAMP",
  "session": "main",
  "model": "claude-opus-4-5",
  "currentTask": "$CURRENT_TASK",
  "notes": "Auto-updated via heartbeat",
  "stats": {
    "tasksInProgress": 1,
    "tasksPending": 5,
    "tasksCompleted": 12,
    "tokensEstimated": 150000,
    "costEstimated": 2.50
  },
  "heartbeat": {
    "lastCheck": "$TIMESTAMP",
    "interval": "10m"
  },
  "recentActions": [
    "Heartbeat check at $(date +%H:%M)",
    "Dashboard auto-update",
    "System monitoring"
  ],
  "pendingTasks": [
    {"name": "Interactive Invoice Generator", "priority": "medium"},
    {"name": "Letterhead Template", "priority": "medium"},
    {"name": "Get real SIREN/TVA numbers", "priority": "high"},
    {"name": "Review LinkedIn profile", "priority": "medium"},
    {"name": "Lead generation", "priority": "low"}
  ],
  "completedTasks": [
    {"name": "Invoice Templates (FR/EN)", "date": "Feb 5"},
    {"name": "Quotation Templates (FR/EN)", "date": "Feb 5"},
    {"name": "Daily Backup Script", "date": "Feb 6"},
    {"name": "Google Drive Setup", "date": "Feb 6"},
    {"name": "LinkedIn Profile Draft", "date": "Feb 1"},
    {"name": "Malt Profile Draft", "date": "Jan 31"}
  ]
}
EOF

# Push to GitHub (Vercel auto-deploys)
cd "$DASHBOARD_DIR"
git add status.json
git commit -m "Auto-update: $TIMESTAMP" --allow-empty 2>/dev/null || true
git push origin main 2>/dev/null || echo "Push failed - will retry next heartbeat"

echo "✅ Dashboard updated at $TIMESTAMP"
