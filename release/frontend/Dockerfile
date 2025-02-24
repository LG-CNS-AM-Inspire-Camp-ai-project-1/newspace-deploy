#프론트 도커 파일 
FROM	 node:22.13.1 AS builder
ARG      NEWSPACE_TEST_BACKEND_URL
RUN      echo "NEW BUILD NO CACHE => ${NEWSPACE_TEST_BACKEND_URL}" > /tmp/value.txt
ENV      VITE_NEWSPACE_TEST_BACKEND_URL=$NEWSPACE_TEST_BACKEND_URL
WORKDIR  /app
COPY	 . .
RUN 	 npm install
RUN 	 npm run build

FROM	 nginx
COPY	 --from=builder /app/dist /usr/share/nginx/html
COPY	 --from=builder /app/nginx.conf /etc/nginx/conf.d
RUN      rm /etc/nginx/conf.d/default.conf