#!/bin/sh -l
set -e

echo "DOCKER BUILD AND PUSH"

echo "Environment: "
echo "- BUILD_PATH: ${BUILD_PATH}";
echo "- DOCKER_FILE: ${DOCKER_FILE}";
echo "- CONTAINER_TAG: ${CONTAINER_TAG}";
echo "- GITHUB_EVENT_NAME: ${GITHUB_EVENT_NAME}";
echo "- GITHUB_EVENT_PATH: ${GITHUB_EVENT_PATH}";
echo "- GITHUB_REF: ${GITHUB_REF}";
echo "- GITHUB_WORKSPACE: ${GITHUB_WORKSPACE}";
echo "- GITHUB_REPOSITORY: ${GITHUB_REPOSITORY}";
echo "- GITHUB_ACTOR: ${GITHUB_ACTOR}";

if [ -z "${DOCKER_FILE}" ]
then
   echo "Do Dockerfile spectified. Using default file: Dockerfile"
   DOCKER_FILE=Dockerfile
fi

if [[ -z "$GITHUB_EVENT_NAME" ]]; then
  echo "Set the GITHUB_EVENT_NAME env variable."
  exit 1
fi

if [[ -z "$GITHUB_EVENT_PATH" ]]; then
  echo "Set the GITHUB_EVENT_PATH env variable."
  exit 1
fi

if [[ -z "$GITHUB_REF" ]]; then
  echo "Set the GITHUB_REF env variable."
  exit 1
fi

ls -al

if [ -n "${BUILD_PATH}" ]
then
   cd ${BUILD_PATH}
fi

ls -al

docker build . -f ${DOCKER_FILE} -t ${CONTAINER_TAG}

docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}

docker push ${CONTAINER_TAG}
