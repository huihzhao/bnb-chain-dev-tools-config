FROM node:12.22.7 AS builder

WORKDIR /app

COPY . .

RUN yarn install
ENV NODE_ENV production
RUN ./scripts/build.sh

FROM nginx:alpine
WORKDIR /usr/share/nginx/html

COPY build/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/public /usr/share/nginx/html

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]