#!/bin/sh -l

echo "DOCKER BUILD AND PUSH"

echo "Environment: "
echo "- BUILD_PATH: ${BUILD_PATH}";
echo "- DOCKER_FILE: ${DOCKER_FILE}";
echo "- CONTAINER_TAG: ${CONTAINER_TAG}";

ls -al

if [ -n "${BUILD_PATH}" ]
then
   cd ${BUILD_PATH}
fi

ls -al

docker build -f ${DOCKER_FILE} . -t ${CONTAINER_TAG}

docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}

docker push ${CONTAINER_TAG}
