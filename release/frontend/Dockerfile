#프론트 도커 파일 
FROM	 node:22.13.1 AS builder
ENV 	 BACKEND_IP=127.0.0.1
ENV 	 BACKEND_PORT=8080
WORKDIR  /app
COPY	 . .
RUN 	 npm install
RUN 	 npm run build

FROM	 nginx
COPY	 --from=builder /app/dist /usr/share/nginx/html