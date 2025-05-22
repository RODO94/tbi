FROM node:20-alpine AS base

WORKDIR /home/src

COPY package*.json pnpm-lock.yaml ./
COPY tbi-client/package*.json tbi-client/pnpm-lock.yaml ./tbi-client/
COPY tbi-server/package*.json tbi-server/pnpm-lock.yaml ./tbi-server/

# Install pnpm globally
RUN npm install -g pnpm@10.9.0

# Copy client code to dir and install dependencies
FROM base AS client-builder
WORKDIR /home/src/tbi-client
COPY tbi-client/ .
RUN pnpm install --frozen-lockfile
RUN pnpm build

# Copy server code to dir and install dependencies
FROM base AS server-builder
WORKDIR /home/src/tbi-server
COPY tbi-server/ .
RUN pnpm install --frozen-lockfile
RUN pnpm run build


# Bring client and server together
RUN mkdir -p tbi-server/public && \
        echo "📁 Copying client build files to server..."; \
        cp -r tbi-client/dist/* tbi-server/public/; \
        echo "✅ Client files copied successfully"; 

        
# Set environment variables
ENV NODE_ENV=production
ENV PORT=8080

# Expose port 8080 as required
EXPOSE 8080

# Default command to start the application
CMD ["node", "tbi-server/dist/index.js"]
