#!/bin/bash

usage_exit() {
  echo "Usage: sh $0 [-v VERSION] [-b PREV_DATE] [-d DATE] [-n BINARY_NAME] [-p BINARY_PATH]"
  exit 1
}

while getopts v:b:d:n:p:h OPT
do
  case $OPT in
    v) VERSION=$OPTARG;;
    b) PREV_DATE=$OPTARG;;
    d) DATE=$OPTARG;;
    n) BINARY_NAME=$OPTARG;;
    p) BINARY_PATH=$OPTARG;;
    h) usage_exit ;;
    *) usage_exit ;;
  esac
done

cp ./manifest.plist ./Archives/manifest_$PREV_DATE.plist
echo "[Done] Archive manifest_"$PREV_DATE

gsed -i "s/$PREV_DATE/$DATE/g" ./manifest.plist
echo "[Done] Update manifest"

ACCESS_TOKEN=`cat ./secret/access_token`
echo $ACCESS_TOKEN

TAG=$VERSION-$DATE
git tag $TAG && git push --tags
echo "[Done] push tag:" $TAG

echo "Now Releasing:" $TAG
sh ./app_release.sh \
    -t $ACCESS_TOKEN \
    -v $VERSION \
    -d $DATE \
    -n $BINARY_NAME \
    -p $BINARY_PATH