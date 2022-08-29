#!/bin/bash

version=$1
isMajor=$2

echo "========================="
echo "=======isMajor = 0 稳定版========"
echo "=======isMajor = 1 major版========"

if [ -z "$version" ]; then
   echo "============版本号不能为空==============="
   echo "Usage: bash uploadToCom.sh 1.0.0 1"
   exit
fi

if [[ $isMajor == 1 ]]; then
	# major版
	echo "=======发布 major 版========"
	cp -r FinAppletWXExt.dev.tpl.podspec FinAppletWXExt.podspec
else
	# 开始打稳定版小程序SDK
	echo "=======发布 stable 版========"
	cp -r FinAppletWXExt.tpl.podspec FinAppletWXExt.podspec
fi


sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

echo ">>>>>>>>>>> start upload to com FinPods  " 
git clone https://git.finogeeks.com/cocoapods/FinPods

rm -rf FinPods/FinAppletWXExt/${version}

mkdir -p FinPods/FinAppletWXExt/${version}
cp FinAppletWXExt.podspec FinPods/FinAppletWXExt/${version}/FinAppletWXExt.podspec
cd FinPods

git add FinAppletWXExt/${version} && git commit -m "upgrade FinAppletWXExt ${version}" && git push

cd ..

rm -rf FinPods

git reset --hard
