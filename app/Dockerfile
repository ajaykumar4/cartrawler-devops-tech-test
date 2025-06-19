FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

# The app listens on port 8000
EXPOSE 8000

CMD [ "npm", "start" ]