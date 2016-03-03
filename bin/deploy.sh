#!/bin/bash
set -e

docker login -e "$DOCKER_EMAIL" -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"
docker push ${DOCKER_IMAGE_TAG}
docker tag -f ${DOCKER_IMAGE_TAG} ${DOCKER_REPOSITORY}:last_successful_build
docker push ${DOCKER_REPOSITORY}:last_successful_build

# Install deis client
curl -sSL http://deis.io/deis-cli/install.sh | sh
./deis login $DEIS_CONTROLLER  --username $DEIS_USERNAME --password $DEIS_PASSWORD
./deis pull ${DOCKER_IMAGE_TAG} -a $1
