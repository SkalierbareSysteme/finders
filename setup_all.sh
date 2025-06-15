#!/bin/bash

missing=0

# Check for docker compose (modern CLI-style)
if ! docker compose version >/dev/null 2>&1; then
  echo "❌ 'docker compose' not found. Please install Docker with Compose v2 support."
  missing=1
else
  echo "✅ 'docker compose' found"
fi

# Check for npm
if ! command -v npm >/dev/null 2>&1; then
  echo "❌ 'npm' not found. Please install Node.js and npm."
  missing=1
else
  echo "✅ 'npm' found"
fi

# Stop if anything is missing
if [ $missing -ne 0 ]; then
  echo "❌ One or more required tools are missing. Exiting..."
  exit 1
fi

#Anfang User und auth
# docker network all
if ! docker network ls --format '{{.Name}}' | grep -q "^shared-net$"; then
  echo "🔧 Creating Docker network 'shared-net'..."
  docker network create shared-net
else
  echo "✅ Docker network 'shared-net' already exists"
fi

# ENV auth
if [ ! -f auth/auth-service/.env ]; then
  if [ -f auth/auth-service/.env.example ]; then
    cp auth/auth-service/.env.example auth/auth-service/.env
    echo "⚠️  'auth/auth-service/.env' was missing — copied from 'auth/auth-service/.env.example'"
  else
    echo "❌ 'auth/auth-service/.env.example' not found — cannot create auth/auth-service/.env"
    exit 1
  fi
fi

# NPM auth
if [ ! -d auth/node_modules ]; then
  echo "📦 Installing dependencies in auth/..."
  (cd auth && npm install)
else
  echo "✅ auth dependencies already installed"
fi

if [ ! -d auth/auth-service/node_modules ]; then
  echo "📦 Installing dependencies in auth/auth-service/..."
  (cd auth/auth-service && npm install)
else
  echo "✅ auth-service dependencies already installed"
fi




# ENV user
if [ ! -f user/user-service/.env ]; then
  if [ -f user/user-service/.env.example ]; then
    cp user/user-service/.env.example user/user-service/.env
    echo "⚠️  'user/user-service/.env' was missing — copied from 'user/user-service/.env.example'"
  else
    echo "❌ 'user/user-service/.env.example' not found — cannot create user/user-service/.env"
    exit 1
  fi
fi

# NPM user
if [ ! -d user/node_modules ]; then
  echo "📦 Installing dependencies in user/..."
  (cd user && npm install)
else
  echo "✅ user dependencies already installed"
fi


if [ ! -d user/user-service/node_modules ]; then
  echo "📦 Installing dependencies in user/user-service/..."
  (cd user/user-service && npm install)
else
  echo "✅ user/user-service dependencies already installed"
fi


#Ende User und auth