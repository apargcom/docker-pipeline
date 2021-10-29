FROM node:14.18.0-alpine@sha256:fe676cd79c27a562f8be7b0c57255b0457ac66d5c32d9ab88a9e836d92a6f6ea AS base

EXPOSE 3000
WORKDIR /usr/src/app

FROM base AS prod

ENV NODE_ENV production
COPY --chown=node:node package*.json ./
RUN npm ci --only=production
COPY --chown=node:node . .
USER node
CMD npm start

FROM base AS dev

ENV NODE_ENV development
CMD npm install && npm run dev