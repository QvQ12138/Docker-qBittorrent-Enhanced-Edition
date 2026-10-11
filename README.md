# qBittorrentEE Pro

**官方增强版二进制 + 实用增强外壳**  
基于 [c0re100/qBittorrent-Enhanced-Edition](https://github.com/c0re100/qBittorrent-Enhanced-Edition) 官方静态二进制构建。

镜像地址：

```bash
docker pull ghcr.io/qvq12138/qbittorrentee:latest
```

---

## 核心特点

- **核心程序**：官方 qBittorrent Enhanced Edition 静态二进制（无修改）
- 继承 SuperNG6 优秀优化（中文、权限、配置、搜索插件等）
- **Pro 增强**（本仓库新增）：
  - 启动时自动更新最新 Tracker 列表（ngosang）
  - 支持环境变量设置 WebUI 用户名/密码
  - Healthcheck 健康检查
  - 启动环境检测
  - 干净的 docker-compose（含可选 qbit_manage 侧车）

---

## 快速开始

```bash
mkdir -p qbittorrentee/{config,downloads}
cd qbittorrentee

# 下载 compose
curl -O https://raw.githubusercontent.com/QvQ12138/Docker-qBittorrent-Enhanced-Edition/master/docker-compose.yml

docker compose up -d
```

访问：`http://你的IP:8080`  
默认用户名：`admin`，首次密码请查看容器日志。

---

## 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `PUID` / `PGID` | 1000 | 用户/组 ID（群晖等必改） |
| `TZ` | Asia/Shanghai | 时区 |
| `WEBUIPORT` | 8080 | WebUI 端口 |
| `ENABLE_DOWNLOADS_PERM_FIX` | true | 是否自动修复 /downloads 权限 |
| `ENABLE_TRACKER_UPDATE` | true | 启动时自动更新 Tracker |
| `WEB_USERNAME` | （空） | 设置 WebUI 用户名 |
| `WEB_PASSWORD` | （空） | 设置 WebUI 密码（建议配合 PBKDF2） |

---

## 可选：启用 qbit_manage

编辑 `docker-compose.yml`，取消注释 `qbit_manage` 服务即可获得：

- 自动标签 / 分类
- 分享限制与清理
- 规则调度

---

## 路线图（Pro / AI Edition）

**Phase 1（当前）**：实用增强 + 稳定 Docker 成品  
**Phase 2**：完整集成 qbit_manage + Apprise 通知  
**Phase 3**：MCP Server + AI 控制接口  
**Phase 4**：监控（Prometheus）+ 高级 WebUI

---

## 致谢

- [c0re100/qBittorrent-Enhanced-Edition](https://github.com/c0re100/qBittorrent-Enhanced-Edition)
- [SuperNG6/Docker-qBittorrent-Enhanced-Edition](https://github.com/SuperNG6/Docker-qBittorrent-Enhanced-Edition)
- [ngosang/trackerslist](https://github.com/ngosang/trackerslist)
- [StuffAnThings/qbit_manage](https://github.com/StuffAnThings/qbit_manage)
