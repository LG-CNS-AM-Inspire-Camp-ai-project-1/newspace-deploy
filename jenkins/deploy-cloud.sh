#!/bin/sh

# git clone https://${GIT_PASS}@github.com/LG-CNS-AM-Inspire-Camp-ai-project-1/newspace-frontend
# git clone https://${GIT_PASS}@github.com/LG-CNS-AM-Inspire-Camp-ai-project-1/newspace-deploy

currentDir=$(pwd -P);
remoteID="lgcns"
remoteIP="172.21.1.22"
remoteBaseDir="/home/lgcns/docker"
mountDir=$currentDir/mount;
separationPhrase="=====================================";

DOCKER_NICKNAME="kudong"
BACKEND_IMAGE_NAME="newspace-backend"
FRONTEND_IMAGE_NAME="newspace-frontend"
EUREKA_IMAGE_NAME="newspace-eureka"
GATEWAY_IMAGE_NAME="newspace-gateway"

DEPLOY_NAME="newspace-deploy"
TAG="latest"

echo $separationPhrase
echo
echo "Newspace Deploy Process Start......"
echo 
echo $separationPhrase
echo
echo "currentDir = $currentDir" 
echo "mountDir = $mountDir" 
echo "remoteID = $remoteID" 
echo "remoteIP = $remoteIP" 
echo "DOCKER_NICKNAME = $DOCKER_NICKNAME" 
echo "BACKEND_IMAGE_NAME = $BACKEND_IMAGE_NAME"
echo "FRONTEND_IMAGE_NAME = $FRONTEND_IMAGE_NAME"
echo "DEPLOY_NAME = $DEPLOY_NAME"
echo "TAG = $TAG"
echo
echo $separationPhrase


#프론트 도커 파일 이미지 경로 생성
mkdir -p $currentDir/images;

