#!/bin/sh

currentDir=$(pwd -P);

git clone https://${GIT_PASS}@github.com/newspaceProject/newspace-frontend
git clone https://${GIT_PASS}@github.com/newspaceProject/newspace-deploy

cp -r -f ./newspace-deploy/jenkins/deploy.sh $currentDir

chmod +x ./deploy.sh
./deploy.sh