#!/bin/bash
set -e

echo "🚀 Starting setup for Docker Infra..."

# 1. Create .env if it doesn't exist
if [ ! -f .env ]; then
    echo "📋 Copying .env.example to .env..."
    cp .env.example .env
    echo "⚠️  Please edit .env to set your secure passwords!"
else
    echo "✅ .env file already exists."
fi

# 2. Create volumes dir (used for bind mounts if needed later)
mkdir -p volumes
touch volumes/.gitkeep

# 3. Create Docker network if it doesn't exist
if ! docker network ls | grep -q "inhouse_network"; then
    echo "🌐 Creating docker network 'inhouse_network'..."
    docker network create inhouse_network
else
    echo "✅ Network 'inhouse_network' already exists."
fi

echo "✅ Setup complete. You can now run: docker compose up -d"
