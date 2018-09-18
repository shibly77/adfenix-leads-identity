#!/bin/bash
source ../deploy-envs.sh

#AWS_ACCOUNT_NUMBER={} set in private variable
export AWS_ECS_REPO_DOMAIN=$AWS_ACCOUNT_NUMBER.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com

#Get and copy deps
git clone https://github.com/AdfenixLeads/adfenix-leads-core.git ../../adfenix-leads-core
mkdir -p ../app/deps && cp -r ../../adfenix-leads-core ../app/deps


# Build process
docker build -t $IMAGE_NAME ../
docker tag $IMAGE_NAME $AWS_ECS_REPO_DOMAIN/$IMAGE_NAME:$IMAGE_VERSION
