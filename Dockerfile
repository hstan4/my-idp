FROM node:18
WORKDIR /idp-service
COPY . .
RUN npm install
CMD ["node", "index.js"]
EXPOSE 3000