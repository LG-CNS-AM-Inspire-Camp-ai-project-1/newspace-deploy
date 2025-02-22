#프론트 도커 파일 
FROM	 node:22.13.1 AS builder
WORKDIR  /app
COPY	 . .
RUN 	 npm install
RUN 	 npm run build

FROM	 nginx
ENV 	 BACKEND_IP=127.0.0.1
ENV 	 BACKEND_PORT=8080
COPY	 --from=builder /app/dist /usr/share/nginx/html
COPY	 --from=builder /app/nginx.conf /etc/nginx/conf.d
RUN      rm /etc/nginx/conf.d/default.conf