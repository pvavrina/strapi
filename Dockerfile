# Use a Node.js base image compatible with Strapi 5.x
FROM node:20-alpine AS base

# Set the working directory
WORKDIR /opt/app

# --- Install dependencies ---
# Copy package.json and package-lock.json (or yarn.lock)
COPY package.json ./
COPY package-lock.json ./

# Install dependencies
RUN npm install

# --- Copy application files ---
# Copy all local files to the container
COPY . .

# Set permissions
RUN chown -R node:node /opt/app

# Change to the non-root user
USER node

# Expose the default Strapi port
EXPOSE 1337

# Command to start Strapi in production mode
CMD ["npm", "start"]
