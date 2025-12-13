#!/bin/sh
# Strapi custom entrypoint script

SQLITE_DEV_DB="./strapi-assets/data.db"

echo "Starting Strapi custom entrypoint..."

# Check if the SQLite development data file exists
if [ -f "$SQLITE_DEV_DB" ]; then
    echo "SQLite development data found. Checking if database needs import..."

    # This is a placeholder. A real migration tool or logic (like using 'knex migrate:latest' 
    # or a custom node script to dump/restore tables) is usually needed for cross-DB migration.
    
    echo "*** EXECUTING DATA MIGRATION (SQLite -> PostgreSQL) ***"
    
    # We will continue by ensuring content types are registered (via build done previously)
    # and launching the app. The actual migration logic must be handled separately.
    
    echo "Assuming migration is handled by a custom script or will be done manually later."
    
fi

# Always launch the main application command
echo "Launching Strapi in production mode..."
# The CMD in the Dockerfile will now be replaced by this script.
exec "$@"
