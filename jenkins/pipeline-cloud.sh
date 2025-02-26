#!/bin/sh

currentDir=$(pwd -P);

git clone https://${GIT_PASS}@github.com/newspaceProject/newspace-frontend
git clone https://${GIT_PASS}@github.com/newspaceProject/newspace-deploy
git clone https://${GIT_PASS}@github.com/newspaceProject/newspace-eureka
git clone https://${GIT_PASS}@github.com/newspaceProject/newspace-gateway

cp -r -f ./newspace-deploy/jenkins/deploy-cloud.sh $currentDir

chmod +x ./deploy-cloud.sh
./deploy-cloud.sh