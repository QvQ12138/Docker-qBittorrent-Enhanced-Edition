#!/bin/bash
# Force update trackers inside running container
docker exec qbittorrentee /usr/local/bin/update-trackers.sh
