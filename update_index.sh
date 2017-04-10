#!/bin/bash

usage_exit() {
  echo "Usage: sh $0 [-b PREV_DATE] [-c CURRENT_DATE]"
  exit 1
}

while getopts b:c:h OPT
do
  case $OPT in
    b) PREV_DATE=$OPTARG;;
    c) CURRENT_DATE=$OPTARG;;
    h) usage_exit ;;
    *) usage_exit ;;
  esac
done

cat Templates/1 > index.html
echo $CURRENT_DATE >> index.html
cat Templates/2 >> index.html

echo '<li>' >> index.html
echo '<p>' >> index.html
echo "<a href=\"itms-services://?action=download-manifest&url=https://github.com/Kular/Kular.github.io/raw/master/Archives/manifest_$PREV_DATE.plist\">" >> index.html
echo $PREV_DATE >> index.html
echo '</a>' >> index.html
echo '</p>' >> index.html
echo '</li>' >> index.html
cat Templates/3 >> index.html

cp Templates/3 Templates/4
echo '<li>' > Templates/3
echo '<p>' >> Templates/3
echo "<a href=\"itms-services://?action=download-manifest&url=https://github.com/Kular/Kular.github.io/raw/master/Archives/manifest_$PREV_DATE.plist\">" >> Templates/3
echo $PREV_DATE >> Templates/3
echo '</a>' >> Templates/3
echo '</p>' >> Templates/3
echo '</li>' >> Templates/3
cat Templates/4 >> Templates/3
rm Templates/4

echo "[Done] Update index.html"