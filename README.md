# Docker Infrastructure Manage In-House Server

A production-ready, one-command Docker stack showcasing a comprehensive suite of in-house server management and infrastructure tools. This repository provides a complete, isolated environment for databases, reverse proxying, monitoring, and container management.

## 🚀 Included Services

| Service | Exposes | Port (Default) | Description |
| :--- | :--- | :--- | :--- |
| **Nginx Proxy Manager** | UI / HTTP / HTTPS | `81` / `80` / `443` | Reverse proxy and SSL certificate management |
| **Portainer CE** | UI | `9443` | Comprehensive Docker container management UI |
| **Dozzle** | UI | `8080` | Real-time web-based Docker log viewer |
| **MySQL 8** | DB | `3306` (internal) | Relational database management system |
| **phpMyAdmin** | UI | `8082` | Web interface for MySQL administration |
| **PostgreSQL 16**| DB | `5432` (internal) | Advanced open-source relational database |
| **pgAdmin 4** | UI | `8083` | Web interface for PostgreSQL administration |
| **MongoDB** | DB | `27017` (internal)| High-performance NoSQL database |
| **Mongo-Express** | UI | `8081` | Web interface for MongoDB administration |
| **Redis** | Cache | `6379` (internal) | In-memory data structure store / cache |
| **MinIO** | UI / API | `9001` / `9000` | High-performance, S3-compatible object storage |
| **ELK Stack** | Logs / UI | `5601` / `9200` | Elasticsearch, Logstash, Kibana centralized logging |
| **Netdata** | UI | `19999` | Real-time performance and health monitoring |
| **RabbitMQ** | Queue / UI| `5672` / `15672` | Industry-standard message broker |
| **FreeRADIUS** | Auth | `1812`/`1813` (UDP) | High-performance RADIUS server |
| **Uptime Kuma** | UI | `3001` | Self-hosted monitoring tool |
| **Watchtower** | Background| - | Automated Docker container base image updates |

## 🛠️ Prerequisites

* A Linux server (Ubuntu/Debian recommended)
* Docker Engine installed (`curl -fsSL https://get.docker.com | sh`)
* Docker Compose plugin installed
* Git installed

## 🚦 Quick Start Guide

### 1. Clone the Repository

```bash
git clone https://github.com/ajitraidits9878/docker-infra-manage-inhouse-server.git
cd docker-infra-manage-inhouse-server
```

### 2. Configure Environment Variables

Copy the example environment file and customize it. **Do not skip this step.** You should change all default passwords before deploying to a production network.

```bash
cp .env.example .env
nano .env # Or your preferred editor
```

### 3. Setup and Deploy

You can use the provided setup script or run docker-compose directly.

**Option A: Using the setup script (Recommended)**
```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

**Option B: Manual start**
```bash
docker compose up -d
```

## 🔐 Default Administrative Credentials

*(Note: These correspond to the `.env.example` values. Change them in your `.env`!)*

* **Nginx Proxy Manager:** `admin@example.com` / `changeme` (Requires immediate change on first login)
* **Portainer:** Set on first run via the web UI at `https://<server-ip>:9443`
* **pgAdmin:** `admin@example.com` / `super_secret_pgadmin_password`
* **MinIO:** `admin` / `super_secret_minio_password`
* **Dozzle:** `admin` / `super_secret_dozzle_password`
* **Mongo-Express:** `admin` / `super_secret_mongo_express`
* **RabbitMQ:** `admin` / `super_secret_rabbitmq_password`
* **ELK (Elasticsearch/Kibana):** Setup required; `elastic` / `super_secret_elastic_password`

## 📁 Project Structure

```text
.
├── config/
│   └── freeradius/       # RADIUS configuration files
│       ├── clients.conf
│       └── users
├── scripts/
│   ├── setup.sh          # Initialization script
│   ├── backup.sh         # Database backup script
│   └── restore.sh        # Database restore script
├── volumes/              # Directory for bind mounts (if any)
├── .env.example          # Template for environment variables
├── .gitignore            # Ignores sensitive and local files
├── docker-compose.yml    # Core infrastructure orchestration
└── README.md             # This documentation
```

## 💾 Backups and Maintenance

Two scripts are provided in the `scripts/` directory to help manage your databases:

* **Backup:** Run `./scripts/backup.sh` to generate SQL/archive dumps of MySQL, PostgreSQL, and MongoDB to a local `backups/` folder.
* **Restore:** Run `./scripts/restore.sh <backup_date>` to restore the databases from a specific backup timestamp.

## 🛑 Stopping the Stack

To gracefully stop all services without losing data:

```bash
docker compose down
```

To remove all services **AND delete all persistent data** (use with extreme caution):

```bash
docker compose down -v
```

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.
