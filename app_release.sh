#!/bin/bash

usage_exit() {
  echo "Usage: sh $0 [-t ACCESS_TOKEN] [-v VERSION] [-d DATE] [-n BINARY_NAME] [-p BINARY_PATH]"
  exit 1
}

while getopts t:v:d:n:p:h OPT
do
  case $OPT in
    t) ACCESS_TOKEN=$OPTARG;;
    v) VERSION=$OPTARG;;
    d) DATE=$OPTARG;;
    n) BINARY_NAME=$OPTARG;;
    p) BINARY_PATH=$OPTARG;;
    h) usage_exit ;;
    *) usage_exit ;;
  esac
done

# set your token
export GITHUB_TOKEN=$ACCESS_TOKEN

REPO=Kular.github.io

echo "name:" $VERSION-$DATE

echo "description:" auto build of $DATE

echo "binary:" $BINARY_PATH/$BINARY_NAME

echo "repo:" $REPO

# create a formal release
~/go/bin/github-release release \
    --user kular \
    --repo $REPO \
    --tag $VERSION-$DATE \
    --name $DATE \
    --description "auto build of $DATE" \
    --pre-release

# upload the binary
~/go/bin/github-release upload \
    --user kular \
    --repo $REPO \
    --tag $VERSION-$DATE \
    --name $BINARY_NAME \
    --file $BINARY_PATH/$BINARY_NAME

echo "[Done] " $VERSION-$DATE " Released!" 