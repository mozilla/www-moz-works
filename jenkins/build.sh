#!/bin/bash
set -xe

# Workaround to ignore mtime until we upgrade to Docker 1.8
# See https://github.com/docker/docker/pull/12031
find . -newerat 20140101 -exec touch -t 201401010000 {} \;

docker build -t $PRIVATE_REGISTRY/$DOCKER_REPO:$GIT_COMMIT .
docker push $PRIVATE_REGISTRY/$DOCKER_REPO:$GIT_COMMIT

deis login $DEIS_CONTROLLER  --username $DEIS_USERNAME --password $DEIS_PASSWORD
deis pull $DOCKER_REPO:$GIT_COMMIT -a $DOCKER_REPO
