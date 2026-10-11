FROM superng6/alpine:3.22 AS builder
LABEL maintainer="QvQ12138"
LABEL org.opencontainers.image.title="qBittorrentEE Pro"
LABEL org.opencontainers.image.description="qBittorrent Enhanced Edition Pro - Official binary + practical enhancements"
LABEL org.opencontainers.image.source="https://github.com/QvQ12138/Docker-qBittorrent-Enhanced-Edition"

WORKDIR /qbittorrent

COPY install.sh /qbittorrent/
COPY ReleaseTag /qbittorrent/

RUN apk add --no-cache ca-certificates curl jq unzip

RUN cd /qbittorrent \
	&& chmod a+x install.sh \
	&& bash install.sh

# Final image
FROM superng6/alpine:3.22

ENV TZ=Asia/Shanghai \
    WEBUIPORT=8080 \
    ENABLE_DOWNLOADS_PERM_FIX=true \
    ENABLE_TRACKER_UPDATE=true \
    WEB_USERNAME="" \
    WEB_PASSWORD=""

COPY root /
COPY --from=builder /qbittorrent/qbittorrent-nox /usr/local/bin/qbittorrent-nox

RUN apk add --no-cache python3 curl \
    && rm -rf /var/cache/apk/* \
    && chmod a+x /usr/local/bin/qbittorrent-nox \
    && chmod a+x /etc/cont-init.d/* \
    && chmod a+x /etc/services.d/qBittorrent/run \
    && chmod a+x /usr/local/bin/update-trackers.sh || true

VOLUME /downloads /config
EXPOSE 8080 6881 6881/udp

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://127.0.0.1:${WEBUIPORT}/api/v2/app/version || exit 1
