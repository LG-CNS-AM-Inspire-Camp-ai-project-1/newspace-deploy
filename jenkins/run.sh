#!/bin/sh

docker run -d -p 8888:8080 --name jenkins \
  -v /home/lgcns/jenkins:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -u root \
  --device /dev/fuse \
  --cap-add SYS_ADMIN \
  --security-opt apparmor:unconfined \
  newspace/jenkins:lts

if [ "$#" -eq 3 ]; then
    MOUNT_TARGET_USER=$1
    MOUNT_TARGET_PW=$2
    MOUNT_TARGET_IP=$3

    docker exec -it jenkins /bin/bash -c "\
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N '' && \
    sshpass -p '${MOUNT_TARGET_PW}' ssh-copy-id -i ~/.ssh/id_rsa '${MOUNT_TARGET_USER}@${MOUNT_TARGET_IP}'"

fi
