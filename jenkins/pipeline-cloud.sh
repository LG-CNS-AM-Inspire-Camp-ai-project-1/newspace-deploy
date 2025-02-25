#!/bin/sh

currentDir=$(pwd -P);

git clone https://${GIT_PASS}@github.com/LG-CNS-AM-Inspire-Camp-ai-project-1/newspace-frontend
git clone https://${GIT_PASS}@github.com/LG-CNS-AM-Inspire-Camp-ai-project-1/newspace-deploy
git clone https://${GIT_PASS}@github.com/LG-CNS-AM-Inspire-Camp-ai-project-1/newspace-eureka
git clone https://${GIT_PASS}@github.com/LG-CNS-AM-Inspire-Camp-ai-project-1/newspace-gateway

cp -r -f ./newspace-deploy/jenkins/deploy-cloud.sh $currentDir

chmod +x ./deploy-cloud.sh
./deploy-cloud.sh