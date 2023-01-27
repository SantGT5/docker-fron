FROM node:18.13-alpine as builder

WORKDIR /app

COPY ./package.json ./

RUN npm install

COPY  ./ ./

RUN npm run build

# nginx config
FROM nginx:1.23.3

EXPOSE 80

# /app/build is the result of "npm run build"
# is the path of our project that
# we want to be in production
COPY --from=builder /app/build /usr/share/nginx/html