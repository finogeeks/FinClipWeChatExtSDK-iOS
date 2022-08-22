#!/bin/bash

version=$1
if [ -z "$version" ]; then
   echo "============版本号不能为空==============="
   echo "Usage: bash packSta.sh 2.35.13 "
   exit
fi

echo ">>>>🍏🍏🍏🍏>>>>>>> 当前版本: ${version}"

echo ">>>【4444】>>>>>>>>[Release] add  FinAppletWXExt tag start"

git add .
git commit -m "version++"
git tag -d ${version}
git push origin --delete tag ${version}
git tag -a ${version} -m 'FinClipWebRTC发版'
git push origin HEAD:refs/heads/master --tags -f

echo ">>>【4444】>>>>>>>>[Release] add  FinAppletWXExt tag end"


# 开始打Release版SDK
cp -r Podfile.tpl Podfile
sed -i "" "s/__finapplet_version__/${version}/g" Podfile

pod update
rm -rf build dist


fastlane deploy


# 修改podspec文件
cp -r FinAppletWXExt.tpl.podspec FinAppletWXExt.podspec
sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec
# 内存拷贝进FinAppletWXExt.dist.podspec 便于查看打出的framework
cp -f FinAppletWXExt.podspec FinAppletWXExt.dist.podspec


echo ">>>>🍎🍎🍎🍎>>>>>[Release] upgrading FinPods start"
git clone ssh://git.finogeeks.club/finoapp-ios/FinPods
rm -rf FinPods/FinAppletWXExt/${version}

mkdir -p FinPods/FinAppletWXExt/${version}
cp FinAppletWXExt.podspec FinPods/FinAppletWXExt/${version}/FinAppletWXExt.podspec
cd FinPods

git add FinAppletWXExt/${version} && git commit -m "upgrade FinAppletWXExt ${version}" && git push

cd ..
rm -rf FinPods
echo ">>>>🍎🍎🍎🍎>>>>>>>[Release] upgrading FinPods end"


echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec start"
cp -r FinAppletWXExt.code.tpl.podspec FinAppletWXExt.podspec
sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

git add . 
git commit -m "update ${version} code FinAppletWXExt.podspec "
git push origin HEAD:refs/heads/master
echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec end"

echo ">>>>🍏🍏🍏🍏>>>>>>>[Release] upgrading FinAppletWXExt github start"
git clone --depth=1 ssh://git@github.com/finogeeks/FinAppletWXExt.git
cd FinAppletWXExt

cp -r ../dist/Release/FinAppletWXExt.framework .
cp -r FinAppletWXExt.tpl.podspec FinAppletWXExt.podspec
sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

git add .
git commit -m "version++"
git tag -d ${version}
git push origin --delete tag ${version}
git tag -a ${version} -m 'FinAppletWXExt发版'
git push origin HEAD:refs/heads/master --tags -f

cd ..
rm -rf FinAppletWXExt

echo ">>>>🍏🍏🍏🍏>>>>>>>[Release] upgrading FinAppletWXExt github end"
