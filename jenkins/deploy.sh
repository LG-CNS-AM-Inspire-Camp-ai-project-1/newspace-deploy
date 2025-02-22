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
cp -r -f ./$DEPLOY_NAME/release/backend/* $currentDir

echo
echo "REMOTE SERVER STOP...."
echo 
echo $separationPhrase

ssh lgcns@172.21.1.22 /bin/bash <<'EOT'
cd /home/lgcns/docker
echo "currentDir => $(pwd -P)"

#도커 컴포즈 종료
docker compose down

#도커 이미지 제거
docker image rmi newspace-backend:latest
docker image rmi newspace-frontend:latest
docker image prune -f
echo
docker images -a
EOT

echo
echo $separationPhrase
echo
echo "FRONTEND BUILD Start...."
echo 
echo $separationPhrase

#프론트 도커 파일 빌드
cd $currentDir/$FRONTEND_IMAGE_NAME/$FRONTEND_IMAGE_NAME
docker image build --no-cache -t $FRONTEND_IMAGE_NAME:$TAG .

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
docker image build -t $BACKEND_IMAGE_NAME:$TAG .

#백엔드 도커 파일 tar 저장
docker save -o $currentDir/images/$BACKEND_IMAGE_NAME.tar $BACKEND_IMAGE_NAME:$TAG

#도커 허브에 업로드
echo $separationPhrase
echo
echo "Upload Image to DockerHub......"
echo 
echo $separationPhrase

docker images
echo
echo "DOCKER_USER = $DOCKER_USER"
echo "DOCKER_PASS = $DOCKER_PASS"
echo
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

#허브 이미지 생성
docker tag "$BACKEND_IMAGE_NAME:$TAG" "$DOCKER_NICKNAME/$BACKEND_IMAGE_NAME:$TAG"
docker tag "$FRONTEND_IMAGE_NAME:$TAG" "$DOCKER_NICKNAME/$FRONTEND_IMAGE_NAME:$TAG"

#허브 이미지 푸시
docker push "$DOCKER_NICKNAME/$BACKEND_IMAGE_NAME:$TAG"
docker push "$DOCKER_NICKNAME/$FRONTEND_IMAGE_NAME:$TAG"

#허브 이미지 제거
docker image rmi $DOCKER_NICKNAME/$FRONTEND_IMAGE_NAME:$TAG
docker image rmi $DOCKER_NICKNAME/$BACKEND_IMAGE_NAME:$TAG
docker image prune -f

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

#도커 컴포즈 시작
docker compose up -d
EOT

echo
echo "Newspace Deploy Finished!"