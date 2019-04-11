#!/usr/bin/env bash
set -e

DOCKER_CROSS_IMAGE=vault-cross

# Get the version from the command line
VERSION=$1
if [ -z $VERSION ]; then
  echo "Please specify a version."
  exit 1
fi

if [ -z $NOBUILD ] && [ -z $DOCKER_CROSS_IMAGE ]; then
  echo "Please set the Docker cross-compile image in DOCKER_CROSS_IMAGE"
  exit 1
fi

# Get the parent directory of where this script is.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

# Change into that dir because we expect that
cd $DIR

if [ -z $RELBRANCH ]; then
  RELBRANCH=localrelease
fi

# Build the packages
if [ -z $NOBUILD ]; then
  # This should be a local build of the Dockerfile in the cross dir
  docker run --rm -v "$(pwd)":/gopath/src/github.com/hashicorp/vault -w /gopath/src/github.com/hashicorp/vault ${DOCKER_CROSS_IMAGE}
fi

# Zip all the files
rm -rf ./pkg/dist
mkdir -p ./pkg/dist
for FILENAME in $(find ./pkg -mindepth 1 -maxdepth 1 -type f); do
  FILENAME=$(basename $FILENAME)
  cp ./pkg/${FILENAME} ./pkg/dist/vault_${VERSION}_${FILENAME}
done

exit 0
