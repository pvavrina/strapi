#!/bin/sh

# This script is the entrypoint for the Strapi application in production.
# It ensures all required commands are executed before starting the server.

# We rely on Strapi's built-in migration to handle schema updates
# and environment variables to handle database connection (PostgreSQL in production).
# We explicitly check for the node_modules presence (optional but safe).
if [ ! -d "node_modules" ]; then
  echo "Node modules not found. Running npm install..."
  npm install
fi

# Start the Strapi application in production mode
echo "Starting Strapi..."
exec "$@"
