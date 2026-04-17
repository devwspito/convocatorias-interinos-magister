# -- Stage 1: Build Frontend ---------------------------------------------
FROM node:20-slim AS frontend-builder

WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json* ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# -- Stage 2: Production --------------------------------------------
FROM node:20-slim

WORKDIR /app

# Install backend deps
COPY package.json package-lock.json* ./
RUN npm install --omit=dev

# Copy backend source
COPY src/ ./src/

# Copy frontend build output
COPY --from=frontend-builder /app/frontend/dist ./frontend/dist

# Copy seed data
COPY data/ ./data/

# Default env vars (override at runtime)
ENV PORT=3000
ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "src/index.js"]
