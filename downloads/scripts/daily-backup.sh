#!/bin/bash
# Alex Prime Daily Backup Script
# Backs up entire .openclaw folder to Google Drive

set -e

# Configuration
BACKUP_DIR="/tmp/alex-prime-backups"
OPENCLAW_DIR="/home/ubuntu/.openclaw"
GDRIVE_FOLDER_ID="1V-EN0KdCTYekeHoNiYdW5EZTOSG93Pyb"
DATE=$(date +%Y-%m-%d)
BACKUP_NAME="alex-prime-backup-${DATE}.tar.gz"

# Export for gog CLI
export GOG_KEYRING_PASSWORD="openclaw"

echo "🔄 Starting Alex Prime backup - ${DATE}"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create compressed backup (exclude large/unnecessary files)
echo "📦 Creating backup archive..."
tar -czvf "${BACKUP_DIR}/${BACKUP_NAME}" \
    --exclude='*.log' \
    --exclude='node_modules' \
    --exclude='.git' \
    --exclude='media/*' \
    -C /home/ubuntu \
    .openclaw

# Get file size
SIZE=$(du -h "${BACKUP_DIR}/${BACKUP_NAME}" | cut -f1)
echo "📊 Backup size: ${SIZE}"

# Upload to Google Drive
echo "☁️ Uploading to Google Drive..."
gog drive upload "${BACKUP_DIR}/${BACKUP_NAME}" --parent "${GDRIVE_FOLDER_ID}"

# Clean up local backup (keep only last 2 days locally - older ones are on Google Drive)
echo "🧹 Cleaning up local backups older than 2 days..."
find "$BACKUP_DIR" -name "alex-prime-backup-*.tar.gz" -mtime +2 -delete

echo "✅ Backup complete: ${BACKUP_NAME} (${SIZE}) uploaded to Google Drive"
echo "📁 Folder: https://drive.google.com/drive/folders/${GDRIVE_FOLDER_ID}"
