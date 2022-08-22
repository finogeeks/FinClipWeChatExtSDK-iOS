#!/bin/bash
version=$1
message=$2
if [ -z "$message" ]; then
   echo "============发布内容不能为空==============="
   echo "Usage: bash tag.sh 1.0.0 '发布说明文字填这里'"
   exit
fi
git tag |xargs git tag -d
git pull --tags
git tag -d $1
git push origin --delete tag $1
git add -u && git commit -m "add tag $1"
git tag -m "$message" $1
git push --tags