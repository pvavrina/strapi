# Use a Node.js base image compatible with Strapi 5.x
FROM node:20-alpine AS base

# Set the working directory
WORKDIR /opt/app

# --- INSTALL SYSTEM BUILD DEPENDENCIES (FOR pg MODULE) ---
# Install tools necessary to compile native Node.js modules like pg on Alpine
RUN apk add --no-cache build-base python3

# --- Install dependencies ---
# Copy package.json and package-lock.json (or yarn.lock)
COPY package.json ./
COPY package-lock.json ./

# Install dependencies
RUN npm install

# --- Copy application files ---
# Copy all local files to the container
COPY . .

#Copy the entrypoint script and the assets folder
COPY entrypoint.sh /opt/app/entrypoint.sh
COPY strapi-assets /opt/app/strapi-assets

#Make the entrypoint script executable
RUN chmod +x /opt/app/entrypoint.sh

# CRITICAL STEP: Build the Strapi Admin UI for production.
# This generates the 'dist' folder inside the container.
RUN npm run strapi build

# Set permissions
RUN chown -R node:node /opt/app

# Change to the non-root user
USER node

# Expose the default Strapi port
EXPOSE 1337

#Use the custom entrypoint script
ENTRYPOINT ["/opt/app/entrypoint.sh"]

#Command to start Strapi in production mode (passed to the entrypoint script)
CMD ["npm", "start"]
