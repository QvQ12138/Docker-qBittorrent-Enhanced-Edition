#!/bin/bash
set -e
BACKUP_DIR="./data/backups"
CONFIG_DIR="./data/config"
DATE=$(date +%Y%m%d_%H%M%S)
mkdir -p "${BACKUP_DIR}"
tar -czf "${BACKUP_DIR}/qbee-config-${DATE}.tar.gz" -C "${CONFIG_DIR}" .
echo "Backup: ${BACKUP_DIR}/qbee-config-${DATE}.tar.gz"
ls -1t "${BACKUP_DIR}"/qbee-config-*.tar.gz 2>/dev/null | tail -n +11 | xargs -r rm -f
