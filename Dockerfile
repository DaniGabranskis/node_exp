FROM node:hydrogen-alpine3.21

WORKDIR /app

COPY src/package*.json .

RUN npm install --no-cache-dir -r package*.json

COPY . .

EXPOSE 3000:3000

CMD ["npm","start"]