#프로젝트 별 설정파일 복사
cp -r -f ./$DEPLOY_NAME/release/frontend/* $currentDir/$FRONTEND_IMAGE_NAME/$FRONTEND_IMAGE_NAME
cp -r -f ./$DEPLOY_NAME/release-cloud/eureka/* $currentDir/$EUREKA_IMAGE_NAME
cp -r -f ./$DEPLOY_NAME/release-cloud/gateway/* $currentDir/$GATEWAY_IMAGE_NAME
cp -r -f ./$DEPLOY_NAME/release-cloud/backend/* $currentDir

echo
echo "REMOTE SERVER STOP AND CLEAN DOCKER BUILD CACHE...."
echo 
echo $separationPhrase

ssh lgcns@172.21.1.22 /bin/bash <<'EOT'
cd /home/lgcns/docker
echo "currentDir => $(pwd -P)"

#도커 컴포즈 종료
docker compose down
docker compose -f docker-compose-cloud.yml down

#도커 이미지 제거
docker image rmi newspace-backend:latest
docker image rmi newspace-frontend:latest
docker image rmi newspace-eureka:latest
docker image rmi newspace-gateway:latest
docker image prune -f
docker builder prune -a -f
echo
docker images -a
EOT

echo
echo $separationPhrase
echo
echo "EUREKA BUILD Start...."
echo 
echo $separationPhrase

#유레카 도커 파일 빌드
cd $currentDir/$EUREKA_IMAGE_NAME
chmod +x gradlew
./gradlew clean build -x test
docker buildx build --no-cache -t $EUREKA_IMAGE_NAME:$TAG .

#유레카 도커 파일 tar 저장
docker save -o $currentDir/images/$EUREKA_IMAGE_NAME.tar $EUREKA_IMAGE_NAME:$TAG

echo $separationPhrase
echo
echo "GATEWAY BUILD Start...."
echo 
echo $separationPhrase

#게이트웨이 도커 파일 빌드
cd $currentDir/$GATEWAY_IMAGE_NAME
chmod +x gradlew
./gradlew clean build -x test
docker buildx build --no-cache -t $GATEWAY_IMAGE_NAME:$TAG .

#게이트웨이 도커 파일 tar 저장
docker save -o $currentDir/images/$GATEWAY_IMAGE_NAME.tar $GATEWAY_IMAGE_NAME:$TAG

echo $separationPhrase
echo
echo "FRONTEND BUILD Start...."
echo 
echo $separationPhrase

#프론트 도커 파일 빌드
cd $currentDir/$FRONTEND_IMAGE_NAME/$FRONTEND_IMAGE_NAME
docker buildx build --no-cache --build-arg NEWSPACE_TEST_BACKEND_URL=http://kudong.kr:55021/ -t $FRONTEND_IMAGE_NAME:$TAG .

#프론트 도커 파일 tar 저장
docker save -o $currentDir/images/$FRONTEND_IMAGE_NAME.tar $FRONTEND_IMAGE_NAME:$TAG

echo $separationPhrase
echo
echo "BACKEND BUILD Start...."
echo 
echo $separationPhrase

#백엔드 도커 이미지 빌드
cd $currentDir
chmod +x gradlew
./gradlew clean build -x test
docker buildx build -t $BACKEND_IMAGE_NAME:$TAG .

#백엔드 도커 파일 tar 저장
docker save -o $currentDir/images/$BACKEND_IMAGE_NAME.tar $BACKEND_IMAGE_NAME:$TAG

# #도커 허브에 업로드 <= 필요할 시 주석 해제해서 사용할 것
# echo $separationPhrase
# echo
# echo "Upload Image to DockerHub......"
# echo 
# echo $separationPhrase

# docker images
# echo
# echo "DOCKER_USER = $DOCKER_USER"
# echo "DOCKER_PASS = $DOCKER_PASS"
# echo
# echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

# #도커 허브에 업로드할 로컬용 이미지 생성

# cd $currentDir/$FRONTEND_IMAGE_NAME/$FRONTEND_IMAGE_NAME
# docker buildx build --no-cache --build-arg NEWSPACE_TEST_BACKEND_URL=http://localhost:8072/ -t "$DOCKER_NICKNAME/$FRONTEND_IMAGE_NAME:$TAG" .
# cd $currentDir
# docker tag "$BACKEND_IMAGE_NAME:$TAG" "$DOCKER_NICKNAME/$BACKEND_IMAGE_NAME:$TAG"
# docker tag "$EUREKA_IMAGE_NAME:$TAG" "$DOCKER_NICKNAME/$EUREKA_IMAGE_NAME:$TAG"
# docker tag "$GATEWAY_IMAGE_NAME:$TAG" "$DOCKER_NICKNAME/$GATEWAY_IMAGE_NAME:$TAG"

# #도커 허브에 이미지 푸시
# docker push "$DOCKER_NICKNAME/$BACKEND_IMAGE_NAME:$TAG"
# docker push "$DOCKER_NICKNAME/$FRONTEND_IMAGE_NAME:$TAG"
# docker push "$DOCKER_NICKNAME/$EUREKA_IMAGE_NAME:$TAG"
# docker push "$DOCKER_NICKNAME/$GATEWAY_IMAGE_NAME:$TAG"

# #임시 이미지 제거
# docker image rmi $DOCKER_NICKNAME/$FRONTEND_IMAGE_NAME:$TAG
# docker image rmi $DOCKER_NICKNAME/$BACKEND_IMAGE_NAME:$TAG
# docker image rmi $DOCKER_NICKNAME/$EUREKA_IMAGE_NAME:$TAG
# docker image rmi $DOCKER_NICKNAME/$GATEWAY_IMAGE_NAME:$TAG
# docker image prune -f

#마운트 시작
echo $separationPhrase
echo
echo "Remote Server Mount...."
echo 
echo $separationPhrase

mkdir -p $mountDir;

sshfs $remoteID@$remoteIP:$remoteBaseDir $mountDir;
echo
echo "=> Successfully Mounted sshfs $remoteID@$remoteIP:$remoteBaseDir <=> $mountDir";
echo
echo $separationPhrase
echo
echo "Copy Docker images to Remote Server...."
echo 
echo $separationPhrase

#복사
echo
cp -r -f $currentDir/images/*.tar $mountDir;
echo "=> Successfully copied Docker images to Remote Server"
echo

#touch $mountDir/hello.txt;

echo $separationPhrase
echo
echo "Remote Server UnMount...."
echo 
echo $separationPhrase

#언마운트
echo
umount $mountDir;
echo "=> Successfully Unmounted sshfs $remoteID@$remoteIP:$remoteBaseDir <=> $mountDir"
echo

echo $separationPhrase
echo
echo "Run Docker Container in Remote Server...."
echo 
echo $separationPhrase

ssh lgcns@172.21.1.22 /bin/bash <<'EOT'
echo
echo "Remote Server Environment: $( uname -a )"
echo "login user => $( whoami )"
cd /home/lgcns/docker
echo "currentDir => $(pwd -P)"

#도커 이미지 로드
docker load -i newspace-backend.tar
docker load -i newspace-frontend.tar
docker load -i newspace-eureka.tar
docker load -i newspace-gateway.tar

#도커 컴포즈 시작
docker compose -f docker-compose-cloud.yml up -d --scale newspace-backend=3
EOT

echo
echo "Newspace Deploy Finished!"