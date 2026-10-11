# qBittorrentEE Pro

**完整可用的增强版 qBittorrent 下载管理平台**

- 核心：官方 [qBittorrent Enhanced Edition](https://github.com/c0re100/qBittorrent-Enhanced-Edition) 静态二进制
- 外壳：继承 SuperNG6 优秀优化 + 本仓库实用增强
- 管理：集成 [qbit_manage](https://github.com/StuffAnThings/qbit_manage)（自动标签/分类/清理/分享控制）
- 镜像：`ghcr.io/qvq12138/qbittorrentee:latest`

---

## 一键部署

```bash
# 1. 创建目录
mkdir -p qbee && cd qbee

# 2. 下载文件
curl -O https://raw.githubusercontent.com/QvQ12138/Docker-qBittorrent-Enhanced-Edition/master/docker-compose.yml
curl -O https://raw.githubusercontent.com/QvQ12138/Docker-qBittorrent-Enhanced-Edition/master/.env.example
cp .env.example .env

# 3. 编辑 .env（修改 PUID/PGID 和密码）
nano .env

# 4. 启动
docker compose up -d

# 5. 查看日志（首次获取默认密码）
docker logs qbittorrentee
```

访问：
- qBittorrent WebUI → `http://IP:8080`
- qbit_manage WebUI → `http://IP:8181`

---

## 功能一览

### 核心镜像已包含
| 功能 | 说明 |
|------|------|
| 官方增强版二进制 | 反吸血、客户端屏蔽等 |
| 默认中文 + 优化配置 | 开箱即用 |
| 自动更新 Tracker | 启动时拉取 ngosang 最新列表 |
| Healthcheck | Docker 正确判断健康状态 |
| PUID/PGID 权限映射 | 群晖/威联通友好 |
| 权限自动修复 | 可选 |
| 预装搜索插件 | 开箱可用 |

### 完整 Compose 栈已包含
| 服务 | 功能 |
|------|------|
| **qbittorrentee** | 下载核心 |
| **qbit_manage** | 自动标签、分类、分享限制、清理、规则调度 |

---

## 目录结构（部署后）

```
qbee/
├── docker-compose.yml
├── .env
├── data/
│   ├── config/          # qB 配置
│   ├── downloads/       # 下载目录
│   ├── qbit_manage/     # qbit_manage 配置
│   └── backups/         # 配置备份（手动脚本）
└── scripts/
    └── backup-config.sh
```

---

## 常用命令

```bash
# 更新镜像并重启
docker compose pull && docker compose up -d

# 备份配置
bash scripts/backup-config.sh

# 查看状态
docker compose ps
docker logs -f qbittorrentee
```

---

## 后续规划（已预留结构）

- Apprise 统一通知（Telegram / 飞书 / Discord 等）
- MCP Server（AI 自然语言控制）
- Prometheus + Grafana 监控
- 更完善的密码/安全选项
- 配置导入导出工具

当前版本已经是**可直接长期使用的完整成品**，核心下载 + 智能任务管理全部就绪。

---

## 致谢

- [c0re100/qBittorrent-Enhanced-Edition](https://github.com/c0re100/qBittorrent-Enhanced-Edition)
- [SuperNG6](https://github.com/SuperNG6/Docker-qBittorrent-Enhanced-Edition)
- [StuffAnThings/qbit_manage](https://github.com/StuffAnThings/qbit_manage)
- [ngosang/trackerslist](https://github.com/ngosang/trackerslist)
