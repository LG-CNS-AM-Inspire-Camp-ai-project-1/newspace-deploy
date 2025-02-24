#프론트 도커 파일 
FROM	 node:22.13.1 AS builder
WORKDIR  /app
COPY	 . .
RUN 	 npm install
RUN 	 npm run build

FROM	 nginx
ARG      NEWSPACE_TEST_BACKEND_URL
ENV      NEWSPACE_TEST_BACKEND_URL=$NEWSPACE_TEST_BACKEND_URL
COPY	 --from=builder /app/dist /usr/share/nginx/html
COPY	 --from=builder /app/nginx.conf /etc/nginx/conf.d
RUN      rm /etc/nginx/conf.d/default.conf