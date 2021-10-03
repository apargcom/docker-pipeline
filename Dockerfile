FROM node:lts-alpine@sha256:1fdf68e175b39915e740da73269970b0a0a881c497865bc7b5accb9bd83a7811 AS base

WORKDIR /usr/src/app
ARG APP_PORT
EXPOSE $APP_PORT

FROM base AS prod

ENV NODE_ENV production
COPY --chown=node:node package*.json ./
RUN npm ci --only=production
COPY --chown=node:node . .
USER node
CMD ["npm", "start"]

FROM base AS dev

ENV NODE_ENV development
RUN npm install
CMD ["npm", "run", "dev"]