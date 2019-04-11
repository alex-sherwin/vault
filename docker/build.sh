#!/usr/bin/env bash
set -e

# Get the root project directory
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
PROJECT_DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

# the project pkg dir
PKG_DIR=${PROJECT_DIR}/pkg

# the project docker dir
DOCKER_DIR=${PROJECT_DIR}/docker

# copy the built packages into the docker dir (so they can be available to the docker build context)
rm -rf ${DOCKER_DIR}/pkg || echo "no pkg dir to remove"
cp -R ${PKG_DIR} ${DOCKER_DIR}/pkg

docker build -t nexus3.acadiasoft.net:4443/vault:1.1.0_01 .