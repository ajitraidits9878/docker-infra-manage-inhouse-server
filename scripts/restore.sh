#!/bin/bash

# Check arguments
if [ -z "$1" ]; then
  echo "Usage: ./restore.sh <timestamp>"
  echo "Example: ./restore.sh 20230710_153000"
  exit 1
fi

TIMESTAMP=$1
BACKUP_DIR="./backups"

# Source env variables
if [ -f .env ]; then
  source .env
else
  echo "❌ Error: .env file not found."
  exit 1
fi

echo "⚠️ WARNING: This will overwrite existing databases."
read -p "Are you sure you want to proceed? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# 1. Restore MySQL
MYSQL_FILE="$BACKUP_DIR/mysql_full_$TIMESTAMP.sql.gz"
if [ -f "$MYSQL_FILE" ]; then
    echo "📥 Restoring MySQL from $MYSQL_FILE..."
    zcat "$MYSQL_FILE" | docker exec -i mysql /usr/bin/mysql -u root --password="${MYSQL_ROOT_PASSWORD}"
    echo "✅ MySQL restored."
else
    echo "❌ MySQL backup $MYSQL_FILE not found."
fi

# 2. Restore PostgreSQL
PG_FILE="$BACKUP_DIR/postgres_full_$TIMESTAMP.sql.gz"
if [ -f "$PG_FILE" ]; then
    echo "📥 Restoring PostgreSQL from $PG_FILE..."
    zcat "$PG_FILE" | docker exec -i postgres psql -U "${POSTGRES_USER}" -d postgres
    echo "✅ PostgreSQL restored."
else
    echo "❌ PostgreSQL backup $PG_FILE not found."
fi

echo "🎉 Restore process completed."
