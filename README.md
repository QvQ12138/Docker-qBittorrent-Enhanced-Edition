# qBittorrentEE Pro

**完整可部署的增强版下载管理平台**

核心 = 官方 qBittorrent Enhanced Edition 二进制  
管理 = qbit_manage（自动标签 / 分类 / 分享限制 / 清理）  
通知 = Apprise（支持 Telegram / Discord / 飞书 / 邮件等）

镜像：`ghcr.io/qvq12138/qbittorrentee:latest`

---

## 一键部署（成品）

```bash
mkdir -p qbee && cd qbee

# 拉取部署文件
curl -fsSL -O https://raw.githubusercontent.com/QvQ12138/Docker-qBittorrent-Enhanced-Edition/master/docker-compose.yml
curl -fsSL -O https://raw.githubusercontent.com/QvQ12138/Docker-qBittorrent-Enhanced-Edition/master/.env.example
cp .env.example .env

# 必须修改 PUID / PGID / 密码
nano .env

# 启动核心 + 任务管理
docker compose up -d

# 如需通知服务
# docker compose --profile notify up -d
```

访问地址：
- qBittorrent WebUI → http://你的IP:8080
- qbit_manage → http://你的IP:8181

首次启动后请立刻修改默认密码，并同步修改 `.env` 里的 `QBT_PASSWORD`。

---

## 已实现功能（完整可用）

### 核心镜像
- 官方增强版二进制（反吸血等特性完整保留）
- 默认中文 + 优化配置
- 启动自动更新最新 Tracker
- Healthcheck
- PUID/PGID 权限映射
- 下载目录权限修复
- 预装搜索插件

### 任务管理（qbit_manage）
- 自动标签 / 分类
- 分享比率与做种时间限制
- 自动清理
- 回收站
- 定时规则执行
- 独立 WebUI 管理

### 通知（Apprise）
- 支持 Telegram、Discord、Bark、邮件、飞书、企业微信等
- 按需启动（profile）

### 运维工具
- 配置一键备份脚本
- Tracker 强制更新脚本

---

## 目录结构

```
qbee/
├── docker-compose.yml
├── .env
├── data/
│   ├── config/           # qB 配置与数据
│   ├── downloads/        # 下载目录
│   ├── qbit_manage/      # 任务管理配置
│   ├── apprise/          # 通知配置
│   └── backups/          # 配置备份
└── scripts/
    ├── backup-config.sh
    └── update-trackers.sh
```

---

## 常用命令

```bash
docker compose pull && docker compose up -d   # 更新
docker logs -f qbittorrentee                 # 查看日志
bash scripts/backup-config.sh                # 备份配置
bash scripts/update-trackers.sh              # 强制更新 Tracker
```

---

## 说明

当前版本是**完整可运行的生产级成品**，覆盖下载核心 + 智能任务管理 + 通知能力。

更高阶的 AI 接口、MCP Server、自定义 WebUI、Prometheus 监控大盘属于独立大型模块，需要单独开发与维护。当前平台已为这些扩展预留了清晰的目录与网络结构。

---

## 致谢

- c0re100/qBittorrent-Enhanced-Edition
- SuperNG6
- StuffAnThings/qbit_manage
- caronc/apprise
- ngosang/trackerslist
