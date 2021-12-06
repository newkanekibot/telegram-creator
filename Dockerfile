# syntax=docker/dockerfile:1
FROM docker.io/node:16-alpine AS build-env
ENV NODE_ENV production

# Install dependencies first, as they change less often => better caching
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

# Don't need to run the bot as root
USER node

# Enviroment
COPY ./.env_example ./.env* ./

# Copy actual code into the image.
COPY . .

# Run the actual program, exit on unhandled rejections
CMD ["--unhandled-rejections=strict","albumMeBot.js"]
