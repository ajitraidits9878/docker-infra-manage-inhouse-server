#!/bin/bash

# Configuration
BACKUP_DIR="./backups"
DATE=$(date +"%Y%m%d_%H%M%S")

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

echo "💾 Starting database backups..."

# Source env variables for passwords
if [ -f .env ]; then
  source .env
else
  echo "❌ Error: .env file not found."
  exit 1
fi

# 1. Backup MySQL
echo "📦 Backing up MySQL..."
docker exec mysql /usr/bin/mysqldump -u root --password="${MYSQL_ROOT_PASSWORD}" --all-databases > "$BACKUP_DIR/mysql_full_$DATE.sql"
gzip "$BACKUP_DIR/mysql_full_$DATE.sql"

# 2. Backup PostgreSQL
echo "📦 Backing up PostgreSQL..."
docker exec postgres pg_dumpall -U "${POSTGRES_USER}" > "$BACKUP_DIR/postgres_full_$DATE.sql"
gzip "$BACKUP_DIR/postgres_full_$DATE.sql"

# 3. Backup MongoDB
echo "📦 Backing up MongoDB..."
docker exec mongo mongodump --username="${MONGO_INITDB_ROOT_USERNAME}" --password="${MONGO_INITDB_ROOT_PASSWORD}" --authenticationDatabase=admin --archive > "$BACKUP_DIR/mongo_full_$DATE.archive"
gzip "$BACKUP_DIR/mongo_full_$DATE.archive"

echo "✅ Backups completed and saved in $BACKUP_DIR"
ls -lh "$BACKUP_DIR"
