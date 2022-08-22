#!/bin/bash

sdkType=$1

rm -rf build dist
pod update --no-repo-update

fastlane deploy
#fastlane deploy_static

export version=`git describe --abbrev=0 --tags | tr -d '\\n' | tr -d '\\t'`
export PROJECT_HOME=`pwd`
export branch=`git rev-parse --abbrev-ref HEAD`

branchMsg="release"

if [[ "$sdkType" = "debug" ]]
then
    branchMsg="debug"
fi

# 开始打Release版小程序SDK
cp -r FinAppletWXExt.tpl.podspec FinAppletWXExt.podspec
cp -r FinAppletWXExt-Min.tpl.podspec FinAppletWXExt-Min.podspec

sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec
sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt-Min.podspec
# 内存拷贝进FinAppletWXExt.dist.podspec 便于查看打出的framework
cp -f FinAppletWXExt.podspec FinAppletWXExt.dist.podspec

echo "📣📣📣>>>>>>>>>>>[Release] start upgrading FinPods"
git clone ssh://git.finogeeks.club/finoapp-ios/FinPods
rm -rf FinPods/FinAppletWXExt/${version}
rm -rf FinPods/FinAppletWXExt-Min/${version}

mkdir -p FinPods/FinAppletWXExt/${version}
mkdir -p FinPods/FinAppletWXExt-Min/${version}

cp FinAppletWXExt.podspec FinPods/FinAppletWXExt/${version}/FinAppletWXExt.podspec
cp FinAppletWXExt-Min.podspec FinPods/FinAppletWXExt-Min/${version}/FinAppletWXExt-Min.podspec

cd FinPods
git add FinAppletWXExt/${version} && git add FinAppletWXExt-Min/${version} && git commit -m "upgrade FinAppletWXExt ${version}" && git push

cd ..

rm -rf FinPods

echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec"

cp -r FinAppletWXExt.code.tpl.podspec FinAppletWXExt.podspec

sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

git add . && git commit -m "deploy FinAppletWXExt ${version} on ${branch}" && git push
