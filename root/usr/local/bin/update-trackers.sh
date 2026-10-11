#!/usr/bin/with-contenv bash
# Auto update public trackers from ngosang/trackerslist

set -e

TRACKER_URL="https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt"
CONF_FILE="/config/qBittorrent/config/qBittorrent.conf"
TMP_FILE="/tmp/trackers_best.txt"

if [ "${ENABLE_TRACKER_UPDATE}" != "true" ]; then
  echo "[trackers] ENABLE_TRACKER_UPDATE=false, skip."
  exit 0
fi

echo "[trackers] Fetching latest trackers..."
if ! curl -fsSL --connect-timeout 15 --max-time 30 -o "${TMP_FILE}" "${TRACKER_URL}"; then
  echo "[trackers] Failed to download trackers list, keep existing."
  exit 0
fi

# Convert to single line with \n separators for qBittorrent conf
TRACKERS=$(grep -v '^$' "${TMP_FILE}" | paste -sd '\\n' -)

if [ -z "${TRACKERS}" ]; then
  echo "[trackers] Empty list, skip."
  exit 0
fi

if [ ! -f "${CONF_FILE}" ]; then
  echo "[trackers] Config not found yet, will apply on next start."
  exit 0
fi

# Ensure AddTrackers is enabled
if grep -q "Bittorrent\\AddTrackers=" "${CONF_FILE}"; then
  sed -i "s|Bittorrent\\AddTrackers=.*|Bittorrent\\AddTrackers=true|" "${CONF_FILE}"
else
  echo "Bittorrent\\AddTrackers=true" >> "${CONF_FILE}"
fi

# Session\\AdditionalTrackers is the key used in recent versions
if grep -q "Session\\AdditionalTrackers=" "${CONF_FILE}"; then
  sed -i "s|Session\\AdditionalTrackers=.*|Session\\AdditionalTrackers=${TRACKERS}|" "${CONF_FILE}"
else
  echo "Session\\AdditionalTrackers=${TRACKERS}" >> "${CONF_FILE}"
fi

echo "[trackers] Updated successfully."
rm -f "${TMP_FILE}"
