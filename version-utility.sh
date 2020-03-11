#!/bin/bash

VERSION_FILE=version.txt


readBaseVersion() {
  local VERSION=$(head -n 1 version.txt)
  VERSION=`echo ${VERSION} | sed 's/\\r//g'`
  echo "${VERSION}"
}

validateBaseVersion() {
  local BASE_VERSION=$1
  
  if ! [[ $BASE_VERSION =~ ^[0-9]+\.[0-9]+$ ]]
  then
    echo "The base version is not match <number>.<number>" >&2
	return 1
  fi
  
  if [[ $BASE_VERSION =~ ^0\.0$ ]]
  then
    echo "The version can not be 0.0" >&2
	return 1
  fi
  
  if [[ $BASE_VERSION =~ ^0[0-9]+\. ]]
  then
    echo "The major version can not be prefixed with 0" >&2
	return 1
  fi
  
  if [[ $BASE_VERSION =~ \.0[0-9]+ ]]
  then
    echo "The minor version can not be prefixed with 0" >&2
	return 1
  fi
}

getCheckoutLatestCommitSha() {
  local GIT_SHA=$(git log -n1 --format=format:"%H")
  if [[ "${#GIT_SHA}" -lt 8 ]]
  then
    echo "Could not get the latest Git Sha. Ensure you are running the script in a git repo" >&2
	return 1
  fi
  echo ${GIT_SHA}
}

#BASE_VERSION=$(readBaseVersion)
#validateBaseVersion ${BASE_VERSION}
getCheckoutLatestCommitSha
echo "return value ${?}"  


