FROM node:lts-alpine@sha256:b2da3316acdc2bec442190a1fe10dc094e7ba4121d029cb32075ff59bb27390a as base

WORKDIR /usr/src/app
EXPOSE 3000

FROM base as dev

RUN npm install
CMD ["npm", "run", "dev"]

FROM base as production

ENV NODE_ENV production
COPY --chown=node:node package*.json ./
RUN npm ci --only=production
COPY --chown=node:node . .
USER node
CMD ["npm", "start"]