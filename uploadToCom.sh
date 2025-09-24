#!/bin/bash
#当前脚本是通过核心SDK中的Generate_uploadToCom.sh 脚本自动生成的。如果需要改脚本，请到那个脚本中进行修改

# SDK的版本号
version=$1

echo "========================="

if [ -z "$version" ]; then
   echo "============版本号不能为空==============="
   echo "Usage: bash uploadToCom.sh 1.0.0"
   exit
fi

# 开始打稳定版小程序SDK
echo "=======发布 stable 版========"
cp -r FinAppletWXExt.tpl.podspec FinAppletWXExt.podspec

sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

echo ">>>>>>>>>>> start upload to com FinPods"
git clone https://git.finogeeks.com/cocoapods/FinPods

rm -rf FinPods/FinAppletWXExt/${version}

mkdir -p FinPods/FinAppletWXExt/${version}
cp FinAppletWXExt.podspec FinPods/FinAppletWXExt/${version}/FinAppletWXExt.podspec
cd FinPods

git add FinAppletWXExt/${version} && git commit -m "upgrade FinAppletWXExt ${version}" && git push

cd ..

rm -rf FinPods

git reset --hard
