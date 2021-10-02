FROM node:lts-alpine@sha256:b2da3316acdc2bec442190a1fe10dc094e7ba4121d029cb32075ff59bb27390a

# Create app directory
WORKDIR /usr/src/app

# For production open comment and remove volume to app src on docker-compose
#COPY package*.json ./

#RUN npm install
# If you are building your code for production
#RUN npm ci --only=production

# For production open comment and remove volume to app src on docker-composer
#COPY . .

#EXPOSE 3000
#CMD [ "node", "server.js" ]