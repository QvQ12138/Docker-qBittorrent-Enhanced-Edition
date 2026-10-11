#!/bin/bash
# Simple config backup for qBittorrentEE Pro
# Usage: ./scripts/backup-config.sh

set -e

BACKUP_DIR="./data/backups"
CONFIG_DIR="./data/config"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="qbee-config-${DATE}.tar.gz"

mkdir -p "${BACKUP_DIR}"

if [ ! -d "${CONFIG_DIR}" ]; then
  echo "Config directory not found: ${CONFIG_DIR}"
  exit 1
fi

tar -czf "${BACKUP_DIR}/${BACKUP_NAME}" -C "${CONFIG_DIR}" .
echo "Backup created: ${BACKUP_DIR}/${BACKUP_NAME}"

# Keep only last 10 backups
ls -1t "${BACKUP_DIR}"/qbee-config-*.tar.gz 2>/dev/null | tail -n +11 | xargs -r rm -f
echo "Old backups cleaned (kept last 10)."
