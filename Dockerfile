FROM node:lts
WORKDIR /app
COPY . .
RUN npm install express prom-client
EXPOSE 3000
CMD ["node", "index.js"] 

