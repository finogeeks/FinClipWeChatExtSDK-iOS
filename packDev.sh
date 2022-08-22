#!/bin/bash

branch=$1
version=$2

echo ">>>>>>>>>>> 当前分支: ${branch};"

echo ">>>>>>>>>>> 版本: ${version}"

if [ -z "$branch" ]; then
   echo "============版本号不能为空==============="
   echo "示例: bash packDev.sh stable_dev 2.35.14 "
   exit
fi

if [ -z "$version" ]; then
   echo "============版本号不能为空==============="
   echo "示例: bash packDev.sh stable_dev 2.35.14 "
   exit
fi

git reset --hard

git checkout ${branch}

git pull

bundle install --path vendor/cache

cp -r Podfile.dev.tpl Podfile
sed -i "" "s/__finapplet_version__/${version}/g" Podfile

git add .
git commit -m "version++"
git tag -d ${version}
git push origin --delete tag ${version}
git tag -a ${version} -m 'FinClipSDK发版'
git push origin HEAD:refs/heads/master --tags -f

rm -rf build dist

pod update 

fastlane dev createReport:false

# 开始打Release版小程序SDK
cp -r FinAppletWXExt.dev.tpl.podspec FinAppletWXExt.podspec

# 替换版本号
sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

# 拷贝进FinAppletWXExt.dist.podspec 便于查看打出的framework
cp -f FinAppletWXExt.podspec FinAppletWXExt.dist.podspec


echo ">>>>>>>>>>>[Release] start upgrading FinPods"
git clone ssh://git.finogeeks.club/finoapp-ios/DevPods

rm -rf DevPods/FinAppletWXExt/${version}

mkdir -p DevPods/FinAppletWXExt/${version}
cp FinAppletWXExt.podspec DevPods/FinAppletWXExt/${version}/FinAppletWXExt.podspec
cd DevPods

git add FinAppletWXExt/${version} && git commit -m "upgrade FinAppletWXExt ${version}" && git push

cd ..

rm -rf DevPods

# 生成源码依赖的podspec
echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec"

cp -r FinAppletWXExt.code.tpl.podspec FinAppletWXExt.podspec

sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

commitbranch=`echo "${branch}" | sed "s/origin\///g"`

git add . 
git commit -m "update ${version} code FinAppletWXExt.podspec "
git push origin HEAD:refs/heads/${commitbranch}





